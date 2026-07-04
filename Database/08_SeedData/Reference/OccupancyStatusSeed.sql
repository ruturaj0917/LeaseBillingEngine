USE LeaseBillingEngine;
GO

INSERT INTO property.OccupancyStatus
(
    OccupancyStatusCode,
    OccupancyStatusName,
    Description
)
VALUES
('VAC','Vacant','Available for leasing'),
('OCC','Occupied','Currently leased'),
('RES','Reserved','Reserved for a future tenant'),
('MNT','Maintenance','Temporarily unavailable');
GO