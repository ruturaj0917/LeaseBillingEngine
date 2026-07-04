USE LeaseBillingEngine;
GO

CREATE TABLE property.ApartmentUnit
(
    UnitId INT IDENTITY(1,1) NOT NULL,

    BuildingId INT NOT NULL,

    UnitNumber VARCHAR(20) NOT NULL,

    FloorNumber SMALLINT NOT NULL,

    BedroomCount TINYINT NOT NULL,

    BathroomCount TINYINT NOT NULL,

    CarpetAreaSqFt DECIMAL(8,2) NOT NULL,

    OccupancyStatusId INT NOT NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_ApartmentUnit_IsActive
        DEFAULT (1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_ApartmentUnit_CreatedDate
        DEFAULT (SYSDATETIME()),

    ModifiedDate DATETIME2 NULL,

    CONSTRAINT PK_ApartmentUnit
        PRIMARY KEY CLUSTERED (UnitId),

    CONSTRAINT FK_ApartmentUnit_Building
        FOREIGN KEY (BuildingId)
        REFERENCES property.Building(BuildingId),

    CONSTRAINT FK_ApartmentUnit_OccupancyStatus
        FOREIGN KEY (OccupancyStatusId)
        REFERENCES property.OccupancyStatus(OccupancyStatusId),

    CONSTRAINT UQ_ApartmentUnit_Building_UnitNumber
        UNIQUE (BuildingId, UnitNumber),

    CONSTRAINT CK_ApartmentUnit_Floor
        CHECK (FloorNumber >= 0),

    CONSTRAINT CK_ApartmentUnit_Bedrooms
        CHECK (BedroomCount >= 0),

    CONSTRAINT CK_ApartmentUnit_Bathrooms
        CHECK (BathroomCount >= 1),

    CONSTRAINT CK_ApartmentUnit_Area
        CHECK (CarpetAreaSqFt > 0)
);
GO