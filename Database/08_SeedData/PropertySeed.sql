USE LeaseBillingEngine;
GO

INSERT INTO property.Property
(
    PropertyCode,
    PropertyName,
    PropertyTypeId,
    PropertyStatusId,
    AddressLine1,
    AddressLine2,
    City,
    State,
    Country,
    PostalCode,
    OpeningDate
)
VALUES
(
    'PUNE001',
    'Green Valley Residency',
    1,          -- Residential
    1,          -- Active
    'Baner Road',
    'Near Metro Station',
    'Pune',
    'Maharashtra',
    'India',
    '411045',
    '2023-01-15'
),

(
    'PUNE002',
    'Sunrise Apartments',
    1,
    1,
    'Wakad Main Road',
    NULL,
    'Pune',
    'Maharashtra',
    'India',
    '411057',
    '2022-10-01'
),

(
    'MUM001',
    'Skyline Towers',
    2,          -- Commercial
    1,
    'Bandra West',
    NULL,
    'Mumbai',
    'Maharashtra',
    'India',
    '400050',
    '2021-05-10'
),

(
    'HYD001',
    'Tech Park One',
    2,
    1,
    'HITEC City',
    NULL,
    'Hyderabad',
    'Telangana',
    'India',
    '500081',
    '2020-08-20'
),

(
    'BLR001',
    'Lake View Homes',
    1,
    1,
    'Whitefield',
    NULL,
    'Bengaluru',
    'Karnataka',
    'India',
    '560066',
    '2021-11-15'
),

(
    'DEL001',
    'Capital Business Center',
    2,
    1,
    'Connaught Place',
    NULL,
    'New Delhi',
    'Delhi',
    'India',
    '110001',
    '2020-03-01'
),

(
    'CHE001',
    'Marina Residency',
    1,
    1,
    'Anna Nagar',
    NULL,
    'Chennai',
    'Tamil Nadu',
    'India',
    '600040',
    '2022-02-10'
),

(
    'KOL001',
    'Eastern Heights',
    1,
    2,          -- Inactive
    'Salt Lake Sector V',
    NULL,
    'Kolkata',
    'West Bengal',
    'India',
    '700091',
    '2019-06-18'
),

(
    'AHM001',
    'Riverfront Plaza',
    2,
    3,          -- Under Maintenance
    'Ashram Road',
    NULL,
    'Ahmedabad',
    'Gujarat',
    'India',
    '380009',
    '2021-09-25'
),

(
    'GOA001',
    'Ocean View Villas',
    4,          -- Mixed Use
    1,
    'Calangute Beach Road',
    NULL,
    'North Goa',
    'Goa',
    'India',
    '403516',
    '2023-04-12'
);

GO