<?phpinclude 'config.php';$error = 0;$time = time();if(@$_POST['Submit']){	$userName 		=  addslashes(trim($_POST['email']));	$firstName 		=  addslashes(trim($_POST['firstName']));	$lastName 		=  addslashes(trim($_POST['lastName']));	$email 			=  addslashes(trim($_POST['email']));$email2 			=  addslashes(trim($_POST['email']));$country			=  addslashes(trim($_POST['country']));$new	= @$_POST['new'];	$new 			=  addslashes(trim($_POST['new']));$emailedu 			=  addslashes(trim($_POST['emailedu']));$status 			=  addslashes(trim($_POST['status']));	$password 		=  trim($_POST['password']); 	$again 			=  trim($_POST['password']);        $confirmed              = rand(100000,999999);  	        $isconfirmed              = 0;	$sql = " SELECT * FROM `users` WHERE `email` = '$email' and `isconfirmed` = '1' ";	$exe	= mysql_query($sql) or die(mysql_error());	$emailRow	= mysql_num_rows($exe);  		  	if($password != $again)	{		$error = 1;		 $msg = 'Password not matching';	}		if(strlen($password) <= 6)	{		$error = 1;		 $msg = ' Password length should be minimum of 7 characters';			}	//if( $_SESSION['security_code'] != @$_POST['security_code'] || empty($_SESSION['security_code'] ) )//	//{//		$msg = 'Security code not matching';////		 $error = 1;////	}		if(empty($firstName) || empty($lastName) || empty($email) || empty($userName)||empty($status))	{ 		$error = 1;		$msg = 'All Fields are Mandatory';	}		if($emailRow != 0)	{		$error = 1;		 $msg = 'This email has already been registered';	}		  	 if(($status == 'alumni' or $status == 'current student')){    if(strpos($emailedu,'.edu')){}    else{    $error = 1;		 $msg = 'To register as a current student (US) or alumni (US) you need to provide a valid .edu address';}}		if($error == 0)		{			if(strpos($emailedu,'.edu')==TRUE){                    $edu = '1';                                            }else{$edu = '0';}	if( $_SESSION['security_code'] != @$_POST['security_code'] || empty($_SESSION['security_code'] ) )	{		$msg = 'Security code not matching';		 $error = 1;	}if($error==0){$sql234 = "DELETE FROM `users` WHERE `email` ='$email' and `isconfirmed` = '0'";                        $exe234	= mysql_query($sql234) or die(mysql_error());                       			        $SQL = " SELECT * FROM `users` ORDER BY userID DESC";$EXE	= mysql_query($SQL) or die(mysql_error());$userName	= mysql_result($EXE,0,'userID')+1;                                       // $sql234 = "UPDATE `users` SET `username` ='$userName'";                                $sql = " INSERT INTO `users` (  			`firstName`,`lastName`,`email`,`registerdate` ,`password`,`status`,`username`,`userID`,`confirmed`,`isconfirmed`,`edu`) 			VALUES ( '$firstName','$lastName','$email', NOW(),'$password','$status','$userName','$userName','$confirmed','$isconfirmed','$edu')";                                                                        			$exe	= mysql_query($sql) or die(mysql_error());                                                $sql2343 = "DELETE FROM `user_profile` WHERE `userID` ='$userName'";                        $exe2343	= mysql_query($sql2343) or die(mysql_error());                       			$sql3 = " INSERT INTO `user_profile` (`username`,`userID`, `country`,`status`,`funny`,`useful`,`blogviews`, `profileviews`,`emailnews`) 			VALUES ( '$userName','$userName', '$country','$status','0','0','0','0','$new')";			 			$exe3	= mysql_query($sql3) or die(mysql_error());                                                                      //  $sql2 = "SELECT * FROM `groups` where `title` = '$country'"; 			 //$exe2	= mysql_query($sql2) or die(mysql_error());                       // $rows2 = mysql_num_rows($exe2);                        //if($rows2 == 0){                          //$sql5 = "INSERT INTO `groups` (`title`, `summary`, `postedOn`, `numPosts`, `numThreads`, `startedBy`) VALUES ('$country', 'Welcome to the $country group!', '$time', 0,0, '$userName')";//$exe5	= mysql_query($sql5) or die(mysql_error());  //                      }    //                    else{      //                      $sql4 = "INSERT INTO `membership` (`userID`, `grouptitle`, `joinDate`) VALUES ('$userName', '$country', '$time')";//$exe4	= mysql_query($sql4) or die(mysql_error());  //                      }                            //                    if($status == 'prospective student')//{			$a = "http://www.unicq.net/registerprospect.php?user=$userName&num=$confirmed";//}if($status == 'current student' ||$status == 'current student (other)'){$a = "http://www.unicq.net/registerstudent.php?user=$userName&num=$confirmed";   } if($status == 'alumni'||$status == 'alumni (other)'){$a = "http://www.unicq.net/registeralum.php?user=$userName&num=$confirmed";}if($status == 'affiliate'){$a = "http://www.unicq.net/registeraffiliate.php?user=$userName&num=$confirmed";}if($status == 'group'){$a = "http://www.unicq.net/registergroup.php?user=$userName&num=$confirmed";}if($status == 'nconsultant'){$a = "http://www.unicq.net/registerconsultant.php?user=$userName&num=$confirmed";}			$contents = "Dear $firstName $lastName,<br><br>Thanks for registering with us. Please keep this email safe, as it contains your username and password			 for the website login.<br><br>Email : $email<br>Password : $password<br>To confirm your registration you must go to the following link: <a href = $a>$a</a>			<br><br>Alternatively, copy and paste this link into your brower: $a			Looking forward to your visits.<br><br>unicq.net team";			 			 			require("phpmailer/class.phpmailer.php");						$mail = new PHPMailer();						//$mail->IsSMTP();  // telling the class to use SMTP			//$mail->Host     = "smtp.example.com"; // SMTP server						$mail->From     = 'noreply@unicq.net';			$mail->FromName	= 'Unicq';if($edu =='1'){			$to = $emailedu;                        $msg = "good";                        }                        else{			$to = $email;                                                    $msg = "good";                        }	 $tdate     =date('Y-m-d');									$headers  = 'MIME-Version: 1.0' . "\r\n";			$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";			// Additional headers			$headers .= 'From: Unicq<noreply@Unicq.net>' . "\r\n";			// Mail it			mail($to, "Confirm UNIcq Registration", $contents, $headers);			//header('location:viewprofile.php?profile='.$id.'&msg=Your message sent successfully');			//$msg        = 'Your message sent successfully. '; header('location:confirm.php');			exit;		}                               }                                                                                                }include 'html/register.htm';?>