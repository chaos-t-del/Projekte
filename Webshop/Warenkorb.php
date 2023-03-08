<?php

$pid = $_REQUEST["pid"];
if(!empty($anzahl) && $anzahl > 0)
{
    if (array_key_exists($pid, $korb))
    {
        $korb[$pid] += $anzahl;
    }
    else
    {
        $korb[$pid] = $anzahl;
    }
}

print "<table>";
print "<tr><th>Produkt</th><th>Menge</th></tr>";
foreach($korb as $produkt => $menge)
{
    
}
print "</table>";
    
?>