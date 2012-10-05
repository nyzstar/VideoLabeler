<?php
//header("Content-type: text/xml"); 
$con = mysql_connect("localhost","nyzstar","dirac");
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }
// some code
mysql_select_db("labellife", $con);
$result = mysql_query("SELECT * FROM labels WHERE video_id = ".$_POST['video_id']." ORDER BY label_id");


$xml_output = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";  
$xml_output .= "<Alllabels>\n";
$xml_output .= "<video_name>".$_POST['video_name']."</video_name>\n";
$num_rows = mysql_num_rows($result);
$xml_output .= "<total_label>".$num_rows."</total_label>\n";
while($row = mysql_fetch_array($result)){  
    $xml_output .= "\t<label>\n"; 
	$getlabelname = mysql_query("SELECT label_name FROM labelname WHERE label_id = ".$row['label_id']);
	$labelname = mysql_fetch_array($getlabelname);
    $xml_output .= "\t\t<label_name>". $labelname['label_name'] ."</label_name>\n"; 
    $xml_output .= "\t\t<start_time>". $row['start_time'] ."</start_time>\n"; 
	$xml_output .= "\t\t<end_time>". $row['end_time'] ."</end_time>\n"; 
    $xml_output .= "\t</label>\n";
} 
$xml_output .= "</Alllabels>";  
$filename = "XML/".$_POST['video_id']."_".$_POST['video_name'].".xml";
//echo $xml_output; 
echo file_put_contents($filename, $xml_output); 
mysql_close($con);
?>