-- Create Database
CREATE DATABASE IF NOT EXISTS RealEstateDB;
USE RealEstateDB;

-- Drop existing tables if they exist (in correct order to avoid foreign key errors)
DROP TABLE IF EXISTS Listings;
DROP TABLE IF EXISTS House;
DROP TABLE IF EXISTS BusinessProperty;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Works_With;
DROP TABLE IF EXISTS Agent;
DROP TABLE IF EXISTS Firm;
DROP TABLE IF EXISTS Buyer;

-- Create the Database
CREATE DATABASE IF NOT EXISTS RealEstateDB;
USE RealEstateDB;

-- Create the Property Table
CREATE TABLE IF NOT EXISTS Property (
    address VARCHAR(50) PRIMARY KEY,
    ownerName VARCHAR(30) NOT NULL,
    price INTEGER NOT NULL
);

-- Create the House Table (House details are stored here)
CREATE TABLE IF NOT EXISTS House (
    bedrooms INTEGER NOT NULL,
    bathrooms INTEGER NOT NULL,
    size INTEGER NOT NULL,
    address VARCHAR(50),
    FOREIGN KEY (address) REFERENCES Property(address)
);

-- Create the BusinessProperty Table (Business properties are stored here)
CREATE TABLE IF NOT EXISTS BusinessProperty (
    type CHAR(20) NOT NULL,
    size INTEGER NOT NULL,
    address VARCHAR(50),
    FOREIGN KEY (address) REFERENCES Property(address)
);

-- Create the Firm Table
CREATE TABLE IF NOT EXISTS Firm (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    address VARCHAR(50) NOT NULL
);

-- Create the Agent Table
CREATE TABLE IF NOT EXISTS Agent (
    agentId INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    phone CHAR(12) NOT NULL,
    firmId INTEGER,
    dateStarted DATE NOT NULL,
    FOREIGN KEY (firmId) REFERENCES Firm(id)
);

-- Create the Listings Table (where properties are listed)
CREATE TABLE IF NOT EXISTS Listings (
    mlsNumber INTEGER PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(50),
    agentId INTEGER,
    dateListed DATE NOT NULL,
    FOREIGN KEY (address) REFERENCES Property(address),
    FOREIGN KEY (agentId) REFERENCES Agent(agentId)
);

-- Create the Buyer Table (buyer's preferences are stored here)
CREATE TABLE IF NOT EXISTS Buyer (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    phone CHAR(12) NOT NULL,
    propertyType CHAR(20),
    bedrooms INTEGER,
    bathrooms INTEGER,
    businessPropertyType CHAR(20),
    minimumPreferredPrice INTEGER,
    maximumPreferredPrice INTEGER
);

-- Create the Works_With Table (linking agents with buyers)
CREATE TABLE IF NOT EXISTS Works_With (
    buyerId INTEGER,
    agentId INTEGER,
    PRIMARY KEY (buyerId, agentId),
    FOREIGN KEY (buyerId) REFERENCES Buyer(id),
    FOREIGN KEY (agentId) REFERENCES Agent(agentId)
);

-- Insert Data into Property Table
INSERT INTO Property (address, ownerName, price) VALUES
('123 Elm St', 'Alice Johnson', 200000),
('456 Oak St', 'Bob Smith', 300000),
('789 Pine St', 'Charlie Brown', 400000),
('101 Maple Ave', 'Diana Prince', 500000),
('202 Birch Blvd', 'Eve Adams', 600000);

-- Insert Data into House Table
INSERT INTO House (bedrooms, bathrooms, size, address) VALUES
(3, 2, 1500, '123 Elm St'),
(4, 3, 2000, '456 Oak St'),
(3, 2, 1800, '789 Pine St'),
(4, 3, 2200, '101 Maple Ave'),
(2, 1, 1200, '202 Birch Blvd');

-- Insert Data into BusinessProperty Table
INSERT INTO BusinessProperty (type, size, address) VALUES
('Office', 2500, '789 Pine St'),
('Storefront', 3000, '101 Maple Ave'),
('Restaurant', 3500, '123 Elm St'),
('Gas Station', 4000, '456 Oak St'),
('Warehouse', 5000, '202 Birch Blvd');

-- Insert Data into Firm Table
INSERT INTO Firm (name, address) VALUES
('Sunset Realty', '999 Realty Lane'),
('Oceanview Properties', '123 Beach Blvd'),
('Dream Realty', '456 Lake St'),
('Premium Properties', '789 Mountain Rd'),
('Urban Estates', '101 Ocean Drive');

-- Insert Data into Agent Table
INSERT INTO Agent (name, phone, firmId, dateStarted) VALUES
('John Doe', '123-456-7890', 1, '2020-01-01'),
('Jane Smith', '987-654-3210', 2, '2021-02-15'),
('Lucas Scott', '555-123-4567', 3, '2018-07-20'),
('Mia Green', '555-987-6543', 4, '2020-08-15'),
('Ethan Black', '555-444-5555', 5, '2021-05-12');

-- Insert Data into Listings Table
INSERT INTO Listings (address, agentId, dateListed) VALUES
('123 Elm St', 1, '2023-11-01'),
('456 Oak St', 2, '2023-11-10'),
('789 Pine St', 3, '2023-11-15'),
('101 Maple Ave', 4, '2023-11-20'),
('202 Birch Blvd', 5, '2023-11-25');

-- Insert Data into Buyer Table
INSERT INTO Buyer (name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice) VALUES
('Chris Evans', '111-222-3333', 'House', 3, 2, NULL, 150000, 250000),
('Emily Blunt', '444-555-6666', 'BusinessProperty', NULL, NULL, 'Office', 300000, 400000),
('Rachel Adams', '555-666-7777', 'House', 4, 3, NULL, 350000, 500000),
('David Nelson', '888-999-0000', 'House', 2, 1, NULL, 100000, 200000),
('Olivia Harris', '999-000-1111', 'BusinessProperty', NULL, NULL, 'Storefront', 200000, 350000);

-- Insert Data into Works_With Table
INSERT INTO Works_With (buyerId, agentId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
