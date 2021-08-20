<?php  
/**
* 
*/
class DbOperation
{
	private $conn;
	
	function __construct()
	{
		require_once dirname(__FILE__).'/Constants.php';
		require_once dirname(__FILE__).'/DbConnect.php';
		$db = new DbConnect();
		$this->conn = $db->connect();
	}

	public function createUser($lname, $fname, $mname, $username, $password, $contact, $email, $stat, $ld1, $ld2){
		$query = "SELECT * FROM tbl_users WHERE username='".$username."'";

			$testusername = $this->conn->query($query);

			try{
				if ($testusername -> num_rows > 0) {
					while ($rows[] = $testusername -> fetch_assoc()) {
						$arrayLoginRes = array("SignInResult" => $rows);
					}
					$user = $arrayLoginRes["SignInResult"][0]["username"];
					if ($user == $username){
						return USER_NOT_CREATED;
					} else {
						echo "Sign Up Success!";
					}
				} else{
					echo "Sign Up Success!";
				}
			} catch (Exception $e) {
				echo "Sign Up Success!";
			}

		$stmt = $this->conn->prepare("INSERT INTO tbl_users (user_lastname, user_firstname, user_middlename, username, password, contact_num, email_add, status, legaldoc_1, legaldoc_2) VALUES (?,?,?,?,?,?,?,?,?,?)");
		$stmt->bind_param("ssssssssss", $lname, $fname, $mname, $username, $password, $contact, $email, $stat, $ld1, $ld2);
		if ($stmt->execute()) {
			return USER_CREATED;
		} else {
			return USER_NOT_CREATED;
		}
	}
}
?>