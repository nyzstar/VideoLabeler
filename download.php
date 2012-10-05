<?php
require_once "connectdb.php";

header("Content-type: text/xml"); 
header("Content-Disposition: attachment; filename= output.xml");
header("Pragma: no-cache");
header("Expires: 0");

$result = mysql_query("SELECT * FROM labels WHERE video_id = ".$_GET['video_id']." ORDER BY label_id");
$numLabels = mysql_num_rows($result);

$result2 = mysql_query("SELECT * FROM videos WHERE video_id = ".$_GET['video_id']);
$videoName = mysql_result($result2, 0, 'name'); 

//Get label names
$result3 = mysql_query("SELECT * FROM labelnames ORDER BY label_id");
for ($i=0; $i<mysql_num_rows($result3); $i++){
	$labelName[$i] = mysql_result($result3, $i, 'label_name');
}

$xml_output = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";  
$xml_output .= "<Alllabels>\n";
$xml_output .= "<video_name>".$videoName."</video_name>\n";
$xml_output .= "<total_label>".$numLabels."</total_label>\n";
while($row = mysql_fetch_array($result)){  
    $xml_output .= "\t<label>\n"; 
    $xml_output .= "\t\t<label_name>". $labelName[$row['label_name_id']-1] ."</label_name>\n"; 
	 $xml_output .= "\t\t<user_id>". $row['user_id'] ."</user_id>\n"; 
    $xml_output .= "\t\t<start_time>". $row['start_time'] ."</start_time>\n"; 
	$xml_output .= "\t\t<end_time>". $row['end_time'] ."</end_time>\n"; 
    $xml_output .= "\t</label>\n";
} 
$xml_output .= "</Alllabels>";  
//$filename = $_POST['video_name'].".xml";
echo $xml_output; 
//echo file_put_contents($filename, $xml_output); 
?>