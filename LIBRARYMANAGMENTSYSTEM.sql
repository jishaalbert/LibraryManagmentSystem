CREATE DATABASE LibraryManagmentSystem; 

USE LibraryManagmentSystem; 

CREATE TABLE BrancH (
Branch_no INT PRIMARY KEY,
Manager_id INT,
Branch_address VARCHAR(100),
Contact_no VARCHAR (12)
);  

CREATE TABLE EmployeE (
Emp_id INT PRIMARY KEY,
Emp_name VARCHAR(100),
Position VARCHAR(100),
Salary DECIMAL (10,2),
Branch_no INT,
 FOREIGN KEY (branch_no)REFERENCES Branch(Branch_no)
 ); 
 
 CREATE TABLE CustomeR (
Customer_id INT PRIMARY KEY,
Customer_name VARCHAR(30) ,
Customer_address VARCHAR(100),
reg_date DATE
); 

CREATE TABLE BookS (
    ISBN INT  PRIMARY KEY,
    Book_title VARCHAR(250),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
); 

CREATE TABLE Issuestatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_id),
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Isbn_book) REFERENCES BookS(isbn)
); 
CREATE TABLE ReturnStatuS (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(100),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_id),
    FOREIGN KEY (Isbn_book2) REFERENCES BookS(ISBN)); 
    
    INSERT INTO BrancH (Branch_no,Manager_id,Branch_address,Contact_no)
VALUES(1,101,'Karukachal_KTM','88774xxxxx'),
    (2,102,'Nedumkunnam_KTM','88776xxxxx'),
    (3,103,'Mulayamveli_KTM','88775xxxxx'),
    (4,104,'Punnavely_KTM','88777xxxxx'); 
    
    INSERT INTO EmployeE (Emp_id,Emp_name,Position,Salary,Branch_no)
VALUES(1,'Midhun M','Manager',60000,1),
    (2,'Tince Tony','Clerk',45000,1),
    (3,'Hari S','Manager',70000,2),
    (4,'Kevin James','Staff',70000,1),
    (5,'Tony','Clerk',45000,1),
    (6,'Mathew M','Clerk',45000,1),
    (7,'Ram Rahul','Clerk',55000,1); 
    
    INSERT INTO CustomeR (Customer_id,Customer_name,Customer_address,reg_date)
VALUES(1,'Johnson Sebastian','Pampady_KTM','2021-12-15'),
    (2,'Bobin M','Kangazha_KTM','2022-02-20'),
    (3,'Ajay Saji','Punnavely_PAT','2021-11-01'),
    (4,'Melvin Mathew','Mallappally_PAT','2021-09-01'); 
    
    INSERT INTO BookS (ISBN,Book_title,Category,Rental_Price,Status,Author,Publisher)
VALUES(101,'Data Science','Science & Tech',550,'yes','ABC','XYZ'),
(102,'Technology','Fiction',450,'yes','ABCD','XYZA'),
(103,'Story','Drama',650,'yes','GABC','TXYZ'),
(104,'Scene!','Noval',550,'no','YYABC','YYXYZ'),
(105,'Untold','History',350,'yes','LYYABC','LYYXYZ'); 

INSERT INTO Issuestatus (Issue_Id,Issued_cust,Issued_book_name,Issue_date,Isbn_book)
VALUES (1,1,'Data Science','2022-01-10',101),
  (2,2,'Technology','2023-06-06',102),
  (3,3,'Story','2023-04-06',103),
  (4,4,'Story','2023-05-05',104); 
  
  INSERT INTO ReturnStatuS (Return_Id,Return_cust,Return_book_name,Return_date,Isbn_book2)
VALUES(1,1,'Data Science','2022-02-05',101),
    (2,2,'Story','2022-04-15',103); 
    
    Retrieve the book title, category, and rental price of all available books.
    
SELECT Book_title,Category,Rental_Price
FROM BookS
WHERE Status='yes'; 

List the employee names and their respective salaries in descending order of salary.

SELECT Emp_name,Salary
FROM EmployeE
ORDER BY Salary DESC; 

Retrieve the book titles and the corresponding customers who have issued those books. 

SELECT BookS.Book_title, Customer.Customer_name
FROM Issuestatus 
JOIN BookS ON Issuestatus.Isbn_book=BookS.ISBN
JOIN Customer ON Issuestatus.Issued_cust=Customer.Customer_id; 

Display the total count of books in each category.

SELECT Category,COUNT(*) AS BookCount
FROM BookS 
GROUP BY Category; 

Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT Emp_name,Position,Salary 
FROM EmployeE
WHERE Salary>50000;

List the customer names who registered before 2022-01-01 and have not issued any books yet.

SELECT Customer_name
FROM CustomeR
WHERE reg_date<'2022-01-01' AND Customer_id NOT IN (SELECT Issued_cust FROM Issuestatus); 

- Display the branch numbers and the total count of employees in each branch.

SELECT Branch_no, COUNT(*) AS E_Count
FROM EmployeE
GROUP BY Branch_no;

Display the names of customers who have issued books in the month of June 2023. 

SELECT DISTINCT Customer.Customer_name
FROM Issuestatus
JOIN Customer ON Issuestatus.Issued_cust = Customer.Customer_id
WHERE MONTH(Issuestatus.Issue_date)=6 AND YEAR(Issuestatus.Issue_date)=2023; 


 Retrieve book_title from book table containing history.
SELECT Book_title
FROM BookS
WHERE Category ='History';

 Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, COUNT(*) AS Employee_Count
FROM EmployeE
GROUP BY Branch_no
HAVING Employee_Count > 5;
