<?php  
/**
* 
*/
class newItemOperation
{
	private $conn;
	
	function __construct()
	{
		require_once dirname(__FILE__).'/Constants.php';
		require_once dirname(__FILE__).'/DbConnect.php';
		$db = new DbConnect();
		$this->conn = $db->connect();
	}

	public function createNewItem($itemname, $qty, $price, $desc){
		$query = "SELECT * FROM tbl_items WHERE item_name='".$itemname."'";

			$test = $this->conn->query($query);

			try{
				if ($test -> num_rows > 0) {
					while ($rows[] = $test -> fetch_assoc()) {
						$arrayLoginRes = array("CreateResult" => $rows);
					}
					$item = $arrayLoginRes["CreateResult"][0]["item_name"];
					if ($item == $itemname){
						return ITEM_NOT_CREATED;
					} else {
						echo "Creation Success!";
					}
				} else{
					echo "Creation Success!";
				}
			} catch (Exception $e) {
				echo "Creation Success!";
			}

		$stmt = $this->conn->prepare("INSERT INTO tbl_items (item_name, quantity, price, description) VALUES (?,?,?,?)");
		$stmt->bind_param("sids", $itemname, $qty, $price, $desc);
		if ($stmt->execute()) {
			return ITEM_CREATED;
		} else {
			return ITEM_NOT_CREATED;
		}
	}
}
?>