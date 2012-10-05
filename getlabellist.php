<?php
header("Content-type: text/xml"); 
require_once "connectdb.php";
//$result = mysql_query("SELECT * FROM labels WHERE video_id = 1 AND user_id = 1 ORDER BY label_id");
$result = mysql_query("SELECT * FROM labels WHERE video_id = ".$_POST['videoID']." AND user_id = ".$_POST['user_id']." ORDER BY label_id ASC");
$xml_output = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";  
$xml_output .= "<Alllabels>\n";       
while($row = mysql_fetch_array($result)){
    $xml_output .= "\t<label>\n"; 
    $xml_output .= "\t\t<label_id>". $row['label_id'] ."</label_id>\n"; 
	$xml_output .= "\t\t<label_name_id>".$row['label_name_id']."</label_name_id>\n";
    $xml_output .= "\t\t<start_time>". $row['start_time'] ."</start_time>\n"; 
	$xml_output .= "\t\t<end_time>". $row['end_time'] ."</end_time>\n"; 
    $xml_output .= "\t</label>\n";  
} 
     
$xml_output .= "</Alllabels>";  

echo $xml_output;  

//$fw = fopen("getLabelList.txt", "w");
//fwrite($fw, $xml_output);
//fclose($fw);

mysql_close($link);
?>