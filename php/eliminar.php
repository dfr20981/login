<?php

	require_once "conexion.php";

	$conexion=conexion();
	$id=$_POST['id'];
	$sql="CALL eliminar('$id')";
	echo mysqli_query($conexion,$sql);
 ?>
