<?php
$dbserver = 'localhost';
$dbusername = 'root';
$dbpassword = '';
$dbname = 'db_Fertilizer';
$connection = new mysqli($dbserver, $dbusername, $dbpassword, $dbname);
if ($connection -> connect_error) {
	die("Connection Failed: " . $connection -> connect_error);
}
if (isset($_GET["id"])) {
	$id=$_GET["id"];
	$status = "ACTIVATED";
	$con = mysqli_connect($dbserver, $dbusername, $dbpassword, $dbname);
	$query1 = "UPDATE tbl_users SET status='$status' WHERE id = '$id'";
	$result1 = mysqli_query($con,$query1);

	echo "Record has been successfully ACTIVATED!<br><br>";

	echo "<a href='../iOSProject_Backend/users.php'> BACK</a>";
	}


?>