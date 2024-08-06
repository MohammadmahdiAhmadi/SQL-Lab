IF EXIST (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_NAME='MY_TABLE')
	DROP TABLE MY_TABLE
GO
CREATE TABLE MY_TABLE


# 1-1:
# 1-2:
CREATE TABLE Departments
(
	Name varchar(20) NOT NULL,
	ID char(5) PRIMARY KEY,
	Budget numeric(12, 2),
	Category varchar(15) Check (Category in ('Engineering', 'Science'))
);


CREATE TABLE Teachers
(
	FirstName varchar(20) NOT NULL,
	LastName varchar(30) NOT NULL,
	ID char(7) UNIQUE NOT NULL, #
	BirthYear int NOT NULL, #
	DepartmentID char(5),
	Salary numeric(7, 2) Default 10000.00,
	PRIMARY KEY (ID),
	FOREIGN KEY (DepartmentID) REFERENCES Departments(ID)
);

CREATE TABLE Students
(
	FirstName varchar(20) NOT NULL,
	LastName varchar(30) NOT NULL,
	StudentNumber char(7) PRIMARY KEY,
	BirthYear int NOT NULL, #
	DepartmentID char(5),
	AdvisorID char(7),
	FOREIGN KEY (DepartmentID) REFERENCES Departments(ID),
	FOREIGN KEY (AdvisorID) REFERENCES Teachers(ID)
);
# Add UnitsNumber to Students
ALTER TABLE Students
 ADD UnitsNumber int

CREATE TABLE Courses
(
	ID char(5) PRIMARY KEY,
	Title VARCHAR(255),
	Credits INT,
	DepartmentID Char(5),
	FOREIGN KEY(DepartmentID) REFERENCES Departments(ID) 
);

CREATE TABLE Available_Courses
(
	CourseID Char(5) NOT NULL,
	Semester VARCHAR(10) NOT NULL CHECK(Semester in ('spring', 'fall')),
	YEAR INT NOT NULL,
	ID char(5) PRIMARY KEY,
	TeacherID Char(7) NOT NULL,
	FOREIGN KEY(CourseID) REFERENCES Courses(ID),
	FOREIGN KEY(TeacherID) REFERENCES Teachers(ID)
);

# ToDo: Edit Primary Key
CREATE TABLE Taken_Courses
(
	StudentID Char(7) NOT NULL,
	CourseID Char(5) NOT NULL,
	Semester VARCHAR(10) NOT NULL CHECK(Semester in ('spring', 'fall')),
	YEAR INT NOT NULL,
	Grade NUMERIC(4, 2) CHECK (Grade >= 0 AND Grade <= 20) NOT NULL,
	PRIMARY KEY(StudentID, CourseID, Semester, YEAR),
	FOREIGN KEY(CourseID) REFERENCES Courses(ID),
	FOREIGN KEY(StudentID) REFERENCES Students(StudentNumber)
);
ALTER TABLE Taken_Courses
 ADD CONSTRAINT PK_Taken_Courses PRIMARY KEY(StudentID, CourseID, Semester, YEAR)
ALTER TABLE Taken_Courses
	ALTER COLUMN Grade NUMERIC(4, 2)

CREATE TABLE Prerequisites
(
	PrereqID Char(5) NOT NULL,
	CourseID Char(5) NOT NULL,
	FOREIGN KEY(PrereqID) REFERENCES Courses(ID),
	FOREIGN KEY(CourseID) REFERENCES Courses(ID),
	PRIMARY KEY(PrereqID, CourseID)
);


# 1-3:
INSERT INTO Departments Values('CE', 'CE', '1000.00', 'Engineering');
INSERT INTO Departments Values('EE', 'EE', '1500.00', 'Engineering');

INSERT INTO Teachers Values('Alireza', 'Basiri', '1000000', 1360, 'CE', 20000.00);
INSERT INTO Teachers Values('Zeinab', 'Zali', '1000001', 1361, 'EE', 19000.00);

INSERT INTO Students Values('Sepehr', 'Khodadadi', '9811234', 1379, 'CE', '1000000', 125);
INSERT INTO Students Values('Amir', 'Hosseini', '9811235', 1379, 'EE', '1000001', 120);

INSERT INTO Courses Values('1', 'DB', '3', 'CE');
INSERT INTO Courses Values('2', 'OS', '3', 'CE');

INSERT INTO Available_Courses Values('1', 'fall', 1402, '11402', '1000000');
INSERT INTO Available_Courses Values('2', 'fall', 1402, '21402', '1000001');

INSERT INTO Taken_Courses Values('9811234', '1', 'fall', 1402, 10.00);
INSERT INTO Taken_Courses Values('9811235', '2', 'fall', 1402, 11.00);

INSERT INTO Prerequisites Values('1', '2');
INSERT INTO Prerequisites Values('2', '1');


# 2-1:
SELECT Departments.* FROM Departments, Students
	WHERE Departments.ID=Students.DepartmentID AND Students.StudentNumber='9811234';

# 2-2:
UPDATE Taken_Courses
	SET Grade = (Grade + 1)

# 2-3:
SELECT Students.* FROM Students
	WHERE Students.StudentNumber NOT IN (SELECT StudentID FROM Taken_Courses WHERE CourseID='1');
	


