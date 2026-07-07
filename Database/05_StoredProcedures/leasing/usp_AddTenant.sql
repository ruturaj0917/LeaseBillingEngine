USE LeaseBillingEngine;
GO

CREATE PROCEDURE leasing.usp_AddTenant

    @TenantCode NVARCHAR(20),
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20),
    @AadhaarNumber NVARCHAR(20),
    @DateOfBirth DATE,
    @EmergencyContactName NVARCHAR(100),
    @EmergencyContactPhone NVARCHAR(20)

AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        ---------------------------------------------------
        -- Duplicate Tenant Code
        ---------------------------------------------------

        IF EXISTS
        (
            SELECT 1
            FROM leasing.Tenant
            WHERE TenantCode = @TenantCode
        )
        BEGIN
            THROW 50001,'Tenant Code already exists.',1;
        END;

        ---------------------------------------------------
        -- Duplicate Aadhaar
        ---------------------------------------------------

        IF EXISTS
        (
            SELECT 1
            FROM leasing.Tenant
            WHERE AadhaarNumber = @AadhaarNumber
        )
        BEGIN
            THROW 50002,'Aadhaar Number already exists.',1;
        END;

        ---------------------------------------------------
        -- Insert
        ---------------------------------------------------

        INSERT INTO leasing.Tenant
        (
            TenantCode,
            FirstName,
            LastName,
            Email,
            Phone,
            AadhaarNumber,
            DateOfBirth,
            EmergencyContactName,
            EmergencyContactPhone
        )
        VALUES
        (
            @TenantCode,
            @FirstName,
            @LastName,
            @Email,
            @Phone,
            @AadhaarNumber,
            @DateOfBirth,
            @EmergencyContactName,
            @EmergencyContactPhone
        );

        PRINT 'Tenant added successfully.';

    END TRY

    BEGIN CATCH

        THROW;

    END CATCH

END;
GO