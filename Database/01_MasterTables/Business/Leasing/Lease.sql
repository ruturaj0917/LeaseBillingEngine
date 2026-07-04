USE LeaseBillingEngine;
GO

CREATE TABLE leasing.Lease
(
    LeaseId INT IDENTITY(1,1) NOT NULL,

    LeaseCode VARCHAR(20) NOT NULL,

    TenantId INT NOT NULL,

    UnitId INT NOT NULL,

    LeaseStatusId INT NOT NULL,

    StartDate DATE NOT NULL,

    EndDate DATE NOT NULL,

    MonthlyRent DECIMAL(12,2) NOT NULL,

    SecurityDeposit DECIMAL(12,2) NOT NULL,

    Notes NVARCHAR(500) NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_Lease_IsActive
        DEFAULT (1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_Lease_CreatedDate
        DEFAULT (SYSDATETIME()),

    ModifiedDate DATETIME2 NULL,

    ----------------------------------------------------
    -- Primary Key
    ----------------------------------------------------

    CONSTRAINT PK_Lease
        PRIMARY KEY CLUSTERED (LeaseId),

    ----------------------------------------------------
    -- Unique
    ----------------------------------------------------

    CONSTRAINT UQ_Lease_Code
        UNIQUE (LeaseCode),

    ----------------------------------------------------
    -- Foreign Keys
    ----------------------------------------------------

    CONSTRAINT FK_Lease_Tenant
        FOREIGN KEY (TenantId)
        REFERENCES leasing.Tenant(TenantId),

    CONSTRAINT FK_Lease_ApartmentUnit
        FOREIGN KEY (UnitId)
        REFERENCES property.ApartmentUnit(UnitId),

    CONSTRAINT FK_Lease_LeaseStatus
        FOREIGN KEY (LeaseStatusId)
        REFERENCES leasing.LeaseStatus(LeaseStatusId),

    ----------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------

    CONSTRAINT CK_Lease_Date
        CHECK (EndDate > StartDate),

    CONSTRAINT CK_Lease_MonthlyRent
        CHECK (MonthlyRent > 0),

    CONSTRAINT CK_Lease_Deposit
        CHECK (SecurityDeposit >= 0)
);
GO