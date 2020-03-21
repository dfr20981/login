<?php

	require_once "conexion.php";

	$conexion=conexion();

	$nombre=$_POST['name'];
	$apellido=$_POST['Lname'];
	$email=$_POST['username'];
	$usuario=$_POST['email'];
	$contrase=$_POST['pass'];
	$privileguio=$_POST['id_p'];

	$sql="CALL RegistraUsuario('$nombre','$apellido','$email','$usuario','$contrase','$privileguio')";

	echo mysqli_query($conexion,$sql);

 ?>
