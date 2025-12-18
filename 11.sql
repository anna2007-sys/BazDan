--1.зависимости: title, author_name, publisher_id, publisher_name, publisher_city от book_id; publisher_name, publisher_city от publisher_id; publisher_name, publisher_city от publisher_id
--3нф нарушается, потому что publisher_name и publisher_city не напрямую зависят от первичного ключа book_id, а через промежуточный атрибут publisher_id
CREATE TABLE publishers (
    publisher_id int PRIMARY KEY,
    publisher_name VARCHAR(255),
    peblisher_city VARCHAR(100)
);

CREATE Table books (
    book_id int PRIMARY KEY,
    title VARCHAR(255),
    publisher_id int,
    Foreign Key (publisher_id) REFERENCES publishers(publisher_id)
);

CREATE Table authors (
    authors_id int PRIMARY key,
    author_name VARCHAR(255)
);

CREATE Table books_authors (
    book_id int,
    authors_id int,
    PRIMARY KEY (book_id,authors_id),
    Foreign Key (book_id) REFERENCES books(book_id),
    Foreign Key (authors_id) REFERENCES authors(authors_id)
);

--2. 3нф нарушается так как, car_manufacturer зависит не от ключевого ключа car_model
--функциональные зависисимоти race_id, driver_id для car_model, car_manufacturer, finish_time 
CREATE TABLE CarModels (
    car_model VARCHAR(100) PRIMARY KEY,
    car_manufacturer VARCHAR(100)
);

CREATE TABLE RaceResults (
    race_id INT,
    driver_id INT,
    car_model VARCHAR(100),
    finish_time TIME,
    PRIMARY KEY (race_id, driver_id),
    FOREIGN KEY (car_model) REFERENCES CarModels(car_model)
);

--3. event_type → room_name нарушает правило НФБК, потому что event_type НЕ суперключ
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    room_name VARCHAR(50)
);
CREATE TABLE RoomBookings (
    booking_id INT PRIMARY KEY,
    room_id INT NOT NULL,
    booking_time DATE,
    event_type status_type,
    Foreign Key (room_id) REFERENCES Rooms(room_id)
);
CREATE TYPE status_type AS ENUM ('Встреча', 'Презентация');