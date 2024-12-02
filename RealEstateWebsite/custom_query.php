<?php
require_once 'db_config.php';  // Ensure your connection is established

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve the SQL query entered by the user
    $user_query = $_POST['query'];

    // Execute the query
    $result = $conn->query($user_query);

    // Check if there are results
    if ($result->num_rows > 0) {
        echo "<h3>Query Results:</h3>";
        echo "<table border='1'>";
        // Fetch column names dynamically
        $columns = array();
        while ($field = $result->fetch_field()) {
            $columns[] = $field->name;
        }
        echo "<tr><th>" . implode("</th><th>", $columns) . "</th></tr>";

        // Display the results
        while ($row = $result->fetch_assoc()) {
            echo "<tr>";
            foreach ($columns as $col) {
                echo "<td>" . htmlspecialchars($row[$col]) . "</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No results found for your query.</p>";
    }
} else {
    echo "<p>Please enter a SQL query to run.</p>";
}
?>
