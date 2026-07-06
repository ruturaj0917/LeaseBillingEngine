USE LeaseBillingEngine;
GO

CREATE VIEW leasing.vw_LeaseSummary
AS

SELECT

    p.PropertyCode,
    p.PropertyName,

    COUNT(l.LeaseId) AS TotalLeases,

    SUM(l.MonthlyRent) AS TotalMonthlyRent,

    AVG(l.MonthlyRent) AS AverageRent,

    MIN(l.MonthlyRent) AS LowestRent,

    MAX(l.MonthlyRent) AS HighestRent

FROM leasing.Lease l

INNER JOIN property.ApartmentUnit a
ON l.UnitId = a.UnitId

INNER JOIN property.Building b
ON a.BuildingId = b.BuildingId

INNER JOIN property.Property p
ON b.PropertyId = p.PropertyId

INNER JOIN leasing.LeaseStatus ls
ON l.LeaseStatusId = ls.LeaseStatusId

WHERE ls.LeaseStatusCode='ACT'

GROUP BY

    p.PropertyCode,
    p.PropertyName;
GO