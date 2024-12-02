<?php
require_once 'db_config.php';  // Include database connection
require_once 'queries.php';    // Include query functions

// Fetch listings and data
$houses_result = getHouseListings($conn);
$business_result = getBusinessListings($conn);
$agents_result = getAgents($conn);
$buyers_result = getBuyers($conn);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Real Estate Listings</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Real Estate Listing Service</h1>

    <!-- Display House Listings -->
    <?php if ($houses_result->num_rows > 0): ?>
        <h2>House Listings</h2>
        <table border="1">
            <tr>
                <th>MLS Number</th>
                <th>Address</th>
                <th>Owner Name</th>
                <th>Price</th>
                <th>Bedrooms</th>
                <th>Bathrooms</th>
                <th>Size</th>
                <th>Date Listed</th>
            </tr>
            <?php while ($row = $houses_result->fetch_assoc()): ?>
                <tr>
                    <td><?= $row['mlsNumber'] ?></td>
                    <td><?= $row['address'] ?></td>
                    <td><?= $row['ownerName'] ?></td>
                    <td>$<?= $row['price'] ?></td>
                    <td><?= $row['bedrooms'] ?></td>
                    <td><?= $row['bathrooms'] ?></td>
                    <td><?= $row['size'] ?></td>
                    <td><?= $row['dateListed'] ?></td>
                </tr>
            <?php endwhile; ?>
        </table>
    <?php else: ?>
        <p>No house listings found.</p>
    <?php endif; ?>

    <!-- Display Business Property Listings -->
    <?php if ($business_result->num_rows > 0): ?>
        <h2>Business Property Listings</h2>
        <table border="1">
            <tr>
                <th>MLS Number</th>
                <th>Address</th>
                <th>Owner Name</th>
                <th>Price</th>
                <th>Business Type</th>
                <th>Size</th>
                <th>Date Listed</th>
            </tr>
            <?php while ($row = $business_result->fetch_assoc()): ?>
                <tr>
                    <td><?= $row['mlsNumber'] ?></td>
                    <td><?= $row['address'] ?></td>
                    <td><?= $row['ownerName'] ?></td>
                    <td>$<?= $row['price'] ?></td>
                    <td><?= $row['businessType'] ?></td>
                    <td><?= $row['size'] ?></td>
                    <td><?= $row['dateListed'] ?></td>
                </tr>
            <?php endwhile; ?>
        </table>
    <?php else: ?>
        <p>No business property listings found.</p>
    <?php endif; ?>

    <!-- Search Houses Form -->
    <h2>Search Houses</h2>
    <form method="POST" action="index.php">
        <label>Bedrooms:</label>
        <input type="number" name="bedrooms" required>
        <label>Bathrooms:</label>
        <input type="number" name="bathrooms" required>
        <label>Min Price:</label>
        <input type="number" name="minPrice" required>
        <label>Max Price:</label>
        <input type="number" name="maxPrice" required>
        <button type="submit" name="searchHouses">Search</button>
    </form>

    <!-- PHP Code for House Search -->
    <?php
    if (isset($_POST['searchHouses'])) {
        $bedrooms = $_POST['bedrooms'];
        $bathrooms = $_POST['bathrooms'];
        $minPrice = $_POST['minPrice'];
        $maxPrice = $_POST['maxPrice'];

        $search_query = "
            SELECT L.mlsNumber, P.address, P.ownerName, P.price, H.bedrooms, H.bathrooms, H.size, L.dateListed
            FROM Listings L
            JOIN Property P ON L.address = P.address
            JOIN House H ON P.address = H.address
            WHERE H.bedrooms = ? AND H.bathrooms = ? AND P.price BETWEEN ? AND ?
        ";

        $stmt = $conn->prepare($search_query);
        $stmt->bind_param("iiii", $bedrooms, $bathrooms, $minPrice, $maxPrice);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            echo "<h3>Search Results:</h3>";
            echo "<table border='1'>
                    <tr>
                        <th>MLS Number</th>
                        <th>Address</th>
                        <th>Owner Name</th>
                        <th>Price</th>
                        <th>Bedrooms</th>
                        <th>Bathrooms</th>
                        <th>Size</th>
                        <th>Date Listed</th>
                    </tr>";
            while ($row = $result->fetch_assoc()) {
                echo "<tr>
                        <td>{$row['mlsNumber']}</td>
                        <td>{$row['address']}</td>
                        <td>{$row['ownerName']}</td>
                        <td>\${$row['price']}</td>
                        <td>{$row['bedrooms']}</td>
                        <td>{$row['bathrooms']}</td>
                        <td>{$row['size']}</td>
                        <td>{$row['dateListed']}</td>
                    </tr>";
            }
            echo "</table>";
        } else {
            echo "<p>No houses found matching your criteria.</p>";
        }
    }
    ?>

    <!-- Search Business Properties Form -->
    <h2>Search Business Properties</h2>
    <form method="POST" action="index.php">
        <label>Min Price:</label>
        <input type="number" name="minPriceBusiness" required>
        <label>Max Price:</label>
        <input type="number" name="maxPriceBusiness" required>
        <label>Min Size (sq ft):</label>
        <input type="number" name="minSize" required>
        <label>Max Size (sq ft):</label>
        <input type="number" name="maxSize" required>
        <button type="submit" name="searchBusiness">Search</button>
    </form>

    <!-- PHP Code for Business Property Search -->
    <?php
    if (isset($_POST['searchBusiness'])) {
        $minPrice = $_POST['minPriceBusiness'];
        $maxPrice = $_POST['maxPriceBusiness'];
        $minSize = $_POST['minSize'];
        $maxSize = $_POST['maxSize'];

        $search_query = "
            SELECT L.mlsNumber, P.address, P.ownerName, P.price, B.type AS businessType, B.size, L.dateListed
            FROM Listings L
            JOIN Property P ON L.address = P.address
            JOIN BusinessProperty B ON P.address = B.address
            WHERE P.price BETWEEN ? AND ? AND B.size BETWEEN ? AND ?
        ";

        $stmt = $conn->prepare($search_query);
        $stmt->bind_param("iiii", $minPrice, $maxPrice, $minSize, $maxSize);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            echo "<h3>Search Results:</h3>";
            echo "<table border='1'>
                    <tr>
                        <th>MLS Number</th>
                        <th>Address</th>
                        <th>Owner Name</th>
                        <th>Price</th>
                        <th>Business Type</th>
                        <th>Size</th>
                        <th>Date Listed</th>
                    </tr>";
            while ($row = $result->fetch_assoc()) {
                echo "<tr>
                        <td>{$row['mlsNumber']}</td>
                        <td>{$row['address']}</td>
                        <td>{$row['ownerName']}</td>
                        <td>\${$row['price']}</td>
                        <td>{$row['businessType']}</td>
                        <td>{$row['size']}</td>
                        <td>{$row['dateListed']}</td>
                    </tr>";
            }
            echo "</table>";
        } else {
            echo "<p>No business properties found matching your criteria.</p>";
        }
    }
    ?>

    <!-- Display All Agents -->
    <?php
    if ($agents_result->num_rows > 0) {
        echo "<h2>All Agents</h2>";
        echo "<table border='1'>
                <tr>
                    <th>Agent ID</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Firm Name</th>
                </tr>";
        while ($row = $agents_result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['agentId']}</td>
                    <td>{$row['name']}</td>
                    <td>{$row['phone']}</td>
                    <td>{$row['firmName']}</td>
                </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No agents found.</p>";
    }
    ?>

    <!-- Display All Buyers -->
    <?php
    if ($buyers_result->num_rows > 0) {
        echo "<h2>All Buyers and Their Preferences</h2>";
        echo "<table border='1'>
                <tr>
                    <th>Buyer ID</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Property Type</th>
                    <th>Bedrooms</th>
                    <th>Bathrooms</th>
                    <th>Business Property Type</th>
                    <th>Min Price</th>
                    <th>Max Price</th>
                </tr>";
        while ($row = $buyers_result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['id']}</td>
                    <td>{$row['name']}</td>
                    <td>{$row['phone']}</td>
                    <td>{$row['propertyType']}</td>
                    <td>{$row['bedrooms']}</td>
                    <td>{$row['bathrooms']}</td>
                    <td>{$row['businessPropertyType']}</td>
                    <td>\${$row['minimumPreferredPrice']}</td>
                    <td>\${$row['maximumPreferredPrice']}</td>
                </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No buyers found.</p>";
    }
    ?>

    <!-- Manual Query Form -->
    <h2>Run Custom SQL Query</h2>
    <form method="POST" action="custom_query.php">
        <label for="query">Enter SQL Query:</label><br>
        <textarea name="query" id="query" rows="5" cols="50" placeholder="Enter SELECT queries only"></textarea><br>
        <button type="submit">Run Query</button>
    </form>
</body>
</html>
