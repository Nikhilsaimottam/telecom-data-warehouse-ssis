-- ============================================
-- SP: Load Subscribers Staging to DW
-- Client: StarHub Telecom
-- Author: Nikhil Sai
-- ============================================

USE TelecomDW;
GO

CREATE PROCEDURE dw.usp_LoadSubscribers
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert new subscribers
        INSERT INTO dw.Subscribers (
            subscriber_id, full_name, email,
            phone_number, plan_type, activation_date,
            deactivation_date, status, region
        )
        SELECT 
            s.subscriber_id,
            LTRIM(RTRIM(s.full_name)),
            LOWER(LTRIM(RTRIM(s.email))),
            s.phone_number,
            s.plan_type,
            TRY_CAST(s.activation_date AS DATE),
            TRY_CAST(s.deactivation_date AS DATE),
            UPPER(s.status),
            s.region
        FROM staging.Subscribers s
        WHERE NOT EXISTS (
            SELECT 1 FROM dw.Subscribers d
            WHERE d.subscriber_id = s.subscriber_id
        );

        -- Update existing subscribers
        UPDATE d
        SET 
            d.full_name         = LTRIM(RTRIM(s.full_name)),
            d.email             = LOWER(LTRIM(RTRIM(s.email))),
            d.plan_type         = s.plan_type,
            d.status            = UPPER(s.status),
            d.deactivation_date = TRY_CAST(s.deactivation_date AS DATE),
            d.modified_date     = GETDATE()
        FROM dw.Subscribers d
        JOIN staging.Subscribers s 
            ON d.subscriber_id = s.subscriber_id;

        COMMIT TRANSACTION;
        PRINT 'Subscribers loaded successfully.';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
