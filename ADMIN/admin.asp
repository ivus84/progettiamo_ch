<%Session.Abandon%>
<!DOCTYPE html>
<html lang="it">
<head><title>dSm v2.0.13 - powered by lavb.ch </title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.2,minimum-scale=0.5,maximum-scale=2.0"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="SHORTCUT ICON" href="/admin/images/dsm.ico"/>
<link rel="stylesheet" href="/admin/admstyles.css" type="text/css">
<script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script> 
<style type="text/css">
#centered { position: relative;	right: 0;  margin: 0 auto;  width: 400px;  height:360px; text-align: left;background: url(/admin/images/bg_login.png) center 10px no-repeat; }
</style>
</head>
<body style="margin:0px; margin-top:10%;background:url(/admin/images/bg_menu.png) left 0px repeat-x;background-color:#efefef;text-align:center">
<div id="centered">
<form name="form1" action="log.asp" method="POST">
<div id="mainLog" style="position:relative;  width:360px; height:333px">
<img src="./images/dsm_logo.png" style="width:170px; border:0px;position:absolute;left:41px; top:35px;"/>
<div style="vertical-align:top;padding-top:100px;padding-left:42px;">

<table width="300" cellpadding=0 cellspacing=0 >
<tr><td class="testoadm" valign="middle" style="color:#9f9494"><b>Login</b></td><td><input type="text" class="testoadm" name="user1" id="user1" size="20" style="width:164px;border:solid 1px #bab1b1;background-color:#f8f7f7;margin-bottom:6px;height:20px"/></td></tr>
<tr><td class="testoadm" valign="middle" style="color:#9f9494"><b>Password</b></td><td><input style="width:164px;border:solid 1px #bab1b1;background-color:#f8f7f7;height:20px;margin-bottom:6px" type="password" class="testoadm" name="psw1" size="20"/></td></tr>
<tr><td>&nbsp;</td><td><input type="submit" value="LOGIN" class="testoadm" style="width:80px; margin-right:20px;"/> <a href="javascript: passRetrieve()" style="color:#9f9494">lost password</a><br><br></td></tr>
</table>
</div>
</div>
</form>


<form name="form2" action="reset_password.asp" method="POST">
<div id="mainPass" style="position:relative; width:360px; height:333px; display:none">
<img src="./images/dsm_logo.png" style="width:170px; border:0px;position:absolute;left:41px; top:35px;"/>
<div style="vertical-align:top;padding-top:100px;padding-left:42px;">
<p class="fMsg" style="margin:0px;font-size:12px"></p>
<table id="passTable" width="300" cellpadding=0 cellspacing=0 >
<tr><td class="testoadm" valign="middle" style="color:#9f9494"><b>E-Mail/Login&nbsp;</b></td><td><input type="text" class="testoadm" name="user1" size="20" style="width:164px;border:solid 1px #bab1b1;background-color:#f8f7f7;margin-bottom:6px;height:20px"/></td></tr>
<tr><td>&nbsp;</td><td><input type="submit" value="RESET PASSWORD" class="testoadm" style="width:166px; margin-right:20px;"/><br/><br/><a href="javascript: backRetrieve()" style="color:#9f9494">back to login</a><br><br></td></tr>
</table>
</div>
</div>
</form>
<script type="text/javascript">

function passRetrieve() {
$('.fMsg').html('');
$('#mainLog').css("display","none")
$('#mainPass').css("display","inline")
$('#passTable').css("display","inline")
}

function backRetrieve() {
$('#mainLog').css("display","inline")
$('#mainPass').css("display","none")
}

<%
mode=request("mode")
%>

$(document).ready(function() {
<%if mode="not_Found" then%>
passRetrieve()
$('.fMsg').html('Login/Email not found<br/><br/>')
<%end if%>
<%if mode="reset" then%>
passRetrieve()
$('#passTable').css("display","none")
$('.fMsg').html('Reset password was sent to your e-mail.<br/>Please check your mailbox.<br/><a href="javascript: backRetrieve()">Back to login</a>')
<%end if%>

$('#user1').focus();
});
</script>
</body>
</html>
