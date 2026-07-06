USE LeaseBillingEngine;
GO

CREATE VIEW property.vw_ApartmentAvailability
AS

SELECT

    p.PropertyCode,
    p.PropertyName,

    b.BuildingName,

    a.UnitId,
    a.UnitNumber,

    a.FloorNumber,

    a.BedroomCount,

    a.CarpetAreaSqFt,

    os.OccupancyStatusName

FROM property.ApartmentUnit a

INNER JOIN property.Building b
ON a.BuildingId = b.BuildingId

INNER JOIN property.Property p
ON b.PropertyId = p.PropertyId

INNER JOIN property.OccupancyStatus os
ON a.OccupancyStatusId = os.OccupancyStatusId;
GO