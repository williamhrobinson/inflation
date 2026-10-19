from pyspark import pipelines as dp
from pyspark.sql import functions as F
import requests, pandas as pd, time

FRED_KEY = dbutils.secrets.get(scope="fred", key="api_key")

SERIES = [
    "CPIAUCNS",
    "CPILFENS",
    "FEDFUNDS"
]

def _fred_get(endpoint, **params):
    r = requests.get(
        f"https://api.stlouisfed.org/fred/{endpoint}",
        params={**params, "api_key": FRED_KEY, "file_type": "json"},
        timeout=30,
    )
    data = r.json()
    if r.status_code != 200:
        raise Exception(f"{endpoint} {params.get('series_id')}: {data.get('error_message')}")
    return data

def _pull_series(series_id, start="2018-01-01", **extra):
    obs = _fred_get("series/observations", series_id=series_id,
                   observation_start=start, **extra)["observations"]
    pdf = pd.DataFrame(obs)[["date", "value"]]
    pdf["series_id"] = series_id
    return pdf

dp.create_streaming_table(
    name="fred_series_bz_stream",
    comment="Bronze layer: FRED economic observations appended from the FRED API."
)

@dp.append_flow(target="fred_series_bz_stream", once=True)
def fred_series_pull():
    frames, failed = [], []
    for s in SERIES:
        try:
            frames.append(_pull_series(s))
        except Exception as e:
            failed.append((s, str(e)))
        time.sleep(0.5)

    if failed:
        print("failed:", failed)

    if not frames:
        return spark.createDataFrame([], "date STRING, value STRING, series_id STRING, ingested_at TIMESTAMP")

    pdf_all = pd.concat(frames, ignore_index=True)
    sdf = (spark.createDataFrame(pdf_all.astype(str))
               .withColumn("ingested_at", F.current_timestamp()))
    return sdf