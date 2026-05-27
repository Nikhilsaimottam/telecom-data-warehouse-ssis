# 📡 Telecom Data Warehouse — SSIS + SQL Server + SSRS + Power BI

![SQL Server](https://img.shields.io/badge/SQL%20Server-2019-red)
![SSIS](https://img.shields.io/badge/SSIS-ETL%20Pipeline-blue)
![SSRS](https://img.shields.io/badge/SSRS-Reports-green)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

---

## 📌 Project Overview

End-to-end **Telecom Data Warehouse** built for **StarHub Telecom** to consolidate subscriber, billing, call detail records (CDR), and network performance data into a centralized SQL Server warehouse with full ETL automation via SSIS, operational reporting via SSRS, and executive dashboards via Power BI.

---

## 🏗️ Architecture

[CSV Source Files]
|
v
[SSIS Packages] --> [staging schema] --> [Stored Procedures] --> [dw schema]
|
[reporting schema views] <--+
|
+-----------------------------+--------------------------+
|                                                        |
[SSRS Reports]                                    [Power BI Dashboard]

---

## 📂 Repository Structure

telecom-data-warehouse-ssis/
├── database/
│   ├── schema/                  ← DB, staging and DW table scripts
│   ├── views/                   ← Reporting views for SSRS and Power BI
│   ├── stored_procedures/       ← ETL load and churn detection SPs
│   └── indexes/                 ← Performance tuning indexes
├── ssis/
│   ├── packages/                ← SSIS .dtsx ETL packages
│   └── configs/                 ← Connection config files
├── ssrs/
│   └── reports/                 ← SSRS .rdl report files
├── powerbi/
│   └── dashboards/              ← Power BI .pbix dashboard
├── sample_data/                 ← CSV source files for testing
└── docs/
└── architecture/            ← Architecture docs and diagrams

---

## 🔄 ETL Pipeline — SSIS Packages

| Package | Source | Staging Table | DW Table | Stored Procedure |
|---------|--------|--------------|----------|-----------------|
| 01_SSIS_Load_Subscribers | subscribers.csv | staging.Subscribers | dw.Subscribers | usp_LoadSubscribers |
| 02_SSIS_Load_Billing | billing.csv | staging.Billing | dw.Billing | usp_LoadBilling |
| 03_SSIS_Load_CDR | cdr.csv | staging.CDR | dw.CDR | usp_LoadCDR + usp_DetectChurn |
| 04_SSIS_Load_Network | network_performance.csv | staging.NetworkPerformance | dw.NetworkPerformance | usp_LoadNetworkPerformance |

---

## 🗄️ Database Schema

### Staging Layer
| Table | Purpose |
|-------|---------|
| staging.Subscribers | Raw subscriber records from CSV |
| staging.Billing | Raw billing transactions |
| staging.CDR | Raw call detail records |
| staging.NetworkPerformance | Raw network KPI data |

### Data Warehouse Layer
| Table | Purpose |
|-------|---------|
| dw.Subscribers | Cleansed subscriber master with SCD support |
| dw.Billing | Billing with computed outstanding amount |
| dw.CDR | Call analytics with FK to subscribers |
| dw.NetworkPerformance | Tower KPIs by region and date |
| dw.ChurnTracking | Churn detection with tenure and ARPU |

### Reporting Layer
| View | Purpose |
|------|---------|
| reporting.vw_SubscriberSummary | Subscriber revenue and tenure |
| reporting.vw_MonthlyRevenue | ARPU, billed vs collected by month |
| reporting.vw_CDRAnalytics | Call volume and duration trends |
| reporting.vw_NetworkPerformance | Signal strength and downtime summary |
| reporting.vw_ChurnAnalysis | Churn by plan type, region and reason |

---

## 📊 SSRS Reports

| Report | Description |
|--------|-------------|
| 01_Subscriber_Summary_Report | Full subscriber list with revenue, tenure and plan |
| 02_Monthly_Revenue_Report | Monthly billing, ARPU and outstanding by region |
| 03_Churn_Report | Churn trends, average tenure and ARPU by segment |

---

## 📈 Power BI Dashboard

Executive dashboard covering:
- Active vs Inactive subscriber counts
- Monthly revenue trend by plan type
- ARPU by region
- Churn rate over time
- Network downtime by region and tower
- CDR volume by network type (3G / 4G / 5G)

---

## 🚀 How to Run

1. Run `database/schema/01_create_database.sql` to create TelecomDW
2. Run `02_staging_tables.sql` and `03_dw_tables.sql`
3. Run `database/indexes/04_indexes.sql`
4. Run all scripts in `database/views/` and `database/stored_procedures/`
5. Update connection strings in `ssis/configs/connection_config.dtsConfig`
6. Execute SSIS packages in order: Subscribers → Billing → CDR → Network
7. Open `.rdl` files in SSRS Report Builder
8. Open `.pbix` in Power BI Desktop

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| SQL Server 2019 | Data warehouse engine |
| SSIS Visual Studio 2019 | ETL pipeline automation |
| SSRS Report Builder 3.0 | Operational reporting |
| Power BI Desktop | Executive dashboards |
| T-SQL | Stored procedures, views and indexes |

---

## 👤 Author

**Nikhil Sai**  
Data Engineer — SQL Server · SSIS · Azure Data Factory · Databricks · PySpark  
[GitHub Profile](https://github.com/Nikhilsaimottam)
