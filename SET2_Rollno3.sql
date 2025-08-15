create database hospital_management_system;
use hospital_management_system;

create table Doctors(
DoctorID INT PRIMARY KEY,
Name Varchar(50),
Specialization Varchar(40),
Phone varchar(10) Check (Phone REGEXP'^[789]') ,
JoiningDate date
);


create table Patients(
PatientID INT PRIMARY KEY,
Name Varchar(50),
DOB date,
Gender Varchar(10),
Phone varchar(10) Check (Phone REGEXP'^[789]')
);

create table Appointments(
AppointmentID INT PRIMARY KEY,
PatientID INT,
DoctorID INT,
Date date,
Time time,
Status Varchar(30) DEFAULT('Pending'),
FOREIGN KEY (PatientID) references Patients(PatientID),
FOREIGN KEY (DoctorID) references Doctors(DoctorID)
);

create table Departments(
DeptID INT PRIMARY KEY,
DeptName Varchar(40),
Location Varchar(40)
);

create table Bills(
BillID INT PRIMARY KEY,
PatientID INT,
Amount DECIMAL(10,2),
BillDate datetime,
PaymentStatus Varchar(30) DEFAULT('Pending'),
FOREIGN KEY (PatientID) references Patients(PatientID)
);

INSERT INTO Doctors(DoctorID,Name, Specialization, Phone, JoiningDate)
Values(101, 'Dr.Shika Gaur', 'Cardiology', '9770478987', '2018-05-02'),
(102, 'Dr.Mansi Mehta', 'Neurology', '8770478987', '2015-01-12'),
(103, 'Dr.Tejas Gupta', 'Neurology', '7704789897', '2020-11-02'),
(104, 'Dr.Raj Kapoor', 'Cardiology', '8890478987', '2014-07-09'),
(105, 'Dr.Ganesh Shetty', 'Surgeon', '980478987', '2021-10-02');

INSERT INTO Patients(PatientID, Name, DOB, Gender, Phone)
Values(001, 'Sanea Rajput', '2003-02-02', 'Female', '8970478987'),
(002, 'Pratham Agrawal', '2000-02-09', 'Male', '7770478987'),
(003, 'Faruq Siddiqi', '2011-11-01', 'Male', '8704733897'),
(004, 'Arsh Rawat', '1999-07-08', 'Male', '8690478987'),
(005, 'Vihan Gupta', '1992-01-02', 'Male', '780478987'),
(006, 'Bhoomi Mehra', '1988-06-15', 'Female', '8812345678'),
(007, 'Adithi Joshi', '1963-12-20', 'Female', '7923456789'),
(008, 'Kabir Agicha', '1951-03-05', 'Male', '9834567890');

INSERT INTO Appointments(AppointmentID,PatientID, DoctorID, Date, Time, Status)
Values(467, 002, 101, '2025-08-12', '09:30', 'Pending'),
(432, 003, 102, '2025-08-15', '10:45', 'Pending'),
(421, 001, 101, '2025-07-28', '01:00', 'Completed'),
(399, 007, 103, '2025-08-12', '13:00', 'Cancelled'),
(397, 005, 105, '2025-08-12', '09:20', 'Completed'),
(470, 004, 104, '2025-08-12', '11:20', 'Pending'),
(468, 006, 105, '2025-07-20', '15:00', 'Completed'),
(465, 008, 102, '2025-07-22', '14:00', 'Pending'),
(462, 001, 103, '2025-06-25', '10:00', 'Cancelled'),
(460, 008, 101, '2025-07-28', '12:30', 'Completed');

INSERT INTO Departments(DeptID,DeptName,Location )
Values(1, 'Surgeon', 'Floor 3'),
(2, 'Dermatology', 'Floor 1'),
(3, 'Neurology', 'Floor 1'),
(4, 'Orthopedics', 'Floor 2'),
(5, 'Cardiology', 'Floor 4');

INSERT INTO  Bills(BillID, PatientID, Amount,BillDate, PaymentStatus)
Values(105, 007, 4200.00, '2025-08-12 14:35', 'Cancelled'),
(112, 002, 2500.00, '2025-07-28 09:20', 'Pending'),
(119, 005, 2750.00, '2025-08-12 11:45', 'Pending'),
(124, 008, 5000.00, '2025-08-11 16:10', 'Paid'),
(131, 003, 5200.50, '2025-08-15 10:55', 'Pending'),
(138, 001, 1500.75, '2025-07-28 08:05', 'Completed'),
(145, 006, 2100.50, '2025-07-27 15:40', 'Paid'),
(152, 004, 3500.00, '2025-08-12 13:25', 'Pending');

-- 1 
select * 
from Doctors
where Specialization='Cardiology';

-- 2
select * 
from Patients
where DOB<'1965-01-01';

-- 3
select * 
from Appointments 
where Date=curdate();

-- 6
select * 
from Bills 
where Amount>5000.00;

-- 7
select *
from Bills 
where PaymentStatus='Pending';

-- 8
select DoctorID, count(*) as total 
from Appointments 
group by DoctorID desc
limit 1;

-- 12
select * 
from Doctors
where JoiningDate>'2020-01-01';

-- 13
select * 
from Patients
where Name REGEXP('^A');


-- 10 
select * 
from Patients
order by DOB 
limit 3;

-- 14
select * 
from Appointments 
where Status='Cancelled';

-- 15
select Date, count(*) 
from Appointments 
group by Date;

-- 18
select * 
from Doctors 
where Specialization='Neurology';

-- 23
select *
from Doctors 
where Phone REGEXP('^98');



-- 11
alter table Bills add DeptID INT;
alter table Bills add constraint fk_billsdepartments FOREIGN KEY (DeptID) references Departments(DeptID);

select DeptID, Avg(Amount)
from Bills 
group by DeptID;

-- 17
alter table Doctors add DeptName varchar(50);

update Doctors set DeptName='Surgeon' 
where DoctorID=105;

update Doctors set DeptName='Neurology'
where DoctorID in (102,103);

update Doctors set DeptName='Orthopedics' where DoctorID=104;
update Doctors set DeptName='Cardiology'
where DoctorID in (101,104);

select DeptName, Name 
from Doctors;

-- 16
alter table patients add Visit INT;
update patients set Visit=5 where PatientID=1;
update patients set Visit=2 where PatientID=2;
update patients set Visit=4 where PatientID=3;
update patients set Visit=1 where PatientID=4;

select * 
from patients 
where Visit>3;

-- 8
alter table doctors add Appointment INT;
update doctors set Appointment=7 where DoctorID=101;
update doctors set Appointment=4 where DoctorID=102;
update doctors set Appointment=13 where DoctorID=103;

select * 
from Doctors 
order by Appointment DESC
limit 1;

-- 5
alter table patients add DoctorID INT;
update patients set DoctorID=101 where PatientID in (001,002);
update patients set DoctorID=105 where PatientID in (004,006);

select * 
from Patients 
where DoctorID=101;

-- 20
select PatientID, SUM(Amount) as Total
from Bills 
group by PatientID 
order by Total
limit 5;

-- 19
select PatientID, SUM(Amount)
from Bills
group by PatientID;