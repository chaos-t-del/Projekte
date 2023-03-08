<html>
    <head>
        <meta charset="utf-8" />
        <title>Start Webshop</title>
        <link rel="stylesheet" type="text/css" href="../css/deko.css" />
    </head>
    <body>
        <header></header>
        <main>
            <a href="warenkorb.php?delete"><button>Warenkorb leeren</button></a>
            <?php
                //wir speichern das im warenkorb -- session mit dem Namen korb
                if( isset($_SESSION["korb"]) == false)
                {
                    session_start();
                }

                //wir prüfen, ob schon daten im korb, wenn nein dann neues Array 
                if(empty($_SESSION["korb"]) == true)
                {
                    $_SESSION["korb"] = array();
                }

                $korb = $_SESSION["korb"];

                if(isset($_REQUEST["delete"]))
                {
                    $korb = array();
                }

                //Alles abholen aus Formular 
                if(isset($_REQUEST["pid"]) && isset($_REQUEST["anzahl"]))
                {
                    $pid = $_REQUEST["pid"];
                    $anzahl = $_REQUEST["anzahl"];

                    

                    if(!empty($anzahl) && $anzahl > 0)
                    {
                        //wir prüfen, ob das gewählte produkt schon im warenkorb ist 
                        if( array_key_exists($pid, $korb))
                        {
                            $korb[$pid] += $anzahl;
                        }
                        else
                        {
                            $korb[$pid] = $anzahl; 
                        }
                    }

                   
                }

                 //Ausgabe warenkorb
                 print "<table>";
                 print "<tr><th>Produkt</th><th>Menge</th></tr>";
                 foreach($korb as $produkt => $menge)
                 {
                     print "<tr>";
                     print "<td>$produkt</td>";
                     print "<td>$menge</td>";
                     print "</tr>";
                 }
                 print "</table>";

                 //Session speichern auf browser 
                 $_SESSION["korb"] = $korb; 

                $url = "http://localhost:8080/27102022/php/warenkorb.php";
                echo("<script>history.replaceState({},'','$url');</script>"); 
            ?>

            <form action="bestellung.php">
                Kundenname: <input type="text" name="kunde" /> <br/>
                <input type="submit" value="bestellen" /> 
            </form>
        </main>
        <footer></footer>
    </body>
</html>