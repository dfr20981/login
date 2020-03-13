<?php

	require_once "conexion.php";

	$conexion=conexion();

	$nombre=$_POST['name'];
	$apellido=$_POST['Lname'];
	$email=$_POST['email'];
	$usuario=$_POST['usuario'];
	$contrase=$_POST['pass'];
	$privileguio=$_POST['privileguio'];

	$sql="CALL reguistra('$email','$usuario','$nombre','$apellido','$password')";

	echo mysqli_query($conexion,$sql);

 ?>
