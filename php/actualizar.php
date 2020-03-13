<?php

	require_once "conexion.php";

	$conexion=conexion();
	$id=$_POST['id'];
	$nombre=$_POST['name'];
	$apellido=$_POST['Lname'];
	$email=$_POST['email'];
	$usuario=$_POST['usuario'];
	$privileguio=$_POST['privileguio];

	$sql="CALL actualisarU('$nombre','$apellido','$usuario','$email','$privileguio','$id')";

	echo mysqli_query($conexion,$sql);
 ?>
