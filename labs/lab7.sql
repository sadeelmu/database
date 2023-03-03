Drop table sw_category cascade constraints;
Drop table developer cascade constraints;
Drop table software cascade constraints;
------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE sw_category(cat_id NUMBER(2) PRIMARY KEY,cat_name VARCHAR2(40));
------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE developer(dev_id NUMBER(2) PRIMARY KEY,dev_name VARCHAR2(20),founded_date DATE,
net_worth NUMBER(4), cat_id NUMBER(2)  REFERENCES sw_category(cat_id));
------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE software(soft_id NUMBER(4) PRIMARY KEY,soft_name VARCHAR2(40),platform VARCHAR2(10), price NUMBER(2),developer_id NUMBER(2) REFERENCES developer(dev_id), cat_id NUMBER(2) REFERENCES sw_category(cat_id));
------------------------------------------------------------------------------------------------------------------------------
insert into sw_category values(1,'Web Applications');
insert into sw_category values(2,'Mobile Applications');
insert into sw_category values(3,'ERP');
insert into sw_category values(4,'Cloud');
------------------------------------------------------------------------------------------------------------------------------
insert into developer values(1,'fromsoftware','01-nov-1986',45,1);
insert into developer values(2,'Kojima Productions','16-dec-2015',30,2);
insert into developer values(3,'Valve','24-aug-1996',2000,2);
insert into developer values(4,'Rockstar','01-dec-1998',3000,4);
insert into developer values(5,'Santa Monica Studio','01-jan-1999',40,1);
------------------------------------------------------------------------------------------------------------------------------
insert into software values(1,'XXX University Website','Windows',40,1,1);
insert into software values(2,'YYY Hospital Website','all',40,1,1);
insert into software values(3,'ZZZ Superstore Website','all',45,1,1);
insert into software values(4,'Shopping Online App','all',39,2,2);
insert into software values(5,'Rental Car App','all',20,2,2);
insert into software values(6,'Gym App','ios',10,3,2);
insert into software values(7,'Dental Clinic App','ios',15,3,2);
insert into software values(8,'Dietition App','android',10,3,2);
insert into software values(9,'C# online programing','all',50,4,4);
insert into software values(10,'AAA Hotel Website','ps',59,4,1);
insert into software values(11,'Human Resources Sytstem','pc',0,3,3);
commit;

/* 1. Display all of the softwares that are cheaper than the software 'Shopping Online
App' and are the same software catefory as the software 'Dietition App'? */

select soft_name  as q1
from software
where software.price<
(select price from software where soft_name = 'Shopping Online App')
and cat_id = 
(select cat_id from software where soft_name  = 'Dietition App');

/*Display the name of all developers that are worth more than the average net worth
of developers who develop Mobile Applications softwares.*/

select dev_name as q2
 from developer 
where net_worth>(select AVG(net_worth) from developer 
where cat_id = (select cat_id from sw_category where cat_name='Mobile Applications'))
group by dev_name;

/*3. Display all the softwares who belong to a category that has 3 or more softwares.*/
select soft_name as q3
from software 
where cat_id in (select cat_id from software group by cat_id having COUNT(cat_id)>2);

/*4. Display the name of the developer who has the most expensive software.*/
select dev_name as q4
from developer 
where cat_id in (select cat_id from software where price=(select max(price) from software));

/*5. Display the number of softwares per category and the category name.*/
/*join*/
select COUNT(software.soft_id), sw_category.cat_name as q5
from sw_category, software
where sw_category.cat_id = software.cat_id
group by cat_name;

/*6. Display the name of the developers who have the most number of softwares*/
/*result should be valve*/
/*we have to use 5 here*/
select dev_name as q6
from developer
where dev_id in 
(select developer_id from software group by developer_id having COUNT(dev_id) = 
(select MAX(COUNT(developer_id)) from software group by developer_id));

/*7. Display the name of softwares that can be executed on any platform and their
price is greater than the cheapest software.*/
select soft_name as q7
from software
where platform = 'all'
and price > (select MIN(price) from software);

/*8. Display the name of all softwares whose developers name length is more than 6
characters.*/
select soft_name as q8 from software 
where developer_id in (select dev_id from developer where length(dev_name) > 6);

/*9. Display the average price of softwares per developer along with the developer
name.*/
select avg(price), dev_name
from software, developer
where software.developer_id = developer.dev_id
group by dev_name;
