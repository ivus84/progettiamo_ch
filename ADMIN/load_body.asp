<%
Response.Expires = 0
Response.Expiresabsolute = Now() - 1 
Response.AddHeader "pragma","no-cache" 
Response.AddHeader "cache-control","private" 
Response.CacheControl = "no-cache"

limiteduser=false
SQL00="SELECT * FROM limita_contenuti WHERE CO_utenticantieri="&Session("IDuser")
set recordset00=connection.execute(SQL00)

if Not recordset00.eof Then 
limiteduser=True
limitedsection=recordset00("CO_oggetti")
End if


%>
<!DOCTYPE html>
<html lang="it">
<head><title>dSm v2.0.13 - powered by lavb.ch </title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="SHORTCUT ICON" href="/admin/images/dsm.ico"/>
<meta name="viewport" content="width=device-width,initial-scale=0.85,minimum-scale=0.5,maximum-scale=2.0"/>
<meta http-equiv="CACHE-CONTROL" content="NO-CACHE"/>
<meta http-equiv="PRAGMA" content="NO-CACHE"/>

<link rel="stylesheet" href="/css/ui-lightness/jquery-ui-1.8.18.custom.css" type="text/css"/>
<link rel="stylesheet" href="./admstyles.css" type="text/css"/>
<link rel="stylesheet" href="/source/jquery.fancybox.css" type="text/css"/>

<script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script> 
<script type="text/javascript" src="/js/jquery-ui-1.8.18.custom.min.js"></script>
<script type="text/javascript" src="/js/jquery.ui.datepicker-it.js"></script>
<script type="text/javascript" src="./jscripts/functions_editpage.js"></script>
<script type="text/javascript" src="./jscripts/tiny_mce3.5.10/jquery.tinymce.js"></script>
<script type="text/javascript" src="/source/jquery.fancybox.js"></script>
<script src="./jscripts/vendor/jquery.ui.widget.js"></script>
<script src="./jscripts/jquery.iframe-transport.js"></script>
<script src="./jscripts/jquery.fileupload.js"></script>
<script type="text/javascript" src="./main_lang/langedit_<%=Session("adminlanguageactive")%>.js"></script>

<title>Website Administration - dsmPro v.2.0.11 - powered by distanze.ch</title>
</head>
<%If nobg=True then%>
<body style="margin:0px; background-color:transparent; height:100%">
<%else%>
<body class="testoadm" style="margin:0px 0px 0px 1%;height:100%; background:url(./images/bg_menu.png) left 0px repeat-x;background-color:#efefef;width:99%">
<%End if%>

