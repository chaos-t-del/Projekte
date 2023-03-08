<?php
$tiere = array("Reh", "Hase", "Igel");

print_r($tiere);

print "<br/>";

$artikel = array("bezeichnung" => "Hose", "preis" => 23.45, "menge" => 10);

print_r($artikel);
print "<br/>";

foreach($artikel as $key => $value)
{
    print "$key: $value <br/>";
}

print $artikel["bezeichnung"];
?>