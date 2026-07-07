USE LeaseBillingEngine;
GO

CREATE VIEW finance.vw_DashboardKPIs
AS

SELECT

    -------------------------------------------------------
    -- Property Statistics
    -------------------------------------------------------

    (SELECT COUNT(*) FROM property.Property)
        AS TotalProperties,

    (SELECT COUNT(*) FROM property.Building)
        AS TotalBuildings,

    (SELECT COUNT(*) FROM property.ApartmentUnit)
        AS TotalUnits,

    -------------------------------------------------------
    -- Occupancy
    -------------------------------------------------------

    (SELECT COUNT(*)
     FROM property.ApartmentUnit a
     INNER JOIN property.OccupancyStatus os
     ON a.OccupancyStatusId = os.OccupancyStatusId
     WHERE os.OccupancyStatusCode='OCC')
        AS OccupiedUnits,

    (SELECT COUNT(*)
     FROM property.ApartmentUnit a
     INNER JOIN property.OccupancyStatus os
     ON a.OccupancyStatusId = os.OccupancyStatusId
     WHERE os.OccupancyStatusCode='VAC')
        AS VacantUnits,

    -------------------------------------------------------
    -- Leasing
    -------------------------------------------------------

    (SELECT COUNT(*)
     FROM leasing.Lease l
     INNER JOIN leasing.LeaseStatus ls
     ON l.LeaseStatusId = ls.LeaseStatusId
     WHERE ls.LeaseStatusCode='ACT')
        AS ActiveLeases,

    -------------------------------------------------------
    -- Finance
    -------------------------------------------------------

    (SELECT ISNULL(SUM(PaymentAmount),0)
     FROM finance.Payment)
        AS TotalRevenue,

    (SELECT ISNULL(SUM(OutstandingAmount),0)
     FROM finance.Charge)
        AS TotalOutstanding;
GO