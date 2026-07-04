USE LeaseBillingEngine;
Go

CREATE TABLE property.PropertyStatus
(
    PropertyStatusId INT IDENTITY(1,1) NOT NULL,
    PropertyStatusCode VARCHAR(20) NOT NULL,
    PropertyStatusName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200) NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_PropertyStatus_IsActive
        DEFAULT(1),
    
    CreateData DATETIME2 NOT NULL
        CONSTRAINT DF_PropertyStatus_CreatedDate
        DEFAULT(SYSDATETIME()),
    
    CONSTRAINT PK_PropertyStatus
        PRIMARY KEY CLUSTERED(PropertyStatusId),
    
    CONSTRAINT UQ_PropertyStatus_Code
        UNIQUE(PropertyStatusCode),

    CONSTRAINT UQ_PropertyStatus_Name
        UNIQUE(PropertyStatusName)
);
GO