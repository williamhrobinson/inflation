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
-- -- MEDIAN CPI
-- ════════════════════════════════════════════════════════════
CREATE OR REFRESH STREAMING TABLE whriv.economics.median_cpi_sr
(
-- A. Define a fixed schema to prevent schema evolution.
  release_date     DATE,
  value            DOUBLE,
  series_id        STRING,

-- B. Data quality constraints to drop or flag or drop invalid rows.
CONSTRAINT series_id EXPECT (series_id IS NOT NULL) ON VIOLATION FAIL UPDATE
)

-- C. Adds a table comment
COMMENT 'MEDCPIM157SFRBCLE - Median Consumer Price Index'

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
WHERE series_id = 'MEDCPIM157SFRBCLE';

-- ════════════════════════════════════════════════════════════
-- -- 16% TRIMMED-MEAN CPI
-- ════════════════════════════════════════════════════════════
CREATE OR REFRESH STREAMING TABLE whriv.economics.trimmed_mean_cpi_sr
(
-- A. Define a fixed schema to prevent schema evolution.
  release_date     DATE,
  value            DOUBLE,
  series_id        STRING,

-- B. Data quality constraints to drop or flag or drop invalid rows.
CONSTRAINT series_id EXPECT (series_id IS NOT NULL) ON VIOLATION FAIL UPDATE
)

-- C. Adds a table comment
COMMENT 'TRMMEANCPIM157SFRBCLE - 16% Trimmed-Mean Consumer Price Index'

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
WHERE series_id = 'TRMMEANCPIM157SFRBCLE';

-- ════════════════════════════════════════════════════════════
-- -- NATIONAL SAVINGS RATE
-- ════════════════════════════════════════════════════════════
CREATE OR REFRESH STREAMING TABLE whriv.economics.savings_rate_sr
(
-- A. Define a fixed schema to prevent schema evolution.
  release_date     DATE,
  value            DOUBLE,
  series_id        STRING,

-- B. Data quality constraints to drop or flag or drop invalid rows.
CONSTRAINT series_id EXPECT (series_id IS NOT NULL) ON VIOLATION FAIL UPDATE
)

-- C. Adds a table comment
COMMENT 'SNDR - National Rate: Savings'

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
WHERE series_id = 'SNDR';

-- ════════════════════════════════════════════════════════════
-- -- 12 MONTH CD <100M
-- ════════════════════════════════════════════════════════════
CREATE OR REFRESH STREAMING TABLE whriv.economics.cd_12m_rate_sr
(
-- A. Define a fixed schema to prevent schema evolution.
  release_date     DATE,
  value            DOUBLE,
  series_id        STRING,

-- B. Data quality constraints to drop or flag or drop invalid rows.
CONSTRAINT series_id EXPECT (series_id IS NOT NULL) ON VIOLATION FAIL UPDATE
)

-- C. Adds a table comment
COMMENT 'NDR12MCD - National Rate: 12 Month CD <100M'

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
WHERE series_id = 'NDR12MCD';

-- ════════════════════════════════════════════════════════════
-- -- TREASURY 3 MONTH
-- ════════════════════════════════════════════════════════════
CREATE OR REFRESH STREAMING TABLE whriv.economics.tbill_3m_yield_sr
(
-- A. Define a fixed schema to prevent schema evolution.
  release_date     DATE,
  value            DOUBLE,
  series_id        STRING,

-- B. Data quality constraints to drop or flag or drop invalid rows.
CONSTRAINT series_id EXPECT (series_id IS NOT NULL) ON VIOLATION FAIL UPDATE
)

-- C. Adds a table comment
COMMENT 'DGS3MO - Market Yield on U.S. Treasury Securities at 3-Month Constant Maturity, Quoted on an Investment Basis'

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
WHERE series_id = 'DGS3MO';