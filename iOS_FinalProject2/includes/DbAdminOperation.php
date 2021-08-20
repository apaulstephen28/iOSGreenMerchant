<?php  
/**
* 
*/
class DbAdminOperation
{
	private $conn;
	
	function __construct()
	{
		require_once dirname(__FILE__).'/Constants.php';
		require_once dirname(__FILE__).'/DbConnect.php';
		$db = new DbConnect();
		$this->conn = $db->connect();
	}

	public function createAdminUser($lname, $fname, $mname, $username, $password){
		$query = "SELECT * FROM tbl_admin WHERE admin_username='".$username."'";

			$testusername = $this->conn->query($query);

			try{
				if ($testusername -> num_rows > 0) {
					while ($rows[] = $testusername -> fetch_assoc()) {
						$arrayLoginRes = array("SignInResult" => $rows);
					}
					$user = $arrayLoginRes["SignInResult"][0]["admin_username"];
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

		$stmt = $this->conn->prepare("INSERT INTO tbl_admin (admin_lastname, admin_firstname, admin_middlename, admin_username, admin_password) VALUES (?,?,?,?,?)");
		$stmt->bind_param("sssss", $lname, $fname, $mname, $username, $password);
		if ($stmt->execute()) {
			return USER_CREATED;
		} else {
			return USER_NOT_CREATED;
		}
	}
}
?>