<?php
require_once "connectdb.php";

$createLabelTable = "CREATE TABLE labels(
label_id 		INT UNSIGNED 	NOT NULL,
video_id 		INT UNSIGNED 	NOT NULL,
label_name_id 	INT UNSIGNED 	NOT NULL,
start_time 		DOUBLE 			NOT NULL,
end_time 		DOUBLE 			NOT NULL,
user_id			INT UNSIGNED	NOT NULL,
PRIMARY KEY(label_id, video_id)
)";

$createVideoTable = "CREATE TABLE videos(
video_id 	INT UNSIGNED 	NOT NULL,
name		VARCHAR(256) 	NOT NULL,
type		CHAR(10)		NOT NULL,
length		DOUBLE			NOT NULL,
upload_date	datetime		NOT NULL,
URL			VARCHAR(256)	NOT NULL,
PRIMARY KEY (video_id)
)";

$createLabelNameTable = "CREATE TABLE labelnames(
label_id	INT UNSIGNED	NOT NULL,
label_name	VARCHAR(256)	NOT NULL,
PRIMARY KEY(label_id)
)";

$createUserTable = "CREATE TABLE users(
user_id		INT UNSIGNED	NOT NULL,
user_name	VARCHAR(256)	NOT NULL,
password	VARCHAR(256)	NOT NULL,
email		VARCHAR(256)	NOT NULL,
PRIMARY KEY(user_id)
)";

if(mysql_query($createLabelTable)){
	Print "Table 'labels' is created successfully! <br />";
}else{
	Print "Error: Table 'labels' is not created! <br />";
}
if(mysql_query($createVideoTable)){
	Print "Table 'videos' is created successfully! <br />";
}else{
	Print "Error: Table 'videos' is not created! <br />";
}
if(mysql_query($createLabelNameTable)){
	Print "Table 'labelnames' is created successfully! <br />";
}else{
	Print "Error: Table 'labelnames' is not created! <br />";
}

if(mysql_query($createUserTable)){
	Print "Table 'users' is created successfully! <br />";
}else{
	Print "Error: Table 'users' is not created! <br />";
}
?>