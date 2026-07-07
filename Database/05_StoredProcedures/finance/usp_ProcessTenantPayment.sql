USE LeaseBillingEngine;
GO

CREATE OR ALTER PROCEDURE finance.usp_ProcessTenantPayment

    @PaymentCode       NVARCHAR(20),
    @LeaseId           INT,
    @BankAccountId     INT,
    @FiscalPeriodId    INT,
    @PaymentDate       DATE,
    @PaymentAmount     DECIMAL(12,2),
    @PaymentModeId     INT,
    @ReferenceNumber   NVARCHAR(50)=NULL,
    @Notes             NVARCHAR(200)=NULL

AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @PaymentId INT;
    DECLARE @ChargeId INT;
    DECLARE @OutstandingAmount DECIMAL(12,2);

    BEGIN TRY

    -------------------------------------------------------
    -- Duplicate Payment Code
    -------------------------------------------------------

    IF EXISTS
    (
        SELECT 1
        FROM finance.Payment
        WHERE PaymentCode = @PaymentCode
    )
        THROW 52001,'Payment Code already exists.',1;

    -------------------------------------------------------
    -- Lease Exists
    -------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM leasing.Lease
        WHERE LeaseId=@LeaseId
    )
        THROW 52002,'Invalid Lease.',1;

    -------------------------------------------------------
    -- Fiscal Period Exists
    -------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM finance.FiscalPeriod
        WHERE FiscalPeriodId=@FiscalPeriodId
    )
        THROW 52003,'Invalid Fiscal Period.',1;

    -------------------------------------------------------
    -- Bank Account Exists
    -------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM finance.BankAccount
        WHERE BankAccountId=@BankAccountId
    )
        THROW 52004,'Invalid Bank Account.',1;

    -------------------------------------------------------
    -- Payment Mode Exists
    -------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM finance.PaymentMode
        WHERE PaymentModeId=@PaymentModeId
    )
        THROW 52005,'Invalid Payment Mode.',1;

    -------------------------------------------------------
    -- Outstanding Charge
    -------------------------------------------------------

    SELECT TOP (1)

        @ChargeId = ChargeId,
        @OutstandingAmount = OutstandingAmount

    FROM finance.Charge

    WHERE LeaseId=@LeaseId
    AND FiscalPeriodId=@FiscalPeriodId
    AND OutstandingAmount>0

    ORDER BY DueDate;

    IF @ChargeId IS NULL
        THROW 52006,'No outstanding charge found.',1;

    -------------------------------------------------------
    -- Payment Validation
    -------------------------------------------------------

    IF @PaymentAmount>@OutstandingAmount
        THROW 52007,'Payment cannot exceed outstanding amount.',1;

    -------------------------------------------------------
    -- Transaction
    -------------------------------------------------------

    BEGIN TRANSACTION;

    -------------------------------------------------------
    -- Insert Payment
    -------------------------------------------------------

    INSERT INTO finance.Payment
    (
        PaymentCode,
        LeaseId,
        BankAccountId,
        FiscalPeriodId,
        PaymentDate,
        PaymentAmount,
        PaymentModeId,
        ReferenceNumber,
        Notes
    )
    VALUES
    (
        @PaymentCode,
        @LeaseId,
        @BankAccountId,
        @FiscalPeriodId,
        @PaymentDate,
        @PaymentAmount,
        @PaymentModeId,
        @ReferenceNumber,
        @Notes
    );

    -------------------------------------------------------
    -- PaymentId
    -------------------------------------------------------

    SET @PaymentId=SCOPE_IDENTITY();

    -------------------------------------------------------
    -- Insert Payment Application
    -------------------------------------------------------

    INSERT INTO finance.PaymentApplication
    (
        PaymentId,
        ChargeId,
        AppliedAmount,
        AppliedDate
    )
    VALUES
    (
        @PaymentId,
        @ChargeId,
        @PaymentAmount,
        @PaymentDate
    );

    -------------------------------------------------------
    -- Update Outstanding
    -------------------------------------------------------

    UPDATE finance.Charge

    SET OutstandingAmount=
        OutstandingAmount-@PaymentAmount

    WHERE ChargeId=@ChargeId;

    COMMIT TRANSACTION;

    PRINT 'Payment processed successfully.';

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT>0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO