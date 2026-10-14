-- ════════════════════════════════════════════════════════════
-- -- HEADLINE CPI
-- ════════════════════════════════════════════════════════════
CREATE OR REFRESH STREAMING TABLE whriv.economics.headline_cpi_sr
(
-- A. Define a fixed schema to prevent schema evolution.
  release_date     DATE,
  value            DOUBLE,
  series_id        STRING,

-- B. Data quality constraints to drop or flag or drop invalid rows.
CONSTRAINT series_id EXPECT (series_id IS NOT NULL) ON VIOLATION FAIL UPDATE
)

-- C. Adds a table comment
COMMENT 'CPIAUCSL - Consumer Price Index for All Urban Consumers: All Items in U.S. City Average'

-- D. Enable liquid clustering to improve performance on common filters.
CLUSTER BY AUTO

AS
-- E. Select and clean data from the bronze table
SELECT
    TRY_CAST(date AS DATE) AS release_date,
    TRY_CAST(value AS DOUBLE) AS value,
    series_id
-- F. Incrementally reads data from the bronze table that contains data from three volumes.
FROM STREAM whriv.economics.fred_series_bz_stream
WHERE series_id = 'CPIAUCSL';

-- ════════════════════════════════════════════════════════════
-- -- CORE CPI
-- ════════════════════════════════════════════════════════════
CREATE OR REFRESH STREAMING TABLE whriv.economics.core_cpi_sr
(
-- A. Define a fixed schema to prevent schema evolution.
  release_date     DATE,
  value            DOUBLE,
  series_id        STRING,

-- B. Data quality constraints to drop or flag or drop invalid rows.
CONSTRAINT series_id EXPECT (series_id IS NOT NULL) ON VIOLATION FAIL UPDATE
)

-- C. Adds a table comment
COMMENT 'CPILFESL - Consumer Price Index for All Urban Consumers: All Items Less Food and Energy in U.S. City Average'

-- D. Enable liquid clustering to improve performance on common filters.
CLUSTER BY AUTO

AS
-- E. Select and clean data from the bronze table
SELECT
    TRY_CAST(date AS DATE) AS release_date,
    TRY_CAST(value AS DOUBLE) AS value,
    series_id
-- F. Incrementally reads data from the bronze table that contains data from three volumes.
FROM STREAM whriv.economics.fred_series_bz_stream
WHERE series_id = 'CPILFESL';

-- ════════════════════════════════════════════════════════════
-- -- FED FUNDS RATE
-- ════════════════════════════════════════════════════════════
CREATE OR REFRESH STREAMING TABLE whriv.economics.fed_funds_rate_sr
(
-- A. Define a fixed schema to prevent schema evolution.
  release_date     DATE,
  value            DOUBLE,
  series_id        STRING,

-- B. Data quality constraints to drop or flag or drop invalid rows.
CONSTRAINT series_id EXPECT (series_id IS NOT NULL) ON VIOLATION FAIL UPDATE
)

-- C. Adds a table comment
COMMENT 'FEDFUNDS - Federal Funds Effective Rate'

-- D. Enable liquid clustering to improve performance on common filters.
CLUSTER BY AUTO

AS
-- E. Select and clean data from the bronze table
SELECT
    TRY_CAST(date AS DATE) AS release_date,
    TRY_CAST(value AS DOUBLE) AS value,
    series_id
-- F. Incrementally reads data from the bronze table that contains data from three volumes.
FROM STREAM whriv.economics.fred_series_bz_stream
WHERE series_id = 'FEDFUNDS';
