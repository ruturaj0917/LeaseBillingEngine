USE LeaseBillingEngine;
GO

CREATE TABLE property.OccupancyStatus
(
    OccupancyStatusId INT IDENTITY(1,1) NOT NULL,

    OccupancyStatusCode VARCHAR(10) NOT NULL,

    OccupancyStatusName NVARCHAR(50) NOT NULL,

    Description NVARCHAR(200) NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_OccupancyStatus_IsActive
        DEFAULT (1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_OccupancyStatus_CreatedDate
        DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_OccupancyStatus
        PRIMARY KEY CLUSTERED (OccupancyStatusId),

    CONSTRAINT UQ_OccupancyStatus_Code
        UNIQUE (OccupancyStatusCode),

    CONSTRAINT UQ_OccupancyStatus_Name
        UNIQUE (OccupancyStatusName)
);
GO