CREATE TABLE authors (author_id NUMBER(7) constraint author_id_pk PRIMARY KEY, 
author_name VARCHAR2 (20), author_city VARCHAR2 (15) constraint city_nn NOT NULL,
constraint author_name_uq UNIQUE(author_name));

CREATE TABLE books (book_id NUMBER(5), book_title VARCHAR2(15), 
price NUMBER(2) DEFAULT 10 CHECK(price>0), b_author_id NUMBER(7), publishing_date DATE CHECK (publishing_date>'1-1-1990'), 
constraint author_id_fk FOREIGN KEY (b_author_id) REFERENCES authors(author_id),constraint book_title_pk PRIMARY KEY (book_title));

ALTER TABLE authors
ADD author_nationality VARCHAR2(20);

ADD TABLE books
ADD book_category VARCHAR2(25);

ALTER TABLE books
DROP constraint book_title_pk;

ALTER TABLE books
ADD constraint book_id_pk PRIMARY KEY(book_id);

ALTER TABLE authors
ADD constraint author_name_nn NOT NULL(author_name);

ALTER TABLE books
MODIFY book_title VARCHAR(30);

ALTER TABLE authors
DROP COLUMN author_nationality;

RENAME TABLE books to publications; 

DROP TABLE books; 

ALTER TABLE publications
ADD constraint book_title_uq UNIQUE (book_title);

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'PUBLICATIONS';
