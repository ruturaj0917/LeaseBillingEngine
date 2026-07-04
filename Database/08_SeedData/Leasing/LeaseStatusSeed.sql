USE LeaseBillingEngine;
GO

INSERT INTO Leasing.LeaseStatus
(
    LeaseStatusCode,
    LEaseStatusName,
    Description
)
VALUES
('PEN', 'Pending', 'Lease created but not yet active'),
('ACT', 'Active', 'Currently active lease'),
('EXP','Expired','Lease Completed'),
('TER', 'Terminated','Lease ended before expiry'),
('REN','Renewed', 'LEase renewed');
Go