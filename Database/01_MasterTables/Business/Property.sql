USE LeaseBillingEngine;
Go

CREATE TABLE property.Property
(
    PropertyId INT IDENTITY(1,1) NOT NULL,
    PropertyCode VARCHAR(20) NOT NULL,
    PropertyName NVARCHAR(100) NOT NULL,
    PropertyTypeId INT NOT NULL,
    PropertyStatusId INT NOT NULL,
    AddressLine1 NVARCHAR(200) NOT NULL,
    AddressLine2 NVARCHAR(200) NULL,
    City NVARCHAR(50) NOT NULL,
    State NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    PostalCode VARCHAR(15) NOT NULL,
    OpeningDate DATE NOT NUL,
    TotalBuilding INT NOT NULL
        CONSTRAINT DF_Peoperty_TotalBuilding DEFAULT(0),
    TotalUnits INT NOT NULL
        CONSTRAINT DF_Property_TotalUnits DEFAULT(0),
    TimeZone VARCHAR(50) NOT NULL
        CONSTRAINT DF_Property_TimeZone DEFAULT('Asia/Kolkata'),
    IsActive BIT NOT NULL
        CONSTRAINT DF_Property_IsActive DEFAULT(1),
    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_Property_CreatedDate DEFAULT(SYSDATETIME()),
    ModifiedDate DATETIME2 NULL,

    CONSTRAINT PK_Property
        PRIMARY KEY CLUSTERED(PropertyId),
    
    CONSTRAINT UQ_Property_Code
        UNIQUE(PropertyCOde),

    CONSTRAINT FK_Property_PropertyType
        FOREIGN KEY (PropertyTypeId)
        REFERENCE property.PropertyType(PropertyTypeId),
    
    CONSTRAINT FK_Property_PropertyStatus
        FOREIGN KEY (PropertyStatusId)
        REFERENCES property.PropertyStatus(PropertyStatusId)
);

GO