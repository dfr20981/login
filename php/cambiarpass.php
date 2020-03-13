<?php
require_once "conexion.php";

$conexion=conexion();
$id=$_POST['id'];
$nombre=$_POST['name'];
$contrase=$_POST['pass'];


$sql="CALL cambio_pass('$id','$nombre',$contrase)";

echo mysqli_query($conexion,$sql);

 ?>
