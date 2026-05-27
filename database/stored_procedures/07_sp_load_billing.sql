-- ============================================
-- SP: Load Billing Staging to DW
-- Client: StarHub Telecom
-- Author: Nikhil Sai
-- ============================================

USE TelecomDW;
GO

CREATE PROCEDURE dw.usp_LoadBilling
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO dw.Billing (
            bill_id, subscriber_key, bill_date,
            amount_due, amount_paid, payment_date,
            payment_method, bill_status
        )
        SELECT 
            b.bill_id,
            d.subscriber_key,
            TRY_CAST(b.bill_date AS DATE),
            TRY_CAST(b.amount_due AS DECIMAL(10,2)),
            TRY_CAST(b.amount_paid AS DECIMAL(10,2)),
            TRY_CAST(b.payment_date AS DATE),
            b.payment_method,
            UPPER(b.bill_status)
        FROM staging.Billing b
        JOIN dw.Subscribers d ON b.subscriber_id = d.subscriber_id
        WHERE NOT EXISTS (
            SELECT 1 FROM dw.Billing dw
            WHERE dw.bill_id = b.bill_id
        );

        COMMIT TRANSACTION;
        PRINT 'Billing loaded successfully.';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
