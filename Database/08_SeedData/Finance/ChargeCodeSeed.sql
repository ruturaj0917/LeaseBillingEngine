USE LeaseBillingEngine;
GO

INSERT INTO finance.ChargeCode
(
    ChargeCode,
    ChargeName,
    Description,
    IsRecurring
)
VALUES
('RENT','Monthly Rent','Monthly apartment rent',1),

('PARK','Parking Fee','Monthly parking charge',1),

('WATER','Water Charge','Monthly water bill',1),

('MAINT','Maintenance','Monthly maintenance charge',1),

('LATE','Late Fee','Late payment penalty',0),

('SECDEP','Security Deposit','Refundable security deposit',0);
GO