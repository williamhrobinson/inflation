-- ════════════════════════════════════════════════════════════
-- a. GOLD MATERIALIZED VIEW: Monthly Macro Aggregations
-- Combines the indicators into one row per month for analysis
-- ════════════════════════════════════════════════════════════
CREATE OR REPLACE MATERIALIZED VIEW
    whriv.economics.monthly_macro_agg_gd
AS

-- STEP 1: Pivot economic indicators into monthly columns
WITH monthly_pivot AS (

    SELECT
        release_date,

        MAX(
            CASE
                WHEN series_id = 'CPIAUCNS' THEN value
            END
        ) AS headline_cpi_index,

        MAX(
            CASE
                WHEN series_id = 'CPILFENS' THEN value
            END
        ) AS core_cpi_index,

        MAX(
            CASE
                WHEN series_id = 'FEDFUNDS' THEN value
            END
        ) AS fed_funds_rate

    FROM whriv.economics.fact_economic_observations_sr

    GROUP BY release_date
),

-- STEP 2: Retrieve prior-period observations
monthly_lagged AS (

    SELECT
        release_date,
        headline_cpi_index,
        core_cpi_index,
        fed_funds_rate,

        LAG(headline_cpi_index, 12) OVER (
            ORDER BY release_date
        ) AS headline_cpi_index_prior_year,

        LAG(core_cpi_index, 12) OVER (
            ORDER BY release_date
        ) AS core_cpi_index_prior_year,

        LAG(fed_funds_rate, 1) OVER (
            ORDER BY release_date
        ) AS fed_funds_rate_prior_month

    FROM monthly_pivot
),

-- STEP 3: Calculate monthly economic metrics
monthly_metrics AS (

    SELECT
        release_date,
        headline_cpi_index,
        core_cpi_index,
        fed_funds_rate,

        ROUND(
            100.0 * (
                headline_cpi_index
                / headline_cpi_index_prior_year - 1
            ), 2
        ) AS headline_inflation_yoy_pct,

        ROUND(
            100.0 * (
                core_cpi_index
                / core_cpi_index_prior_year - 1
            ), 2
        ) AS core_inflation_yoy_pct,

        ROUND(
            fed_funds_rate - fed_funds_rate_prior_month,
            2
        ) AS fed_funds_rate_change_mom

    FROM monthly_lagged
)

-- STEP 4: Final Gold output
SELECT
    release_date,
    headline_cpi_index,
    core_cpi_index,
    fed_funds_rate,

    headline_inflation_yoy_pct,
    core_inflation_yoy_pct,
    fed_funds_rate_change_mom,

    -- Approximate real-rate proxy (percentage points)
    ROUND(
        fed_funds_rate - headline_inflation_yoy_pct,
        2
    ) AS fed_funds_real_rate_proxy,
    CASE
        WHEN fed_funds_real_rate_proxy < 0 THEN 'Deeply Expansionary'
        WHEN (fed_funds_real_rate_proxy >= 0 AND fed_funds_real_rate_proxy < 0.05) THEN 'Expansionary'
        WHEN (fed_funds_real_rate_proxy >= 0.05 AND fed_funds_real_rate_proxy < 1.5) THEN 'Equilibrium'
        WHEN (fed_funds_real_rate_proxy >= 1.5 AND fed_funds_real_rate_proxy < 3) THEN 'Contractionary'
        WHEN fed_funds_real_rate_proxy >= 3 THEN 'Severely Contractionary'
        ELSE NULL
    END AS real_rate_range

FROM monthly_metrics;