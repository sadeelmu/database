drop table BOOKs cascade constraints;
drop table PUBLISHER  cascade constraints;
---------------------------------------------
create table BOOKs(ID number(4) primary key,Title varchar2(40),PublishingDate date,Price number (3), PublisherID number(2));
insert into BOOKs values (0607,'The Hobbit','21-sep-1937',5,1);
insert into BOOKs values (0964,'The Handmaids Tale','25-Apr-2017',20,1);
insert into BOOKs values (1906,'Hairy Maclary from Donaldsons Dairy','04-Jul-1992',4,2);
insert into BOOKs values (0328,'How to Lie with Statistics','07-Dec-2010',17,3);
insert into BOOKs (ID,Title,PublishingDate,PublisherID) values (0916,'Mechanical Harry','01-Jan-1999',2);
insert into BOOKs values (0973,'My Cat Likes to Hide in Boxes','27-April-2010',17,2);
---------------------------------------------
create table PUBLISHER( pid number(2) primary key, pname varchar2(20),City varchar2(7), PublisherEmail varchar2(30));
insert into PUBLISHER values(1,'Houghton Mifflin','USA', 'Houghton@yahoo.com');
insert into PUBLISHER values(2,'Mallinson Rendel','NZ', 'Mallinson@gmail.com');
insert into PUBLISHER values(3,'W. W. Norton','USA', 'Norton@yahoo.com');
insert into PUBLISHER values(4,'Pavilion','England', 'Pavilion@hotmail.com');

--1--
SELECT * FROM BOOKs;

--2--
SELECT pname AS Name FROM PUBLISHER;  
SELECT City AS Address FROM PUBLISHER;  
SELECT PublisherEmail AS Email FROM PUBLISHER;  

--3--
SELECT DISTINCT City 
FROM PUBLISHER;

--4--
SELECT Title || ' has been published on ' || PublishingDate || ' and it costs ' || Price as "Book Information"
from BOOKs;
 
--5--
SELECT * 
FROM BOOKs
WHERE PublishingDate LIKE '_______17%' or PublishingDate LIKE '_______9%'
ORDER BY Title;

--6--
SELECT *
FROM BOOKs 
WHERE Title LIKE '%The%' and ID LIKE '9__';

--7--
SELECT *
FROM BOOKs
WHERE Price IS NULL;

--8--
SELECT *
FROM BOOKs
WHERE Price>7 AND Title = 'The Hobbit' or Title = 'How to Lie with Statistics';


--9--
SELECT Title, Price
FROM BOOKs
WHERE Title LIKE 'The%' and Price BETWEEN 5 and 50;

--10--
SELECT *
FROM PUBLISHER
WHERE CITY LIKE 'U__';

--11--
SELECT * 
FROM PUBLISHER
WHERE PublisherEmail LIKE '%@gmail%';

--12--
SELECT ID, Title, Price
FROM BOOKs
WHERE (PublisherID = 1 or PublisherID = 2) and (Price != 4 AND Price != 20);

--13--
SELECT Title, (Price*0.35) as Tax
from BOOKs
ORDER BY Tax ASC;

--14--
SELECT *
from BOOKs
Order by PRICE DESC, TITLE ASC; 
