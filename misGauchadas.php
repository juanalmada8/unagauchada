<?php session_start(); 
$pag='Mis Gauchadas';
require 'includes/encabezadoLog.php';
if ($_SESSION['logueado']) { 
	
	
	$idU=$_SESSION['idUsuario']; ?>


	<?php $msj=array();
		  $msj[1]['text'] = "Califica tus gauchadas para publicar otra";
		  $msj[1]['type'] = 'error';
		  $msj[2]['text'] = "No hay gauchadas";
		  $msj[2]['type'] = 'error';

		  if (isset($_GET['m'])) {
		  	$error=$_GET['m'];
		  }


		 if (isset($_GET['crit'])) {

		$traer = ' AND 1=1';
		
		if ($_GET['crit'] == 'postEle') {
			$traer = " AND g.calificacionid='1'";
		} else if ($_GET['crit'] == 'sinPost') {
			$traer = " AND g.calificacionid='0'";
		}else if ($_GET['crit'] == 'calificada') {
			$traer = " AND g.calificacionid>2";
		}else if ($_GET['crit'] == 'vencida') {
			$traer = " AND date(now())>=date(fecha) AND calificacionid<=2";
		}

	}
	 ?>
	<div class="menuPerfil">
		<p><h3 class="titulo">Mis Gauchadas</h3><br>
		 <div id="volverPos">
		 	<a href="perfil.php">Volver</a>
		 </div>
		 <?php if ($error) {?>
				<h3 style="margin-left:20%" class="<?php echo $msj[$error]['type']; ?>"><?php echo $msj[$error]['text']; ?></h3>
		<?php } ?>

		<div id="ordenarPor">
			<form method="GET" action="misGauchadas.php">
		 		
		 		<p><label>Ver mis gauchadas: <select name="crit" id="crit" required></label>
					<option value="0" selected>Todas</option>			
					<option value="postEle" <?php echo ($_GET['crit']=="postEle" ) ? "selected" : '' ;?>>Con postulante elegido</option>	
					<option value="sinPost" <?php echo ($_GET['crit']=="sinPost" ) ? "selected" : '' ;?>>Sin postulante</option>	
					<option value="calificada" <?php echo ($_GET['crit']=="calificada" ) ? "selected" : '' ;?>>Calificadas</option>	
					<option value="vencida" <?php echo ($_GET['crit']=="vencida" ) ? "selected" : '' ;?>>Vencidas</option>	
				</select>

				<button>Buscar</button></p>

			</form><br><br>

		</div>

		 <div id="cajaGauchadas">
				
			<?php $queryG = "SELECT *
								FROM gauchada as g
	       						LEFT JOIN calificacion as c 
	       						ON g.calificacionid = c.idcalificacion
								WHERE g.autor_usuarioid = $idU AND g.calificacionid < 6 $traer";
			$gauchadas = fetch ($queryG); 

			#Postulante elegido


			if ($gauchadas!=NULL) {

				foreach ($gauchadas as $rowG) {
						
					$idG=$rowG['idGauchada'];

					$queryUsuarioElegido="SELECT * FROM postulante as p
								WHERE p.estado=1 AND p.gauchadaid='$idG';";
								
					$usuarioElegido = fetch($queryUsuarioElegido,true); ?>


					<?php if ($rowG['idcalificacion']==0) {
						$calificacion="Sin postulante elegido";
					} else if ($rowG['idcalificacion']==1) {
						$calificacion="Postulante elegido";
					} else if ($rowG['idcalificacion']==2 && !empty($usuarioElegido)) {
						$calificacion="Califique al usuario";
					} else { $calificacion=$rowG['calificacion']; } ?>
					<div class="individual">
						<?php $string="Calificación: ";   ?>
						<div class="cont">
							<h5><?php if ($calificacion=="Califique al usuario") { ?>
									
									<form method="POST" action="calificar.php" id="colorBoton">
	 								<input type="hidden" name="idG" value="<?php echo $idG ?>">
	 								<input type="hidden" name="idU" value="<?php echo $usuarioElegido['usuarioid']; ?>">
	 								<button id="botoncitoRaro">Califique al usuario</button>
	 							</form>	
						<?php } else if($calificacion=="Bien" || $calificacion=="Mal" || $calificacion=="Neutral") { echo $string."".$calificacion; }else { echo $calificacion; } ?> | Título: <?php echo $rowG['titulo']; ?> </h5>
							<p><?php echo $rowG['descripcion'] ?></p>
							<a href="gauchada.php?id=<?php echo $idG ?>&&a=1">Ver</a>
						</div>
						<div class="imagen">
							<img src="<?php 
							echo ($rowG['foto']) ? $rowG['foto'] : 'img/logo.png' ;?>"><br>
						</div>
					</div>
				<?php }
				
			} else if (count($gauchadas)==0) { ?>
				<div id="vacio" style="margin-bottom:10%; margin-top:10%;" >
					<?php  	echo "<h4 class='error'>No se encuentran gauchadas.</h4>";?>
				</div>
		<?php }

			?>

			</div>


	</div>
	
<?php } else { header("index.php"); } ?>
<?php require 'includes/footer.php'; ?>