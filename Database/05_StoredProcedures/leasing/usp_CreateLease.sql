USE LeaseBillingEngine;
GO

CREATE OR ALTER PROCEDURE leasing.usp_CreateLease

    @LeaseCode NVARCHAR(20),
    @TenantId INT,
    @UnitId INT,
    @StartDate DATE,
    @EndDate DATE,
    @MonthlyRent DECIMAL(12,2),
    @SecurityDeposit DECIMAL(12,2),
    @NoticePeriodDays INT,
    @Notes NVARCHAR(200)=NULL

AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        ----------------------------------------------------
        -- Duplicate Lease Code
        ----------------------------------------------------

        IF EXISTS
        (
            SELECT 1
            FROM leasing.Lease
            WHERE LeaseCode = @LeaseCode
        )
            THROW 50010,'Lease Code already exists.',1;

        ----------------------------------------------------
        -- Tenant Exists
        ----------------------------------------------------

        IF NOT EXISTS
        (
            SELECT 1
            FROM leasing.Tenant
            WHERE TenantId = @TenantId
        )
            THROW 50011,'Tenant does not exist.',1;

        ----------------------------------------------------
        -- Apartment Exists
        ----------------------------------------------------

        IF NOT EXISTS
        (
            SELECT 1
            FROM property.ApartmentUnit
            WHERE UnitId = @UnitId
        )
            THROW 50012,'Apartment does not exist.',1;

        ----------------------------------------------------
        -- Apartment Already Occupied?
        ----------------------------------------------------

        IF EXISTS
        (
            SELECT 1
            FROM leasing.Lease
            WHERE UnitId = @UnitId
              AND LeaseStatusId = 2
        )
            THROW 50013,'Apartment is already occupied.',1;

        ----------------------------------------------------
        -- Date Validation
        ----------------------------------------------------

        IF @StartDate >= @EndDate
            THROW 50014,'End Date must be greater than Start Date.',1;

        ----------------------------------------------------
        -- Transaction
        ----------------------------------------------------

        BEGIN TRANSACTION;

        INSERT INTO leasing.Lease
        (
            LeaseCode,
            TenantId,
            UnitId,
            LeaseStatusId,
            StartDate,
            EndDate,
            MonthlyRent,
            SecurityDeposit,
            NoticePeriodDays,
            Notes
        )
        VALUES
        (
            @LeaseCode,
            @TenantId,
            @UnitId,
            2,
            @StartDate,
            @EndDate,
            @MonthlyRent,
            @SecurityDeposit,
            @NoticePeriodDays,
            @Notes
        );

        ----------------------------------------------------
        -- Update Apartment Status
        ----------------------------------------------------

        UPDATE property.ApartmentUnit
        SET OccupancyStatusId = 2
        WHERE UnitId = @UnitId;

        COMMIT TRANSACTION;

        PRINT 'Lease created successfully.';

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO