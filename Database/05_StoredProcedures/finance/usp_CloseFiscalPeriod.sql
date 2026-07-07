USE LeaseBillingEngine;
GO

CREATE OR ALTER PROCEDURE finance.usp_CloseFiscalPeriod

    @FiscalPeriodId INT

AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

    ------------------------------------------------------
    -- Fiscal Period Exists
    ------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM finance.FiscalPeriod
        WHERE FiscalPeriodId=@FiscalPeriodId
    )
        THROW 55001,'Fiscal Period does not exist.',1;

    ------------------------------------------------------
    -- Already Closed?
    ------------------------------------------------------

    IF EXISTS
    (
        SELECT 1
        FROM finance.FiscalPeriod
        WHERE FiscalPeriodId=@FiscalPeriodId
        AND IsClosed=1
    )
        THROW 55002,'Fiscal Period already closed.',1;

    ------------------------------------------------------
    -- Outstanding Charges
    ------------------------------------------------------

    IF EXISTS
    (
        SELECT 1
        FROM finance.Charge
        WHERE FiscalPeriodId=@FiscalPeriodId
        AND OutstandingAmount>0
    )
        THROW 55003,'Outstanding balances exist. Cannot close fiscal period.',1;

    ------------------------------------------------------
    -- Transaction
    ------------------------------------------------------

    BEGIN TRANSACTION;

    UPDATE finance.FiscalPeriod

    SET

        IsClosed=1

    WHERE FiscalPeriodId=@FiscalPeriodId;

    COMMIT TRANSACTION;

    PRINT 'Fiscal Period Closed Successfully.';

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT>0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO