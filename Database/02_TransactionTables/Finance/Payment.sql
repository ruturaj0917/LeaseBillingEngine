USE LeaseBillingEngine;
GO

CREATE TABLE finance.Payment
(
    PaymentId INT IDENTITY(1,1) NOT NULL,

    PaymentCode VARCHAR(20) NOT NULL,

    LeaseId INT NOT NULL,

    BankAccountId INT NOT NULL,

    FiscalPeriodId INT NOT NULL,

    PaymentDate DATE NOT NULL,

    PaymentAmount DECIMAL(18,2) NOT NULL,

    PaymentModeId INT NOT NULL,

    ReferenceNumber VARCHAR(100) NULL,

    Notes VARCHAR(250) NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_Payment_IsActive
        DEFAULT(1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_Payment_CreatedDate
        DEFAULT(SYSDATETIME()),

    ModifiedDate DATETIME2 NULL,

--------------------------------------------------------

    CONSTRAINT PK_Payment
        PRIMARY KEY(PaymentId),

--------------------------------------------------------

    CONSTRAINT UQ_Payment_Code
        UNIQUE(PaymentCode),

--------------------------------------------------------

    CONSTRAINT FK_Payment_Lease
        FOREIGN KEY(LeaseId)
        REFERENCES leasing.Lease(LeaseId),

    CONSTRAINT FK_Payment_BankAccount
        FOREIGN KEY(BankAccountId)
        REFERENCES finance.BankAccount(BankAccountId),

    CONSTRAINT FK_Payment_FiscalPeriod
        FOREIGN KEY(FiscalPeriodId)
        REFERENCES finance.FiscalPeriod(FiscalPeriodId),

    CONSTRAINT FK_Payment_Mode
        FOREIGN KEY(PaymentModeId)
        REFERENCES finance.PaymentMode(PaymentModeId),

--------------------------------------------------------

    CONSTRAINT CK_Payment_Amount
        CHECK(PaymentAmount > 0)
);
GO