USE LeaseBillingEngine;
GO

CREATE TABLE property.Building
(
    BuildingId INT IDENTITY(1,1) NOT NULL,
    PropertyId INT NOT NULL,
    BuildingCode VARCHAR(20) NOT NULL,
    BuildingName NVARCHAR(100) NOT NULL,
    NumberOfFloors SMALLINT NOT NULL,
    YearBuilt SMALLINT NOT NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_Building_IsActive 
        DEFAULT(1),
    
    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_Building_CreatedDAte
        DEFAULT(SYSDATETIME()),
    
    ModifiedDate DATETIME2 NULL,

    CONSTRAINT PK_Building
        PRIMARY KEY CLUSTERED(BuildingId),

    CONSTRAINT FK_Building_Property
        FOREIGN KEY (PropertyId)
        REFERENCES property.Property(PropertyId),

    CONSTRAINT UQ_Building_Property_BuildingCode
        UNIQUE(PropertyId, BuildingCode),

    CONSTRAINT CK_Building_NumberOfFloors
        CHECK(NUmberOfFloors > 0),
    
    CONSTRAINT CK_Building_YearBuilt
        CHECK(YearBuilt BETWEEN 1900 AND YEAR(GETDATE()))    
);
GO