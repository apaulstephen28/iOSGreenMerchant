<?php

require_once '../includes/updateItemOperation.php';
$response = array();
if ($_SERVER['REQUEST_METHOD'] == 'POST') 
{
	if (!verifyRequiredParams(array('item_name', 'quantity', 'price'))) 
	{
		//getting values
		$itemname = $_POST['item_name']; 
		$qty = $_POST['quantity']; 
		$price = $_POST['price'];

		//creating db operation object 
		$db = new updateItemOperation();
		//adding user to database
		$result = $db->updateItem($itemname, $qty, $price);

		//making the response accordingly
		if ($result == USER_CREATED) 
		{
			$response['error'] = false;
			$response['message'] = 'Item updated successfully'; 
		}

		else if ($result == USER_NOT_CREATED) 
		{ 
			$response['error'] = true; 
			$response['message'] = 'Item already in the database.';
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