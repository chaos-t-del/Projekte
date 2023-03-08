<?php
$größewahl = $_REQUEST ["größewahl"];
$bewahl = $_REQUEST ["bewahl"];

print_r($bewahl);
print "<br/>";
if ($größewahl == "mini")
{
    $preis = 3;
}
else if ($größewahl = "standard")
{
    $preis = 5;
}
else if ($größewahl = "family")
{
    $preis = 7;
}
$preis  = $preis + $anzahl;
print "Bitte zahlen:" .$preis. "€";

?>