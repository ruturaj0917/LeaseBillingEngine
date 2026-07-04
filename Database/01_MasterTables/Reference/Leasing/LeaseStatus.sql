USE LeaseBillingEngine;
Go

CREATE TABLE Leasing.LeaseStatus
(
     LeaseStatusId INT IDENTITY(1,1) NOT NULL,
     LeaseStatusCode VARCHAR(10) NOT NULL,
     LeaseStatusName NVARCHAR(50) NOT NULL,
     Description NVARCHAR(200) NULL,

     IsACtive BIT NOT NULL
        CONSTRAINT DF_LeaseStatus_IsActive
        DEFAULT (1),
    
    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_ LeaseStatus_createdDate
        DEFAULT (SYSDATETIME()),
    
    CONSTRAINT PK_ LeaseStatus
        PRIMARY KEY CLUSTERED ( LeaseStatusId),

    CONSTRAINT UQ_LeaseStatus_Code
        UNIQUE ( LeaseStatusCode),
    
    CONSTRAINT UQ_LeaseStatus_Name
        UNIQUE ( LeaseStatusName)
);
GO