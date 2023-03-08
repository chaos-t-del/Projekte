<html>
    <head>
        <meta charset="utf-8" />
        <title>Start Webshop</title>
        <link rel="stylesheet" type="text/css" href="../css/deko.css" />
    </head>
    <body>
        <header></header>
        <main>
            <?php
                //wir holen den Kundennamen aus dem formular
                $kunde = $_REQUEST["kunde"];
                if(!empty($kunde))
                {
                    //wir holen den Warenkorb 
                    if(isset($_SESSION["korb"]) == false)
                    {
                        session_start();
                    }
                    if(empty($_SESSION["korb"]) == true)
                    {
                        $_SESSION["korb"] = array();
                    }

                    $korb = $_SESSION["korb"];

                    //1. neue Bestellung für den Kunden eintragen 
                    $conny = mysqli_connect("localhost", "selli", "0000", "webshop");
                    $sql = "insert into bestellung (kunde, datum) values (?, now())";
                    $insert = $conny->prepare($sql);
                    $insert->bind_param("s", $kunde);
                    $insert->execute();

                    //2. neue Bestellnummer ausgeben lassen 
                    $sql = "select bid from bestellung order by datum desc limit 1";
                    $tabelle = mysqli_query($conny, $sql);

                    $zeile = mysqli_fetch_assoc($tabelle);

                    $bid = $zeile["bid"];

                    //freigabe der Tabelle 
                    mysqli_free_result($tabelle);

                    //3. Schritt - für jeden Eintrag im Warenkorb ein Eintrag in Bestellpositionen
                    $sql = "insert into bestellposition (pid, bid, anzahl) values (?,?,?)" ;
                    $insert = $conny->prepare($sql);
                    foreach($korb as $pid => $anzahl)
                    {
                        $insert->bind_param("iii", $pid, $bid, $anzahl);
                        $insert->execute();
                    }


                    print "Vielen Dank für Ihre Bestellung <br/>";
                    print "Ihre Bestellnummer: $bid";

                    $_SESSION["korb"] = array();  //warenkorb ist nun wieder leer 

                    $sql = "select titel, anzahl, preis, anzahl * preis as gesamt from bestellposition inner join produkt using(pid) where bid = $bid";
                    $tabelle = mysqli_query($conny, $sql);

                    $zeile = mysqli_fetch_assoc($tabelle);
                    $summe = 0; 
                    print "<table>";
                    print "<tr><th>Titel</th><th>Anzahl</th><th>Einzelpreis</th><th>Gesamtpreis</th></tr>";
                    while($zeile == true)
                    {
                        print "<tr>";
                        print "<td>$zeile[titel]</td>";
                        print "<td>$zeile[anzahl]</td>"; 
                        print "<td>$zeile[preis]</td>";
                        print "<td>$zeile[gesamt]</td>";
                        print "</tr>";
                        $summe += $zeile["gesamt"];
                        print "<br/>";

                        $zeile = mysqli_fetch_assoc($tabelle);
                    }
                    print "</table>";

                    print "<b>Gesamtsumme: $summe";
                    mysqli_close($conny);
                }
                else
                {
                    print "kein Name - keine Bestellung";
                }
            ?>

        </main>
        <footer></footer>
    </body>
</html>