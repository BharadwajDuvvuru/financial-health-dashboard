# Financial-health-dashboard
A data-driven dashboard for analyzing small business financial health using SQL + Power BI
# Financial Health Dashboard 📊

This capstone project analyzes and visualizes the financial health of small businesses by combining data on SBA loans, company financials, regional GDP, and World Bank SME finance indicators.

## 🚀 Project Overview

The dashboard answers key financial questions like:
- How are small businesses performing financially?
- Are certain regions or time periods riskier for lending?
- How do global SME benchmarks compare with local data?

It includes:
- ✅ MySQL ETL pipeline with calculated KPIs
- ✅ Power BI report with 4 interactive pages
- ✅ Clean and well-documented code and dataset structure

## 🗂️ Data Sources

1. **loans.csv** – SBA 7(a) loan volume, status, and default flags  
2. **financials.csv** – Company revenue, COGS, balance sheet metrics  
3. **regional_gdp.csv** – GDP by U.S. state  
4. **wb_indicators.csv** – Global SME finance indicators (credit-to-GDP, interest rates)

## 🧮 SQL ETL + KPI Views

Database: `financial_health`

**Tables Created**:
- `loans`
- `financials`
- `regional_gdp`
- `wb_indicators`

**Views Created**:
- `vw_operating_cf`
- `vw_gross_margin`
- `vw_current_ratio`
- `vw_debt_equity_ratio`

**Final KPI Table**:
- `kpi_financial_health` – Merges all views into a single, queryable KPI layer

## 📊 Power BI Dashboard (4 Pages)

1. **Overview** – KPI summary cards + trendlines  
2. **Loan Analysis** – Loan volumes, default rates  
3. **Regional Context** – GDP trends by state  
4. **Global Benchmarking** – SME indicators by country  

## 🛠️ How to Run

1. Run `Financial_Analysis.sql` to create tables and views
2. Import the `.csv` files into your MySQL `financial_health` database
3. Open `financial_health_Dashboard.pbix` in Power BI
4. Connect to MySQL DB > Import mode > Set credentials
5. Explore and modify visualizations!

## 🧩 Future Enhancements

- Add KPIs like ROA, EBITDA Margin, and Quick Ratio  
- Enable drill-throughs to company-level financial details  
- Deploy MySQL on a cloud server for auto-refresh  
- Add Power BI alerts for threshold breaches  

---

## 👨‍💻 Author

**Bharadwaj Duvvuru**  
*M.S. in IT Management | Data Analyst* 
🔗 [LinkedIn](https://www.linkedin.com/in/bharadwaj-0934442b5/)  
📫 Duvvurubharadwaj@gmail.com  

---

