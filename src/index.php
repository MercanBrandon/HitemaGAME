<?php
// Connexion, sélection de la base de données
$dbconn = pg_connect("host=localhost dbname=tpgame user=yvann password=yvann")
    or die('Connexion impossible : ' . pg_last_error());
?>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- <link rel="icon" href="../../../../favicon.ico"> -->

    <title>TP GAME</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/cover.css" rel="stylesheet">
  	<script type="text/javascript" src="https://gc.kis.v2.scr.kaspersky-labs.com/03CCC148-B608-8F49-BA75-4FCE0A1EF387/main.js" charset="UTF-8"></script></head>

  <body class="text-center">

    <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">
      <header class="masthead mb-auto">
        <div class="inner">
          <h3 class="masthead-brand">TP GAME HITEMA</h3>
          <nav class="nav nav-masthead justify-content-center">
            <a class="nav-link active" href="#">Accueil</a>
          </nav>
        </div>
      </header>

      <main role="main" class="inner cover">
        <h1 class="cover-heading">Résultat SQL</h1><br><br>
        <h3 class="cover-heading">Liste des ressources pour l’intervention n°1</h3>
		<?php
		// Exécution de la requête SQL
		$query = 'SELECT r.idressource, r.intitule, r.etat, r.qtedispo FROM tp.ressource r
					JOIN tp.utiliser u ON (u.idressource = r.idressource)
					JOIN tp.intervention i ON (i.idinter = u.idinter)
					WHERE i.idinter = 1
					';
		$result = pg_query($query) or die('Échec de la requête : ' . pg_last_error());

		echo "<table class='table table-inverse'>\n";
		echo "<thead>";
		    echo "\t<tr>\n";
		    	echo "\t\t<th>id</th>\n";
		    	echo "\t\t<th>intitule</th>\n";
		    	echo "\t\t<th>etat</th>\n";
		    	echo "\t\t<th>qteDispo</th>\n";
		    echo "\t</tr>\n";
		echo "</thead>"; 
		while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {

		    echo "\t<tr>\n";
		    foreach ($line as $col_value) {
		        echo "\t\t<td>$col_value</td>\n";
		    }
		    echo "\t</tr>\n";
		}
		echo "</table>\n";
		?>      





		<br><br>
		<h3 class="cover-heading">Liste des villes ayant eu au moins une intervention</h3>
		<?php
		// Exécution de la requête SQL
		$query = 'SELECT v.idVille,v.nomVille FROM tp.ville v
					JOIN tp.SECTEUR s ON (s.idville = v.idville)
					JOIN tp.INTERVENTION i ON (i.idsecteur = s.idsecteur)
					GROUP BY 1,2
					HAVING COUNT(i.idinter) > 0';
		$result = pg_query($query) or die('Échec de la requête : ' . pg_last_error());

		echo "<table class='table table-inverse'>\n";
		echo "<thead>";
		    echo "\t<tr>\n";
		    	echo "\t\t<th>id</th>\n";
		    	echo "\t\t<th>nomVille</th>\n";
		    echo "\t</tr>\n";
		echo "</thead>"; 
		while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {

		    echo "\t<tr>\n";
		    foreach ($line as $col_value) {
		        echo "\t\t<td>$col_value</td>\n";
		    }
		    echo "\t</tr>\n";
		}
		echo "</table>\n";		
		?>





		<br><br>
		<h3 class="cover-heading">Quels sont les interventions créées par l’utilisateur Yvann</h3>
		<?php
		// Exécution de la requête SQL
		$query = "SELECT i.idinter,i.intitule,i.typeinter,i.etatinter,i.datedebut,i.datefin FROM tp.INTERVENTION i
					JOIN tp.UTILISATEUR u ON (u.iduser = i.iduser_utilisateur)
					WHERE u.prenomuser = 'yvann'";
		$result = pg_query($query) or die('Échec de la requête : ' . pg_last_error());

		echo "<table class='table table-inverse'>\n";
		echo "<thead>";
		    echo "\t<tr>\n";
		    	echo "\t\t<th>id</th>\n";
		    	echo "\t\t<th>intitule</th>\n";
		    	echo "\t\t<th>typeinter</th>\n";
		    	echo "\t\t<th>etatinter</th>\n";
		    	echo "\t\t<th>datedebut</th>\n";
		    	echo "\t\t<th>datefin</th>\n";
		    echo "\t</tr>\n";
		echo "</thead>"; 
		while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {

		    echo "\t<tr>\n";
		    foreach ($line as $col_value) {
		        echo "\t\t<td>$col_value</td>\n";
		    }
		    echo "\t</tr>\n";
		}
		echo "</table>\n";
		?>		


		<br><br>
		<h3 class="cover-heading">Quels sont les ressources commandées par Yvann pour l’intervention 1 </h3>
		<?php
		// Exécution de la requête SQL
		$query = "SELECT c.idcommande,c.datecommande,u.prenomuser FROM tp.COMMANDE c
				JOIN tp.UTILISATEUR u ON (u.iduser = c.iduser)
				WHERE u.prenomuser = 'yvann'";
		$result = pg_query($query) or die('Échec de la requête : ' . pg_last_error());

		echo "<table class='table table-inverse'>\n";
		echo "<thead>";
		    echo "\t<tr>\n";
		    	echo "\t\t<th>id</th>\n";
		    	echo "\t\t<th>datecommande</th>\n";
		    	echo "\t\t<th>prenomuser</th>\n";
		    echo "\t</tr>\n";
		echo "</thead>"; 
		while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {

		    echo "\t<tr>\n";
		    foreach ($line as $col_value) {
		        echo "\t\t<td>$col_value</td>\n";
		    }
		    echo "\t</tr>\n";
		}
		echo "</table>\n";
		?>		

		<br><br>
		<h3 class="cover-heading">Quels sont les interventions validées par l’utilisateur Brandon</h3>
		<?php
		// Exécution de la requête SQL
		$query = "SELECT i.idinter,i.intitule,i.typeinter,i.etatinter,i.datedebut,i.datefin FROM tp.INTERVENTION i
				JOIN tp.UTILISATEUR u ON (u.iduser = i.iduser_utilisateur)
				WHERE u.prenomuser = 'brandon'";
		$result = pg_query($query) or die('Échec de la requête : ' . pg_last_error());

		echo "<table class='table table-inverse'>\n";
		// echo "<thead>";
		//     echo "\t<tr>\n";
		//     	echo "\t\t<th>id</th>\n";
		//     	echo "\t\t<th>datecommande</th>\n";
		//     	echo "\t\t<th>prenomuser</th>\n";
		//     echo "\t</tr>\n";
		// echo "</thead>"; 
		while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {

		    echo "\t<tr>\n";
		    foreach ($line as $col_value) {
		        echo "\t\t<td>$col_value</td>\n";
		    }
		    echo "\t</tr>\n";
		}
		echo "</table>\n";
		?>

		<?php
		// Libère le résultat
		pg_free_result($result);

		// Ferme la connexion
		pg_close($dbconn);
		?>
      </main>


    </div>


    <script src="js/jquery-3.2.1.slim.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>