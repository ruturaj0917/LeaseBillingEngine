USE LeaseBillingEngine;
GO

CREATE VIEW finance.vw_MonthlyRevenue
AS

SELECT

    fp.PeriodCode,

    COUNT(pay.PaymentId) AS TotalPayments,

    SUM(pay.PaymentAmount) AS TotalRevenue,

    AVG(pay.PaymentAmount) AS AveragePayment,

    MIN(pay.PaymentAmount) AS LowestPayment,

    MAX(pay.PaymentAmount) AS HighestPayment

FROM finance.Payment pay

INNER JOIN finance.FiscalPeriod fp
ON pay.FiscalPeriodId = fp.FiscalPeriodId

GROUP BY fp.PeriodCode;
GO