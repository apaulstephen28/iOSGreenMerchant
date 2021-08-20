<?php

require_once '../includes/DbAdminOperation.php';
$response = array();
if ($_SERVER['REQUEST_METHOD'] == 'POST') 
{
	if (!verifyRequiredParams(array('admin_lastname', 'admin_firstname', 'admin_middlename', 'admin_username', 'admin_password'))) 
	{
		//getting values
		$lname = $_POST['admin_lastname']; 
		$fname = $_POST['admin_firstname']; 
		$mname = $_POST['admin_middlename'];
		$username = $_POST['admin_username'];
		$password = $_POST['admin_password'];

		//creating db operation object 
		$db = new DbAdminOperation();
		//adding user to database
		$result = $db->createAdminUser($lname, $fname, $mname, $username, $password);

		//making the response accordingly
		if ($result == USER_CREATED) 
		{
			$response['error'] = false;
			$response['message'] = 'User created successfully'; 
		}

		else if ($result == USER_NOT_CREATED) 
		{ 
			$response['error'] = true; 
			$response['message'] = 'Username already taken.';
		}
	} 
	else 
	{
		$response['error'] = true;
		$response['message'] = 'Required parameters are missing'; 
	}
}
else
{
	$response['error'] = true; 
	$response['message'] = 'Invalid request';
}

function verifyRequiredParams($required_fields)
{
//Getting the request parameters 
	$request_params = $_REQUEST;
//Looping through all the parameters
	foreach ($required_fields as $field) 
	{
		//if any requred parameter is missing
		if (!isset($request_params[$field]) || strlen(trim($request_params[$field])) <= 0) 
		{
			//returning true;
			return true; 
		}
	}
	return false; 
}

echo json_encode($response);
?>

