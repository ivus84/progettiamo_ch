<%
    Response.CharSet = "ISO-8859-1"
Response.CodePage = 28591
html_lang=Session("langref")
If Len(html_lang)=0 Then html_lang="it"
main_lang=html_lang
If html_lang="ti" Then html_lang="it-ch"
If html_lang="it" Then html_lang="it-it"
If html_lang="en" Then html_lang="en-us"

%><!DOCTYPE html>
<html lang="<%=html_lang%>">
<head><title>Progettiamo.ch - Il Ticino insieme - Crowdfunding promosso dagli Enti Regionali per lo Sviluppo del Canton Ticino</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width">
<link type="text/css" rel="stylesheet" href="/css/login.css" media="all" />
<script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/config/txt.<%=main_lang%>.js"></script>

    <script src="../js/closure-library/closure/goog/base.js" type="text/javascript"></script>
    <script>
        goog.require('goog.proto2.Message');
</script>
 <script src="../js/i18n/phonenumbers/phonemetadata.pb.js" type="text/javascript"></script>
    <script src="../js/i18n/phonenumbers/phonenumber.pb.js" type="text/javascript"></script>
    <script src="../js/i18n/phonenumbers/metadata.js" type="text/javascript"></script>
    <script src="../js/i18n/phonenumbers/phonenumberutil.js" type="text/javascript"></script>
   


<script type="text/javascript" src="/js/src.site.1.js"></script>
<link rel="shortcut icon" href="/prog.ico" />
<meta name="robots" content="noindex"/>
<!--#INCLUDE VIRTUAL="./INCS/load_analytics.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_language_vars.asp"-->
<!--[if lt IE 9]>
<script type="text/javascript">oldIeBrowser = true;</script> 
<![endif]-->

</head>