# SQL Database Management Project

This repository contains various SQL scripts related to different aspects of database management, including schema creation, data manipulation, querying, and administration tasks. The scripts are organized into separate files, each addressing specific scenarios or requirements.

## Contents

### [Carwash Management Project](./CarwashManagement/)
This project contains SQL scripts for managing a carwash business. The scripts cover database creation, table definitions, stored procedures, functions, triggers, and sample data insertion. Additionally, a simple GUI is provided to interact with the database, allowing CRUD operations on various tables.

### [1. Database Schema and Data Initialization](./1/Solution.sql)
This script defines the schema for a university database and populates it with initial data. The database includes tables for Departments, Teachers, Students, Courses, Available Courses, Taken Courses, and Prerequisites. It also includes constraints such as primary keys, foreign keys, and checks.

#### Key Features:
- **Schema Definition**: Tables for storing data about departments, teachers, students, courses, and their relationships.
- **Data Population**: Initial data insertion for departments, teachers, students, courses, and prerequisite relationships.
- **Sample Queries**: Example queries for selecting and updating data.

### [2. Advanced Queries and Data Transformation](./2/Solution.sql)
This script demonstrates advanced SQL operations, including complex joins, conditional aggregation, and data transformation tasks.

#### Key Features:
- **Complex Joins**: Using INNER JOINs and filtering with specific conditions.
- **Conditional Logic**: Handling different conditions and transforming data accordingly.
- **Data Aggregation**: Creating summaries and categorizing data based on criteria.

### [3. Security and User Management](./3/Solution.sql)
This script focuses on SQL Server security features, including creating logins, users, roles, and assigning permissions.

#### Key Features:
- **Login and User Management**: Creation of logins and users with specific roles and permissions.
- **Role Management**: Assigning database roles like `db_datareader`, `db_datawriter`, and `db_owner` to users.
- **Security Configuration**: Adjusting security settings and enabling necessary features.

### [4. Data Analysis and Reporting](.4/Solution.sql)
This script provides examples of SQL queries used for data analysis and reporting, including groupings and rollup operations.

#### Key Features:
- **Grouping and Aggregation**: Using `GROUP BY` with `ROLLUP` to generate comprehensive reports.
- **Advanced Filtering**: Conditional filtering based on specific criteria.
- **Data Analysis**: Calculating metrics and performing data analysis for reporting purposes.

### [5. Data Transformation and Functions](./5/Solution.sql)
This script includes various data transformation techniques and user-defined functions.

#### Key Features:
- **Pivoting Data**: Transforming row data into columnar format using PIVOT.
- **String Manipulation**: Handling string operations and pattern matching.
- **User-Defined Functions**: Creating and using custom functions for specific data processing tasks.

### [6. Triggers and Data Logging](./6/Solution.sql)
This script defines triggers for logging changes in the database and procedures for managing data history.

#### Key Features:
- **Triggers**: Automatic logging of data changes using INSERT, UPDATE, and DELETE triggers.
- **Change Tracking**: Maintaining logs of changes to key tables for auditing purposes.
- **Stored Procedures**: Procedures for generating reports and maintaining data logs.

### [7. External Data Management and Bulk Operations](./7/Solution.sql)
This script demonstrates external data management and bulk operations using SQL Server features.

#### Key Features:
- **Bulk Insert Operations**: Importing and exporting data using `BULK INSERT` and `bcp`.
- **Configuration**: Enabling advanced options and features for handling external data.
- **Data Integration**: Loading data from external files and integrating it into SQL Server tables.

### [8. Transactions in SQL](./8/)
This directory contains SQL scripts that demonstrate different transaction isolation levels and read phenomena, such as dirty reads and non-repeatable reads, within the **AdventureWorks2012** database. These examples are used to understand the behavior and impact of various SQL operations under different transaction settings.

#### Key Features:
- **Transaction Management**: Includes examples of using transactions with `BEGIN TRANSACTION`, `COMMIT`, and `ROLLBACK` to manage database changes.
- **Isolation Levels**: Demonstrates the use of different transaction isolation levels (`READ UNCOMMITTED`, `READ COMMITTED`) to observe their effects on data visibility.
- **Read Phenomena**: Explores scenarios such as dirty reads and non-repeatable reads, showcasing how data can be inconsistently viewed under different transaction isolation levels.

These scripts are useful for learning and testing the impacts of transactions and isolation levels on database consistency and data integrity.

## Getting Started

### Prerequisites
- SQL Server (version used: `AdventureWorks2012`)
- Access to the AdventureWorks2012 database or equivalent for running the scripts.

### Running the Scripts
1. Clone the repository to your local machine.
2. Open SQL Server Management Studio (SSMS) or any SQL client.
3. Execute the scripts in the order provided to set up the database and explore the different functionalities.

## Contributing
Feel free to submit pull requests or open issues if you find any bugs or have suggestions for improvements.

## License
This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Acknowledgments
Special thanks to the SQL Server community and the creators of the AdventureWorks sample database for providing valuable resources.

---

Please replace placeholder values (such as `AdventureWorks2012` and file paths) with appropriate values as per your setup. Always test scripts in a development environment before applying them in production.
