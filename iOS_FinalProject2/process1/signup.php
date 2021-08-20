<?php

require_once '../includes/DbOperation.php';
$response = array();
if ($_SERVER['REQUEST_METHOD'] == 'POST') 
{
	if (!verifyRequiredParams(array('user_lastname', 'user_firstname', 'user_middlename', 'username', 'password', 'contact_num', 'email_add', 'status'))) 
	{
		//getting values
		$lname = $_POST['user_lastname']; 
		$fname = $_POST['user_firstname']; 
		$mname = $_POST['user_middlename'];
		$username = $_POST['username'];
		$password = $_POST['password'];
		$contact = $_POST['contact_num'];
		$email = $_POST['email_add'];
		$stat = "PENDING";
		$ld1 = $_POST['legaldoc_1'];
		$ld2 = $_POST['legaldoc_2'];

		//creating db operation object 
		$db = new DbOperation();
		//adding user to database
		$result = $db->createUser($lname, $fname, $mname, $username, $password, $contact, $email, $stat, $ld1, $ld2);

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

