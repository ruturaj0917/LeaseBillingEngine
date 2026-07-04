USE LeaseBillingEngine;
GO

CREATE TABLE finance.FiscalPeriod
(
    FiscalPeriodId INT IDENTITY(1,1) NOT NULL,

    PeriodCode INT NOT NULL,

    PeriodYear SMALLINT NOT NULL,

    PeriodMonth TINYINT NOT NULL,

    MonthName VARCHAR(20) NOT NULL,

    StartDate DATE NOT NULL,

    EndDate DATE NOT NULL,

    IsClosed BIT NOT NULL
        CONSTRAINT DF_FiscalPeriod_IsClosed
        DEFAULT (0),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_FiscalPeriod_CreatedDate
        DEFAULT (SYSDATETIME()),

    -------------------------------------------------
    -- Primary Key
    -------------------------------------------------

    CONSTRAINT PK_FiscalPeriod
        PRIMARY KEY CLUSTERED (FiscalPeriodId),

    -------------------------------------------------
    -- Unique
    -------------------------------------------------

    CONSTRAINT UQ_FiscalPeriod_PeriodCode
        UNIQUE (PeriodCode),

    -------------------------------------------------
    -- Check Constraints
    -------------------------------------------------

    CONSTRAINT CK_FiscalPeriod_Month
        CHECK (PeriodMonth BETWEEN 1 AND 12),

    CONSTRAINT CK_FiscalPeriod_Year
        CHECK (PeriodYear >= 2020),

    CONSTRAINT CK_FiscalPeriod_Date
        CHECK (EndDate > StartDate)
);
GO