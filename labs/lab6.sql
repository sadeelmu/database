drop table drug_supplier cascade constraints;
drop table doctor cascade constraints;
drop table patient cascade constraints;
drop table drug cascade constraints;
drop table drug_amountstatus cascade constraints;

create table drug_supplier(supplier_id number(5) primary key,supplier_name varchar2(15),address varchar2(15));
insert into drug_supplier values(201,'ali','Amman');
insert into drug_supplier values(202,'omar','Zarqa');
insert into drug_supplier values(203,'hend','Irbid');
insert into drug_supplier values(204,'bana','Amman');
insert into drug_supplier values(205,'zaid',null);
-----------------------------------------------------------------------------------------------------------------------
create table doctor(id number(5) primary key,name varchar2(15),specialty varchar2(25));
insert into doctor values(121,'said','dermatologist');
insert into doctor values(122,'reem','internist');
insert into doctor values(123,'ahmad','surgeon');
insert into doctor values(124,'lina','internist');
insert into doctor values(125,'saleem','dermatologist');
-----------------------------------------------------------------------------------------------------------------------
create table patient(patient_id number(5) primary key,first_name varchar2(13),last_name varchar2(13),
mobile varchar2(10),bdate date, d_id number(5) references doctor(id));
insert into patient values(1,'asad','ahmad','0713333331','1-feb-1990',121);
insert into patient values(2,'areej','wajdi','0714444442','3-oct-93',122);
insert into patient values(3,'barra','saleem','0715566878','6-jan-96',122);
insert into patient values(4,'fadi','fadi','0716671888','7-jan-90',122);
insert into patient values(5,'fars','moneer','0711111119','11-jan-90',123);
insert into patient values(6,'lama','hani','0712222225','3-jun-99',124);
insert into patient values(7,'wael','wael','0713333912','7-dec-95',122);
----------------------------------------------------------------------------------------------------------------------
create table drug(d_name varchar2(10) primary key,supplier_id number(5) references drug_supplier(supplier_id),
amount number(3), price number(3));
insert into drug values('drug1',201,50,30);
insert into drug values('drug2',201,60,15);
insert into drug values('drug3',203,70,10);
insert into drug values('drug4',204,80,20);
insert into drug values('drug5',204,10,25);
insert into drug values('drug6',204,70,30);
-------------------------------------------------------------------------------------------------------------------
create table drug_AmountStatus(status varchar2(30) primary key,lower_amount number(3) ,
upper_amount number(3));
insert into drug_AmountStatus values('not available',0,0);
insert into drug_AmountStatus values('very few',1,10);
insert into drug_AmountStatus values('available',11,40);
insert into drug_AmountStatus values('abundant',41,150);

/*1. Write a query to display the birth date of the youngest and the oldest patients whose physician is ‘reem’.*/
SELECT MIN(patient.bdate) as YoungestPatient, MAX(patient.bdate) as OldestPatient
FROM Patient, Doctor
WHERE Patient.d_id = Doctor.id AND Doctor.name = 'reem';

/*2. Write a query to display the minimum price of drugs which status is abundant.*/
SELECT MIN(drug.price)
FROM drug, drug_AmountStatus
WHERE drug_AmountStatus.status = 'abundant' 
AND drug.amount BETWEEN drug_AmountStatus.lower_amount AND drug_AmountStatus.upper_amount; 
/*non equi join*/

/*3  Write a query to display the total price of drugs which their amount is more than 50 and their supplier address is Amman.*/
SELECT SUM(drug.price)
FROM drug, drug_supplier
WHERE drug_supplier.supplier_id = drug.supplier_id AND (drug.amount > 50) AND (drug_supplier.address = 'Amman');

/*4 Write a query to display the cities and number of suppliers located in them.*/
SELECT address, COUNT(supplier_id)
FROM drug_supplier
GROUP BY address;

/*5 Determine the number of specialties for doctors without listing them.*/
SELECT COUNT(DISTINCT(specialty)) as NumberOfSpecialties
FROM doctor; 

/*6. Write a query to display the supplier name and the highest drug price that has been supplied by that supplier. Exclude any group where the minimum price is less than $15.*/
SELECT drug_supplier.supplier_name, MAX(drug.price)
FROM drug_supplier, drug
WHERE drug_supplier.supplier_id = drug.supplier_id
GROUP BY drug_supplier.supplier_name
HAVING MIN(drug.price)<15;

/*7  Write a query to display the supplier ID and the average amount of drugs belongs to this supplier, exclude any drug which price is less than ‘drug4’.*/
SELECT d1.supplier_id, AVG(d1.amount)
FROM drug d1, drug d2
WHERE d2.d_name = 'drug4' and d1.price > d2.price 
GROUP BY d1.supplier_id; 
