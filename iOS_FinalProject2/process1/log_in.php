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
$username = mysqli_real_escape_string($connection, $_POST['username']);
$password = mysqli_real_escape_string($connection, $_POST['password']);
$status = "ACTIVATED";
$query = "SELECT * FROM tbl_users WHERE username='".$username."' AND password='".$password."'";

$loginresult = $connection->query($query);

try{
	if ($loginresult -> num_rows > 0) {
		while ($rows[] = $loginresult -> fetch_assoc()) {
			$arrayLoginRes = array("LoginResult" => $rows);
		}
		$user = $arrayLoginRes["LoginResult"][0]["username"];
		$pass = $arrayLoginRes["LoginResult"][0]["password"];
		$stat = $arrayLoginRes["LoginResult"][0]["status"];
		if (($user == $username) && ($pass == $password) && ($stat == $status)) {
			$response['error'] = false;
			$response['message'] = 'Log in Success!'; 
		}
		elseif (($user == $username) && ($pass == $password) && ($stat != $status)) {
		 	$response['error'] = true; 
			$response['message'] = "Account has been deactivated";
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
