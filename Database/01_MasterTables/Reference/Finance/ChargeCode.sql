USE LeaseBillingEngine;
GO

CREATE TABLE finance.ChargeCode
(
    ChargeCodeId INT IDENTITY(1,1) NOT NULL,

    ChargeCode VARCHAR(20) NOT NULL,

    ChargeName VARCHAR(100) NOT NULL,

    Description VARCHAR(200) NULL,

    IsRecurring BIT NOT NULL
        CONSTRAINT DF_ChargeCode_IsRecurring
        DEFAULT (1),

    IsActive BIT NOT NULL
        CONSTRAINT DF_ChargeCode_IsActive
        DEFAULT (1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_ChargeCode_CreatedDate
        DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_ChargeCode
        PRIMARY KEY (ChargeCodeId),

    CONSTRAINT UQ_ChargeCode_Code
        UNIQUE (ChargeCode),

    CONSTRAINT UQ_ChargeCode_Name
        UNIQUE (ChargeName)
);
GO