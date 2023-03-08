<html>
    <head>
        <meta charset="utf-8" />
        <title>Start Webshop</title>
        <link rel="stylesheet" type="text/css" href="../css/deko.css" />
    </head>
    <body>
        <header> Ihre Wahl </header>
        <main>
            <?php
                    //Testdaten: http://localhost:8080/27102022/php/auswahl.php?pid=2
                    $pid = $_REQUEST["pid"];

                    $conny = mysqli_connect("localhost", "selli", "0000", "webshop");

                    $sql = "select * from produkt where pid = ?";

                    $select = $conny->prepare($sql);

                    $select->bind_param("i", $pid);

                    $select->execute();

                    $tabelle = $select->get_result();

                    $zeile = mysqli_fetch_assoc($tabelle);

                    while($zeile == true)
                    {
                        $pid = $zeile["pid"];
                        $bild = $zeile["bild"];
                        $titel = $zeile["titel"];
                        $besch = $zeile["beschreibung"];
                        $preis = $zeile["preis"];
                        print "<figure class='auswahl'>";
                        print "<p class='title'>$titel</p>";
                        print "<img src='../Bilder/$bild' /></figure>";

                        $zeile = mysqli_fetch_assoc($tabelle);
                    }

                    mysqli_close($conny);


            ?>
            <form action="warenkorb.php" >
                <!-- wir übertragen auch die pid, wollen die aber nicht anzeigen -->
                <input type="hidden" name="pid" value="<?php print $pid ?>" />
                Anzahl: <input type="number" min="1" name="anzahl" />
                <br/>
                <input type="submit" value="In den Warenkorb" />
            </form>
        </main>
        <footer>Datenschutz und Impressum</footer>
    </body>
</html>