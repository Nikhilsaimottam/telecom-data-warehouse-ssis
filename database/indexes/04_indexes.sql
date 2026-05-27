-- ============================================
-- Indexes - Performance Tuning
-- Client: StarHub Telecom
-- Author: Nikhil Sai
-- ============================================

USE TelecomDW;
GO

-- Subscribers Indexes
CREATE INDEX IX_Subscribers_SubscriberID 
ON dw.Subscribers(subscriber_id);
GO

CREATE INDEX IX_Subscribers_Status_Region 
ON dw.Subscribers(status, region);
GO

CREATE INDEX IX_Subscribers_PlanType 
ON dw.Subscribers(plan_type);
GO

-- Billing Indexes
CREATE INDEX IX_Billing_SubscriberKey 
ON dw.Billing(subscriber_key);
GO

CREATE INDEX IX_Billing_BillDate 
ON dw.Billing(bill_date);
GO

CREATE INDEX IX_Billing_Status 
ON dw.Billing(bill_status);
GO

-- CDR Indexes
CREATE INDEX IX_CDR_CallerKey 
ON dw.CDR(caller_subscriber_key);
GO

CREATE INDEX IX_CDR_CallDate 
ON dw.CDR(call_date);
GO

CREATE INDEX IX_CDR_NetworkType_Region 
ON dw.CDR(network_type, region);
GO

-- Network Performance Indexes
CREATE INDEX IX_Network_Region_Date 
ON dw.NetworkPerformance(region, record_date);
GO

CREATE INDEX IX_Network_TowerID 
ON dw.NetworkPerformance(tower_id);
GO

-- Churn Indexes
CREATE INDEX IX_Churn_SubscriberKey 
ON dw.ChurnTracking(subscriber_key);
GO

CREATE INDEX IX_Churn_Date 
ON dw.ChurnTracking(churn_date);
GO
