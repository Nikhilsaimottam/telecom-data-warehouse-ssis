-- ============================================
-- Telecom Data Warehouse - Database Setup
-- Client: StarHub Telecom
-- Author: Nikhil Sai
-- ============================================

CREATE DATABASE TelecomDW;
GO

USE TelecomDW;
GO

-- Schemas
CREATE SCHEMA staging;   -- Raw ingested data
GO
CREATE SCHEMA dw;        -- Cleansed warehouse tables
GO
CREATE SCHEMA reporting; -- Views for SSRS/Power BI
GO
