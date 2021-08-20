<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="bootstrap-4.2.1-dist/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="bootstrap-4.2.1-dist/css/customStyle.css">	
	<title>Accounts</title>
<style type="text/css">
	body{
  background-color: #e9e9e9; 
}
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  border: 1px solid #e7e7e7;
  background-color: #f3f3f3;
}
li {
  float: left;
}
li a{
  display: block;
  color: #666;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}
li a:hover:not(.active) {
  background-color: #ddd;
}
li a.active{
  color: white;
  background-color: #4caf50;
}
</style>
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
					<a href="inventory.php"><button class="btn btn-warning boton">INVENTORY</button></a>
				</div>
				<div class="col-sm-3">
					<a href="users.php"><button class="btn btn-warning boton activeX">ACCOUNTS</button></a>
				</div>
				<div class="col-sm-3">
					<a href="../index.php"><button class="btn btn-danger boton">LOGOUT</button></a>
				</div>
			</div>
			<br><br>
		</div>
		<br>
	</div>

	<div class="container-fluid">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<ul>
						<li><a href="users.php" class="active" style="text-decoration: none;">Users</a></li>
						<li><a href="admin.php" style="text-decoration: none;">Admin</a></li>
					</ul>
				</div>
			</div>
		</div>		
	</div>

	<div class="container-fluid">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<table class="table table-bordered">
						<tr>
							<th>NAME</th>
							<th>USERNAME</th>
							<th>PASSWORD</th>
							<th>CONTACT NUMBER</th>
							<th>EMAIL ADDRESS</th>
							<th>ACTION</th>
						</tr>
						<?php
							$con = mysqli_connect("localhost","root","","db_Fertilizer");
						$query1 = "SELECT * FROM tbl_users ORDER BY id";
						$res1 = mysqli_query($con, $query1);

						if (mysqli_num_rows($res1)==0){
							echo "<tr><td colspan=4>No Records Found</td></tr>";
						}
						while ($row1=mysqli_fetch_array($res1)) {
							$id = $row1["id"];
							$fullname = $row1["user_firstname"].' '.$row1["user_middlename"].' '.$row1["user_lastname"];
							$username = $row1["username"];
							$pass = $row1["password"];
							$contact = $row1["contact_num"];
							$email = $row1["email_add"];
							echo "<tr>
							<td>$fullname</td>
							<td>$username</td>
							<td>$pass</td>
							<td>$contact</td>
							<td>$email</td>
							<td><a href = '../process1/activate_user.php?id=$id'><button style='width:100%' class='btn-success'>ACTIVATE</button></a><br> <a href = '../process1/deactivate_user.php?id=$id''><button style='width:100%' class='btn-danger'>DEACTIVATE</button></a></td>
							</tr>";
						}
						?>
					</table>				
				</div>				
			</div>
		</div>		
	</div>
</div>
</body>
</html>