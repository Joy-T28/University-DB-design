CREATE TABLE departments (
    id integer PRIMARY KEY,
    Name varchar(50) NOT NULL UNIQUE,
    Office_location varchar(100)
);

CREATE TABLE courses (
   id serial PRIMARY KEY,
   course_code varchar(25) UNIQUE,
   title varchar(50),
   credits INT CHECK (credits > 0)
);

ALTER TABLE courses
ADD COLUMN department_id INT;


CREATE TABLE students (
    matric_no varchar(25) PRIMARY KEY,
    Name varchar(50),
    Date_of_birth date,
    email varchar(50) UNIQUE,
    admission_date date NOT NULL);
	
	ALTER TABLE students
ADD COLUMN department_id INT;

ALTER TABLE students
ADD COLUMN course_id INT;

CREATE TABLE lecturers (
    id serial PRIMARY KEY,
    name varchar,
    email varchar UNIQUE,
    employment_date date NOT NULL
);

ALTER TABLE lecturers
ADD COLUMN department_id INT;

CREATE TABLE course_offerings (
    id serial PRIMARY KEY,
    semester varchar(20),
    year integer
);

ALTER TABLE course_offerings
ADD COLUMN lecturer_id INT;

ALTER TABLE course_offerings
ADD COLUMN course_id INT;

CREATE TABLE admissions (
   id serial PRIMARY KEY,
   grade CHAR(2) CHECK (grade IN ('A', 'B', 'C', 'D', 'E', 'F', 'I', 'W'))
);

ALTER TABLE admissions
ADD COLUMN matric_no varchar;

ALTER TABLE admissions
ADD COLUMN offering_id INT;


ALTER TABLE students ADD FOREIGN KEY (department_id) REFERENCES departments (id);

ALTER TABLE lecturers ADD FOREIGN KEY (department_id) REFERENCES departments (id) ON DELETE SET NULL;

ALTER TABLE course_offerings ADD FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE;

ALTER TABLE course_offerings ADD FOREIGN KEY (lecturer_id) REFERENCES lecturers (id) ON DELETE SET NULL;

ALTER TABLE admissions ADD FOREIGN KEY (matric_no) REFERENCES students (matric_no) ON DELETE CASCADE;

ALTER TABLE admissions ADD FOREIGN KEY (offering_id) REFERENCES course_offerings (id) ON DELETE CASCADE;

ALTER TABLE courses ADD FOREIGN KEY (department_id) REFERENCES departments (id) ON DELETE CASCADE;

ALTER TABLE students ADD FOREIGN KEY (course_id) REFERENCES courses (id);
