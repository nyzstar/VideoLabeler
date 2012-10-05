<?php
require_once "connectdb.php";

$sql="UPDATE labels SET label_name_id = ".$_POST['label_name_id'].", start_time = ".$_POST['start_time'].", end_time=".$_POST['end_time']." WHERE label_id = ".$_POST['label_id']." AND video_id = ".$_POST['video_id'];
$s = "succeed";
$f = "fail";
$result = mysql_query($sql);
if (!$result){
    print ("rst=$f");
	//die('Error: ' . mysql_error());
}
else{
	print ("rst=$s");
}

$fw = fopen("update_debug.txt", "w");
fwrite($fw, $sql);
fclose($fw);

mysql_close($link)
?>