<?php
// Function to search houses based on user input
function searchHouses($conn, $bedrooms, $bathrooms, $minPrice, $maxPrice) {
    // SQL query to find houses matching the criteria
    $query = "
        SELECT P.address, P.ownerName, P.price, H.bedrooms, H.bathrooms, H.size
        FROM Listings L
        JOIN Property P ON L.address = P.address
        JOIN House H ON P.address = H.address
        WHERE H.bedrooms = ? AND H.bathrooms = ? AND P.price BETWEEN ? AND ?
    ";

    // Prepare the query
    $stmt = $conn->prepare($query);

    // Bind parameters to the query
    $stmt->bind_param("iiii", $bedrooms, $bathrooms, $minPrice, $maxPrice);

    // Execute the query
    $stmt->execute();

    // Return the result
    return $stmt->get_result();
}

// Fetch all house listings
function getHouseListings($conn) {
    $query = "
        SELECT L.mlsNumber, P.address, P.ownerName, P.price, H.bedrooms, H.bathrooms, H.size, L.dateListed
        FROM Listings L
        JOIN Property P ON L.address = P.address
        JOIN House H ON P.address = H.address
    ";
    return $conn->query($query);
}

// Fetch all business property listings
function getBusinessListings($conn) {
    $query = "
        SELECT L.mlsNumber, P.address, P.ownerName, P.price, B.type AS businessType, B.size, L.dateListed
        FROM Listings L
        JOIN Property P ON L.address = P.address
        JOIN BusinessProperty B ON P.address = B.address
    ";
    return $conn->query($query);
}

// Fetch all agents
function getAgents($conn) {
    $query = "
        SELECT A.agentId, A.name, A.phone, F.name AS firmName
        FROM Agent A
        JOIN Firm F ON A.firmId = F.id
    ";
    return $conn->query($query);
}

// Fetch all buyers
function getBuyers($conn) {
    $query = "
        SELECT B.id, B.name, B.phone, B.propertyType, B.bedrooms, B.bathrooms, B.businessPropertyType, B.minimumPreferredPrice, B.maximumPreferredPrice
        FROM Buyer B
    ";
    return $conn->query($query);
}
?>
