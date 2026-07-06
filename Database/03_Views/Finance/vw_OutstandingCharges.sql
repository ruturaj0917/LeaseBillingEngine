
USE LeaseBillingEngine;
GO

CREATE VIEW finance.vw_OutstandingCharges
AS

SELECT

    c.ChargeId,

    p.PropertyName,

    CONCAT(t.FirstName,' ',t.LastName) AS TenantName,

    l.LeaseCode,

    cc.ChargeName,

    c.ChargeAmount,

    c.OutstandingAmount,

    c.DueDate,

    CASE

        WHEN c.OutstandingAmount = 0
            THEN 'Paid'

        WHEN c.DueDate < GETDATE()
            THEN 'Overdue'

        ELSE 'Pending'

    END AS PaymentStatus

FROM finance.Charge c

INNER JOIN finance.ChargeCode cc
ON c.ChargeCodeId = cc.ChargeCodeId

INNER JOIN leasing.Lease l
ON c.LeaseId = l.LeaseId

INNER JOIN leasing.Tenant t
ON l.TenantId = t.TenantId

INNER JOIN property.ApartmentUnit a
ON l.UnitId = a.UnitId

INNER JOIN property.Building b
ON a.BuildingId = b.BuildingId

INNER JOIN property.Property p
ON b.PropertyId = p.PropertyId;
GO