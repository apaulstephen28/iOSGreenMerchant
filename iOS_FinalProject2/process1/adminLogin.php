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
$username = mysqli_real_escape_string($connection, $_POST['txtAdmin']);
$password = mysqli_real_escape_string($connection, $_POST['txtPass']);

$query = "SELECT * FROM tbl_admin WHERE admin_username='".$username."' AND admin_password='".$password."'";

$loginresult = $connection->query($query);

try{
	if ($loginresult -> num_rows > 0) {
		while ($rows[] = $loginresult -> fetch_assoc()) {
			$arrayLoginRes = array("LoginResult" => $rows);
		}
		$user = $arrayLoginRes["LoginResult"][0]["admin_username"];
		$pass = $arrayLoginRes["LoginResult"][0]["admin_password"];
		if (($user == $username) && ($pass == $password)) {
			//$response['error'] = false;
			//$response['message'] = 'Log in Success!'; 
			header("Location: ../iOSProject_Backend/main.php");
		} else {
			$response['error'] = true; 
			$response['message'] = 'Invalid Username or Password.';
		}
	} else{
		$response['error'] = true; 
			$response['message'] = 'Invalid Username or Password.';
	}
} catch (Exception $e) {
	echo "Invalid Request";
} finally {
	mysqli_close($connection);
}

echo json_encode($response);
?>
