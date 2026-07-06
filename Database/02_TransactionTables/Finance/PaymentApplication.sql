USE LeaseBillingEngine;
GO

CREATE TABLE finance.PaymentApplication
(
    PaymentApplicationId INT IDENTITY(1,1) NOT NULL,

    PaymentId INT NOT NULL,

    ChargeId INT NOT NULL,

    AppliedAmount DECIMAL(18,2) NOT NULL,

    AppliedDate DATE NOT NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_PaymentApplication_IsActive
        DEFAULT(1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_PaymentApplication_CreatedDate
        DEFAULT(SYSDATETIME()),

    ModifiedDate DATETIME2 NULL,

--------------------------------------------------------

    CONSTRAINT PK_PaymentApplication
        PRIMARY KEY (PaymentApplicationId),

--------------------------------------------------------

    CONSTRAINT FK_PA_Payment
        FOREIGN KEY (PaymentId)
        REFERENCES finance.Payment(PaymentId),

    CONSTRAINT FK_PA_Charge
        FOREIGN KEY (ChargeId)
        REFERENCES finance.Charge(ChargeId),

--------------------------------------------------------

    CONSTRAINT CK_PA_AppliedAmount
        CHECK (AppliedAmount > 0)
);
GO