<?php
global $DBname, $link;
$host = "localhost";
$user = "root";
$password = "";
$DBname = "labellife";
$link = mysql_connect($host, $user, $password);
mysql_select_db($DBname, $link);
//echo mysql_errno($link) . ": " . mysql_error($link). "\n";
?>