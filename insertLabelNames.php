<?php
require_once "connectdb.php";
$sql = "INSERT INTO labelnames VALUES(1, 'drink')";
mysql_query($sql);
$sql = "INSERT INTO labelnames VALUES(2, 'eat')";
mysql_query($sql);
$sql = "INSERT INTO labelnames VALUES(3, 'groom')";
mysql_query($sql);
$sql = "INSERT INTO labelnames VALUES(4, 'hang')";
mysql_query($sql);
$sql = "INSERT INTO labelnames VALUES(5, 'micro-movement')";
mysql_query($sql);
$sql = "INSERT INTO labelnames VALUES(6, 'rear')";
mysql_query($sql);
$sql = "INSERT INTO labelnames VALUES(7, 'rest')";
mysql_query($sql);
$sql = "INSERT INTO labelnames VALUES(8, 'walk')";
mysql_query($sql);
?>