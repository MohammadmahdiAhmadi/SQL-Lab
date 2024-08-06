# Carwash Management Database

This project contains SQL scripts for managing a carwash business. The scripts cover database creation, table definitions, stored procedures, functions, triggers, and sample data insertion. Additionally, a simple GUI is provided to interact with the database, allowing CRUD operations on various tables.

## Project Structure

- **`create_tables.sql`**: 
  Contains SQL commands for creating the `carwash` database and its associated tables, such as Customers, Vehicles, Services, Orders, PaymentTransactions, Employees, and Feedbacks.

- **`functions.sql`**: 
  Defines several user-defined functions, including `CalculateOrderPrice`, `GetAverageRatingForService`, `GetTotalSalesByService`, and `GetServiceSummary`.

- **`procedures.sql`**: 
  Contains stored procedures for managing the database operations, such as adding new orders, processing payments, and managing customers, vehicles, services, feedbacks, and employees.

- **`triggers.sql`**: 
  Defines triggers to automate specific actions based on changes in the database, such as updating order status upon payment and adjusting pending order prices when service prices change.

- **`views.sql`**: 
  Defines various views for simplifying complex queries and providing easy access to summarized or detailed data.

- **`insert.sql`**: 
  Inserts sample data into the tables, including sample customers, vehicles, services, employees, feedbacks, orders, and payment transactions.


## Setup Instructions

### Prerequisites
- SQL Server instance
- Python environment (for the GUI)

### Database Setup ([document](./document.pdf))
Please read Report.pdf
1. **Run the SQL Scripts**:
   - Start with `create_tables.sql` to set up the database and tables.
   - Execute `functions.sql`, `procedures.sql`, `triggers.sql`, and `views.sql` in sequence.
   - Insert sample data using `insert.sql`.

2. **Create a New SQL Server Login**:
   - Use `new_login_user.sql` to create a new login and user with appropriate permissions.

### GUI Setup
- Checkout [this](https://github.com/MohammadmahdiAhmadi/sql_server_ui_generator) repository
- The repository contains an auto generating GUI application for interacting with the SQL Server database, built using Python Tkinter.

### Video Demonstration
For a video demonstration of the project, visit [this link](https://iutbox.iut.ac.ir/index.php/s/PJ9R2iMyR58onSc).

