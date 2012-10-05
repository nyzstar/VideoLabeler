<?php
header("Content-type: text/xml"); 
$con = mysql_connect("localhost","nyzstar","dirac");
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }
// some code
mysql_select_db("labellife", $con);
$result = mysql_query("SELECT * FROM videos ORDER BY video_id");


$xml_output = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";  
$xml_output .= "<Allvideos>\n";
while($row = mysql_fetch_array($result)){  
    $xml_output .= "\t<video>\n"; 
    $xml_output .= "\t\t<video_id>". $row['video_id'] ."</video_id>\n"; 
    $xml_output .= "\t\t<video_name>". $row['name'] ."</video_name>\n"; 
	$xml_output .= "\t\t<URL>". $row['URL'] ."</URL>\n"; 
    $xml_output .= "\t</video>\n";
} 
$xml_output .= "</Allvideos>";  

echo $xml_output;  
mysql_close($con);
?>