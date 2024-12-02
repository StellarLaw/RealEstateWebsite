-- Drop existing tables if they exist (drop tables in correct order)
DROP TABLE IF EXISTS Listings;
DROP TABLE IF EXISTS House;
DROP TABLE IF EXISTS BusinessProperty;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Works_With;
DROP TABLE IF EXISTS Agent;
DROP TABLE IF EXISTS Firm;
DROP TABLE IF EXISTS Buyer;

-- Create Tables
CREATE TABLE Property (
    address VARCHAR(50) PRIMARY KEY,
    ownerName VARCHAR(30) NOT NULL,
    price INTEGER NOT NULL
);

CREATE TABLE House (
    bedrooms INTEGER NOT NULL,
    bathrooms INTEGER NOT NULL,
    size INTEGER NOT NULL,
    address VARCHAR(50),
    FOREIGN KEY (address) REFERENCES Property(address)
);

CREATE TABLE BusinessProperty (
    type CHAR(20) NOT NULL,
    size INTEGER NOT NULL,
    address VARCHAR(50),
    FOREIGN KEY (address) REFERENCES Property(address)
);

CREATE TABLE Firm (
    id INTEGER PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    address VARCHAR(50) NOT NULL
);

CREATE TABLE Agent (
    agentId INTEGER PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    phone CHAR(12) NOT NULL,
    firmId INTEGER,
    dateStarted DATE NOT NULL,
    FOREIGN KEY (firmId) REFERENCES Firm(id)
);

CREATE TABLE Listings (
    mlsNumber INTEGER PRIMARY KEY,
    address VARCHAR(50),
    agentId INTEGER,
    dateListed DATE NOT NULL,
    FOREIGN KEY (address) REFERENCES Property(address),
    FOREIGN KEY (agentId) REFERENCES Agent(agentId)
);

CREATE TABLE Buyer (
    id INTEGER PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    phone CHAR(12) NOT NULL,
    propertyType CHAR(20),
    bedrooms INTEGER,
    bathrooms INTEGER,
    businessPropertyType CHAR(20),
    minimumPreferredPrice INTEGER,
    maximumPreferredPrice INTEGER
);

CREATE TABLE Works_With (
    buyerId INTEGER,
    agentId INTEGER,
    PRIMARY KEY (buyerId, agentId),
    FOREIGN KEY (buyerId) REFERENCES Buyer(id),
    FOREIGN KEY (agentId) REFERENCES Agent(agentId)
);

-- Insert additional Property data
INSERT INTO Property VALUES 
('234 Pine St', 'Hannah Walker', 250000),
('567 Cedar Ave', 'David Lee', 350000),
('890 Maple Blvd', 'Emily Davis', 450000),
('678 Oak Dr', 'Michael Fox', 550000),
('345 Birch Ln', 'Sarah Mitchell', 650000),
('234 Oak St', 'John Williams', 800000),
('123 Pine Blvd', 'Sophia Harris', 900000),
('456 Maple Rd', 'James Moore', 1200000);

-- Insert additional House data
INSERT INTO House VALUES 
(3, 2, 1600, '234 Pine St'),
(4, 3, 2200, '567 Cedar Ave'),
(3, 2, 1800, '890 Maple Blvd'),
(4, 3, 2100, '678 Oak Dr'),
(5, 4, 3000, '345 Birch Ln'),
(3, 2, 1500, '234 Oak St'),
(4, 3, 2400, '123 Pine Blvd'),
(4, 3, 2800, '456 Maple Rd');

-- Insert additional Business Property data
INSERT INTO BusinessProperty VALUES 
('Storefront', 3500, '890 Maple Blvd'),
('Office', 4200, '234 Pine St'),
('Storefront', 3000, '567 Cedar Ave'),
('Office', 4500, '678 Oak Dr');

-- Insert additional Firm data
INSERT INTO Firm VALUES 
(3, 'Dream Realty', '456 Dream St'),
(4, 'Premium Properties', '789 Premium Blvd');

-- Insert additional Agent data
INSERT INTO Agent VALUES 
(103, 'Lucas Scott', '555-123-4567', 3, '2018-07-20'),
(104, 'Mia Green', '555-987-6543', 4, '2020-08-15');

-- Insert additional Listings data
INSERT INTO Listings VALUES 
(1003, '234 Pine St', 103, '2024-01-10'),
(1004, '567 Cedar Ave', 104, '2024-02-15'),
(1005, '890 Maple Blvd', 103, '2024-03-05'),
(1006, '678 Oak Dr', 104, '2024-03-20'),
(1007, '345 Birch Ln', 103, '2024-04-02'),
(1008, '234 Oak St', 104, '2024-04-10');

-- Insert additional Buyer data
INSERT INTO Buyer VALUES 
(3, 'Rachel Adams', '555-222-3333', 'House', 3, 2, NULL, 150000, 300000),
(4, 'David Nelson', '555-444-5555', 'House', 4, 3, NULL, 250000, 450000),
(5, 'Olivia Harris', '555-666-7777', 'BusinessProperty', NULL, NULL, 'Office', 300000, 500000),
(6, 'Jacob Williams', '555-888-9999', 'BusinessProperty', NULL, NULL, 'Storefront', 350000, 600000);

-- Insert additional Works_With data
INSERT INTO Works_With VALUES 
(3, 103),
(4, 104),
(5, 103),
(6, 104);
