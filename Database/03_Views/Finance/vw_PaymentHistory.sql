USE LeaseBillingEngine;
GO

CREATE VIEW finance.vw_PaymentHistory
AS

SELECT

    pay.PaymentCode,

    CONCAT(t.FirstName,' ',t.LastName) AS TenantName,

    p.PropertyName,

    b.BuildingName,

    a.UnitNumber,

    pay.PaymentDate,

    pay.PaymentAmount,

    pm.PaymentModeName,

    ba.BankName,

    ba.AccountCode,

    fp.PeriodCode,

    pay.ReferenceNumber

FROM finance.Payment pay

INNER JOIN leasing.Lease l
ON pay.LeaseId = l.LeaseId

INNER JOIN leasing.Tenant t
ON l.TenantId = t.TenantId

INNER JOIN property.ApartmentUnit a
ON l.UnitId = a.UnitId

INNER JOIN property.Building b
ON a.BuildingId = b.BuildingId

INNER JOIN property.Property p
ON b.PropertyId = p.PropertyId

INNER JOIN finance.PaymentMode pm
ON pay.PaymentModeId = pm.PaymentModeId

INNER JOIN finance.BankAccount ba
ON pay.BankAccountId = ba.BankAccountId

INNER JOIN finance.FiscalPeriod fp
ON pay.FiscalPeriodId = fp.FiscalPeriodId;
GO