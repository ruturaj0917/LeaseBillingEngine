USE LeaseBillingEngine;
GO

CREATE VIEW leasing.vw_ActiveLeases
AS

SELECT

    l.LeaseCode,

    t.TenantCode,
    CONCAT(t.FirstName,' ',t.LastName) AS TenantName,

    p.PropertyName,
    b.BuildingName,
    a.UnitNumber,

    l.StartDate,
    l.EndDate,

    l.MonthlyRent,

    ls.LeaseStatusName

FROM leasing.Lease l

INNER JOIN leasing.Tenant t
ON l.TenantId = t.TenantId

INNER JOIN property.ApartmentUnit a
ON l.UnitId = a.UnitId

INNER JOIN property.Building b
ON a.BuildingId = b.BuildingId

INNER JOIN property.Property p
ON b.PropertyId = p.PropertyId

INNER JOIN leasing.LeaseStatus ls
ON l.LeaseStatusId = ls.LeaseStatusId

WHERE ls.LeaseStatusCode='ACT';
GO