USE LeaseBillingEngine;
GO

CREATE OR ALTER PROCEDURE leasing.usp_RenewLease

    @LeaseId INT,
    @NewEndDate DATE,
    @NewMonthlyRent DECIMAL(12,2)=NULL,
    @NewSecurityDeposit DECIMAL(12,2)=NULL,
    @Notes NVARCHAR(500)=NULL

AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @CurrentEndDate DATE;
    DECLARE @RenewedStatusId INT;
    DECLARE @ActiveStatusId INT;

    BEGIN TRY

    --------------------------------------------------------
    -- Lease Exists
    --------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM leasing.Lease
        WHERE LeaseId=@LeaseId
    )
        THROW 53001,'Lease does not exist.',1;

    --------------------------------------------------------
    -- Get Current End Date
    --------------------------------------------------------

    SELECT @CurrentEndDate=EndDate
    FROM leasing.Lease
    WHERE LeaseId=@LeaseId;

    --------------------------------------------------------
    -- Validate End Date
    --------------------------------------------------------

    IF @NewEndDate<=@CurrentEndDate
        THROW 53002,'New End Date must be greater than current End Date.',1;

    --------------------------------------------------------
    -- Get Status IDs
    --------------------------------------------------------

    SELECT @RenewedStatusId=LeaseStatusId
    FROM leasing.LeaseStatus
    WHERE LeaseStatusCode='REN';

    SELECT @ActiveStatusId=LeaseStatusId
    FROM leasing.LeaseStatus
    WHERE LeaseStatusCode='ACT';

    IF @RenewedStatusId IS NULL
        THROW 53003,'Renewed status not found.',1;

    IF @ActiveStatusId IS NULL
        THROW 53004,'Active status not found.',1;

    --------------------------------------------------------
    -- Transaction
    --------------------------------------------------------

    BEGIN TRANSACTION;

    UPDATE leasing.Lease

    SET

        EndDate=@NewEndDate,

        MonthlyRent=
            ISNULL(@NewMonthlyRent,MonthlyRent),

        SecurityDeposit=
            ISNULL(@NewSecurityDeposit,SecurityDeposit),

        LeaseStatusId=@RenewedStatusId,

        Notes=
            CASE
                WHEN @Notes IS NULL THEN Notes
                ELSE @Notes
            END,

        ModifiedDate=GETDATE()

    WHERE LeaseId=@LeaseId;

    --------------------------------------------------------
    -- Optional: Change back to Active
    --------------------------------------------------------

    UPDATE leasing.Lease

    SET LeaseStatusId=@ActiveStatusId

    WHERE LeaseId=@LeaseId;

    COMMIT TRANSACTION;

    PRINT 'Lease renewed successfully.';

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT>0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO