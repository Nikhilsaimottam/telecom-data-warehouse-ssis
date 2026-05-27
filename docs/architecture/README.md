# Telecom Data Warehouse — Architecture Documentation
**Client:** StarHub Telecom  
**Author:** Nikhil Sai  
**Stack:** SSIS · SQL Server · SSRS · Power BI

---

## Architecture Overview
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

## Data Flow

| Layer | Schema | Purpose |
|-------|--------|---------|
| Source | CSV Files | Raw subscriber, billing, CDR, network data |
| Staging | staging.* | Raw ingested data with no transformation |
| Warehouse | dw.* | Cleansed, typed, FK-linked data |
| Reporting | reporting.* | Aggregated views for SSRS and Power BI |

## Domains Covered

| Domain | Tables | Key Metrics |
|--------|--------|-------------|
| Subscribers | dw.Subscribers | Active count, tenure, plan mix |
| Billing | dw.Billing | Revenue, ARPU, outstanding amount |
| CDR | dw.CDR | Call volume, duration, network usage |
| Network | dw.NetworkPerformance | Signal strength, downtime, data usage |
| Churn | dw.ChurnTracking | Churn rate, reason, last ARPU |

## SSIS Packages

| Package | Source | Target | SP Called |
|---------|--------|--------|-----------|
| 01_SSIS_Load_Subscribers | subscribers.csv | staging to dw | usp_LoadSubscribers |
| 02_SSIS_Load_Billing | billing.csv | staging to dw | usp_LoadBilling |
| 03_SSIS_Load_CDR | cdr.csv | staging to dw | usp_LoadCDR + usp_DetectChurn |
| 04_SSIS_Load_Network | network_performance.csv | staging to dw | usp_LoadNetworkPerformance |

## SSRS Reports

| Report | View Used | Purpose |
|--------|-----------|---------|
| 01_Subscriber_Summary_Report | vw_SubscriberSummary | Subscriber list with revenue |
| 02_Monthly_Revenue_Report | vw_MonthlyRevenue | Monthly billing and ARPU |
| 03_Churn_Report | vw_ChurnAnalysis | Churn trends by region and plan |

## Database Schema

| Schema | Tables | Description |
|--------|--------|-------------|
| staging | Subscribers, Billing, CDR, NetworkPerformance | Raw landing zone |
| dw | Subscribers, Billing, CDR, NetworkPerformance, ChurnTracking | Cleansed warehouse |
| reporting | 5 Views | Aggregated for SSRS and Power BI |

## How to Run

1. Create TelecomDW database using scripts in database/schema/
2. Run indexes from database/indexes/
3. Create views from database/views/
4. Create stored procedures from database/stored_procedures/
5. Update connection strings in ssis/configs/connection_config.dtsConfig
6. Run SSIS packages in order: Subscribers, Billing, CDR, Network
7. Open SSRS reports from ssrs/reports/ in SSRS Report Builder
8. Open Power BI dashboard from powerbi/dashboards/

## Technologies Used

| Tool | Version | Purpose |
|------|---------|---------|
| SQL Server | 2019 | Data warehouse database |
| SSIS | Visual Studio 2019 | ETL pipeline orchestration |
| SSRS | Report Builder 3.0 | Operational reports |
| Power BI Desktop | Latest | Interactive dashboards |
| T-SQL | - | Stored procedures and views |
