use master;
--Create Database
CREATE DATABASE LibraryDB;
use LibraryDB;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Table 'Author'
CREATE TABLE Author(
       AuthorID INT PRIMARY KEY,
	   FirstName VARCHAR(50),
	   LastName VARCHAR(50),
	   Nationality VARCHAR(50),
	   DateofBirth VARCHAR(50)
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Table 'Publisher'
CREATE TABLE Publisher(
       PublisherID INT PRIMARY KEY,
	   PhoneNumber VARCHAR(50),
	   Name VARCHAR(50),
	   Address VARCHAR(50),
	   Email VARCHAR(50)
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Table 'Books'
CREATE TABLE Books(
      BookID INT PRIMARY KEY,
	  Title VARCHAR(100),
	  AuthorName VARCHAR(50),
	  Publisher VARCHAR(50),
	  ISBN BIGINT,
	  YearPublished INT,
	  TotalCopies INT,
	  CopiesAvailable INT,
	  Genre VARCHAR(50),
      AuthorID INT,
      PublisherID INT,
      CONSTRAINT FK_Author FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID),
      CONSTRAINT FK_Publisher FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Table 'Borrower'
CREATE TABLE Borrower(
       BorrowerID INT PRIMARY KEY,
	   FirstName VARCHAR(50),
	   LastName VARCHAR(50),
	   Email VARCHAR(50),
	   PhoneNumber VARCHAR(50),
	   MemberShipDate DATE,
	   MemberShipStatus VARCHAR(50)
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Table 'Staff'
CREATE TABLE Staff(
       StaffID INT PRIMARY KEY,
	   FirstName VARCHAR(50),
	   LastName VARCHAR(50),
	   RoleName VARCHAR(50),
	   PhoneNumber VARCHAR(50),
	   Email VARCHAR(50),
	   EmploymentDate DATE,
	   SupervisorID INT,
	   FOREIGN KEY(SupervisorID) REFERENCES Staff(StaffID)
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Table 'Transactions'
CREATE TABLE Transactions(
       TransactionID INT PRIMARY KEY, 
	   BorrowDate DATE,
	   ReturnDate DATE, 
	   TransactionStatus VARCHAR(50),
	   BookID INT,
	   FOREIGN KEY(BookID) REFERENCES Books(BookID),
	   BorrowerID INT,
	   FOREIGN KEY(BorrowerID) REFERENCES Borrower(BorrowerID),
	   StaffID INT,
	   FOREIGN KEY(StaffID) REFERENCES Staff(StaffID)
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Table 'Fines'
CREATE TABLE Fines(
       FineAmount DECIMAL(10,2),
	   FineID INT,
	   PaidStatus VARCHAR(50),
	   TransactionID INT,
	   FOREIGN KEY(TransactionID) REFERENCES Transactions(TransactionID),
	   PRIMARY KEY (FineID,TransactionID)
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Table 'Events'
CREATE TABLE Events(
       EventID INT PRIMARY KEY,
	   EventName VARCHAR(50),
	   EventDate DATE,
	   StartTime VARCHAR(10),
	   EndTime VARCHAR(10),
	   OrganizerID INT,
	   FOREIGN KEY(OrganizerID) REFERENCES Staff(StaffID),
	   Audience VARCHAR(50),
	   Location VARCHAR(50),
	   Capacity INT,
	   RegistrationRequired VARCHAR(10),
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Table 'LibraryBranches'
CREATE TABLE LibraryBranches(
       BranchID INT PRIMARY KEY,
	   BranchName VARCHAR(50) NOT NULL,
	   City VARCHAR(10) NOT NULL,
	   Country VARCHAR(10) NOT NULL,
	   PostalCode INT NOT NULL,
	   OpeningHours VARCHAR(100),
	   NumberOfStaff INT
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Alter Data Types in library branches
ALTER TABLE LibraryBranches
ALTER COLUMN PostalCode VARCHAR(20);
ALTER TABLE LibraryBranches
ALTER COLUMN City VARCHAR(50);
ALTER TABLE LibraryBranches
ALTER COLUMN Country VARCHAR(50);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Table 'BookRequests'
CREATE TABLE BookRequests(
       RequestID INT PRIMARY KEY,
	   BorrowerID INT,
	   FOREIGN KEY(BorrowerID) REFERENCES Borrower(BorrowerID),
	   BookID INT,
	   FOREIGN KEY(BookID) REFERENCES Books(BookID),
	   RequestDate DATE,
	   Status VARCHAR(50)
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Insert into Author 1
INSERT INTO Author(
       AuthorID,FirstName,LastName,Nationality,DateofBirth) 
VALUES
      (2001,'Alex','Michaelides','British-Cypriot','1977-09-04'),
	  (2002,'Andy','Weir','American','1972-06-16'),
	  (2003,'B.A. PARIS',NULL,'British','1958-00-00'),
	  (2004,'Barack','Obama','American','1961-08-04'),
	  (2005,'Barry','Schwartz', 'American','1946-08-15'),
	  (2006,'Benjamin','Graham','American','1894-05-09'),
	  (2007,'Bessel','van der Kolk','Dutch','1943-00-00'),
	  (2008,'Blake','Crouch','American','1978-10-15'),
	  (2009,'Brianna','Wiest','American','1992-10-11'),
	  (2010,'Carl','Sagan','American','1934-11-09'),
	  (2011,'Charles','Duhigg','American','1974-00-00'),
	  (2012,'Colleen','Hoover','American','1979-12-11'),
	  (2013,'Dan','Ariely','American','1967-04-29'),
	  (2014,'Dan','Brown','American','1964-06-22'),
	  (2015,'Daniel','Goleman','American','1946-04-07'),
	  (2016,'Emily','Henry','American','1991-05-17'),
	  (2017,'Eric','Ries','American','1978-09-22'),
	  (2018,'Fonda','Lee','Canadian','1979-03-10'),
	  (2019,'Frank','Herbert','American','1920-10-08'),
	  (2020,'Fredric','Brown','American','1906-10-29'),
	  (2021,'Freida','mcfadden','American','1980-05-01'),
	  (2022,'George R.R.','Martin','American','1948-09-20'),
	  (2023,'Gillian','Flynn','American','1971-02-24'),
	  (2024,'Holly','Black','American','1971-11-10'),
	  (2025,'J. K.','Rowling','British','1965-07-31'),
	  (2026,'James','Clear','American','1968-00-00'),
	  (2027,'Jojo','Moyes','English','1969-08-04'),
	  (2028,'Jon','Ronson','British','1967-05-10'),
	  (2029,'Jordan','Peterson','Canadian','1962-06-12'),
	  (2030,'Lewis','Carroll','English','1832-01-27'),
	  (2031,'Lois','Lowry','American','1937-03-20'),
	  (2032,'lucy','foley','British','1986-08-16'),
	  (2033,'Madeline','Miller','American','1978-07-24'),
	  (2034,'Malala','Yousafzai','Pakistani','1997-07-12'),
	  (2035,'Matthew','McConaughey','American','1969-11-04'),
	  (2036,'Michelle','Obama','American','1964-01-17'),
	  (2037,'Morgan','Housel','American','1990-08-15'),
	  (2038,'Napoleon','Hill','American','1883-10-26'),
	  (2039,'Neal','Stephenson','American','1959-10-31'),
	  (2040,'Nicholas','Sparks','American','1965-12-31'),
	  (2041,'Olaf','Stapledon','British','1886-05-10'),
	  (2042,'Paul','Kalanithi','American','1977-04-01'),
	  (2043,'Paula','Hawkins','British','1972-08026'),
	  (2044,'Peter','Lynch','American','1044-01-19'),
	  (2045,'Pierce','Brown','American','1988-01-28'),
	  (2046,'Robert','Greene','American','1959-05-14'),
	  (2047,'Robert','Kiyosaki','American','1947-04-08'),
	  (2048,'Sarah','J. Maas','American','1986-03-05'),
	  (2049,'Steven','Pinker','Canadian','1954-09-18'),
	  (2050,'Sue','Burke','American','1955-06-21'),
	  (2051,'Suzanne','Collins','American','1962-08-10'),
	  (2052,'Tahereh','Mafi','Iranian-American','1988-11-09'),
	  (2053,'Thomas','Erikson','Swedish','1965-09-19'),
	  (2054,'Trevor','Noah','South African','1984-02-20'),
	  (2055,'V. E.','Schwab','American','1987-07-08'),
	  (2056,'Veronica','Roth','American','1988-08-19'),
      (2057,'Walter','Isaacson','American','1952-05-20');
	  SELECT * FROM Author;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Insert into Author 2
INSERT INTO Author(
       AuthorID,FirstName,LastName,Nationality,DateofBirth) 
VALUES
  (2058, 'A. A.', 'Milne', 'English', '1990-01-01'),
  (2059, 'Alain', 'de Botton', 'British', '1991-01-07'),
  (2060, 'Albert', 'Camus', 'French', '1992-01-15'),
  (2061, 'Alex', 'Ross', 'American', '1993-01-22'),
  (2062, 'Alex', 'Van Halen', 'American', '1994-01-30'),
  (2063, 'Alexei', 'Navalny', 'Russian', '1990-02-02'),
  (2064, 'Ali', 'Hazelwood', 'Italian', '1991-02-08'),
  (2065, 'Alyssa', 'Cole', 'American', '1992-02-14'),
  (2066, 'Ana', 'Huang', 'Chinese', '1993-02-20'),
  (2067, 'Anne Faulkner', 'Oberndorf', 'American', '1994-02-27'),
  (2068, 'Ash', 'Bhardwaj', 'Indian', '1990-03-03'),
  (2069, 'Becca', 'Fitzpatrick', 'American', '1991-03-10'),
  (2070, 'Bill', 'Bryson', 'American', '1992-03-17'),
  (2071, 'Billy', 'Collins', 'American', '1993-03-23'),
  (2072, 'Bram', 'Stoker', 'Irish', '1994-03-29'),
  (2073, 'Bruce', 'Chatwin', 'English', '1990-04-04'),
  (2074, 'Caleb', 'Femi', 'Nigerian', '1991-04-09'),
  (2075, 'Carol Ann', 'Duffy', 'Scottish', '1992-04-15'),
  (2076, 'Cassandra', 'Clare', 'American', '1993-04-21'),
  (2077, 'Charles', 'Darwin', 'English', '1994-04-28'),
  (2078, 'Charles', 'Dickens', 'English', '1990-05-05'),
  (2079, 'Charles Villiers', 'Stanford', 'Irish', '1991-05-11'),
  (2080, 'Charlaine', 'Harris', 'American', '1992-05-16'),
  (2081, 'Charlotte', 'Bronte', 'English', '1993-05-22'),
  (2082, 'Chinua', 'Achebe', 'Nigerian', '1994-05-27'),
  (2083, 'Christina', 'Lauren', 'American', '1990-06-01'),
  (2084, 'Christopher', 'McDougall', 'American', '1991-06-06'),
  (2085, 'Colin', 'Thubron', 'British', '1992-06-12'),
  (2086, 'Courtney', 'Peppernell', 'Australian', '1993-06-18'),
  (2087, 'Daniel', 'Levitin', 'American', '1994-06-24'),
  (2088, 'David', 'Byrne', 'Scottish', '1990-07-02'),
  (2089, 'David', 'Crystal', 'British', '1991-07-08'),
  (2090, 'David', 'McCullough', 'American', '1992-07-14'),
  (2091, 'Diana', 'Gabaldon', 'English', '1993-07-20'),
  (2092, 'Elena', 'Armas', 'Spanish', '1994-07-26'),
  (2093, 'Frederic M.', 'Wheelock', 'American', '1990-08-03'),
  (2094, 'Fyodor', 'Dostoevsky', 'Russian', '1991-08-09'),
  (2095, 'Gabriel', 'Wyner', 'American', '1992-08-15'),
  (2096, 'Gboyega', 'Odubanjo', 'Nigerian', '1993-08-21'),
  (2097, 'Homer', '', 'Greek', '1994-08-28'),
  (2098, 'Jack', 'Kerouac', 'American', '1990-09-04'),
  (2099, 'John', 'Ronald Reuel Tolkien', 'English', '1991-09-10');
  SELECT * FROM Author;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Insert Into Author 3
INSERT INTO Author(
       AuthorID,FirstName,LastName,Nationality,DateofBirth) 
VALUES
  (2103, 'James W.', 'Buel', 'American', '1992-09-16'),
  (2104, 'Jane', 'Austen', 'English', '1993-09-22'),
  (2105, 'Jason', 'Rekulak', 'American', '1994-09-29'),
  (2106, 'Jean-Paul', 'Sartre', 'French', '1990-10-05'),
  (2107, 'Jeannette', 'Walls', 'American', '1991-10-11'),
  (2108, 'Jen', 'Calonita', 'American', '1992-10-17'),
  (2109, 'John', 'Krakauer', 'American', '1993-10-23'),
  (2110, 'John', 'Milton', 'English', '1994-10-29'),
  (2111, 'Jostein', 'Gaarder', 'Norwegian', '1990-11-02'),
  (2112, 'Julia', 'Quinn', 'American', '1991-11-08'),
  (2113, 'Ken', 'Dryden', 'Canadian', '1992-11-14'),
  (2114, 'Ken', 'Follett', 'Welsh', '1993-11-20'),
  (2115, 'Lauren', 'Roberts', 'American', '1994-11-26'),
  (2116, 'Liz', 'Braswell', 'American', '1990-12-01'),
  (2117, 'Lotte', 'Lehmann', 'German', '1991-12-07'),
  (2118, 'Louisa May', 'Alcott', 'American', '1992-12-13'),
  (2119, 'Mark', 'Abley', 'Canadian', '1993-12-19'),
  (2120, 'Mark', 'Forsyth', 'British', '1994-12-25'),
  (2121, 'Mary', 'Kubica', 'American', '1995-01-02'),
  (2122, 'Mary', 'Oliver', 'American', '1996-01-08'),
  (2123, 'Mia', 'Sosa', 'American', '1997-01-14'),
  (2124, 'Michael', 'Lewis', 'American', '1998-01-20'),
  (2125, 'Nora', 'Roberts', 'American', '1999-01-26'),
  (2126, 'Omar', 'El Akkad', 'Egyptian', '1995-02-03'),
  (2127, 'Oliver', 'Sacks', 'British', '1996-02-09'),
  (2128, 'Patrick Leigh', 'Fermor', 'English', '1997-02-15'),
  (2129, 'Patricia', 'Schultz', 'American', '1998-02-21'),
  (2130, 'Patti', 'Smith', 'American', '1999-02-27'),
  (2131, 'Paul', 'Theroux', 'American', '1995-03-04'),
  (2132, 'Peter S.', 'Beagle', 'American', '1996-03-10'),
  (2133, 'Rachel', 'Carson', 'American', '1997-03-16'),
  (2134, 'Rachael', 'Lippincott', 'American', '1998-03-22'),
  (2135, 'Rory', 'Stewart', 'British', '1999-03-28'),
  (2136, 'Rolf', 'Potts', 'American', '1995-04-05'),
  (2137, 'Rupi', 'Kaur', 'Canadian', '1996-04-11'),
  (2138, 'Sally', 'Thorne', 'Australian', '1997-04-17'),
  (2139, 'Sarah', 'Adams', 'American', '1998-04-23'),
  (2140, 'Sarah', 'Hawley', 'American', '1999-04-29'),
  (2141, 'S.F.', 'Kosa', 'American', '1995-05-06'),
  (2142, 'Stephen', 'Hawking', 'English', '1996-05-12'),
  (2143, 'Tara', 'Westover', 'American', '1997-05-18'),
  (2144, 'Taylor Jenkins', 'Reid', 'American', '1998-05-24'),
  (2145, 'Umberto', 'Eco', 'Italian', '1999-05-30'),
  (2146, 'Voltaire', '', 'French', '1995-06-07'),
  (2147, 'Wendy', 'Cope', 'British', '1996-06-13'),
  (2148, 'Will', 'Buxton', 'British', '1997-06-19');
  SELECT * FROM Author;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Insert Into Author 4
INSERT INTO Author
VALUES (2149,'Rachel Lynn','Solomon','American','1987-05-17');
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Insert Into Publisher 1
INSERT INTO Publisher(PublisherID,PhoneNumber,Name,Address,Email)
VALUES
(3001, '555-123', 'Random House', 'New York', 'randomhouse@publisher.com'),
(3002, '555-234', 'Simon & Schuster', 'New York', 'simonandschuster@publisher.com'),
(3003, '555-345', 'Atria Books', 'New York', 'atriabooks@publisher.com'),
(3004, '555-456', 'Avery', 'New York', 'avery@publisher.com'),
(3005, '555-567', 'Bantam Books', 'New York', 'bantambooks@publisher.com'),
(3006, '555-678', 'BenBella Books', 'Dallas, TX', 'benbellabooks@publisher.com'),
(3007, '555-789', 'Bloomsbury', 'New York', 'bloomsbury@publisher.com'),
(3008, '555-890', 'Bookouture', 'London, UK', 'bookouture@publisher.com'),
(3009, '556-901', 'Celadon Books', 'New York', 'celadonbooks@publisher.com'),
(3010, '555-012', 'Chilton Books', 'Radnor, PA', 'chiltonbooks@publisher.com'),
(3011, '555-213', 'Crown Publishing Group', 'New York', 'crownpublishing@publisher.com'),
(3012, '555-324', 'Doubleday', 'New York', 'doubleday@publisher.com'),
(3013, '555-435', 'E.P. Dutton', 'New York', 'epdutton@publisher.com'),
(3014, '555-546', 'Flatiron Books', 'New York', 'flatironbooks@publisher.com'),
(3015, '555-657', 'Hachette Book Group', 'New York', 'hachettebookgroup@publisher.com'),
(3016, '555-768', 'Harcourt', 'Orlando, FL', 'harcourt@publisher.com'),
(3017, '555-879', 'Harper Perennial', 'New York', 'harperperennial@publisher.com'),
(3018, '555-980', 'HarperBusiness', 'New York', 'harperbusiness@publisher.com'),
(3019, '555-091', 'HarperCollins', 'New York', 'harpercollins@publisher.com'),
(3020, '555-102', 'Harriman House', 'Petersfield', 'harrimanhouse@publisher.com'),
(3021, '555-213', 'Hoover Ink, Inc.', 'Birmingham, AL', 'hooverink@publisher.com'),
(3022, '555-324', 'Houghton Mifflin Harcourt', 'Boston, MA', 'houghtonmifflinharcourt@publisher.com'),
(3023, '555-435', 'Katherine Tegen Books', 'New York', 'katherinetegenbooks@publisher.com'),
(3024, '555-546', 'Macmillan', 'New York', 'macmillan@publisher.com'),
(3025, '555-657', 'Penguin Random House', 'New York', 'penguinrandomhouse@publisher.com'),
(3026, '555-768', 'Plata Publishing', 'New York', 'platapublishing@publisher.com'),
(3027, '555-879', 'Random House Canada', 'Toronto, ON', 'randomhousecanada@publisher.com'),
(3028, '555-980', 'Riverhead Books', 'New York', 'riverheadbooks@publisher.com'),
(3029, '555-091', 'Scholastic Press', 'New York', 'scholasticpress@publisher.com'),
(3030, '555-102', 'Simon & Schuster', 'New York', 'simonandschuster2@publisher.com'),
(3031, '555-213', 'St. Martins Press', 'New York', 'stmartinspress@publisher.com'),
(3032, '555-324', 'The Ralston Society', 'New York', 'ralstonsociety@publisher.com'),
(3033, '555-435', 'Thought Catalog Books', 'New York', 'thoughtcatalogbooks@publisher.com'),
(3034, '555-546', 'Viking', 'New York', 'viking@publisher.com'),
(3035, '555-657', 'Warner Books', 'Hoboken, NJ', 'warnerbooks@publisher.com'),
(3036, '555-768', 'Wiley', 'New York', 'wiley@publisher.com'),
(3037, '555-879', 'William Morrow Paperbacks', 'New York', 'williammorrowpaperbacks@publisher.com');
SELECT * FROM Publisher;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Insert Into Publisher 2
INSERT INTO Publisher(PublisherID,PhoneNumber,Name,Address,Email)
VALUES
  (2066, '+39 02 1234567', 'Ana Huang', 'London', 'AnaHuang@email.com'),
  (3039, '+39 06 8901234', 'Andrews McMeel Publishing', 'Paris',  'AndrewsMcMeelPubli@email.com'),
  (3040, '+39 055 4321098', 'Archibald Constable & Co.', 'New York City', 'Archibald Constable & Co.@email.com'),
  (3041, '+39 011 7654321', 'Aschehoug', 'Tokyo',  'Aschehoug@email.com'),
  (3042, '+39 081 9876543', 'Basic Books', 'Los Angeles',  'Basic Books@email.com'),
  (3043, '+39 070 2345678', 'Beacon Press', 'Chicago',  'Beacon Press@email.com'),
  (3044, '+39 095 6789012', 'Blackstone Publishing', 'Berlin',  'Blackstone Publishing@email.com'),
  (3045, '+39 041 3210987', 'Bompiani', 'Madrid','Bompiani@email.com'),
  (3046, '+39 051 6543210', 'Canongate Books', 'Rome',  'Canongate Books@email.com'),
  (3047, '+39 075 9876543', 'Chapman & Hall', 'Moscow', 'Chapman & Hall@email.com'),
  (2086, '+39 089 2109876', 'Courtney Peppernell', 'Mexico City', 'Courtney Peppernell@email.com'),
  (3049, '+39 091 5432109', 'Cramer', 'Seoul',  'Cramer@email.com'),
  (3050, '+39 079 8765432', 'Disney Hyperion', 'Istanbul', 'Disney Hyperion@email.com'),
  (3051, '+39 0541 123456', 'Disney Press', 'Buenos Aires', 'Disney Press@email.com'),
  (3052, '+39 0544 678901', 'Faber & Faber', 'Mumbai',  'Faber & Faber@email.com'),
  (3053, '+39 0574 234567', 'Gallimard', 'Delhi',  'Gallimard@email.com'),
  (3054, '+39 0586 890123', 'George Allen & Unwin', 'Sydney',  'George Allen & Unwin@email.com'),
  (3055, '+39 059 4321098', 'Harlequin MIRA', 'Shanghai',  'Harlequin MIRA@email.com'),
  (3056, '+39 030 7654321', 'Haynes Publishing', 'Beijing',  'Haynes Publishing@email.com'),
  (3057, '+39 035 9876543', 'Heinemann Educational', 'Toronto',  'Heinemann Educational@email.com'),
  (3058, '+39 045 2109876', 'Houghton Mifflin', 'Cairo',  'Houghton Mifflin@email.com'),
  (3059, '+39 049 5432109', 'Houghton Mifflin Harcourt', 'Shenzhen',  'Houghton Mifflin Harcourt@email.com'),
  (3060, '+39 040 8765432', 'Icon Books', 'Guangzhou', 'Icon Books@email.com'),
  (3061, '+39 0187 123456', 'John Murray', 'Shenzhen', 'John Murray@email.com'),
  (3062, '+39 0188 678901', 'Knopf', 'Guangzhou',  'Knopf@email.com'),
  (3063, '+39 0189 234567', 'Penguin Books', 'London',  'penguin books@email.com'),
  (3064, '+39 0881 890123', 'Penguin Classics', 'Paris',  'Penguin Classics@email.com'),
  (3065, '+39 0882 432109', 'Random House', 'New York City', 'Random House@email.com'),
  (3066, '+39 0883 765432', 'Ravyn Press', 'Tokyo',  'Ravyn Press@email.com'),
  (3067, '+39 0922 987654', 'ReganBooks', 'Los Angeles',  'ReganBooks@email.com'),
  (3068, '+39 0923 210987', 'Roberts Brothers', 'Chicago', 'Roberts Brothers@email.com'),
  (2137, '+39 0924 543210', 'Rupi Kaur', 'Berlin',  'Rupi Kaur@writingmail.com'),
  (3070, '+39 0931 876543', 'Smith, Elder & Co.', 'Madrid',  'Smith, Elder & Co.@email.com'),
  (3071, '+39 0932 210987', 'T. Egerton, Whitehall', 'Rome',  'T. Egerton, Whitehall@email.com'),
  (3072, '+39 0965 543210', 'The Russian Messenger', 'Moscow',  'The Russian Messenger@email.com'),
  (3073, '+39 320 1234567', 'Thomas Egerton', 'Mexico City', 'Thomas Egerton@email.com'),
  (3074, '+39 335 6789012', 'Viking Press', 'Seoul',  'Viking Press@email.com'),
  (3075, '+39 347 2345678', 'W. W. Norton & Company', 'Istanbul', 'W. W. Norton & Company@email.com'),
  (3076, '+39 366 8901234', 'William Morrow', 'Buenos Aires',  'William Morrow@email.com');
SELECT * FROM Publisher;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Insert Into Books 1
INSERT INTO Books(
    BookID,Title,AuthorName,Publisher,ISBN,YearPublished,TotalCopies,CopiesAvailable,Genre,AuthorID,PublisherID)
VALUES
	(1001, 'The silent Patient', 'Alex Michaelides', 'Celadon Books', 9781250301697, 2019, 10, 7, 'Psychological Thriller',2001,3009),
    (1002, 'The Housemaid', 'Freida McFadden','Bookouture', 9781538742570, 2022, 15, 5, 'Psychological Thriller',2021,3008),
	(1003, 'Verity', 'Colleen Hoover', 'Hoover Ink, Inc.', 9781538724736, 2018, 8, 0, 'Psychological Thriller',2012,3021),
    (1004, 'Gone Girl', 'Gillian Flynn', 'Crown Publishing Group', 9780307588364, 2012, 3, 3, 'Psychological Thriller',2023,3011),
	(1005,'the da vinci code','dan brown','Doubleday',9780552159715,2003,10,2,'Psychological Thriller',2014,3012),
	(1006,'the guest list','lucy foley','William Morrow Paperbacks',9780062950547,2020,12,4,'Psychological Thriller',2032,3037),
	(1007,'behind closed doors','B.A. PARIS','St. Martin’s Press',9781250120937,2016,5,2,'Psychological Thriller',2003,3031),
	(1008,'the girl on the train','Paula Hawkins','Riverhead Books',9781594633669,2015,7,5,'Psychological Thriller',2043,3028),
	(1009,'dark matter','blake crouch','Crown Publishing Group',9781101904244,2016,9,8,'Psychological Thriller',2008,3011),
	(1010,'the housemaid is watching','Freida mcfadden','Bookouture',9781464230837,2024,15,13,'Psychological Thriller',2021,3008),
	(1012,'Atomic habits','James Clear','Avery',35211292,2018,10,0,'psychology',2026,3004),
	(1013,'12 rules for life','Jordan Peterson','Random House Canada',345816023,2018,7,5,'psychology',2029,3027),
	(1014,'the pyschopath test','Jon Ronson','Riverhead Books',9780393339251,2011,6,1,'psychology',2028,3028),
	(1015,'Emotional Intelligence','Daniel Goleman','Penguin Random House',9780553383713,1995,2,0,'psychology',2015,3025),
	(1016,'The body keeps the score','Bessel van der Kolk','Viking',9780143127741,2014,8,3,'psychology',2007,3034),
	(1017,'Predictably Irrational','Dan Ariely','Harper Perennial',978001,2008,10,5,'psychology',2013,3017),
	(1018, 'The paradox Of choice', 'Barry Schwartz', 'HarperCollins', 9780060005696, 2004, 6, 2, 'psychology',2005,3019),
	(1019, 'The power of Habit', 'Charles Duhigg', 'Penguin Random House', 9781400069286, 2012, 8, 4, 'Psychology',2011,3025),
	(1020, 'Surrounded by idiots ', 'Thomas Erikson', 'Flatiron Books', 9781250134762, 2014, 10, 2, 'Psychology',2053,3014),
	(1021, 'Surrounded by psychopaths ', 'Thomas Erikson', 'BenBella Books', 9781250240371, 2020, 10, 5, 'Psychology',2053,3006),
	(1022, '101 Essays That will change the way you think', 'Brianna Wiest', 'Thought Catalog Books', 9781945796094, 2016, 8, 1, 'Psychology',2009,3033),
	(1023, 'The 48 Laws of Power', 'Robert Greene', 'Penguin Random House', 780140280197, 1998, 5, 5, 'Psychology',2046,3025),
    (1024, 'The language Instict', 'Steven Pinker', 'William Morrow Paperbacks', 9780061336469, 1994, 4, 1, 'Psychology',2049,3037),
	(1025, 'Steve Jobs', 'Walter Isaacson', ' Simon & Schuster', 9781451648546, 2011,9, 0, 'Biography',2057,3030),
	(1026, 'When Breath Becomes Air', 'Paul Kalanithi', ' Random House', 9780812988406, 2016,7 , 2, 'Biography',2042,3001),
	(1027, 'Greenlights', 'Matthew McConaughey', 'Crown Publishing Group', 9780593139134, 2020, 3, 0, 'Biography',2035,3011),
	(1028, 'Born a Crime', 'Trevor Noah', 'Penguin Random House', 9780399588198, 2016,6,2, 'Biography',2054,3025),
	(1029, 'Becoming', 'Michelle Obama', 'Crown Publishing Group', 978152, 2018, 5, 1, 'Biography',2036,3011),
	(1030, 'I Am Malala ', 'Malala Yousafzai', 'Hachette Book Group', 9780316327916, 2013, 4, 3, 'Biography',2034,3015),
	(1031, 'A promised Land', 'Barack Obama', 'Crown Publishing Group', 9781524763169, 2020, 3, 1, 'Biography',2004,3011),
	(1032,'The Cruel Prince','Holly Black', 'Hachette Book Group', 9780316310277, 2018,10,1,'Fantasy Fiction',2024,3015),
    (1033,'The Invisible Life of Addie LaRue','V. E. Schwab',  'Penguin Random House', 9781789095593, 2020,9,2,'Fantasy Fiction',2055,3025),
    (1034, 'A Court of Thorns and Roses','Sarah J. Maas', 'Bloomsbury', 9781619635180, 2015,7,4,'Fantasy Fiction',2048,3007),
    (1035,'A Court of Mist and Fury', 'Sarah J. Maas','Bloomsbury', 9781619635197, 2016,6,5,'Fantasy Fiction',2048,3007),
    (1036, 'A Court of Wings and Ruin','Sarah J. Maas', 'Bloomsbury', 9781619635203, 2017,5,5,'Fantasy Fiction',2048,3007),
    (1037, 'A Court of Frost and Starlight','Sarah J. Maas', 'Bloomsbury', 9781635575613, 2018,8,1,'Fantasy Fiction',2048,3007),
    (1038,'A Court of Silver Flames', 'Sarah J. Maas','Bloomsbury',9781635576191, 2021,5,4,'Fantasy Fiction',2048,3007),
    (1039,'A Game of Thrones','George R.R. Martin', 'Penguin Random House', 9780553103540, 1996,3,0,'Fantasy Fiction',2022,3025),
    (1040, 'Alice’s Adventures in Wonderland', 'Lewis Carroll', 'Macmillan', 9781503250218, 1865,1,0,'Fantasy Fiction',2030,3024),
    (1041, 'Jade City','Fonda Lee', 'Hachette Book Group', 9780316440882, 2017,12,10,'Fantasy Fiction',2018,3015),
    (1042, 'Harry Potter and the Philosopher’s Stone', 'J. K. Rowling', 'Bloomsbury', 9780747532699, 1997,2,0,'Fantasy Fiction',2025,3007),
    (1043, 'Harry Potter and the Chamber of Secrets', 'J. K. Rowling', 'Bloomsbury', 9780747538493, 1998,3,1,'Fantasy Fiction',2025,3007),
    (1044,  'Harry Potter and the Prisoner of Azkaban', 'J. K. Rowling', 'Bloomsbury', 9780747546290, 1999,4,2,'Fantasy Fiction',2025,3007),
    (1045,  'Harry Potter and the Goblet of Fire', 'J. K. Rowling', 'Bloomsbury', 9780747546245, 2000,6,1,'Fantasy Fiction',2025,3007),
    (1046, 'Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'Bloomsbury', 9780747551003, 2003,3,0,'Fantasy Fiction',2025,3007),
    (1047,'Harry Potter and the Half-Blood Prince', 'J. K. Rowling', 'Bloomsbury', 9780747581086, 2005,9,5,'Fantasy Fiction',2025,3007),
	(1048,'Shatter Me', 'Tahereh Mafi', 'HarperCollins', 9780062085481, 2011,4,1, 'Dystopian Fiction',2052,3019),
    (1049,'Unravel Me', 'Tahereh Mafi', 'HarperCollins', 9780062085535, 2013,3,1, 'Dystopian Fiction',2052,3019),
    (1050,'Ignite Me', 'Tahereh Mafi', 'HarperCollins', 9780062085573, 2014,5,2, 'Dystopian Fiction',2052,3019),
    (1051,'Restore Me', 'Tahereh Mafi', 'HarperCollins', 9780062676344, 2018,10,1,'Dystopian Fiction',2052,3019),
    (1052,'Defy Me', 'Tahereh Mafi', 'HarperCollins', 9780062676399, 2019,4,1, 'Dystopian Fiction',2052,3019),
    (1053,'Imagine Me', 'Tahereh Mafi', 'HarperCollins', 9780062676405, 2020,6,2, 'Dystopian Fiction',2052,3019),
    (1054,'Divergent', 'Veronica Roth', 'Katherine Tegen Books', 9780062024039, 2011,5,2,'Dystopian Fiction',2056,3023),
    (1055,'The Giver', 'Lois Lowry', 'Houghton Mifflin Harcourt', 9780544336261, 1993,8,3,'Dystopian Fiction',2031,3022),
    (1056,'The Hunger Games', 'Suzanne Collins', 'Scholastic Press', 9780439023481, 2008,10,0,'Dystopian Fiction',2051,3029),
	(1057,'The Notebook', 'Nicholas Sparks', 'Warner Books', 9780446605236, 1996,4,1,'Romance',2040,3035),
    (1058,'It Ends with Us', 'Colleen Hoover', 'Atria Books', 9781501110368, 2016,5,1,'Romance',2012,3003),
    (1059,'It Starts with Us', 'Colleen Hoover', 'Atria Books', 9781668001226, 2022,6,3,'Romance',2012,3003),
    (1060,'Beach Read', 'Emily Henry', 'Penguin Random House', 9781984806734, 2020,7,4,'Romance',2012,3025),
    (1061,'People We Meet on Vacation', 'Emily Henry', 'Penguin Random House', 9781984806758, 2021,6,5,'Romance',2016,3025),
    (1062,'Book Lovers', 'Emily Henry', 'Penguin Random House', 9780593334836, 2022, 4,2,'Romance',2016,3025),
    (1063,'Ugly Love', 'Colleen Hoover', 'Atria Books', 9781476753188, 2014,9,0,'Romance',2012,3003),
    (1064,'Confess', 'Colleen Hoover', 'Atria Books', 9781476791456, 2015,5,3,'Romance',2012,3003),
    (1065,'November 9', 'Colleen Hoover', 'Atria Books', 9781501110344, 2015,4,1,'Romance',2012,3003),
    (1066,'Reminders of Him', 'Colleen Hoover', 'Atria Books', 9781542025607, 2022,5,2,'Romance',2012,3003),
    (1067,'Me Before You', 'Jojo Moyes', 'Penguin Random House', 9780143124542, 2012,6,2,'Romance',2027,3025),
    (1068,'The Song of Achilles', 'Madeline Miller', 'HarperCollins', 9780062060624, 2011,6,0,'Romance',2033,3019),
	(1069,'Rich Dad Poor Dad', 'Robert Kiyosaki', 'Plata Publishing', 9781612680194, 1997,4,0,'Finance',2047,3026),
    (1070,'Think and Grow Rich', 'Napoleon Hill', 'The Ralston Society', 9781937879501, 1937,1,0,'Finance',2038,3032),
    (1071,'The Psychology of Money', 'Morgan Housel', 'Harriman House', 9780857197689, 2020,5,4,'Finance',2037,3020),   
	(1072,'The Intelligent Investor', 'Benjamin Graham', 'HarperBusiness', 9780060555665, 1949,1,1,'Finance',2006,3018),    
	(1073,'The Lean Startup', 'Eric Ries', 'Penguin Random House', 9780307887894, 2011,4,2,'Finance',2017,3025),
    (1074,'Once Upon a Wall Street', 'Peter Lynch', 'Wiley', 9780471297499, 1989,1,0,'Finance',2044,3036),
	(1075,'Dune', 'Frank Herbert', 'Chilton Books', 9780441172719, 1965,5,1,'Science Fiction',2019,3010),
    (1076,'The Martian', 'Andy Weir', 'Crown Publishing Group', 9780553418026, 2011,3,1,'Science Fiction',2002,3011),
    (1077,'Snow Crash', 'Neal Stephenson', 'Bantam Books', 9780553380958, 1992,3,1,'Science Fiction',2039,3005),
    (1078,'Contact', 'Carl Sagan', 'Simon & Schuster', 9780671434007, 1985,2,1,'Science Fiction',2010,3030),
    (1079,'Star Maker', 'Olaf Stapledon', 'Harcourt', 9780156849605, 1937,1,0,'Science Fiction',2041,3016),
    (1080,'What Mad Universe', 'Fredric Brown', 'E.P Dutton', 9781596546787, 1949,1,0,'Science Fiction',2020,3013),
	(1081,'Red Rising', 'Pierce Brown', 'Penguin Random House', 9780345539809, 2014,4,2,'Science Fiction',2045,3025),
    (1082,'Semiosis', 'Sue Burke', 'Simon & Schuster', 9780765391356, 2018,5,3,'Science Fiction',2050,3030);
SELECT * FROM Books;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Insert Into Books 2
INSERT INTO Books(
    BookID,Title,AuthorName,Publisher,ISBN,YearPublished,TotalCopies,CopiesAvailable,Genre,AuthorID,PublisherID)
VALUES
    (1083,'Fluent Forever: How to Learn Any Language Fast and Never Forget It', 'Gabriel Wyner', 'Penguin Random House', 9780385348119, 2014,5,3,'Languages',2095,3025),
    (1084,'The Language Instinct', 'Steven Pinker', 'William Morrow', 9780060958336, 1994,3,1,'Languages',2049,3076),
    (1085,'The Etymologicon', 'Mark Forsyth', 'Icon Books', 9781848313071, 2011,4,2,'Languages',2120,3060),
    (1086,'How Language Works', 'David Crystal', 'penguin books', 9780141015521, 2005, 5,2,'Languages',2089,3063),
    (1087,'Wheelock’s Latin', 'Frederic M. Wheelock', 'HarperCollins', 9780061997211, 1956,1,0,'Languages',2093,3019),
    (1088,'Spoken Here: Travels Among Threatened Languages', 'Mark Abley', 'Houghton Mifflin', 9780618565839, 2003,4,1,'Languages',2119,3058),
    (1089,'Words and Rules: The Ingredients of Language', 'Steven Pinker', 'Basic Books', 9780465072705, 1999,3,2, 'Languages',2049,3042),
	(1090,'Dark Places', 'Gillian Flynn', 'Crown Publishing Group', 9.78031E+12, 2009,5,3,'Thriller',2023,3011),
    (1091,'The Quiet Girl', 'S. F. Kosa', 'Blackstone Publishing', 9.78173E+12, 2020,7,5,'Thriller',2141,3044),
    (1092,'When No One Is Watching', 'Alyssa Cole', 'HarperCollins', 9.78006E+12, 2020,5,4,'Thriller',2065,3019),
    (1093,'Hidden Pictures', 'Jason Rekulak', 'Doubleday', 9781250784585, 2022,5,2,'Thriller',2105,3012),
    (1094,'The Good Girl', 'Mary Kubica', 'Harlequin MIRA', 9.78078E+12, 2014,4,2,'Thriller',2121,3055),
    (1095,'Into the Wild', 'John Krakauer', 'Random House', 9.78039E+12, 1996,1,0,'Biography',2109,3065),
    (1096,'Just Kids', 'Patti Smith', 'HarperCollins', 7.81424E+11, 2010,5,2,'Biography',2130,3019),
    (1097,'John Adams', 'David McCullough', 'Simon & Schuster', 743223133, 2001,6,2, 'Biography',2090,3030),
    (1098,'Educated', 'Tara Westover', 'Random House', 9.7804E+12, 2018,5,4,'Biography',2143,3065),
    (1099,'The Glass Castle', 'Jeannette Walls', 'Simon & Schuster', 9.78074E+12, 2005,5,2,'Biography',2107,3030),
    (1100,'Patriot', 'Alexei Navalny', 'HarperCollins', 9.78006E+12, 2024,4,2,'Biography',2063,3019),
    (1101,'Water, Water: Poems', 'Billy Collins', 'Penguin Random House', 9.7807E+12, 2024,4,3,'Poetry',2071,3025),
    (1102,'Home Body', 'Rupi Kaur', 'Andrews McMeel Publi', 9.78145E+12, 2020,5,3,'Poetry',2137,3039),
    (1103,'A Thousand Mornings', 'Mary Oliver', 'Penguin Random House', 9.78014E+12, 2012,6,2, 'Poetry',2122,3025),
    (1104,'The Sun and Her Flowers', 'Rupi Kaur', 'Andrews McMeel Publi', 9.78145E+12, 2017,4,1, 'Poetry',2137,3039),
    (1105,'Odyssey', 'Homer', 'Penguin Classics', 9.78014E+12, 1872,3,2,'Poetry',2097,3064),
    (1106,'Pillow Thoughts', 'Courtney Peppernell', 'Courtney Peppernell', 9.78145E+12, 2016,6,2, 'Poetry',2086,2086),
    (1107,'Collected Poems', 'Wendy Cope', 'Faber & Faber', 9.78068E+12, 2024,7,4, 'Poetry',2147,3052),
    (1108,'Healing Through Words', 'Rupi Kaur', 'Rupi Kaur', 9.78145E+12, 2022,4,1, 'Poetry',2137,2137),
    (1109,'Dog Songs', 'Mary Oliver', 'Beacon Press', 9.7808E+12, 2013,7,4,'Poetry',2122,3043),
    (1110,'Paradise Lost', 'John Milton', 'Penguin Classics', 9.78014E+12, 1667,1,0,'Poetry',2110,3064),
    (1111,'The Wickedest', 'Caleb Femi', 'Canongate Books', 9.78099E+12, 2024,14,10,'Poetry',2074,3046),
    (1112,'Three Wise Men', 'Carol Ann Duffy', 'Faber & Faber', 7.78155E+12, 2024,15,5, 'Poetry',2075,3052),
    (1113,'Adam', 'Gboyega Odubanjo', 'Penguin Random House', 9.7816E+12, 2024,9,6,'Poetry',2096,3025),
    (1114,'Jane Eyre', 'Charlotte Bronte', 'Smith, Elder & Co.', 9.78014E+12, 1847,2,0,'Classic',2081,3070),
    (1115,'Pride and Prejudice', 'Jane Austen', 'T. Egerton, Whitehall', 7.78014E+12,1813,2,1,'Classic',2104,3071),
    (1116,'Little Women', 'Louisa May Alcott', 'Roberts Brothers', 9.78014E+12, 1868,3,1,'Classic',2118,3068),
    (1117,'Great Expectations', 'Charles Dickens', 'Chapman & Hall', 9.78014E+12, 1860,1,1, 'Classic',2078,3047),
	(1118,'Sense and Sensibility', 'Jane Austen', 'Thomas Egerton', 9.78014E+12, 1811,4,2, 'Classic',2104,3073),
    (1119,'Emma', 'Jane Austen', 'John Murray', 9.78014E+12, 1815,3,1,'Classic',2104,3061),
    (1120,'The Hobbit', 'John Ronald Reuel Tolkien', 'George Allen & Unwin', 9.78014E+12, 1937,2,1,'Classic',2099,3054),
    (1121,'A Tale of Two Cities', 'Charles Dickens', 'Chapman & Hall', 9.78045E+12, 1859,3,1, 'Classic',2078,3047),
    (1161,'Dracula', 'Bram Stoker', 'Archibald Constable & Co.', 3.78045E+12, 1897,5,3, 'Classic',2072,3040),
    (1122,'Powerless', 'Lauren Roberts', 'Ravyn Press', 9.78038E+12, 2023, 9,8,'Fantasy Fiction',2115,3066),
    (1123,'A Christmas Carol', 'Charles Dickens', 'Chapman & Hall', 9.78045E+12, 1843,5,2,'Classic',2078,3047),
    (1124,'Crime and Punishment', 'Fyodor Dostoevsky', 'The Russian Messenger', 9.78014E+12, 1866,4,1,'Classic',2094,3072),
    (1125,'A Whole New World', 'Liz Braswell', 'Disney Press', 9.78148E+12, 2015,5,2, 'Fantasy Fiction',2116,3051),
    (1126,'Conceal, Don’t Feel', 'Jen Calonita', 'Disney Hyperion', 9.78137E+12, 2019,7,4, 'Fantasy Fiction',2108,3050),
    (1127,'The Last Unicorn', 'Peter S. Beagle', 'Viking Press', 9.78035E+12, 1968,5,2, 'Fantasy Fiction',2132,3074),
    (1128,'The Wedding Crashers', 'Mia Sosa', 'Penguin Random House', 9.78006E+12, 2022,4,1, 'Romance',2123,3025),
    (1129,'The Ex Talk', 'Rachel Lynn', 'Penguin Random House', 1.78174E+12, 2020,7,3, 'Romance',2148,3025),
    (1130,'The Spanish Love Deception', 'Elena Armas', 'Atria Books', 9.78196E+12, 2021,6,3, 'Romance',2092,3003),
    (1131,'The Hating Game', 'Sally Thorne', 'HarperCollins', 9.78006E+12, 2016,6,3,'Romance',2138,3019),
    (1132,'Love and Other Words', 'Christina Lauren', 'Simon & Schuster', 9.78156E+12, 2018,3,1,'Romance',2083,3030),
    (1133,'Twisted Love', 'Ana Huang', 'Ana Huang', 1.78173E+12, 2021,8,4, 'Romance',2066,2066),
    (1134,'Five Feet Apart', 'Rachael Lippincott', 'Simon & Schuster', 9.78153E+12, 2018,8,4,'Romance',2134,3030);
SELECT * FROM Books;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Insert Into Books 3
INSERT INTO Books( BookID,Title,AuthorName,Publisher,ISBN,YearPublished,TotalCopies,CopiesAvailable,Genre,AuthorID,PublisherID)
VALUES
    (1135,'The Love Hypothesis', 'Ali Hazelwood', 'Penguin Random House', 9.78059E+12, 2021,5,2, 'Romance',2064,3025),
    (1136,'Twisted Games', 'Ana Huang', 'Ana Huang', 9.78173E+12, 2021,9,5,'Romance',2066,2066),
    (1137,'Twisted Hate', 'Ana Huang', 'Ana Huang', 1.78172E+12, 2022,10,4,'Romance',2066,2066),
    (1138,'American War', 'Omar El Akkad', 'Penguin Random House', 9.7811E+12, 2017,4,1, 'Dystopian Fiction',2126,3025),
    (1139,'The Seven Husbands of Evelyn Hugo', 'Taylor Jenkins Reid', 'Atria Books', 9.7815E+12, 2017,5,2,'Historical Fiction',2144,3003),
    (1140,'The Armor of Light', 'Ken Follett', 'Penguin Random House', 3.78077E+12, 2022,8,3,'Historical Fiction',2114,3025),
    (1141,'The Duke and I', 'Julia Quinn', 'HarperCollins', 9.78006E+12, 2000,5,2,'Historical Fiction',2112,3019),
    (1142,'The Viscount Who Loved Me', 'Julia Quinn', 'HarperCollins', 3.78006E+12, 2000,4,1, 'Historical Fiction',2112,3019),
    (1143,'An Offer from a Gentleman', 'Julia Quinn', 'HarperCollins', .78006E+12, 2001,6,3,'Historical Fiction',2112,3019),
    (1144,'Romancing Mr. Bridgerton', 'Julia Quinn', 'HarperCollins', .78006E+12, 2002,9,5, 'Historical Fiction',2112,3019),
    (1145,'To Sir Phillip, With Love', 'Julia Quinn', 'HarperCollins', 9.78006E+12, 2003,8,3,'Historical Fiction',2112,3019),
    (1146,'When He Was Wicked', 'Julia Quinn', 'HarperCollins', 9.78006E+12, 2004,5,1,'Historical Fiction',2112,3019),
    (1147,'Its in His Kiss', 'Julia Quinn', 'HarperCollins', 9.78006E+12, 2005,5,1,'Historical Fiction',2112,3019),
    (1148,'On the Way to the Wedding', 'Julia Quinn', 'HarperCollins', 9.78006E+12, 2006,4,1, 'Historical Fiction',2112,3019),
    (1149,'The Pillars of the Earth', 'Ken Follett', 'HarperCollins', .78045E+12, 1989,7,3, 'Historical Fiction',2114,3019),
    (1150,'Outlander', 'Diana Gabaldon', 'Penguin Random House', .78035E+12, 1991,9,3, 'Historical Fiction',2091,3025),
    (1151,'Things Fall Apart', 'Chinua Achebe', 'Heinemann Educational', 9.78029E+12, 1958,8,3,'Historical Fiction',2082,3057),
    (1152,'The Stranger', 'Albert Camus', 'Gallimard', 1.78006E+12, 1942,5,1,'Philosophy',2060,3053),
    (1153,'The Name of the Rose', 'Umberto Eco', 'Bompiani', 9.78016E+12, 1980,5,3, 'Philosophy',2145,3045),
    (1154,'Nausea', 'Jean-Paul Sartre', 'Gallimard', 9.78068E+12, 1938,2,1,'Philosophy',2106,3053),
    (1155,'Candide', 'Voltaire', 'Cramer', 1.78055E+12, 1799,5,1,'Philosophy',2146,3049),
    (1156,'Sophies World', 'Jostein Gaarder', 'Aschehoug', .78047E+12, 1991,6,5, 'Philosophy',2111,3041),
    (1157,'Born to Run: A Hidden Tribe, Superathletes, and the Greatest Race the World Has Ever Seen', 'Christopher McDougall', 'Knopf', 9.78021E+12, 2009,8,3, 'Sports',2084,3062),
    (1158,'The Blind Side: Evolution of a Game', 'Michael Lewis', 'W. W. Norton & Company', 1.78035E+12, 2006,7,4,'Sports',2124,3075),
    (1159,'Moneyball: The Art of Winning an Unfair Game', 'Michael Lewis', 'W. W. Norton & Company', 9.76025E+12, 2002,5,3, 'Sports',2124,3075),
    (1162,'Grand Prix: An Illustrated History of Formula 1', 'Will Buxton', 'Haynes Publishing', 3.78076E+12, 2011,5,1,'Sports',2148,3056),
    (1160,'The Game', 'Ken Dryden', 'ReganBooks', 9.78006E+12, 1983,1,0,'Sports',2113,3067);
SELECT * FROM Books;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Insert Into Borrower
INSERT INTO Borrower(BorrowerID, FirstName, LastName, Email, PhoneNumber, MemberShipDate, MemberShipStatus)
VALUES
(1, 'John', 'Smith', 'johnsmith@email.com', '(555) 555-1212', '2005-03-12', 'Active'),
(2, 'Jane', 'Johnson', 'janemjohnson@email.com', '(555) 555-1213', '2006-11-25', 'Suspended'),
(3, 'Michael', 'Williams', 'michaelwilliams@email.com', '(555) 555-1214', '2007-07-18', 'Active'),
(4, 'Emily', 'Brown', 'emilybrown@email.com', '(555) 555-1215', '2008-04-02', 'Suspended'),
(5, 'David', 'Jones', 'davidjones@email.com', '(555) 555-1216', '2009-12-19', 'Active'),
(6, 'Sarah', 'Davis', 'sarahdavis@email.com', '(555) 555-1217', '2010-09-05', 'Suspended'),
(7, 'James', 'Miller', 'jamesmiller@email.com', '(555) 555-1218', '2011-05-27', 'Active'),
(8, 'Olivia', 'Wilson', 'oliviawilson@email.com', '(555) 555-1219', '2012-02-14', 'Suspended'),
(9, 'William', 'Moore', 'williamoore@email.com', '(555) 555-1220', '2013-10-11', 'Active'),
(10, 'Abigail', 'Taylor', 'abigailtaylor@email.com', '(555) 555-1221', '2014-06-26', 'Suspended'),
(11, 'Noah', 'Anderson', 'noahanderson@email.com', '(555) 555-1222', '2015-03-15', 'Active'),
(12, 'Sophia', 'Thomas', 'sophiathomas@email.com', '(555) 555-1223', '2016-11-02', 'Suspended'),
(13, 'Jacob', 'Jackson', 'jacobjackson@email.com', '(555) 555-1224', '2017-07-20', 'Active'),
(14, 'Charlotte', 'White', 'charlottewhite@email.com', '(555) 555-1225', '2018-04-07', 'Suspended'),
(15, 'Ethan', 'Harris', 'ethanharris@email.com', '(555) 555-1226', '2019-12-25', 'Active'),
(16, 'Amelia', 'Martin', 'ameliamartin@email.com', '(555) 555-1227', '2020-09-12', 'Suspended'),
(17, 'Aiden', 'Thompson', 'aidentthompson@email.com', '(555) 555-1228', '2021-05-29', 'Active'),
(18, 'Ava', 'Garcia', 'avagarcia@email.com', '(555) 555-1229', '2022-02-16', 'Suspended'),
(19, 'Logan', 'Martinez', 'loganmartinez@email.com', '(555) 555-1230', '2023-10-13', 'Active'),
(20, 'Isabella', 'Robinson', 'isabellarobinson@email.com', '(555) 555-1231', '2024-06-28', 'Suspended');
SELECT * FROM Borrower;
---------------------------------------------------------------------------------------------------------------
--Insert Into Staff
INSERT INTO Staff(StaffID, FirstName, LastName, RoleName, PhoneNumber, Email, EmploymentDate, SupervisorID)
VALUES
(100, 'John', 'Smith', 'Manager', '(123) 456-7890', 'johnsmith@email.com', '2005-01-01', 100),
(101, 'Jane', 'Johnson', 'Librarian', '(234) 567-8901', 'janemjohnson@email.com', '2006-04-15', 100),
(102, 'Michael', 'Williams', 'Circulation Clerk', '(345) 678-9012', 'michaelwilliams@email.com', '2007-07-28', 100),
(103, 'Emily', 'Brown', 'Reference Librarian', '(456) 789-0123', 'emilybrown@email.com', '2008-10-12', 100),
(104, 'David', 'Jones', 'Childrens Librarian', '(567) 890-1234', 'davidjones@email.com', '2009-02-22', 101),
(105, 'Sarah', 'Davis', 'Cataloger', '(678) 901-2345', 'sarahdavis@email.com', '2010-05-19', 101),
(106, 'James', 'Miller', 'Technical Services Librarian', '(789) 012-3456', 'jamesmiller@email.com', '2011-08-05', 101),
(107, 'Olivia', 'Wilson', 'Digital Librarian', '(890) 123-4567', 'oliviawilson@email.com', '2012-11-21', 101),
(108, 'William', 'Moore', 'Archives Librarian', '(901) 234-5678', 'williamoore@email.com', '2013-03-07', 101),
(109, 'Abigail', 'Taylor', 'Media Specialist', '(123) 456-7891', 'abigailtaylor@email.com', '2014-06-24', 101),
(110, 'Noah', 'Anderson', 'Outreach Coordinator', '(234) 567-8902', 'noahanderson@email.com', '2015-09-10', 101),
(111, 'Sophia', 'Thomas', 'Security Guard', '(345) 678-9013', 'sophiathomas@email.com', '2016-12-26', 101),
(112, 'Jacob', 'Jackson', 'IT Technician', '(445) 678-9014', 'jacobjackson@email.com', '2017-04-03', 102),
(113, 'Charlotte', 'White', 'Web Developer', '(556) 789-0124', 'charlottewhite@email.com', '2018-07-18', 102),
(114, 'Ethan', 'Harris', 'Marketing Specialist', '(667) 890-1235', 'ethanharris@email.com', '2019-10-02', 102),
(115, 'Amelia', 'Martin', 'Assistant Manager', '(778) 901-2346', 'ameliamartin@email.com', '2020-01-15', 102),
(116, 'Aiden', 'Thompson', 'Library Assistant', '(889) 012-3457', 'aidentthompson@email.com', '2021-04-30', 102),
(117, 'Ava', 'Garcia', 'Teen Librarian', '(990) 123-4568', 'avagarcia@email.com', '2022-08-14', 102),
(118, 'Logan', 'Martinez', 'Acquisitions Librarian', '(101) 234-5679', 'loganmartinez@email.com', '2023-11-29', 102),
(119, 'Isabella', 'Robinson', 'Serials Librarian', '(212) 345-6780', 'isabellarobinson@email.com', '2024-03-13', 102),
(120, 'Lucas', 'Clark', 'Instructional Designer', '(323) 456-7892', 'lucasclark@email.com', '2005-06-01', 103),
(121, 'Mia', 'Lewis', 'Volunteer Coordinator', '(434) 567-8903', 'miale@email.com', '2006-09-16', 103),
(122, 'Liam', 'Lee', 'Janitor', '(545) 678-9014', 'liamwalker@email.com', '2007-12-31', 103),
(123, 'Emma', 'Walker', 'Accountant', '(656) 789-0125', 'emmahall@email.com', '2008-03-26', 103),
(124, 'Mason', 'Hall', 'Human Resources Manager', '(767) 890-1236', 'masonallen@email.com', '2009-07-11', 103),
(125, 'Olivia', 'Allen', 'Facilities Manager', '(878) 901-2347', 'oliviayoung@email.com', '2010-10-27', 103),
(126, 'Ethan', 'Young', 'Librarian', '(989) 012-3458', 'ethanking@email.com', '2011-02-12', 103),
(127, 'Sophia', 'King', 'Circulation Clerk', '(100) 123-4569', 'sophiawright@email.com', '2012-05-28', 104),
(128, 'Jacob', 'Wright', 'Reference Librarian', '(211) 234-5670', 'jacobaker@email.com', '2013-09-13', 104),
(129, 'Isabella', 'Baker', 'Childrens Librarian', '(322) 345-6781', 'isabellagreen@email.com', '2014-12-30', 104);
SELECT * FROM Staff;
---------------------------------------------------------------------------------------------------------------
--Insert Into Transactions
INSERT INTO Transactions(TransactionID, BorrowDate, ReturnDate, TransactionStatus, BookID, BorrowerID, StaffID)
VALUES
  (1, '2023-01-01', '2023-01-15', 'Returned', 1001, 1, 101),
  (2, '2023-02-10', '2023-02-25', 'Overdue', 1002, 2, 102),
  (3, '2023-03-15', '2023-03-30', 'Borrowed', 1003, 3, 103),
  (4, '2023-04-05', '2023-04-20', 'Returned', 1004, 4, 104),
  (5, '2023-05-12', '2023-05-27', 'Overdue', 1005, 5, 105),
  (6, '2023-06-20', '2023-07-05', 'Borrowed', 1006, 6, 106),
  (7, '2023-07-10', '2023-07-25', 'Returned', 1007, 7, 107),
  (8, '2023-08-15', '2023-08-30', 'Overdue', 1008, 8, 108),
  (9, '2023-09-05', '2023-09-20', 'Borrowed', 1009, 9, 109),
  (10, '2023-10-12', '2023-10-27', 'Returned', 1010, 10, 110),
  (11, '2023-11-20', '2023-12-05', 'Overdue', 1012, 11, 111),
  (12, '2023-12-10', '2024-01-05', 'Borrowed', 1012, 12, 112),
  (13, '2024-01-25', '2024-02-09', 'Returned', 1013, 13, 113),
  (14, '2024-02-15', '2024-03-02', 'Overdue', 1014, 14, 114),
  (15, '2024-03-20', '2024-04-04', 'Borrowed', 1015, 15, 115),
  (16, '2024-04-10', '2024-04-25', 'Overdue', 1016, 16, 116),
  (17, '2024-05-15', '2024-05-30', 'Returned', 1017, 17, 117),
  (18, '2024-06-20', '2024-07-05', 'Overdue', 1018, 18, 118),
  (19, '2024-07-10', '2024-07-25', 'Borrowed', 1019, 19, 119),
  (20, '2024-08-15', '2024-08-30', 'Borrowed', 1020, 20, 120),
  (21, '2023-01-01', '2023-01-15', 'Returned', 1021, 1, 121),
  (22, '2023-02-10', '2023-02-25', 'Overdue', 1022, 2, 122),
  (23, '2023-03-15', '2023-03-30', 'Returned', 1023, 3, 123),
  (24, '2023-04-05', '2023-04-20', 'Returned', 1024, 4, 124),
  (25, '2023-05-12', '2023-05-27', 'Overdue', 1025, 5, 125),
  (26, '2023-06-20', '2023-07-05', 'Borrowed', 1026, 6, 126),
  (27, '2023-07-10', '2023-07-25', 'Returned', 1027, 7, 127),
  (28, '2023-08-15', '2023-08-30', 'Borrowed', 1028, 8, 128),
  (29, '2023-09-05', '2023-09-20', 'Borrowed', 1029, 9, 129),
  (30, '2023-10-12', '2023-10-27', 'Returned', 1030, 10, 101),
  (31, '2023-11-20', '2023-12-05', 'Overdue', 1031, 11, 102),
  (32, '2023-12-10', '2024-01-05', 'Returned', 1032, 12, 103),
  (33, '2024-01-25', '2024-02-09', 'Borrowed', 1033, 13, 104),
  (34, '2024-02-15', '2024-03-02', 'Overdue', 1034, 14, 105),
  (35, '2024-03-20', '2024-04-04', 'Borrowed', 1035, 15, 106),
  (36, '2024-04-10', '2024-04-25', 'Overdue', 1036, 16, 107),
  (37, '2024-05-15', '2024-05-30', 'Returned', 1037, 17, 108),
  (38, '2024-06-20', '2024-07-05', 'Borrowed', 1038, 18, 109),
  (39, '2024-07-10', '2024-07-25', 'Returned', 1039, 19, 110),
  (40, '2024-08-15', '2024-08-30', 'Borrowed', 1040, 10, 111),
  (41, '2023-01-01', '2023-01-15', 'Returned', 1041, 11, 112),
  (42, '2023-02-10', '2023-02-25', 'Borrowed', 1042, 12, 113),
  (43, '2023-03-15', '2023-03-30', 'Returned', 1043, 13, 114),
  (44, '2023-04-05', '2023-04-20', 'Overdue', 1044,5,115);
  SELECT * FROM Transactions;
---------------------------------------------------------------------------------------------------------------
--Insert Into Fines
INSERT INTO Fines(FineAmount, FineID, PaidStatus, TransactionID)
VALUES
('0.10', 5000, 'Paid', 2),
('0.25', 5001, 'UnPaid', 5),
('0.25', 5002, 'Paid', 8),
('0.50', 5003, 'UnPaid', 11),
('0.75', 5004, 'Paid', 14),
('1.00', 5005, 'UnPaid', 16),
('1.50', 5006, 'Paid', 18),
('2.00', 5007, 'UnPaid', 22),
('2.50', 5008, 'Paid', 25),
('3.00', 5009, 'UnPaid', 31),
('4.00', 5010, 'Paid', 34),
('5.00', 5011, 'UnPaid', 36),
('7.50', 5012, 'Paid', 44);
SELECT * FROM Fines;
---------------------------------------------------------------------------------------------------------------
--Insert Into Events
INSERT INTO Events(EventID,EventName,EventDate,StartTime,EndTime,OrganizerID,Audience,Location,Capacity,RegistrationRequired)
VALUES
(4000,'Childrens Story Hour','2024-01-15','10:00 AM','11:00 AM',104,'Children','Kids Section',30,'Yes'),
(4001,'Coding Workshop','2024-01-20','02:00 PM','05:00 PM',113,'Teens & Adults','Conference Room',50,'Yes'),
(4002,'Book Launch','2024-01-25','06:00 PM','08:00 PM',103,'General Public','Auditorium',100,'No'),
(4003,'Local History Lecture','2024-01-30','03:00 PM','04:30 PM',108,'Adults','Lecture Hall',40,'No'),
(4004,'Poetry Slam','2024-02-05','05:00 PM','07:00 PM',126,'Teens & Adults','Community Area',60,'No'),
(4005,'Art Workshop','2024-02-10','01:00 PM','04:00 PM',126,'General Public','Workshop Room',25,'Yes'),
(4006,'Career Guidance Session','2024-02-15','11:00 AM','01:00 PM',100,'Adults','Conference Room',40,'Yes'),
(4007,'Film Screening: "Classic"','2024-02-20','07:00 PM','09:30 PM',128,'General Public','Auditorium',120,'No'),
(4008,'Health Awareness Seminar','2024-02-25','02:00 PM','04:00 PM',102,'Adults','Lecture Hall',50,'Yes'),
(4009,'Library Anniversary Event','2024-03-01','10:00 AM','05:00 PM',100,'General Public','Entire Library',300,'No');
SELECT * FROM Events;
---------------------------------------------------------------------------------------------------------------
--Insert Into LibraryBranches
INSERT INTO LibraryBranches(BranchID,BranchName,City,Country,PostalCode,OpeningHours,NumberOfStaff)
VALUES
(5001,'Springfield Library','Springfield, Illinois','USA','62704','Mon-Fri: 9 AM - 8 PM',25),
(5002,'Westminster Library','London, England','UK','W1A 1AA','Mon-Sat: 10 AM - 6 PM',30),
(5003, 'Maple Leaf Library','Toronto,Ontario', 'Canada', 'M5V 2N8', 'Mon-Sun: 9 AM - 5 PM',12),
(5004, 'Sydney Harbor Library', 'Sydney' , 'Australia', '2000', 'Tue-Sat: 10 AM - 7 PM',20),
(5005, 'Cape Town Library','Cape Town', 'South Africa',  '8001', 'Mon-Fri: 8 AM - 4 PM',40),
(5006, 'Dam Square Library','Amsterdam', 'Netherlands', '1011', 'Mon-Fri: 9 AM - 6 PM',15),
(5007, 'Nairobi Central Library', 'Nairobi', 'Kenya',  '00100', 'Mon-Sat: 10 AM - 5 PM',10),
(5008, 'Times Square Library','New York', 'USA','10001', 'Mon-Fri: 8 AM - 7 PM',18),
(5009, 'Biblioteca Verde','São Paulo', 'Brazil', '01000-000', 'Mon-Sun: 10 AM - 6 PM',22),
(5010, 'Sumida Library','Tokyo', 'Japan','100-0001', 'Tue-Sun: 9 AM - 5 PM',35);
SELECT *  FROM LibraryBranches;
---------------------------------------------------------------------------------------------------------------
SELECT * FROM Books
WHERE CopiesAvailable=0;
---------------------------------------------------------------------------------------------------------------
--Insert Into BookRequests
INSERT INTO BookRequests(RequestID,BorrowerID,BookID,RequestDate,Status)
VALUES
(6001,1,1003,'2024-12-01','Pending'),
(6002,3,1012,'2024-12-02','Approved'),
(6003,5,1015,'2024-12-03','Fulfilled'),
(6004,7,1025,'2024-12-04','Denied'),
(6005,9,1027,'2024-11-20','Pending'),
(6006,11,1039,'2024-11-29','Approved'),
(6007,13,1040,'2023-05-23','Fulfilled'),
(6008,15,1042,'2023-07-30','Denied'),
(6009,17,1063,'2024-08-28','Pending'),
(6010,19,1069,'2024-09-12','Approved'),
(6011,2,1074,'2023-06-20','Fulfilled'),
(6012,4,1114,'2022-03-28','Denied'),
(6013,10,1160,'2024-07-05','Pending'),
(6014,5,1114,'2023-06-01','Approved'),
(6015,18,1095,'2024-02-13','Fulfilled');
SELECT * FROM BookRequests;
---------------------------------------------------------------------------------------------------------------
SELECT * FROM Author;
SELECT * FROM Publisher;
SELECT * FROM Books;
SELECT * FROM Borrower;
SELECT * FROM Staff;
SELECT * FROM Transactions;
SELECT * FROM Fines;
SELECT * FROM Events;
SELECT * FROM LibraryBranches;
SELECT * FROM BookRequests;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--QUERIES:
--1:Return unavailable Books
SELECT * FROM Books
WHERE CopiesAvailable=0;
--2:Return British and English Nationalities
SELECT * FROM Author
WHERE Nationality = 'English' OR Nationality = 'British';
--3:Return Publishers based in New York
SELECT * FROM Publisher
WHERE Address = 'New York';
--4:Return Duplicate authors in books as author name
SELECT *FROM Books
WHERE AuthorName IN (
    SELECT AuthorName FROM Books
    GROUP BY AuthorName
    HAVING COUNT(*) > 1
);
--5:Return Distinct authors from book entity
SELECT DISTINCT AuthorName FROM Books;
--6:Return books with distinct authors
SELECT * FROM Books
WHERE AuthorName IN (
    SELECT AuthorName FROM Books
    GROUP BY AuthorName
    HAVING COUNT(*) = 1
);
--7:Return Values of Publisher and Author Entities using the Foreign Keys In Books
SELECT 
    Books.BookID,Books.Title,Books.Genre,Books.YearPublished,
    Books.ISBN,Books.TotalCopies,Books.CopiesAvailable,
    Author.FirstName AS AuthorFirstName,
	Author.LastName AS AuthorLastName,
    Author.Nationality AS AuthorNationality,
	Author.DateofBirth AS AuthorDateOfBirth,
    Publisher.Name AS PublisherName,
	Publisher.PhoneNumber AS PublisherPhoneNumber,
    Publisher.Address AS PublisherAddress,
    Publisher.Email AS PublisherEmail
FROM Books
INNER JOIN 
Author ON Books.AuthorID = Author.AuthorID
INNER JOIN 
    Publisher ON Books.PublisherID = Publisher.PublisherID;
--8:Return Transactions and if they have a fine and its amount and status
SELECT
    Transactions.TransactionID,
    Transactions.BorrowDate,
    Transactions.ReturnDate,
    Transactions.TransactionStatus,
    Books.Title AS BookTitle,
    Borrower.FirstName AS BorrowerFirstName,
    Borrower.LastName AS BorrowerLastName,
    Staff.FirstName AS StaffFirstName,
    Staff.LastName AS StaffLastName,
    Fines.FineAmount,
    Fines.PaidStatus
FROM Transactions
INNER JOIN 
    Books ON Transactions.BookID = Books.BookID
INNER JOIN 
    Borrower ON Transactions.BorrowerID = Borrower.BorrowerID
INNER JOIN 
    Staff ON Transactions.StaffID = Staff.StaffID
LEFT JOIN --Joins Fines to include fine details for transaction
    Fines ON Transactions.TransactionID = Fines.TransactionID;
--9:return transaction data of those who have a fine
SELECT 
    Fines.FineID,
    Fines.FineAmount,
    Fines.PaidStatus,
    Transactions.BorrowDate,
    Transactions.ReturnDate,
    Transactions.TransactionStatus
FROM Fines
INNER JOIN 
    Transactions ON Fines.TransactionID = Transactions.TransactionID;
--10: Return Unpaid Fines
   SELECT * FROM Fines
   WHERE PaidStatus = 'Unpaid';
--11: Return Events that need a regestration
   SELECT * FROM Events
   WHERE RegistrationRequired = 'Yes';
--12: Return data of organizers using events
SELECT 
    Events.EventID,
    Events.EventName,
    Events.EventDate,
    Events.StartTime,
    Events.EndTime,
    Events.Audience,
    Events.Location,
    Events.Capacity,
    Events.RegistrationRequired,
    Staff.FirstName AS OrganizerFirstName,
    Staff.LastName AS OrganizerLastName,
	Staff.PhoneNumber AS OrganizerPhoneNumber,
	Staff.Email As OrganizerEmail
FROM Events
INNER JOIN 
    Staff ON Events.OrganizerID = Staff.StaffID;
--13: Return LibraryBranches with staff greater than or equal to 15
   SELECT * FROM LibraryBranches
   WHERE NumberOfStaff >=15;
--14:Return author first & last names el status bet3thom pending
SELECT FirstName,LastName FROM Author
WHERE AuthorID IN (
    SELECT b.AuthorID FROM Books b
    JOIN BookRequests br ON b.BookID = br.BookID
    WHERE br.Status = 'Pending'
	--lw zawedt el 2 lines dol yb2a ana 3ayza el author name el lih aktar men ketab pending
	--GROUP BY b.AuthorID
	--HAVING COUNT(br.RequestID)>1
);

