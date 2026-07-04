USE LeaseBillingEngine;
GO

INSERT INTO property.PropertyStatus
(
    PropertyStatusCode,
    PropertyStatusName,
    Description
)
VALUES
('ACT', 'Active', 'Currently Opreational'),
('INA', 'Inactive', 'No longer managed'),
('UM', 'Under Maintenance', 'temporarily unavailable');
GO