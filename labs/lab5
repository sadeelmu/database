DROP TABLE PRODUCER CASCADE CONSTRAINTS;
DROP TABLE MOVIE CASCADE CONSTRAINTS;
DROP TABLE ACTOR CASCADE CONSTRAINTS;
DROP TABLE MOVIE_ACTOR CASCADE CONSTRAINTS;
--------------------------------------------------------------------------------
CREATE TABLE PRODUCER
(ID NUMBER(2) PRIMARY KEY,
 NAME VARCHAR2(20) NOT NULL,
 ADDRESS VARCHAR2(7),
 EMAIL VARCHAR2(30)
);

INSERT INTO PRODUCER VALUES (1, 'Warner Bros.', 'CA', 'warnerbrothers@gmail.com');
INSERT INTO PRODUCER VALUES (2, 'Disney', 'LA', 'disney@hotmail.com');
INSERT INTO PRODUCER VALUES (3, 'pixar', 'Dallas', 'pixarmovies@gmail.com');
INSERT INTO PRODUCER VALUES (4, 'Marvel', 'CA', 'MarvelProd@gmail.com');
------------------------------------------------------------------------------------
CREATE TABLE MOVIE
(ID NUMBER(4) PRIMARY KEY,
 NAME VARCHAR2(30) NOT NULL,
 RELEASEDATE DATE,
 PROD_ID NUMBER(2),
 RATING NUMBER(2),
 FOREIGN KEY (PROD_ID) REFERENCES PRODUCER (ID)
);

INSERT INTO MOVIE VALUES (6625, 'Aladdin', '25-apr-2019', 2, 5);
INSERT INTO MOVIE VALUES (1251, 'Toy Story 4', '5-may-2019', 3, 4);
INSERT INTO MOVIE VALUES (4526, 'Harry Potter', '5-jul-2001', 1, 5);
INSERT INTO MOVIE VALUES (5128, 'Inception', '5-jun-2010', 1, 4);
INSERT INTO MOVIE VALUES (3642, 'You have got mail', '18-dec-1998', 1, 5);
INSERT INTO MOVIE VALUES (8956, 'The Proposal', '19-jun-2009', 1, 4);
-------------------------------------------------------------------------------------------
CREATE TABLE ACTOR
(ID NUMBER(2) PRIMARY KEY,
NAME VARCHAR2(30) NOT NULL);

INSERT INTO ACTOR VALUES (11, 'Sandra BUllOck');
INSERT INTO ACTOR VALUES (22, 'Ryan Reynolds');
INSERT INTO ACTOR VALUES (33, 'Tom Hanks');
INSERT INTO ACTOR VALUES (44, 'Meg Ryan');
INSERT INTO ACTOR VALUES (55, 'Leonardo Decaprio');
INSERT INTO ACTOR VALUES (66, 'Will Smith');
INSERT INTO ACTOR VALUES (77, 'Emma Watson');
------------------------------------------------------------------------------------------------
CREATE TABLE MOVIE_ACTOR
(MOV_ID NUMBER(4),
 ACT_ID NUMBER(2),
 FOREIGN KEY (MOV_ID) REFERENCES MOVIE (ID),
 FOREIGN KEY (ACT_ID) REFERENCES ACTOR (ID),
 PRIMARY KEY (MOV_ID, ACT_ID)
);

INSERT INTO MOVIE_ACTOR VALUES (6625, 66);
INSERT INTO MOVIE_ACTOR VALUES (1251, 33);
INSERT INTO MOVIE_ACTOR VALUES (4526, 77);
INSERT INTO MOVIE_ACTOR VALUES (5128, 55);
INSERT INTO MOVIE_ACTOR VALUES (3642, 33);
INSERT INTO MOVIE_ACTOR VALUES (3642, 44);
INSERT INTO MOVIE_ACTOR VALUES (8956, 11);
INSERT INTO MOVIE_ACTOR VALUES (8956, 22);
----------------------------------------------------------------------------------------------

COMMIT;

 
/*1. Write a query to display the movie name, release date and producer name for all movies.*/
/*equi join*/
SELECT Movie.NAME, RELEASEDATE, Producer.NAME
FROM Movie, PRODUCER
WHERE Movie.prod_id = Producer.id;


/*2. Write a query to display the movie name and producer name for the movies which were
released in 2010. (HINT: use TO_CHAR function in the condition)*/
/*equi join*/
SELECT Movie.NAME, Producer.NAME
FROM Movie, Producer
WHERE Movie.prod_id = Producer.id AND TO_CHAR(RELEASEDATE, 'YYYY')='2010';

/*3. Write a query that will display the movie name and the actors of the movie.*/
/*equi join*/
SELECT Movie.NAME, Actor.NAME
FROM Movie_Actor, Movie, Actor
WHERE MOVIE_ACTOR.MOV_ID = Movie.id AND Movie_Actor.ACT_ID = Actor.id;

/*4 Write a query that will display the movie name and the actor of the movie for all movies which the length of their producer email ids’ more than seven characters.*/
/*equi join*/
SELECT Movie.NAME, Actor.NAME
FROM Movie, Actor, Producer, Movie_Actor
WHERE MOVIE_ACTOR.MOV_ID = Movie.id AND Movie_Actor.ACT_ID = Actor.id AND Movie.PROD_ID = Producer.ID AND (INSTR(Producer.EMAIL, '@')>7);

/* 5. Write a query to display the movie names for all movies that were produced by Disney.*/
SELECT Movie.Name
FROM Movie, Producer
WHERE Movie.PROD_ID = Producer.ID AND Producer.Name = 'Disney';

/*6  Write a query to display the movie name and its producer name. All producers must be displayed including the ones which didn't produce any movie.*/
SELECT Movie.Name, Producer.Name
FROM Movie, Producer
WHERE Movie.PROD_ID (+) = Producer.ID; 
/*outer join we put (+) where there might be null */

/*7. Write a query to display the movie name, release date of any movie that was released before the movie “Inception”. */
SELECT M1.Name, M1.RELEASEDATE
FROM Movie M1, Movie M2 
WHERE (M1.ReleaseDate < M2.ReleaseDate) AND (M2.Name = 'Inception'); 

/*8. Write a query that will display all movies that were produced by the same producer, display them in pairs. (Hint: you will need a self-join here)*/
SELECT M1.Name as Movie1, M2.Name as Movie2
FROM Movie M1, Movie M2
WHERE M1.prod_id = M2.prod_id AND M1.Name != M2.Name;
