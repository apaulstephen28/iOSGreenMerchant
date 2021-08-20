<?php  
/**
* 
*/
class updateItemOperation
{
	private $conn;
	
	function __construct()
	{
		require_once dirname(__FILE__).'/Constants.php';
		require_once dirname(__FILE__).'/DbConnect.php';
		$db = new DbConnect();
		$this->conn = $db->connect();
	}

	public function updateItem($itemname, $qty, $price){
		$query = "SELECT id FROM tbl_items WHERE item_name='".$itemname."'";

			$test = $this->conn->query($query);

			try{
				if ($test -> num_rows > 0) {
					while ($rows[] = $test -> fetch_assoc()) {
						$arrayLoginRes = array("CreateResult" => $rows);
					}
					$id = $arrayLoginRes["CreateResult"][0]["id"];
					if ($id == $query){
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

		$stmt = $this->conn->prepare("UPDATE tbl_items SET item_name='".$itemname."', quantity='".$qty."', price='".$price."' WHERE id='".$query."'");
		$stmt->bind_param("sid", $itemname, $qty, $price);
		if ($stmt->execute()) {
			return ITEM_CREATED;
		} else {
			return ITEM_NOT_CREATED;
		}
	}
}
?>