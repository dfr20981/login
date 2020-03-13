<?php

	require_once "conexion.php";
	$conexion=conexion();

	$id=$_POST['id'];
	$sql="CALL ($id)";

	$result=mysqli_query($conexion,$sql);

	$ver=mysqli_fetch_row($result);

	$datos=array(
							'id'=>$ver[0],
              'nombre'=>$ver[1],
              'apellido'=>$ver[2],
              'username'=>$ver[3]
					);
	echo json_encode($datos);
 ?>
