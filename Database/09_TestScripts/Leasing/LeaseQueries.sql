USE LeaseBillingEngine;
GO

PRINT '==================================================';
PRINT 'QUERY 1: ACTIVE LEASE DETAILS (MULTI-TABLE JOIN)';
PRINT '==================================================';
SELECT 
    l.LeaseCode, 
    t.TenantCode, 
    CONCAT(t.FirstName, ' ', t.LastName) AS TenantName, 
    p.PropertyName, 
    b.BuildingName, 
    a.UnitNumber, 
    l.MonthlyRent, 
    l.SecurityDeposit, 
    ls.LeaseStatusName, 
    l.StartDate, 
    l.EndDate
FROM leasing.Lease l
INNER JOIN leasing.Tenant t ON l.TenantId = t.TenantId
INNER JOIN property.ApartmentUnit a ON l.UnitId = a.UnitId
INNER JOIN property.Building b ON a.BuildingId = b.BuildingId
INNER JOIN property.Property p ON b.PropertyId = p.PropertyId
INNER JOIN leasing.LeaseStatus ls ON l.LeaseStatusId = ls.LeaseStatusId
ORDER BY l.LeaseId;


PRINT '==================================================';
PRINT 'QUERY 2: VACANT APARTMENTS (LEFT JOIN ANTI-JOIN)';
PRINT '==================================================';
SELECT 
    p.PropertyName, 
    b.BuildingName, 
    a.UnitNumber
FROM property.ApartmentUnit a
INNER JOIN property.Building b ON a.BuildingId = b.BuildingId
INNER JOIN property.Property p ON b.PropertyId = p.PropertyId
LEFT JOIN leasing.Lease l ON a.UnitId = l.UnitId AND l.LeaseStatusId = 2 -- 2 = Active
WHERE l.LeaseId IS NULL;


PRINT '==================================================';
PRINT 'QUERY 3: RAW LIST OF ACTIVE LEASES';
PRINT '==================================================';
SELECT 
    LeaseCode, 
    MonthlyRent, 
    StartDate, 
    EndDate
FROM leasing.Lease
WHERE LeaseStatusId = 2;


PRINT '==================================================';
PRINT 'QUERY 4: TOTAL EXPECTED MONTHLY REVENUE';
PRINT '==================================================';
SELECT 
    SUM(MonthlyRent) AS TotalMonthlyRevenue
FROM leasing.Lease
WHERE LeaseStatusId = 2;
GO