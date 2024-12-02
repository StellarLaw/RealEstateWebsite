<?php
// Database connection settings
$servername = "localhost";
$username = "root";  // Default user for MySQL
$password = "";  // Default empty password for root
$dbname = "RealEstateDB";  // Name of the database

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
