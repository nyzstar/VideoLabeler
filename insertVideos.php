<?php
require_once "connectdb.php";
$sql = "INSERT INTO videos VALUES(1, 'test_16', 'flv', 145, NOW(), 'videos/test_16.flv')";
mysql_query($sql);
$sql = "INSERT INTO videos VALUES(2, 'test_17', 'flv', 127, NOW(), 'videos/test_17.flv')";
mysql_query($sql);
$sql = "INSERT INTO videos VALUES(3, 'test_18', 'flv', 139, NOW(), 'videos/test_18.flv')";
mysql_query($sql);
$sql = "INSERT INTO videos VALUES(4, 'test_19', 'flv', 291, NOW(), 'videos/test_19.flv')";
mysql_query($sql);
$sql = "INSERT INTO videos VALUES(5, 'FLF_T', 'flv', 650, NOW(), 'videos/FLF_T.flv')";
mysql_query($sql);
$sql = "INSERT INTO videos VALUES(6, 'FLF_S', 'flv', 650, NOW(), 'videos/FLF_S.flv')";
mysql_query($sql);
$sql = "INSERT INTO videos VALUES(7, 'FLG_T', 'flv', 653, NOW(), 'videos/FLG_T.flv')";
mysql_query($sql);
$sql = "INSERT INTO videos VALUES(8, 'FLG_S', 'flv', 653, NOW(), 'videos/FLG_S.flv')";
mysql_query($sql);
?>