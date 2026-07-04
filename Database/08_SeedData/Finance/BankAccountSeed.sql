USE LeaseBillingEngine;
GO

INSERT INTO finance.BankAccount
(
    AccountCode,
    BankName,
    BranchName,
    AccountNumber,
    IFSCCode,
    AccountType,
    CurrentBalance
)
VALUES

(
'OP001',
'State Bank of India',
'Pune Camp',
'123456789012',
'SBIN0000456',
'Operating',
2500000
),

(
'ESC001',
'HDFC Bank',
'Shivajinagar',
'223456789012',
'HDFC0001122',
'Escrow',
1500000
),

(
'MNT001',
'ICICI Bank',
'Kothrud',
'323456789012',
'ICIC0003344',
'Maintenance',
750000
);
GO