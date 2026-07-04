USE LeaseBillingEngine;
GO

INSERT INTO leasing.Tenant
(
    TenantCode,
    FirstName,
    LastName,
    Email,
    Phone,
    AadhaarNumber,
    DateOfBirth,
    EmergencyContactName,
    EmergencyContactPhone
)
VALUES
('TEN000001','Amit','Sharma','amit.sharma@gmail.com','9876543201','123456789001','1994-05-12','Rajesh Sharma','9876500001'),

('TEN000002','Priya','Patil','priya.patil@gmail.com','9876543202','123456789002','1996-08-21','Sunita Patil','9876500002'),

('TEN000003','Rahul','Kulkarni','rahul.k@gmail.com','9876543203','123456789003','1993-11-09','Anita Kulkarni','9876500003'),

('TEN000004','Sneha','Joshi','sneha.joshi@gmail.com','9876543204','123456789004','1997-01-15','Suresh Joshi','9876500004'),

('TEN000005','Vikram','Deshmukh','vikram.d@gmail.com','9876543205','123456789005','1992-03-18','Meena Deshmukh','9876500005'),

('TEN000006','Neha','Pawar','neha.pawar@gmail.com','9876543206','123456789006','1998-07-04','Ajay Pawar','9876500006'),

('TEN000007','Rohan','Jadhav','rohan.j@gmail.com','9876543207','123456789007','1995-09-27','Kiran Jadhav','9876500007'),

('TEN000008','Pooja','More','pooja.more@gmail.com','9876543208','123456789008','1996-12-10','Mahesh More','9876500008'),

('TEN000009','Karan','Naik','karan.naik@gmail.com','9876543209','123456789009','1991-06-06','Rekha Naik','9876500009'),

('TEN000010','Anjali','Gupta','anjali.gupta@gmail.com','9876543210','123456789010','1999-02-25','Ramesh Gupta','9876500010');
GO