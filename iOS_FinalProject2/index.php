<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="iOSProject_Backend/bootstrap-4.2.1-dist/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="iOSProject_Backend/bootstrap-4.2.1-dist/css/customStyle.css">
	<title>Super Admin</title>
</head>
<body>
<div class="container-fluid">
	<div class="container">
		<h1 class="display-1">THE GREEN MERCHANT</h1>
	</div>
	<hr><br><br>
	<form method="POST" action="process1/adminLogin.php">
		<div class="container">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6">
					<label class="lead"><h6>Admin:</h6></label>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6">
					<input type="text" name="txtAdmin" class="form-control">
				</div>
			</div>

			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6">
					<label class="lead"><h6>Password:</h6></label>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6">
					<input type="password" name="txtPass" class="form-control">
				</div>
			</div>
			<br><br>
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6"><input type="submit" name="btnSubmit" class="btn btn-success boton">
				</div>
			</div>
		</div>
	</form>
</div>
</body>
</html>