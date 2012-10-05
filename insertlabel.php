<?php
require_once "connectdb.php";
//Ssql = "INSERT INTO labels VALUES ('1', '1', '1', '6.033', '8.967', '1')";
$sql="INSERT INTO labels VALUES ('$_POST[label_id]', '$_POST[video_id]', '$_POST[label_name_id]', '$_POST[start_time]', '$_POST[end_time]', '$_POST[user_id]')";
$s = "succeed";
$f = "fail";
$result = mysql_query($sql);

$fw = fopen("insert_debug.txt", "w");
fwrite($fw, $sql);
fclose($fw);

if (!$result){
	print ("rst=$f");
	//die('Error: ' . mysql_error());
}else{
	print ("rst=$s");
}

mysql_close($link)
?>