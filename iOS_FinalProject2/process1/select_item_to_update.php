<?php
session_start();
$dbserver = 'localhost';
$dbusername = 'root';
$dbpassword = '';
$dbname = 'db_Fertilizer';
$connection = new mysqli($dbserver, $dbusername, $dbpassword, $dbname);
if ($connection -> connect_error) {
	die("Connection Failed: " . $connection -> connect_error);
}
$id = mysqli_real_escape_string($connection, $_POST['id']);

/*
$sqldata = mysqli_query($connection, "SELECT * FROM tbl_items WHERE id='".$id."'");

$rows = array();
while($r = mysqli_fetch_assoc($sqldata)) {
  $rows[] = $r;
}

echo json_encode($rows);*/


$query = "SELECT * FROM tbl_items WHERE id='".$id."'";

			$test = mysqli_query($connection, $query);
				if ($test -> num_rows > 0) {
					while ($row = $test -> fetch_assoc()) {
						echo "<br>ID: " .$row["id"]. "<br>Item Name: " .$row["item_name"]. "<br>Quantity: " .$row["quantity"]. "<br>Price: " .$row["price"]."";
					} 
				} else {
						echo "0 results";
					}



?>