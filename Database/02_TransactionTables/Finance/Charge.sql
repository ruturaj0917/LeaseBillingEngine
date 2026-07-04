USE LeaseBillingEngine;
GO

CREATE TABLE finance.Charge
(
    ChargeId INT IDENTITY(1,1) NOT NULL,

    ChargeCodeId INT NOT NULL,

    LeaseId INT NOT NULL,

    FiscalPeriodId INT NOT NULL,

    ChargeDate DATE NOT NULL,

    DueDate DATE NOT NULL,

    ChargeAmount DECIMAL(18,2) NOT NULL,

    OutstandingAmount DECIMAL(18,2) NOT NULL,

    Notes VARCHAR(250) NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_Charge_IsActive
        DEFAULT (1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_Charge_CreatedDate
        DEFAULT (SYSDATETIME()),

    ModifiedDate DATETIME2 NULL,

    -------------------------------------------------

    CONSTRAINT PK_Charge
        PRIMARY KEY CLUSTERED (ChargeId),

    -------------------------------------------------

    CONSTRAINT FK_Charge_Lease
        FOREIGN KEY (LeaseId)
        REFERENCES leasing.Lease(LeaseId),

    CONSTRAINT FK_Charge_ChargeCode
        FOREIGN KEY (ChargeCodeId)
        REFERENCES billing.ChargeCode(ChargeCodeId),

    CONSTRAINT FK_Charge_FiscalPeriod
        FOREIGN KEY (FiscalPeriodId)
        REFERENCES finance.FiscalPeriod(FiscalPeriodId),

    -------------------------------------------------

    CONSTRAINT CK_Charge_Amount
        CHECK (ChargeAmount > 0),

    CONSTRAINT CK_Charge_Outstanding
        CHECK (OutstandingAmount >= 0),

    CONSTRAINT CK_Charge_DueDate
        CHECK (DueDate >= ChargeDate)
);
GO