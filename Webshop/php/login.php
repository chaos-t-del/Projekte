<html>
    <head>
        <meta charset="utf-8" />
        <title>Start Webshop</title>
        <link rel="stylesheet" type="text/css" href="../css/deko.css" />
    </head>
    <body>
        <header> Login - Bereich </header>
        <main>
        <form action="" method="post">
                Benutzername: <input type="text" name="bn"  />
                Passwort: <input type="password"  name="pwd" />
                <br/>
                <input type="submit" value="Einlogggn" />
            </form>
            <?php
                    error_reporting(0);
                    if(isset($_REQUEST["bn"]) && isset($_REQUEST["pwd"]))
                    {

                        $bn = $_REQUEST["bn"];
                        $pwd = $_REQUEST["pwd"];
                       
                        //if($bn == "login" && $pwd == "1234")
                        //{
                           
                        //in der Datenbank 
                        // create user login@localhost identified by "1234";
                        //grant select on webshop.* to login@localhost;

                        $conny = mysqli_connect("localhost", $bn, $pwd, "webshop");

                        if($conny == true)
                        {
                            $sql = "select bid, kunde, datum, sum(preis * anzahl) as gesamt from bestellung inner join bestellposition using (bid) inner join produkt using (pid) group by bid";

                            $tabelle = mysqli_query($conny, $sql);

                            $zeile = mysqli_fetch_assoc($tabelle);

                            print "<table>";
                            print "<tr><th>bestellnr</th><th>kunde</th><th>datum</th><th>Gesamtbetrag</th></tr>";
                            while($zeile == true)
                            {
                                print "<tr>";
                                print "<td>$zeile[bid]</td>";
                                print "<td>$zeile[kunde]</td>";
                                print "<td>$zeile[datum]</td>";
                                print "<td>$zeile[gesamt]</td>";
                                print "</tr>";

                                $zeile = mysqli_fetch_assoc($tabelle);
                            }
                            print "</table>";
                            mysqli_close($conny);
                        }
                        else 
                        {
                            print "geh weg";
                        }

                    }
            ?>
            
        </main>
        <footer>Datenschutz und Impressum</footer>
    </body>
</html>