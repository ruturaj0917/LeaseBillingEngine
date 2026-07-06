USE LeaseBillingEngine;
GO

INSERT INTO finance.PaymentMode
(
    PaymentModeCode,
    PaymentModeName,
    Description
)
VALUES
('CASH','Cash','Cash payment'),
('UPI','UPI','UPI transfer'),
('BANK','Bank Transfer','NEFT / RTGS / IMPS'),
('CARD','Card','Credit or Debit Card'),
('CHEQUE','Cheque','Cheque payment');
GO