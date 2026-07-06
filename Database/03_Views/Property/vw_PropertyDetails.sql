USE LeaseBillingEngine;
GO

CREATE VIEW property.vw_PropertyDetails
AS

SELECT

    p.PropertyId,
    p.PropertyCode,
    p.PropertyName,

    pt.PropertyTypeName,

    ps.PropertyStatusName,

    b.BuildingName,

    a.UnitNumber,

    os.OccupancyStatusName,

    a.BedroomCount,

    a.CarpetAreaSqFt

FROM property.Property p

INNER JOIN property.PropertyType pt
ON p.PropertyTypeId = pt.PropertyTypeId

INNER JOIN property.PropertyStatus ps
ON p.PropertyStatusId = ps.PropertyStatusId

INNER JOIN property.Building b
ON p.PropertyId = b.PropertyId

INNER JOIN property.ApartmentUnit a
ON b.BuildingId = a.BuildingId

INNER JOIN property.OccupancyStatus os
ON a.OccupancyStatusId = os.OccupancyStatusId;
GO