<?php
require_once "connectdb.php";
$sql="SELECT * FROM videos WHERE video_id = ".$_GET['video_id'];
$result = mysql_query($sql) or die(mysql_error());
if(mysql_num_rows($result)){
	$video_url = mysql_result($result, 0, "URL");
	$video_name = mysql_result($result, 0, "name");
	$video_length = mysql_result($result, 0, "length");
	//echo $video_url.$video_name.$video_length;
}else{
	echo "Error the video doesn't exist!";
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CBCL Video Labeler</title>
<script src="Scripts/swfobject_modified.js" type="text/javascript"></script>

<script type="text/javascript">
/*
function readIDs() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}
*/


function readInputs(){
	var vars = {};
	vars['video_id'] = <?php echo $_GET['video_id']; ?>;
	vars['user_id'] = <?php echo $_GET['user_id']; ?>;
	vars['video_length'] = <?php echo $video_length; ?>;
	vars['video_name'] = "<?php echo $video_name; ?>";
	vars['video_url'] = "<?php echo $video_url; ?>";
	return vars;
}
function changeDims(){
	var height = window.innerHeight*0.9;
	var width = height/0.8;
	setPlayerDims(height, width);
}

function setPlayerDims(height, width){
	document.getElementById("FlashID").height = height;
	document.getElementById("FlashID").width = width;
	document.getElementById("player").height = height;
	document.getElementById("player").width = width;
	document.getElementById("swf_holder").style.width = width + "px";
}

function init(){
	readInputs();
	changeDims();
}
</script>

<style>
#swf_holder{
	margin-left:auto;
	margin-right:auto;
	width: 1000px;
}
#FlashID{
}
</style>
</head>

<body onload="init()", onresize="changeDims()">
<div id = "swf_holder">
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="1000" height="800" id="FlashID" title="video_labeler">
  <param name="movie" value="player.swf" />
  <param name="quality" value="high" />
  <param name="wmode" value="opaque" />
  <param name="swfversion" value="6.0.65.0" />
  <!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don’t want users to see the prompt. -->
  <param name="expressinstall" value="Scripts/expressInstall.swf" />
  <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
  <!--[if !IE]>-->
  <object id = "player" type="application/x-shockwave-flash" data="player.swf" width="1000" height="800">
    <!--<![endif]-->
    <param name="quality" value="high" />
    <param name="wmode" value="opaque" />
    <param name="swfversion" value="6.0.65.0" />
    <param name="expressinstall" value="Scripts/expressInstall.swf" />
    <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
    <div>
      <h4>Content on this page requires a newer version of Adobe Flash Player.</h4>
      <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" width="112" height="33" /></a></p>
    </div>
    <!--[if !IE]>-->
  </object>
  <!--<![endif]-->
</object>
</div>

<script type="text/javascript">
swfobject.registerObject("FlashID");
</script>
</body>
</html>
