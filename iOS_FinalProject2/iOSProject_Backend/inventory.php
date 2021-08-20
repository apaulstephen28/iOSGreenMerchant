<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="bootstrap-4.2.1-dist/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="bootstrap-4.2.1-dist/css/customStyle.css">
	<title>Inventory</title>
</head>
<body>
<div class="container-fluid">
	<div class="container">
		<h1 class="display-1">THE GREEN MERCHANT</h1>
	</div>
	<hr>
	<div class="container-fluid">
		<div class="container">
			<div class="row">
				<div class="col-sm-3">
					<a href="main.php"><button class="btn btn-warning boton">DASHBOARD</button></a>
				</div>
				<div class="col-sm-3">
					<a href="inventory.php"><button class="btn btn-warning boton activeX">INVENTORY</button></a>
				</div>
				<div class="col-sm-3">
					<a href="users.php"><button class="btn btn-warning boton">ACCOUNTS</button></a>
				</div>
				<div class="col-sm-3">
					<a href="../index.php"><button class="btn btn-danger boton">LOGOUT</button></a>
				</div>
			</div>
		</div>
	</div>
	
<br>
<div class="container">
	<table class="table table-bordered table-secondary">
		<tr>
			<td>ITEM NAME</td>
			<td>QUANTITY</td>
			<td>PRICE</td>
			<td>ACTION</td>
		</tr>
		<?php
			$con = mysqli_connect("localhost","root","","db_Fertilizer");
		$query1 = "SELECT * FROM tbl_items ORDER BY id";
		$res1 = mysqli_query($con, $query1);

		if (mysqli_num_rows($res1)==0){
			echo "<tr><td colspan=4>No Records Found</td></tr>";
		}
		while ($row1=mysqli_fetch_array($res1)) {
			$id = $row1["id"];
			$itemname = $row1["item_name"];
			$qty = $row1["quantity"];
			$price = $row1["price"];
			echo "<tr>
			<td>$itemname</td>
			<td>$qty</td>
			<td>$price</td>
			<td><a href = 'edit_contact.php?id=$id'>EDIT</a> <a href = 'delete_contact.php?id=$id'>DELETE</a></td>
			</tr>";
		}
		?>
	</table>
</div>


</div>
</body>
</html>