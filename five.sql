CREATE TABLE authors(
    authors_id SERIAL PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

CREATE TABLE books(
    books_id INT PRIMARY KEY,
    title text NOT NULL,
    published_year INT,
    authors_id SERIAL NOT NULL,
    FOREIGN KEY (authors_id) REFERENCES authors(authors_id)
);

ALTER TABLE books ADD COLUMN genre VARCHAR(100);

ALTER TABLE books ADD CONSTRAINT published_year CHECK (published_year < 2026);

ALTER TABLE books DROP COLUMN authors_id;

CREATE TABLE book_authors(
    books_id INT,
    authors_id INT,
    PRIMARY KEY (books_id, authors_id),
    FOREIGN KEY (books_id) REFERENCES books(books_id),
    FOREIGN KEY (authors_id) REFERENCES authors(authors_id)

);

