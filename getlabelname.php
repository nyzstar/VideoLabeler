<?php
require_once "connectdb.php";

if ($_POST['sendRequest'] == "get_home_text") {
	$result = mysql_query("SELECT * FROM labelnames");
	$pairs = array();
	$i = 0;
    while($row = mysql_fetch_array($result)) { 
		$pairs[] = 'lbname' . $i . '=' . $row["label_name"];
		$i = $i + 1;
    }
	//print "home_text=$home_body";
	echo implode('&',$pairs);
}

mysql_close($link);
?>