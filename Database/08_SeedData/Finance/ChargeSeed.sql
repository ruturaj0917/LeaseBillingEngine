USE LeaseBillingEngine;
GO

INSERT INTO finance.Charge
(
    ChargeCodeId,
    LeaseId,
    FiscalPeriodId,
    ChargeDate,
    DueDate,
    ChargeAmount,
    OutstandingAmount,
    Notes
)
VALUES

-- Lease 1
(1,1,7,'2026-07-01','2026-07-10',25000,25000,'July Rent'),

-- Lease 2
(1,2,7,'2026-07-01','2026-07-10',28000,28000,'July Rent'),

-- Lease 3
(1,3,7,'2026-07-01','2026-07-10',30000,30000,'July Rent'),

-- Lease 4
(1,4,7,'2026-07-01','2026-07-10',22000,22000,'July Rent'),

-- Lease 5
(1,5,7,'2026-07-01','2026-07-10',26000,26000,'July Rent'),

-- Lease 6
(1,6,7,'2026-07-01','2026-07-10',35000,35000,'July Rent'),

-- Lease 7
(1,7,7,'2026-07-01','2026-07-10',24000,24000,'July Rent'),

-- Lease 8
(1,8,7,'2026-07-01','2026-07-10',29000,29000,'July Rent'),

-- Lease 9
(1,9,7,'2026-07-01','2026-07-10',23000,23000,'July Rent'),

-- Lease 10
(1,10,7,'2026-07-01','2026-07-10',32000,32000,'July Rent');
GO