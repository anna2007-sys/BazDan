-- Очищаем таблицы
TRUNCATE TABLE Enrollments CASCADE;
TRUNCATE TABLE Students CASCADE; 
TRUNCATE TABLE Courses CASCADE;

-- Сбрасываем последовательности
ALTER SEQUENCE students_student_id_seq RESTART WITH 1;
ALTER SEQUENCE courses_course_id_seq RESTART WITH 1;

-- Полностью удаляем таблицы
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Courses;

CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL, 
    start_year INT
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INT CHECK (credits > 0)
);

CREATE TABLE Enrollments (
    student_id INT REFERENCES Students(student_id) ON DELETE CASCADE,
    course_id INT REFERENCES Courses(course_id) ON DELETE CASCADE,
    grade CHAR(1),
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO Students (full_name, email, start_year) VALUES
('Алексей Смирнов', 'smirnov@example.com', 2021),
('Елена Кузнецова', 'kuznetsova@example.com', 2022),
('Дмитрий Новиков', 'novikov@example.com', 2021),
('Ольга Морозова', 'morozova@example.com', 2023);

INSERT INTO Courses (course_name, credits) VALUES
('Введение в программирование', 5),
('Базы данных', 4),
('Веб-технологии', 4);

INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(2, 2, 'B'),
(2, 3, 'A'),
(3, 1, NULL),
(3, 2, NULL),
(3, 3, NULL);

UPDATE Students
SET email = 'elena.kuznetsova@newmail.com'
WHERE full_name = 'Елена Кузнецовa';

UPDATE Enrollments
SET grade = 'A'
WHERE  student_id = 3 AND course_id = 1;

DELETE FROM Students
WHERE email = 'morozova@example.com';

SELECT * FROM Students;

SELECT course_name, credits FROM Courses;

SELECT * FROM Students WHERE start_year = 2021;

SELECT * FROM Courses WHERE credits > 4;

SELECT * FROM Students WHERE email = 'elena.kuznetsova@newmail.com';

SELECT * FROM Students WHERE full_name LIKE 'Дмитрий%';

SELECT * FROM Enrollments WHERE grade IS NULL;

SELECT * FROM Courses ORDER BY course_name;

SELECT * FROM Students ORDER BY start_year, full_name;

SELECT * FROM Students ORDER BY start_year DESC LIMIT 2;