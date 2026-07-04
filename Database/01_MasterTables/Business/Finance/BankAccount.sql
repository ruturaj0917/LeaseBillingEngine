USE LeaseBillingEngine;
GO

CREATE TABLE finance.BankAccount
(
    BankAccountId INT IDENTITY(1,1) NOT NULL,

    AccountCode VARCHAR(20) NOT NULL,

    BankName VARCHAR(100) NOT NULL,

    BranchName VARCHAR(100) NOT NULL,

    AccountNumber VARCHAR(30) NOT NULL,

    IFSCCode VARCHAR(20) NOT NULL,

    AccountType VARCHAR(30) NOT NULL,

    CurrentBalance DECIMAL(18,2) NOT NULL
        CONSTRAINT DF_BankAccount_CurrentBalance
        DEFAULT (0),

    IsActive BIT NOT NULL
        CONSTRAINT DF_BankAccount_IsActive
        DEFAULT (1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_BankAccount_CreatedDate
        DEFAULT (SYSDATETIME()),

    ModifiedDate DATETIME2 NULL,

    --------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------

    CONSTRAINT PK_BankAccount
        PRIMARY KEY CLUSTERED (BankAccountId),

    --------------------------------------------------------
    -- Unique Keys
    --------------------------------------------------------

    CONSTRAINT UQ_BankAccount_AccountCode
        UNIQUE (AccountCode),

    CONSTRAINT UQ_BankAccount_AccountNumber
        UNIQUE (AccountNumber),

    --------------------------------------------------------
    -- Check Constraints
    --------------------------------------------------------

    CONSTRAINT CK_BankAccount_CurrentBalance
        CHECK (CurrentBalance >= 0),

    CONSTRAINT CK_BankAccount_AccountType
        CHECK (AccountType IN
        (
            'Operating',
            'Escrow',
            'Maintenance'
        ))
);
GO