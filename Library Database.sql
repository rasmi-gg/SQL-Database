CREATE DATABASE library; 
use library;

CREATE TABLE Books (
ID INTEGER NOT NULL, 
Title VARCHAR(100) NOT NULL, 
Author VARCHAR(100) NOT NULL , 
Publication_Year INTEGER NOT NULL,
Pages INTEGER NOT NULL,
CONSTRAINT PK_ID PRIMARY KEY(ID)); 

INSERT INTO Books
(ID, Title, Author, Publication_Year, Pages) 
VALUES 
('45362', 'Gone Girl', 'Gillian Flynn','2014', '200'), 
('92871','To Kill a Mockingbird', 'Haper Lee', '1960', '250'), 
('13456','The Da Vinci Code', 'Dan Brown','2003', '400'), 
('71839', 'The Kite Runner', 'Khaled Hosseini' , '2003', '450'), 
('26594', 'The Hunger Games', 'Suzanne Collins', '2008', '500'), 
('83241', 'Pride and Prejudice', 'Jane Austen', '1813','300'), 
('54982', 'The Notebook', 'Nicholas Spark', '1996', '1000'), 
('63701', 'The Girl with the Dragon Tatto', 'Steig Larsson', '2005', '1005'), 
('91453', 'The Great Gatsby', 'F.Scott Fitzgerald', '1925', '800'); 


CREATE TABLE Members (
member_id INTEGER NOT NULL, 
first_name VARCHAR(100) NOT NULL, 
last_name VARCHAR(100) NOT NULL, 
phone_number INTEGER,
CONSTRAINT PK_ID PRIMARY KEY(member_id)); 


INSERT INTO Members
(member_id, first_name, last_name, phone_number) 
VALUES 
('2986', 'Alice', 'Johnson', '078595629'),
('1427', 'John', 'Smith', '071345891'),
('9735','Jessica', 'Sanchez','075401097'),
('4729', 'Ethan' , 'Taylor', '076153847'),
('4516', 'Rajesh', 'Mukherjee', '078270345'), 
('8273', 'Will', 'Smith', '077290548'),
('2956', 'Will', 'Thompson','074910582'),
('4812', 'Randip', 'Rai', '075482679'),
('4901', 'Sophia', 'Davis', '079384729') ; 


ALTER TABLE loans
ADD CONSTRAINT FK_MEMBERSID
FOREIGN KEY (member_id) REFERENCES Members(member_id);

CREATE TABLE loans(
member_id INTEGER NOT NULL, 
book_id INTEGER NOT NULL, 
loan_date VARCHAR(100) NOT NULL, 
return_date VARCHAR(100)NOT NULL,
-- ADDING PRIMARY KEY CONSTRAINT
CONSTRAINT PK_loans PRIMARY KEY(book_id)); 
INSERT INTO loans
(member_id, book_id, loan_date, return_date) 
VALUES 
('2986', '91453', '12th October 2022', '1st November 2022'),
('1427', '63701', '15th December 2022', '27th December 2022'),
('8273', '54982', '9th December 2022', '21st December 2022'),
('2956', '45362', '1st November 2022','13th December 2022'),
('2956', '26594', '1st November 2022','13th December 2022')
;

CREATE TABLE Genre (
ID INTEGER,
genre VARCHAR (50)); 


INSERT INTO Genre 
(ID,genre) 
VALUES 
('45362', 'Psychological Thriller'),
('92871','Southern Gothic'), 
('13456','Mystery Thriller'), 
('71839', 'Bildungsroman'), 
('26594', 'Dystopian'), 
('83241', 'Romance'), 
('54982', 'Romance'), 
('63701', 'Psychological Thriller'), 
('91453', 'Tragedy'); 

CREATE TABLE Overdue_Charges (
member_id INTEGER,
item_loaned INTEGER,
overdue_fee DECIMAL(4,2),
CONSTRAINT PK_Overdue_Charges PRIMARY KEY(item_loaned)); 


-- adding foreign key constraints 
ALTER TABLE Overdue_Charges
ADD CONSTRAINT FK_overduechargesID
FOREIGN KEY (member_id, item_loaned) REFERENCES loans(member_id, book_id); 

ALTER TABLE Overdue_Charges
ADD CONSTRAINT FK_MEMBERS 
FOREIGN KEY (member_id) REFERENCES Members(member_id); 

INSERT INTO Overdue_Charges
(member_id,item_loaned, overdue_fee) 
VALUES 
('2986', '91453', '20.44'), 
('2956', '45362','5.60'),
('2956', '26594','5.60'); 

-- JOIN THE TABLES TOGETHER to the genre and the name of the books together 
select 
Title, 
Author, 
g.genre
FROM Books b
inner join Genre g
ON g.ID = b.ID
order by g.ID asc;

-- find the title and the author of books that were published post 2000 
Select
Title, 
Author
FROM Books 
WHERE Publication_Year >2000; 

-- add a new book 
DELIMITER //
CREATE EVENT new_book
ON SCHEDULE AT NOW() + INTERVAL 30 MINUTE
DO BEGIN 
INSERT INTO Books
	(ID, Title, Author, Publication_Year)
	VALUES 
	('98754','Babel', 'R. F. Kuang' '2022');
END//
DELIMITER ;

-- store function 
DELIMITER //
CREATE FUNCTION booksize(Pages INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
DECLARE booksize VARCHAR(20);
    IF Pages <=300 THEN
        SET booksize = 'small';
    ELSEIF (Pages > 300 AND
            Pages <= 500) THEN
        SET booksize = 'medium';
    ELSEIF Pages > 500 THEN
        SET booksize = 'big';
    END IF;
    RETURN (booksize);
END//Pages
DELIMITER ;


SELECT
	Title,
    Author,
    booksize(Pages)
FROM
    Books; 
    
    
    
    













