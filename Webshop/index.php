<html>
    <head>
        <meta charset="utf-8" />
        <title>Start Webshop</title>
        <link rel="stylesheet" type="text/css" href="css/deko.css" />
    </head>
    <body>
    
        <header>Webshop 3000</header>
        <main>
        
            <section>
                <?php

                    $conny = mysqli_connect("localhost","selli", "0000", "webshop");
                    $sql = "select pid,bild,titel,preis from produkt";

                    $tabelle = mysqli_query($conny, $sql);

                    $zeile = mysqli_fetch_assoc($tabelle);

                    while($zeile == true)
                    {
                        
                        $pid = $zeile["pid"];
                        $bild = $zeile["bild"];
                        $titel = $zeile["titel"];
                        $preis = $zeile["preis"];
                        print "
                            <figure>
                                <!-- test --> 
                                <a href='./php/auswahl.php?pid=$pid'>
                                    <img src='Bilder/$bild' /> 
                                </a>
                                
                                <p class='title'>$titel</p>
                                <p class='price'>$preis</p>
                            </figure>";
                        $zeile = mysqli_fetch_assoc($tabelle);
                    }

                    mysqli_close($conny);
                ?>
            </section>
        </main>
        <footer>Datenschutz und Impressum
            <p><a href="php/login.php">Login</a></p>
        </footer>
    </body>
</html>