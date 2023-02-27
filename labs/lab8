drop table drug_supplier cascade constraints;
drop table doctor cascade constraints;
drop table patient cascade constraints;
drop table drug cascade constraints;
drop table drug_AmountStatus cascade constraints;


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

/*
CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW view
  [(alias[, alias]...)]
AS subquery
[WITH CHECK OPTION [CONSTRAINT constraint]]
[WITH READ ONLY]
VIEWS ARE AN OBJECT
IT IS A TABLE, A VIRTUAL TABLE
It does not exist we just use it to store the data and modify it and modify the original
*/

/*q1. Create a view for the patient table that contains the patient number, first name, D_ID for all patients where their doctor id is 122. Name the columns (Patient_Number, Name, Doctor_Id).*/
create view pdetail (patient_number, pname, Doctor_Id) as
select patient_id, first_name, d_id
from patient
where d_id = 122;

/*here we descibe the view
it calls the query of from patient every time
it does not take physcal space*/
desc pdetail; 

/*DIFFERENCE:
if you change the original table
the view will also be changed
but a duplicate table of the original table will not be changed*/
/*
VIEW:
used as a manner to show data to the user
order by cannot be used in the view create statment
*/

/*modifying*/
/*instead of dropping and creating a view you can use CREATE OR REPLACE*/

/*aliases examples
create view dept_info (dno, dname, dsalary, dcount) as
select dnumber, dname, sum(salary), count(*)
from dno, employee
where dno = dnumber
group by dnumber, dname
*/

/*INSERT
you treat it as a table*/
/* q2. Insert a new patient with id = 80 to the view with D_ID = 122. Choose values for the other columns.*/

insert into pdetail values (80, 'Q2Patient', 122); 
/*this will show up in the view and original table*/

select * from pdetail;

select * from patient;

/* q3. Insert a new patient with id = 90 to the view with D_ID = 123. Choose values for the other columns.*/
insert into pdetail values (90, 'Q3Patient', 123); 
/*this will show up in the original table but not the view*/

select * from pdetail;

select * from patient;

/* q4. 4. Recreate the view with “WITH CHECK OPTION”.*/
/*You can ensure that DML on the view stayswithin the domain of the view by using the WITH CHECK OPTION clause.*/
create or replace view pdetail (patient_number, pname, Doctor_Id) as
select patient_id, first_name, d_id
from patient
where d_id = 122
with check option constraint pdetail_co;
/*this avoids for example later inserting a d_id thats not 122*/

/*q5. Repeat (3) with Patient id = 100. Justify your results.*/
insert into pdetail values (90, 'Q5Patient', 100);
/*this will result into an errror due to the check option constraint as it ensures DML operations on the view stays within the domain of the view as in it doesnt violate the select statement of the view*/

/*q6. Recreate the view with “WITH READ ONLY”*/
/*You can ensure that NO! DML operations occur by adding the WITH READ ONLY option to your view definition.*/
/*Any attempt to perform a DML on any row in the view will result in Oracle Server error.*/
create or replace view pdetail (patient_number, pname, Doctor_Id) as
select patient_id, first_name, d_id
from patient
where d_id = 122
with read only;

/* q7. Repeat (3) with Patient id = 110. Justify your results.*/
insert into pdetail values (90, 'Q5Patient', 110);

/*this will result in an error as read only ensures no DML operations occur to the view*/
/* ORACLE SERVER ERROR: ORA-42399: cannot perform a DML operation on a read-only view */

/*
Removing a View
Remove a view without losing data because a view is based on underlying tables in the database.
*/
drop view pdetail;

/*
CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW view
  [(alias[, alias]...)]
AS subquery
[WITH CHECK OPTION [CONSTRAINT constraint]]
[WITH READ ONLY]
you use force inside the view to build the view based on a table that does not exist yet
*/
create force view d_vw
as select dk, dname
from dept;

/*COMPLEX VIEW*/
/*
CONTAINS AGGREGATE FUCNTIONS
CONTAINS MORE THAN ONE TABLE
CONTAINS GROUPING OF DATA
NOT ALWAYS DML 
*/
/*
examples
create view dept_info (dno, dname, dsalary, dcount) as
select dnumber, dname, sum(salary), count(*)
from dno, employee
where dno = dnumber
group by dnumber, dname
*/

/*q8 Create a view that contains the Doctor name and number of patients for each doctor.*/
create view doctorpatient (doctorname, noofpatients)
as select doctor.name, count(patient.d_id)
from doctor, patient
where patient.d_id = doctor.id
group by doctor.name;

select * from doctorpatient;
