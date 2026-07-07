USE LeaseBillingEngine;
GO

CREATE OR ALTER PROCEDURE finance.usp_GenerateMonthlyCharges

    @FiscalPeriodId INT,
    @ChargeDate DATE,
    @DueDate DATE

AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @RentChargeCodeId INT;
    DECLARE @ActiveLeaseStatusId INT;

    BEGIN TRY

        -------------------------------------------------------
        -- Validate Fiscal Period
        -------------------------------------------------------

        IF NOT EXISTS
        (
            SELECT 1
            FROM finance.FiscalPeriod
            WHERE FiscalPeriodId = @FiscalPeriodId
        )
        BEGIN
            THROW 51001, 'Invalid Fiscal Period.', 1;
        END;

        -------------------------------------------------------
        -- Get RENT ChargeCodeId
        -------------------------------------------------------

        SELECT @RentChargeCodeId = ChargeCodeId
        FROM finance.ChargeCode
        WHERE ChargeCode = 'RENT';

        IF @RentChargeCodeId IS NULL
        BEGIN
            THROW 51002, 'RENT Charge Code not found.', 1;
        END;

        -------------------------------------------------------
        -- Get Active Lease Status Id
        -------------------------------------------------------

        SELECT @ActiveLeaseStatusId = LeaseStatusId
        FROM leasing.LeaseStatus
        WHERE LeaseStatusCode = 'ACT';

        IF @ActiveLeaseStatusId IS NULL
        BEGIN
            THROW 51003, 'Active Lease Status not found.', 1;
        END;

        -------------------------------------------------------
        -- Begin Transaction
        -------------------------------------------------------

        BEGIN TRANSACTION;

        -------------------------------------------------------
        -- Generate Charges
        -------------------------------------------------------

        INSERT INTO finance.Charge
        (
            ChargeCodeId,
            LeaseId,
            FiscalPeriodId,
            ChargeDate,
            DueDate,
            ChargeAmount,
            OutstandingAmount,
            Notes
        )

        SELECT

            @RentChargeCodeId,
            l.LeaseId,
            @FiscalPeriodId,
            @ChargeDate,
            @DueDate,
            l.MonthlyRent,
            l.MonthlyRent,
            'Monthly Rent'

        FROM leasing.Lease l

        WHERE l.LeaseStatusId = @ActiveLeaseStatusId

        AND NOT EXISTS
        (
            SELECT 1
            FROM finance.Charge c

            WHERE c.LeaseId = l.LeaseId
            AND c.FiscalPeriodId = @FiscalPeriodId
            AND c.ChargeCodeId = @RentChargeCodeId
        );

        -------------------------------------------------------
        -- Commit
        -------------------------------------------------------

        COMMIT TRANSACTION;

        PRINT 'Monthly charges generated successfully.';

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO