USE LeaseBillingEngine;
GO

CREATE OR ALTER PROCEDURE leasing.usp_TerminateLease

    @LeaseId INT,
    @TerminationDate DATE,
    @Notes NVARCHAR(500)=NULL

AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @UnitId INT;
    DECLARE @TerminateStatusId INT;
    DECLARE @VacantStatusId INT;

    BEGIN TRY

    -----------------------------------------------------
    -- Lease Exists
    -----------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM leasing.Lease
        WHERE LeaseId=@LeaseId
    )
        THROW 54001,'Lease not found.',1;

    -----------------------------------------------------
    -- Get Unit
    -----------------------------------------------------

    SELECT @UnitId=UnitId
    FROM leasing.Lease
    WHERE LeaseId=@LeaseId;

    -----------------------------------------------------
    -- Get Status IDs
    -----------------------------------------------------

    SELECT @TerminateStatusId=LeaseStatusId
    FROM leasing.LeaseStatus
    WHERE LeaseStatusCode='TER';

    SELECT @VacantStatusId=OccupancyStatusId
    FROM property.OccupancyStatus
    WHERE OccupancyStatusCode='VAC';

    IF @TerminateStatusId IS NULL
        THROW 54002,'Terminate status not found.',1;

    IF @VacantStatusId IS NULL
        THROW 54003,'Vacant status not found.',1;

    -----------------------------------------------------
    -- Transaction
    -----------------------------------------------------

    BEGIN TRANSACTION;

    -----------------------------------------------------
    -- Update Lease
    -----------------------------------------------------

    UPDATE leasing.Lease

    SET

        LeaseStatusId=@TerminateStatusId,
        EndDate=@TerminationDate,
        IsActive=0,
        Notes=
            CASE
                WHEN @Notes IS NULL THEN Notes
                ELSE @Notes
            END,
        ModifiedDate=GETDATE()

    WHERE LeaseId=@LeaseId;

    -----------------------------------------------------
    -- Apartment becomes Vacant
    -----------------------------------------------------

    UPDATE property.ApartmentUnit

    SET

        OccupancyStatusId=@VacantStatusId,
        ModifiedDate=GETDATE()

    WHERE UnitId=@UnitId;

    COMMIT TRANSACTION;

    PRINT 'Lease terminated successfully.';

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT>0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO