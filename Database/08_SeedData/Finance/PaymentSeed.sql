USE LeaseBillingEngine;
GO

INSERT INTO finance.Payment
(
    PaymentCode,
    LeaseId,
    BankAccountId,
    FiscalPeriodId,
    PaymentDate,
    PaymentAmount,
    PaymentModeId,
    ReferenceNumber,
    Notes
)
VALUES

('PAY000001',1,1,7,'2026-07-05',25000,2,'UPI100001','July Rent Payment'),

('PAY000002',2,1,7,'2026-07-06',28000,3,'NEFT100002','July Rent Payment'),

('PAY000003',3,2,7,'2026-07-04',30000,2,'UPI100003','July Rent Payment'),

('PAY000004',4,1,7,'2026-07-08',22000,1,'CASH100004','July Rent Payment'),

('PAY000005',5,3,7,'2026-07-05',26000,4,'CARD100005','July Rent Payment'),

('PAY000006',6,2,7,'2026-07-09',35000,3,'NEFT100006','July Rent Payment'),

('PAY000007',7,1,7,'2026-07-07',24000,2,'UPI100007','July Rent Payment'),

('PAY000008',8,3,7,'2026-07-10',29000,5,'CHQ100008','July Rent Payment'),

('PAY000009',9,2,7,'2026-07-05',23000,2,'UPI100009','July Rent Payment'),

('PAY000010',10,1,7,'2026-07-06',32000,3,'NEFT100010','July Rent Payment');
GO