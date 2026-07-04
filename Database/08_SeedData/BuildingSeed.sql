USE LeaseBillingEngine;
GO

INSERT INTO property.Building
(
    PropertyId,
    BuildingCode,
    BuildingName,
    NumberOfFloors,
    YearBuilt
)
VALUES
(1,'A','Building A',10,2018),
(1,'B','Building B',12,2019),
(1,'C','Building C',8,2020),

(2,'A','Tower A',15,2021),
(2,'B','Tower B',15,2021),

(3,'T1','Tower 1',20,2017),
(3,'T2','Tower 2',22,2018),

(4,'A','Block A',18,2022),
(5,'A','Wing A',14,2020),
(6,'A','Corporate Tower',25,2016);
GO