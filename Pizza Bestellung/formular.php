<?php
$name = $_REQUEST["name"];
$zahl = $_REQUEST["zahl"];

print "name: $name <br/>";
print "zahl: $zahl <br/>";

$rdwahl = $_REQUEST["rdwahl"];
print "Ihre wahl: $rdwahl <br/>";

$chwahl = $_REQUEST["chwahl"];
print "checkboxen <br/>";
print_r($chwahl);
print "<br/>";

$anzahl = count($chwahl);
$index = 0;
while ($index < $anzahl)
{
    print "index: $index => wert: $chwahl[$index] <br/>";
    $index++;
}
print "<br/>";

foreach($chwahl as $index => $wert)
{
    print "$index: $wert <br/>";
}

$selwahl = $_REQUEST["selwahl"];
$selmehr = $_REQUEST["selmehr"];

print "DropDown 1 wert: $selwahl <br/>";
print "Dropdown viele werte: ";
print_r($selmehr);
?>