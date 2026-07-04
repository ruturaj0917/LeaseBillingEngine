CREATE TABLE property.PropertyType
(
    PropertyTypeId INT IDENTITY(1,1) NOT NULL,

    PropertyTypeCode VARCHAR(20) NOT NULL,

    PropertyTypeName NVARCHAR(50) NOT NULL,

    Description NVARCHAR(200) NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_PropertyType_IsActive
        DEFAULT (1),

    CreateDate DATETIME2 NOT NULL
        CONSTRAINT DF_PropertyType_CreatedDate
        DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_PropertyType
        PRIMARY KEY (PropertyTypeId),

    CONSTRAINT UQ_PropertyType_Code
        UNIQUE (PropertyTypeCode),

    CONSTRAINT UQ_PropertyType_Name
        UNIQUE (PropertyTypeName)
);
GO