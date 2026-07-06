USE LeaseBillingEngine;
GO

CREATE TABLE finance.PaymentMode
(
    PaymentModeId INT IDENTITY(1,1) NOT NULL,
    PaymentModeCode VARCHAR(20) NOT NULL,
    PaymentModeName VARCHAR(50) NOT NULL,
    Description VARCHAR(200) NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_PaymentMode_IsActive DEFAULT(1),

    CreatedDAte DATETIME2 NOT NULL
        CONSTRAINT DF_PaymentMode_CreatedDate DEFAULT(SYSDATETIME()),

    ModifiedDate DATETIME2 NULL,

    CONSTRAINT PK_PaymentMode
        PRIMARY KEY (PaymentModeId),
    
    CONSTRAINT UQ_PaymentMode_Code
        UNIQUE(PaymentModeCode)
);
GO

