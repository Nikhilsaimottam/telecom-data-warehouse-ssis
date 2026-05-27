-- ============================================
-- DW Tables - Cleansed & Transformed Data
-- Client: StarHub Telecom
-- Author: Nikhil Sai
-- ============================================

USE TelecomDW;
GO

-- DW: Subscribers
CREATE TABLE dw.Subscribers (
    subscriber_key      INT IDENTITY(1,1) PRIMARY KEY,
    subscriber_id       VARCHAR(20) NOT NULL,
    full_name           VARCHAR(100),
    email               VARCHAR(100),
    phone_number        VARCHAR(20),
    plan_type           VARCHAR(50),
    activation_date     DATE,
    deactivation_date   DATE,
    status              VARCHAR(20),
    region              VARCHAR(50),
    is_active           BIT DEFAULT 1,
    created_date        DATETIME DEFAULT GETDATE(),
    modified_date       DATETIME DEFAULT GETDATE()
);
GO

-- DW: Billing
CREATE TABLE dw.Billing (
    bill_key            INT IDENTITY(1,1) PRIMARY KEY,
    bill_id             VARCHAR(20) NOT NULL,
    subscriber_key      INT,
    bill_date           DATE,
    amount_due          DECIMAL(10,2),
    amount_paid         DECIMAL(10,2),
    outstanding_amount  AS (amount_due - amount_paid),
    payment_date        DATE,
    payment_method      VARCHAR(30),
    bill_status         VARCHAR(20),
    created_date        DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (subscriber_key) REFERENCES dw.Subscribers(subscriber_key)
);
GO

-- DW: Call Detail Records
CREATE TABLE dw.CDR (
    cdr_key             INT IDENTITY(1,1) PRIMARY KEY,
    cdr_id              VARCHAR(30) NOT NULL,
    caller_subscriber_key INT,
    call_date           DATE,
    call_duration_sec   INT,
    call_type           VARCHAR(20),
    network_type        VARCHAR(20),
    region              VARCHAR(50),
    charge_amount       DECIMAL(10,2),
    created_date        DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (caller_subscriber_key) REFERENCES dw.Subscribers(subscriber_key)
);
GO

-- DW: Network Performance
CREATE TABLE dw.NetworkPerformance (
    network_key         INT IDENTITY(1,1) PRIMARY KEY,
    tower_id            VARCHAR(20),
    region              VARCHAR(50),
    record_date         DATE,
    signal_strength     DECIMAL(5,2),
    downtime_minutes    INT,
    data_usage_gb       DECIMAL(10,3),
    network_type        VARCHAR(20),
    created_date        DATETIME DEFAULT GETDATE()
);
GO

-- DW: Churn Tracking
CREATE TABLE dw.ChurnTracking (
    churn_key           INT IDENTITY(1,1) PRIMARY KEY,
    subscriber_key      INT,
    churn_date          DATE,
    churn_reason        VARCHAR(200),
    last_plan_type      VARCHAR(50),
    last_arpu           DECIMAL(10,2),
    tenure_months       INT,
    created_date        DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (subscriber_key) REFERENCES dw.Subscribers(subscriber_key)
);
GO
