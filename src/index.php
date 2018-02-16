<?php
// Connexion, sélection de la base de données
$dbconn = pg_connect("host=localhost dbname=tpgame user=yvann password=yvann")
    or die('Connexion impossible : ' . pg_last_error());

// Exécution de la requête SQL
$query = 'SELECT * FROM tp.INTERVENTION';
$result = pg_query($query) or die('Échec de la requête : ' . pg_last_error());

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
        <h1 class="cover-heading">Résultat SQL</h1>
		<?php

		echo "<table class='table table-inverse'>\n";
		while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
		    echo "\t<tr>\n";
		    foreach ($line as $col_value) {
		        echo "\t\t<td>$col_value</td>\n";
		    }
		    echo "\t</tr>\n";
		}
		echo "</table>\n";

		// Libère le résultat
		pg_free_result($result);

		// Ferme la connexion
		pg_close($dbconn);
		?>
      </main>

      <footer class="mastfoot mt-auto">
        <div class="inner">
          <p>TP GAME - by YVANN & BRANDON</p>
        </div>
      </footer>
    </div>


    <script src="js/jquery-3.2.1.slim.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>