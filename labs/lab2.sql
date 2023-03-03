
create TABLE clinic(clinic_id NUMBER(7), clinic_name VARCHAR2(20) constraint clinic_name_nn NOT NULL, speciality VARCHAR2(15), constraint clinic_id_pk PRIMARY KEY(clinic_id));

create TABLE patient(patient_id NUMBER(5) constraint patient_id_pk PRIMARY KEY, patient_name VARCHAR2(20) constraint patient_name_nn NOT NULL, age NUMBER(2), clinic_id NUMBER(7),
constraint clinic_id_fk FOREIGN KEY(tclinic_id) references clinic(clinic_id) ON DELETE CASCADE);

INSERT INTO clinic(clinic_id, clinic_name, speciality) VALUES (111, 'Clinic1', 'Special1'); 
INSERT INTO clinic(clinic_id, clinic_name, speciality) VALUES (222, 'Clinic2', 'Special2'); 
INSERT INTO clinic(clinic_id, clinic_name, speciality) VALUES (333, 'Clinic3', 'Special3'); 
INSERT INTO clinic(clinic_id, clinic_name, speciality) VALUES (333, ‘Clinic4’, ‘Special3’);

--error Unique Constraint (clinic_id_pk) violated--

INSERT INTO clinic(clinic_id, clinic_name, speciality) VALUES (444, ‘Special4’);

—error not enough values—

INSERT INTO patient(patient_id, patient_name, age, clinic_id) VALUES (1, 'Patient1', 18, 111);
INSERT INTO patient(patient_id, patient_name, age, clinic_id) VALUES (2, 'Patient2', 22, 222);
INSERT INTO patient(patient_id, patient_name, age, clinic_id) VALUES (3, 'Patient3', 60, 111);

INSERT INTO patient(patient_id, patient_name, age, clinic_id) VALUES (4, 'Patient4', 33, 666);

----------- Insert where clinic_id = 666 does not work because integrity constraint violated - parent key not found -------

UPDATE clinic 
SET speciality='Special4'
WHERE clinic_id = (SELECT clinic_id FROM clinic where clinic_id = 111);

UPDATE patient
SET age = age+3
WHERE age = (SELECT age FROM patient where age<20);

commit;

--q1—

UPDATE clinic 
SET speciality='Special3'
WHERE clinic_id = (SELECT clinic_id FROM clinic where clinic_id = 111);

---In table clinic the row where clinic_id = 111 will have its speciality updated to special 3---

—q2— 
rollback;

--the rollback will remove the previous update as we did not commit-
---In table clinic the row where clinic_id = 111 will have its speciality go back to special 4—

—q3— 

UPDATE clinic 
SET speciality='Special4'
WHERE clinic_id = (SELECT clinic_id FROM clinic where clinic_id = 222);

---In table clinic the row where clinic_id = 222 will have its speciality updated to special 4—

commit;
--Data changes are saved in the database.--
--The previous state of the data is overwritten.--

rollback;
--as we commited the data changes are not undone--
—the table clinic in the row where clinic_id == 222 will have its speciality kept at special4—

—q4—

DELETE FROM patient
WHERE clinic_id = 111;

—deletes the first row and third row from patient and patient is only left with one row where clinic_id=222—

—q5—

CREATE TABLE thtest (thetest_id NUMBER(7));

—creates tables called thetest with one column—

—q6— 

rollback;

—rollback does not undo work as create is a ddl statement which has automatic commit—

—q7— 
INSERT INTO clinic(clinic_id, clinic_name, speciality) VALUES (666, 'Clinic4', 'Special6'); 
—creates a new row in clinic table—

—q8-
SAVEPOINT name_a;
—creating savepoint to rollback to later—

—q9—
UPDATE clinic 
SET clinic_name=‘Clinic6'
WHERE clinic_id = (SELECT clinic_id FROM clinic where clinic_id = 666);

—updates the value of clinic_name to Clinic6 in row 4—

—q10—
SAVEPOINT name_b;
—creating savepoint to rollback to later—

—q11-
DELETE FROM clinic 
WHERE clinic_id = 333;
—deletes row where clinic_id = 333—

—q12—
SAVEPOINT name_c;
—creating savepoint to rollback to later—

—q13—
UPDATE clinic 
SET speciality='Special5'
WHERE clinic_id = (SELECT clinic_id FROM clinic where clinic_id = 222);
—updates the row two in clinic to have speciality = special5—

—q14—
INSERT INTO clinic(clinic_id, clinic_name, speciality) VALUES (555, 'Clinic5', 'Special5'); 
—inserts a new row into clinic—

—q15—
-- Undo the update (13) and the insert (14) only.—
ROLLBACK TO SAVEPOINT name_c;
—undoes the update and insert from question 13 and 14—

—q16—
COMMIT:
— the data changes are saved in the database.--
--The previous state of the data is overwritten.--
—will delete all savepoints—

—q17—
ROLLBACK to name_b;
—error the save point B never established—
—this occurs as a commit statement deletes all savepoints— 

—q18—
ROLLBACK;
—no updates will be revoked as we had previously commited-

—q19—
DELETE FROM clinic;
—deletes all the rows in clinic but does not delete the tables—
—we can rollback delete—

—q20—
ROLLBACK:
—undoes work done in q19—

—q21—
TRUNCATE TABLE clinic;
—deletes all data in the table—
—we cannot rollback truncate—

—q22—
ALTER TABLE patient DISABLE CONSTRAINT clinic_id_fk; 
—automatic commit because alter is a ddl statement—

—q23—
ROLLBACK;
—does not undo work as truncate and alter have implicit commit—

—q24—
drop table clinic cascade constraints;
—deletes whole table along with its constraints—
—we cannot rollback drop—
