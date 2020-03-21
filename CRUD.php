<?php require "php/head.php"?>
<?php require "php/header.php" ?>
	<div class="container">
		<br>
		<h1>usuarios reguistro</h1>
		<hr>
		<div class="row">
			<div class="col-sm-12">
				<div id="tablastores"></div>
			</div>
		</div>
	</div>


  <!--************************************************* agregar datosmodal ***********************************************-->
  <div class="modal fade" id="addmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
      <div class="modal-content">
        <div class="modal-header">


          <h5 class="modal-title" id="exampleModalLabel">usuarios</h5>
          <button type="submit" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>


        </div>
        <div class="modal-body">
        	<form id="frmAgrega">
        		<label>Nombre</label>
        		<input type="text" class="form-control form-control-sm" name="name" id="name">
        		<label>apellido</label>
        		<input type="text" class="form-control form-control-sm" name="Lname" id="Lname">
        		<label>email</label>
        		<input type="email" class="form-control form-control-sm" name="email" id="email">
            <label>usuario</label>
            <input type="text" class="form-control form-control-sm" name="username" id="username">
            <label>privileguio</label>
            <input type="text" class="form-control form-control-sm" name="password" id="privileguio">
        	</form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
          <button type="button" class="btn btn-raised btn-primary" id="btnAgregar">Agregar</button>
        </div>
      </div>
    </div>
  </div>
  <!--************************************************* agregar datosmodal ***********************************************-->


  <!--************************************************* updatemodal ***********************************************-->
  <div class="modal fade" id="updatemodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
      <div class="modal-content">
        <div class="modal-header">

          <h5 class="modal-title" id="exampleModalLabel">Actualiza usuarios</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
        	<form id="frmactualiza">
            <input type="text" hidden="" name="id_juego" id="id_juego">
            <label>Nombre</label>
            <input type="text" class="form-control form-control-sm" name="name" id="name">
            <label>apellido</label>
            <input type="text" class="form-control form-control-sm" name="Lname" id="Lname">
            <label>email</label>
            <input type="email" class="form-control form-control-sm" name="email" id="email">
            <label>username</label>
            <input type="text" class="form-control form-control-sm" name="username" id="username">
            <label>password</label>
            <input type="password" class="form-control form-control-sm" name="password" id="password">
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
          <button type="button" class="btn btn-raised btn-warning" id="btnactualizar">Actualizar</button>
        </div>
      </div>
    </div>
  </div>
  <!--************************************************* updatemodal ***********************************************-->

<?php require "php/footer.php" ?>





<script type="text/javascript">
	$(document).ready(function(){
		$('#tablastores').load('tabla.php');

    $('#btnAgregar').click(function(){
      if(validarFormVacio('frmAgrega') > 0){
        alertify.alert("Debes llenar todos los campos por favor!");
        return false;
      }

      datos=$('#frmAgrega').serialize();

      $.ajax({
        type:"POST",
        data:datos,
        url:"php/insertar.php",
        success:function(r){
          if(r==1){
           $('#frmAgrega')[0].reset();
           $('#tablastores').load('tabla.php');
           alertify.success("Agregado:)");
         }else{
          alertify.error("no se a podidi Agregar:");
        }
      }
    });
    });


  });
</script>

<script type="text/javascript">
  $(document).ready(function(){
    $('#btnactualizar').click(function(){

      datos=$('#frmactualiza').serialize();
        $.ajax({
          type:"POST",
          data:datos,
          url:"php/actualizar.php",
          success:function(r){
            if(r==1){
             $('#tablastores').load('tabla.php');
               alertify.success("Actualizado con exito :)");
            }else{
               alertify.error("No se pudo actualizar :(");
            }
           }
        });
    });
  });
</script>

<script type="text/javascript">

  function obtenDatos(idjuego){
    $.ajax({

      type:"POST",
      data:"id=" + id,
      url:"php/obtenerRegistro.php",

      success:function(r){
        datos=jQuery.parseJSON(r);

        $('#nombre').val(datos['name']);
        $('#apellido').val(datos['Lname']);
        $('#email').val(datos['email']);
        $('#username')var(datos['username']);
        $('#password')var(datos[pass]);
      }
    });
  }


  function validarFormVacio(formulario){
    datos=$('#' + formulario).serialize();
    d=datos.split('&');
    vacios=0;
    for(i=0;i< d.length;i++){
      controles=d[i].split("=");
      if(controles[1]=="A" || controles[1]==""){
        vacios++;
      }
    }
    return vacios;
  }

  function elimina(idjuego){
      alertify.confirm('Eliminar usuario', '¿Desea eliminar este registro?',
              function(){
                  $.ajax({
                     type:"POST",
                      data:"id=" + id,
                      url:"php/eliminar.php",
                      success:function(r){
                          if(r==1){
                              $('#tablastores').load('tabla.php');
                              alertify.success("Eliminado con exito :)");
                          }else{
                               alertify.error("No se pudo eliminar :(");
                          }
                      }
                  });
              }
              ,function(){
                alertify.error('Cancelo')
              });
  }

</script>
