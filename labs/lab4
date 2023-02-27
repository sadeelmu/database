drop table GAMES cascade constraints;
drop table DEVELOPER cascade constraints;

create table GAMES(GameID number(4) primary key,Title varchar2(60),ReleaseDate date,Genre varchar2(20), DeveloperID number(2));

insert into games values (1532,'Super Mario World','21-nov-1990','Platform',1);
insert into games values (3523,'Legend of Zelda','21-nov-1998','Adventure',1);
insert into games values (3412,'Half-Life','27-nov-98','Shooter',2);
insert into games values (3567,'Dota 2','09-July-2013','MOBA',2);
insert into games (GameID,Title,ReleaseDate,DeveloperID) values (9786,'Portal 2','19-Apr-2011',2);
insert into games values (4235,'Red Alert','22-sep-1996','Strategy',3);

---------------------------------------------
create table DEVELOPER(ID number(2) primary key,Name varchar2(20),Country varchar2(7), DeveloperEmail varchar2(30));

insert into DEVELOPER values(1,'Nintendo','USA', 'nintendo@yahoo.com');
insert into DEVELOPER values(2,'Valve','USA', 'valve@gmail.com');
insert into DEVELOPER values(3,'West Wood','USA', 'westwood@yahoo.com');
insert into DEVELOPER values(4,'Infinity Ward','USA', 'infinity@hotmail.com');

--q1--
SELECT LOWER(Title) as Title, UPPER(Genre) as Genre
FROM games;

--q2--
SELECT CONCAT(UPPER(SUBSTR(Title,1,3)),LOWER(SUBSTR(Title,1,3))) AS Title, LPAD(Genre, 9, '*') as Genre
FROM games;

--q3--
SELECT To_Char(ReleaseDate, 'DD/Mon/YYYY') 
FROM games;

--q4--
SELECT ReleaseDate
FROM games
WHERE ReleaseDate<(To_Date('05-Sep-2010','DD/Mon/YYYY'));

--q5--
SELECT *
FROM games
WHERE to_char(ReleaseDate,'Mon')='Nov';

--q6--
SELECT Title, NVL(Genre, 'No Genre') as Genre
FROM games;

--q7--
SELECT *
FROM games
WHERE SUBSTR(to_char(ReleaseDate, 'Mon'), 1,1) = 'N';

--q8--
SELECT *
FROM games
WHERE to_char(ReleaseDate,'Mon')!='Nov';

--q9--
SELECT *
FROM games
WHERE (to_char(ReleaseDate, 'YYYY') > '1998') OR (to_char(ReleaseDate, 'YYYY') < '1998');

--q10--
SELECT *
FROM games
WHERE to_char(ReleaseDate, 'Mon-YYYY')= 'Nov-1998';

--q11--
SELECT NEXT_DAY(ADD_MONTHS('24/Oct/1990',6), 'Wednesday')
FROM dual;

--q12--
SELECT DeveloperEmail, DECODE (SUBSTR(DeveloperEmail, INSTR(DeveloperEmail, '@')), '@yahoo.com', 'Yahoo Company', '@gmail.com', 'Google Company', 'Others') As Company
FROM DEVELOPER;
