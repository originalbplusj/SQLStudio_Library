CREATE TABLE book (
	book_id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT,
    title VARCHAR(255),
    isbn INT,
    available BOOL,
    genre_id INT
);


CREATE TABLE author (
	author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    birthday DATE,
    deathday DATE
);


CREATE TABLE patron (
	patron_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    loan_id INT
);


CREATE TABLE reference_books (
	reference_id INT AUTO_INCREMENT PRIMARY KEY,
    edition INT,
    book_id INT,
    FOREIGN KEY (book_id)
		REFERENCES book(book_id)
        ON UPDATE SET NULL
        ON DELETE SET NULL
);

INSERT INTO reference_books(edition, book_id)
VALUE(5, 32);


CREATE TABLE genre (
	genre_id INT PRIMARY KEY,
    genres VARCHAR(100)
);

CREATE TABLE loan (
	loan_id INT AUTO_INCREMENT PRIMARY KEY,
    patron_id INT,
    date_out DATE,
    date_in DATE,
    book_id INT,
    FOREIGN KEY (book_id)
		REFERENCES book(book_id)
        ON UPDATE SET NULL
        ON DELETE SET NULL
);


SELECT genre.genres, book.isbn
FROM genre, book
WHERE genre.genres="Mystery";

-- loan out a book




INSERT INTO loan(patron_id, date_out, book_id)
VALUES(7, current_timestamp, 8);

UPDATE book
SET book.available=false
WHERE book.book_id=8;

SET SQL_SAFE_UPDATES=0;
UPDATE patron JOIN loan
ON patron.patron_id = loan.patron_id 
SET patron.loan_id = loan.loan_id;

-- check in a book

UPDATE book
SET book.available=true
WHERE book.book_id=30;

UPDATE loan
SET loan.date_in=current_timestamp
WHERE book_id=30;

UPDATE patron
SET patron.loan_id=null WHERE (SELECT loan.patron_id FROM loan WHERE loan.patron_id=3);

-- wrap up query

SELECT patron.first_name, patron.last_name, genre.genres
FROM patron
RIGHT JOIN genre ON (SELECT book.genre_id FROM book) = genre.genre_id
WHERE patron.loan_id IS NOT NULL AND (SELECT loan.date_in FROM loan WHERE loan.date_in = NULL);









