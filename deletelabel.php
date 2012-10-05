<?php
require_once "connectdb.php";

$sql="DELETE FROM labels WHERE video_id = ".$_POST['video_id']." AND label_id = ".$_POST['label_id'];
$s = "succeed";
$f = "fail";
$result = mysql_query($sql);

$fw = fopen("delete_debug.txt", "w");
fwrite($fw, $sql);
fclose($fw);

if (!$result){
    print ("rst=$f");
	//die('Error: ' . mysql_error());
}
else{
	print ("rst=$s");
}

mysql_close($link)
?>