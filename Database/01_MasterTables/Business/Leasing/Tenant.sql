USE LeasingBillingEngine;
GO

CREATE TABLE leasing.Tenant
(
    TenantId INT IDENTITY(1,1) NOT NULL,
    TenantCode VARCHAR(20) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    AadhaarNumber CHAR(12) NOT NULL,
    DateofBirth DATE NULL,
    EmergencyContactName NVARCHAR(100) NULL,
    EmergencyContactPhone VARCHAR(20) NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_Tenant_IsActive
        DEFAULT(1),
    
    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_Tenant_CreatedDate
        DEFAULT(SYSDATETIME()),
    
    ModifiedDate DATETIME2 NULL,

    CONSTRAINT PK_Tenant
        PRIMARY KEY CLUSTERED(TenantId),
    
    CONSTRAINT UQ_Tenant_Code
        UNIQUE(TenantCode),
    
    CONSTRAINT UQ_Tenant_Email
        UNIQUE(Email),

    CONSTRAINT UQ_Tenant_Phone
        UNIQUE(Phone),

    CONSTRAINT UQ_Tenant_Aadhaa
        UNIQUE(AadhaarNumber)

    CONSTRAINT CK_Tenant_AadhaarLength
        CHECK(LEN(AadhaarNumber) = 12)
);
GO