<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="bootstrap-4.2.1-dist/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="bootstrap-4.2.1-dist/css/customStyle.css">	
	<title>Accounts | Users</title>
</head>
<body>
	<div class="container">
		<table class="table table-bordered table-secondary">
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
				<td><a href = '#'><button>ACTIVATE</button></a> <a href = '#'><button>DEACTIVATE</button></a></td>
				</tr>";
			}
			?>
		</table>
	</div>

</body>
</html>