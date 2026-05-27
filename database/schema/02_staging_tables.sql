-- ============================================
-- Staging Tables - Raw Ingested Data
-- Client: StarHub Telecom
-- Author: Nikhil Sai
-- ============================================

USE TelecomDW;
GO

-- Staging: Subscribers
CREATE TABLE staging.Subscribers (
    subscriber_id       VARCHAR(20),
    full_name           VARCHAR(100),
    email               VARCHAR(100),
    phone_number        VARCHAR(20),
    plan_type           VARCHAR(50),
    activation_date     VARCHAR(20),
    deactivation_date   VARCHAR(20),
    status              VARCHAR(20),
    region              VARCHAR(50),
    load_date           DATETIME DEFAULT GETDATE()
);
GO

-- Staging: Billing
CREATE TABLE staging.Billing (
    bill_id             VARCHAR(20),
    subscriber_id       VARCHAR(20),
    bill_date           VARCHAR(20),
    amount_due          VARCHAR(20),
    amount_paid         VARCHAR(20),
    payment_date        VARCHAR(20),
    payment_method      VARCHAR(30),
    bill_status         VARCHAR(20),
    load_date           DATETIME DEFAULT GETDATE()
);
GO

-- Staging: Call Detail Records (CDR)
CREATE TABLE staging.CDR (
    cdr_id              VARCHAR(30),
    caller_id           VARCHAR(20),
    receiver_id         VARCHAR(20),
    call_date           VARCHAR(20),
    call_duration_sec   VARCHAR(10),
    call_type           VARCHAR(20),
    network_type        VARCHAR(20),
    region              VARCHAR(50),
    charge_amount       VARCHAR(20),
    load_date           DATETIME DEFAULT GETDATE()
);
GO

-- Staging: Network Performance
CREATE TABLE staging.NetworkPerformance (
    record_id           VARCHAR(30),
    region              VARCHAR(50),
    tower_id            VARCHAR(20),
    record_date         VARCHAR(20),
    signal_strength     VARCHAR(10),
    downtime_minutes    VARCHAR(10),
    data_usage_gb       VARCHAR(10),
    network_type        VARCHAR(20),
    load_date           DATETIME DEFAULT GETDATE()
);
GO
