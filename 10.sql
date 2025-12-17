--1.изначальная структура нарушает 1НФ, потому что в одной ячейке не может храниться несколько значений.
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255),
    team_members VARCHAR(1000) -- Пример: 'Алексеев, Борисов, Васильева'
);
--правильно:
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255)
);

CREATE TABLE Project_Team (
    project_id INT,
    team_members VARCHAR(255),
    PRIMARY KEY (project_id, team_members),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

--2.Каждый неключевой атрибут должен полностью зависеть от первичного ключа; client_name, client_email зависят от client_id, equipment_name зависят от equipment_id
CREATE TABLE EquipmentRentals (
    client_id INT,
    equipment_id INT,
    client_name VARCHAR(255),    -- Имя клиента
    client_email VARCHAR(255),   -- Email клиента
    equipment_name VARCHAR(255), -- Название оборудования
    rental_date DATE,            -- Дата аренды
    PRIMARY KEY (client_id, equipment_id)
);
--правильно:
CREATE TABLE Clients (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(255),
    client_email VARCHAR(255)
);

CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY,
    equipment_name VARCHAR(255)
);

CREATE TABLE Clients_equipment (
    client_id INT,
    equipment_id INT,
    rental_date DATE,
    PRIMARY KEY (client_id, equipment_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

--3. изначальная таблица нарушает 1нф потому что в ячейке несколько значений и assignments_and_grades нарушает правила атомарности
CREATE TABLE StudentGrades (
    student_id INT,
    course_id INT,
    student_name VARCHAR(255),
    course_professor VARCHAR(255),
    assignments_and_grades TEXT, -- Пример содержимого: '{"Quiz 1": 85, "Midterm": 92, "Essay": 88}'
    PRIMARY KEY (student_id, course_id)
);
--правильно в 1нф:
CREATE TABLE Student (
    student_id INT,
    course_id INT,
    student_name VARCHAR(255),
    course_professor VARCHAR(255),
    PRIMARY KEY (student_id, course_id)
);

CREATE TABLE StudentGrades (
    student_id INT,
    course_id INT,
    grade INT, 
    assignment_name VARCHAR(255),                  
    PRIMARY KEY (student_id, course_id, assignment_name),
    FOREIGN KEY (student_id, course_id) REFERENCES Student(student_id, course_id)
);
--2нф:
CREATE Table students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255)
);

CREATE Table courses (
    course_id int PRIMARY KEY,
    course_professor VARCHAR(255)
);

CREATE TABLE students_courses (
    student_id int,
    course_id int,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE Table grades (
    grade_id int PRIMARY KEY,
    assignments_name  VARCHAR(255),
    grade INT, 
    student_id int,
    course_id int,
    Foreign Key (student_id, course_id) REFERENCES students_courses(student_id, course_id)
);
