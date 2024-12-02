# RealEstateWebsite
By Alek Coupet & William Lee

## Overview
This project implements a real estate multiple listing service (MLS) website with a database backend. The system allows users to:

1. View all property listings and their details
2. Search houses and business properties based on user-defined criteria
3. Display agent and buyer information 
4. Execute manual SQL queries

The backend is built using `MySQL`, `PHP`, and the `Apache` webserver (via `XAMPP`), and the frontend features an HTML interface.

## Features

### Database Queries
- Display all house listings
- Retrieve details of specific properties based on user inputs
- Query properties within specified price ranges
- Show associated agent and buyer details
- Custom SQL query execution from the frontend

### Website Functionality
- Display all property listings grouped by type (houses/business properties)
- Search houses based on price, bedrooms, and bathrooms
- Search business properties based on price and size
- Display agent and buyer information, including preferences
- Execute manual SQL queries through an HTML form

## Installation Instructions

### 1. Install Required Software
- `XAMPP`: Contains Apache, PHP, and MySQL

### 2. Setup the Database
- Use the provided `realestate_setup.sql` script to create the database schema and populate tables with test data
- Steps to execute the script:
  1. Launch XAMPP and start MySQL
  2. Open the XAMPP Shell and log in to MySQL:
  ```sql
  mysql -u root -p
  ```
  3. Execute the script:
  ```sql
  source /path/to/realestate_setup.sql;
  ```

### 3. Configure the Application
- Update `db_config.php` with database credentials
- Ensure `RealEstateWebsite` folder and its associated PHP files are in the XAMPP `htdocs` directory

### 4. Run the Application
- Start Apache in XAMPP
- Open `http://localhost/RealEstateWebsite/index.php` in a web browser

## File Descriptions
- `realestate_setup.sql`: Database schema and sample data
- `db_config.php`: Database configuration
- `index.php`: Homepage for the website
- `queries.php`: Contains PHP scripts for handling predefined queries
- `custom_query.php`: Provides functionality for executing custom SQL queries
- `queries.sql`: SQL statements for predefined queries
- `Website Functionality-1.pdf`: Reference document for website functionality
- `SQL Queries.pdf`: Examples of the queries executed

## How to Use

### 1. Search Listings
- Navigate to the homepage and use the search forms for houses or business properties

### 2. View Agent and Buyer Information
- Access agent and buyer data through the main page

### 3. Execute Custom SQL Queries
- Use the custom query textbox to enter and run SQL commands

## Notes
- Ensure Apache and MySQL services are running in XAMPP before accessing the site
- Sample data is preloaded to demonstrate functionality
