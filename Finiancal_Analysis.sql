-- Create the database
CREATE DATABASE IF NOT EXISTS financial_health;
USE financial_health;

-- 1. Loans table (SBA 7(a) data)
CREATE TABLE IF NOT EXISTS loans (
  loan_id             VARCHAR(50)    PRIMARY KEY,
  loan_date           DATE           NOT NULL,
  amount              DECIMAL(15,2)  NOT NULL,
  status              VARCHAR(20),
  payments_total      DECIMAL(15,2),
  default_flag        TINYINT(1),
  created_at          TIMESTAMP      DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Company financials (e.g. SEC EDGAR sample data)
CREATE TABLE IF NOT EXISTS financials (
  company_id          VARCHAR(20),
  fiscal_year         YEAR           NOT NULL,
  revenue             DECIMAL(18,2),
  cogs                DECIMAL(18,2),
  opex                DECIMAL(18,2),
  assets_current      DECIMAL(18,2),
  liabilities_current DECIMAL(18,2),
  liabilities_total   DECIMAL(18,2),
  equity              DECIMAL(18,2),
  PRIMARY KEY (company_id, fiscal_year)
) ENGINE=InnoDB;

-- 3. Regional GDP (BEA)
CREATE TABLE IF NOT EXISTS regional_gdp (
  region              VARCHAR(50),
  period              YEAR           NOT NULL,
  gdp_amount          DECIMAL(18,2),
  PRIMARY KEY (region, period)
) ENGINE=InnoDB;

-- 4. World Bank SME Finance Indicators
CREATE TABLE IF NOT EXISTS wb_indicators (
  indicator_code      VARCHAR(20),
  country             VARCHAR(50),
  year                YEAR           NOT NULL,
  value               DECIMAL(18,4),
  PRIMARY KEY (indicator_code, country, year)
) ENGINE=InnoDB;

SHOW TABLES;

USE financial_health;

-- 1. Operating Cash Flow Estimate
CREATE OR REPLACE VIEW vw_operating_cf AS
SELECT
  company_id,
  fiscal_year,
  (revenue - cogs - opex) AS operating_cf
FROM financials;

-- 2. Gross Margin
CREATE OR REPLACE VIEW vw_gross_margin AS
SELECT
  company_id,
  fiscal_year,
  CASE
    WHEN revenue > 0 THEN ROUND((revenue - cogs) / revenue, 4)
    ELSE NULL
  END AS gross_margin
FROM financials;

-- 3. Current Ratio (Liquidity)
CREATE OR REPLACE VIEW vw_current_ratio AS
SELECT
  company_id,
  fiscal_year,
  CASE
    WHEN liabilities_current > 0 THEN ROUND(assets_current / liabilities_current, 4)
    ELSE NULL
  END AS current_ratio
FROM financials;

-- 4. Debt-Equity Ratio
CREATE OR REPLACE VIEW vw_debt_equity_ratio AS
SELECT
  company_id,
  fiscal_year,
  CASE
    WHEN equity > 0 THEN ROUND(liabilities_total / equity, 4)
    ELSE NULL
  END AS debt_equity_ratio
FROM financials;

USE financial_health;

DROP TABLE IF EXISTS kpi_financial_health;

CREATE TABLE kpi_financial_health AS
SELECT
  f.company_id,
  f.fiscal_year,
  cf.operating_cf,
  gm.gross_margin,
  cr.current_ratio,
  der.debt_equity_ratio
FROM financials AS f
LEFT JOIN vw_operating_cf      AS cf  USING (company_id, fiscal_year)
LEFT JOIN vw_gross_margin      AS gm  USING (company_id, fiscal_year)
LEFT JOIN vw_current_ratio     AS cr  USING (company_id, fiscal_year)
LEFT JOIN vw_debt_equity_ratio AS der USING (company_id, fiscal_year);

SHOW FULL TABLES WHERE Table_type = 'VIEW';

SELECT COUNT(*) AS total_rows FROM kpi_financial_health;
SELECT * FROM kpi_financial_health LIMIT 10;


