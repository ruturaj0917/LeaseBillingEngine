USE LeaseBillingEngine;
GO

INSERT INTO property.PropertyType
(
    PropertyTypeCode,
    PropertyTypeName,
    Description
)
VALUES
('RES', 'Residential', 'Residential Properties'),
('COM', 'Commericial', 'Commercoal Properties'),
('IND', 'Industrial', 'Industrial Properties'),
('MIX', 'Mixed Use', 'Mixed residential and commerical');
GO