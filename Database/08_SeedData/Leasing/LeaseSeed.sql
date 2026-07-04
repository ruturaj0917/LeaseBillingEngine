USE LeaseBillingEngine;
GO

INSERT INTO leasing.Lease
(
    LeaseCode,
    TenantId,
    UnitId,
    LeaseStatusId,
    StartDate,
    EndDate,
    MonthlyRent,
    SecurityDeposit,
    Notes
)
VALUES

('LEA000001',1,1,2,'2026-01-01','2026-12-31',25000,50000,'Annual Residential Lease'),

('LEA000002',2,2,2,'2026-02-01','2027-01-31',28000,56000,'Annual Residential Lease'),

('LEA000003',3,4,2,'2026-01-15','2027-01-14',30000,60000,'Family Lease'),

('LEA000004',4,6,2,'2026-03-01','2027-02-28',22000,44000,'One Bedroom Apartment'),

('LEA000005',5,8,2,'2026-04-01','2027-03-31',26000,52000,'Residential Lease'),

('LEA000006',6,10,2,'2026-05-01','2027-04-30',35000,70000,'Penthouse Lease'),

('LEA000007',7,12,2,'2026-06-01','2027-05-31',24000,48000,'Family Apartment'),

('LEA000008',8,15,2,'2026-07-01','2027-06-30',29000,58000,'Premium Apartment'),

('LEA000009',9,18,2,'2026-08-01','2027-07-31',23000,46000,'Residential'),

('LEA000010',10,21,2,'2026-09-01','2027-08-31',32000,64000,'Corporate Lease');
GO