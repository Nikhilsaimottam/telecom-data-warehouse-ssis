-- ============================================
-- Reporting Views for SSRS and Power BI
-- Client: StarHub Telecom
-- Author: Nikhil Sai
-- ============================================

USE TelecomDW;
GO

-- View 1: Subscriber Summary
CREATE VIEW reporting.vw_SubscriberSummary AS
SELECT 
    s.subscriber_id,
    s.full_name,
    s.plan_type,
    s.region,
    s.status,
    s.activation_date,
    s.deactivation_date,
    DATEDIFF(MONTH, s.activation_date, GETDATE()) AS tenure_months,
    COUNT(b.bill_key) AS total_bills,
    SUM(b.amount_paid) AS total_revenue
FROM dw.Subscribers s
LEFT JOIN dw.Billing b ON s.subscriber_key = b.subscriber_key
GROUP BY 
    s.subscriber_id, s.full_name, s.plan_type,
    s.region, s.status, s.activation_date, s.deactivation_date;
GO

-- View 2: Monthly Revenue
CREATE VIEW reporting.vw_MonthlyRevenue AS
SELECT 
    YEAR(b.bill_date)   AS bill_year,
    MONTH(b.bill_date)  AS bill_month,
    s.plan_type,
    s.region,
    COUNT(DISTINCT s.subscriber_key)    AS total_subscribers,
    SUM(b.amount_due)                   AS total_billed,
    SUM(b.amount_paid)                  AS total_collected,
    SUM(b.amount_due - b.amount_paid)   AS total_outstanding,
    AVG(b.amount_paid)                  AS arpu
FROM dw.Billing b
JOIN dw.Subscribers s ON b.subscriber_key = s.subscriber_key
GROUP BY 
    YEAR(b.bill_date), MONTH(b.bill_date),
    s.plan_type, s.region;
GO

-- View 3: CDR Analytics
CREATE VIEW reporting.vw_CDRAnalytics AS
SELECT 
    c.call_date,
    c.call_type,
    c.network_type,
    c.region,
    COUNT(*)                        AS total_calls,
    SUM(c.call_duration_sec)        AS total_duration_sec,
    AVG(c.call_duration_sec)        AS avg_duration_sec,
    SUM(c.charge_amount)            AS total_revenue
FROM dw.CDR c
GROUP BY 
    c.call_date, c.call_type,
    c.network_type, c.region;
GO

-- View 4: Network Performance Summary
CREATE VIEW reporting.vw_NetworkPerformance AS
SELECT 
    region,
    network_type,
    record_date,
    COUNT(tower_id)             AS total_towers,
    AVG(signal_strength)        AS avg_signal_strength,
    SUM(downtime_minutes)       AS total_downtime_minutes,
    SUM(data_usage_gb)          AS total_data_usage_gb
FROM dw.NetworkPerformance
GROUP BY region, network_type, record_date;
GO

-- View 5: Churn Analysis
CREATE VIEW reporting.vw_ChurnAnalysis AS
SELECT 
    YEAR(ct.churn_date)         AS churn_year,
    MONTH(ct.churn_date)        AS churn_month,
    s.plan_type,
    s.region,
    COUNT(*)                    AS total_churned,
    AVG(ct.tenure_months)       AS avg_tenure_months,
    AVG(ct.last_arpu)           AS avg_last_arpu,
    ct.churn_reason
FROM dw.ChurnTracking ct
JOIN dw.Subscribers s ON ct.subscriber_key = s.subscriber_key
GROUP BY 
    YEAR(ct.churn_date), MONTH(ct.churn_date),
    s.plan_type, s.region, ct.churn_reason;
GO
