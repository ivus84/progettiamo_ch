
<%
if isnull(Session("lang"))=True then Session("lang")=0

servername=Request.ServerVariables("HTTP_HOST")
    secure=Request.ServerVariables("HTTPS")
    https = "http://"
    if (lcase(secure) = "on") then https="https://"
%>
<!--#INCLUDE VIRTUAL="./incs/load_main_languages.asp"-->

<%
   
if len(Session("settedvars"&numproject))=0 Then
     
%>

<!--#INCLUDE VIRTUAL="./incs/load_website_vars.asp"-->

<%
    
Session("settedvars"&numproject)=True
end if
    
pageTitle=Session("nomeprogetto")
   
    pageTitle =  ConvertFromUTF8(pageTitle)
pageKeywords=Session("keywordsdsm3x")
    If Len(settitle)>0 Then settitle=Replace(settitle,"#","'")
    settitle= ConvertFromUTF8(settitle)
if len(setTitle)>0 and ishomepage<>True then 
     
    pageTitle=setTitle&" " &pageTitle
end if
    
    
if len(addKeywords)>0 then pageKeywords=addKeywords
 
    pagekeywords=  ConvertFromUTF8(pagekeywords)
   
pageDesc=Session("descriptiondsm3x")
      
if len(addDesc)>0 then
	addDesc=clearHtmlTags(addDesc,0)
	addDesc=replace(addDesc,chr(10)," ")
	addDesc=replace(addDesc,"  "," ")
	addDesc=replace(addDesc,"  "," ")
	addDesc=replace(addDesc,"&nbsp;"," ")
	addDesc=replace(addDesc,Chr(34),"")
	pageDesc=addDesc
end if

if len(pageDesc)>160 then pageDesc=truncateTxt(pageDesc,160)&" ..."
    pagedesc = ConvertFromUTF8(pagedesc) 
If Len(request.querystring)>0 Then addUrlOG="?"&request.querystring
If Len(addUrlOG)>0 Then addUrlOG=Replace(addUrlOG,"&utm_source=twitterfeed&utm_medium=facebook","")
If instr(addUrlOG,"&")>0 Then addUrlOG=Mid(addUrlOG,1,instr(addUrlOG,"&")-1)
If Len(Session("browser"))>0 AND InStr(Session("browser"),"MSIE")>0 then Response.AddHeader "X-UA-Compatible", "IE=edge"

html_lang=Session("langref")
main_lang=html_lang
If html_lang="ti" Then html_lang="it-ch"
If html_lang="it" Then html_lang="it-it"
If html_lang="en" Then html_lang="en-us"
If html_lang="fr" Then html_lang="fr-ch"
If html_lang="de" Then html_lang="de-ch"
fb_lang=Mid(html_lang,1,2)&"_"&UCase(Mid(html_lang,4))
   
%><!DOCTYPE html>
<html lang="<%=html_lang%>">
<head>
    <title><%=pageTitle%></title>
    <meta property="og:title" content="<%=setTitle%> - Progettiamo.ch" />
    <meta property="og:type" content="Website" />
    <meta property="og:url" content="<%=https&servername%>/<%=addUrlOG%>" />
    <%if len(pImage)>0 Then%><meta property="og:image" content="<%=https&servername%>/<%=imgscript%>?path=<%=pImage%>$370"/><%end if%>
    <meta property="og:description" content="<%=pageDesc%>" />
    <meta property="og:site_name" content="Progettiamo.ch" />
<meta charset="utf-8"/>
    <meta http-equiv="Content-type" content="text/html;charset=UTF-8">
<meta name="description" content="<%=pageDesc%>" />
<meta name="keywords" content="<%=pageKeywords%>" />
<meta name="robots" content="index,follow"/>

<!--[if IE]>
<meta name="SKYPE_TOOLBAR" content="SKYPE_TOOLBAR_PARSER_COMPATIBLE" />
<![endif]-->
<meta name="format-detection" content="telephone=no" />
<meta name="dcterms.rightsHolder" content="Enti Regionali per lo Sviluppo del Canton Ticino">

   
<link type="text/css" rel="stylesheet" href="/css/styles.1.css" media="all" />
<link type="text/css" rel="stylesheet" href="/source/jquery.fancybox.css" media="all" />
<link type="text/css" rel="stylesheet" href="/css/tooltipster.css" media="all" />

<%if len(Session("favicon"))>0 then%><link rel="shortcut icon" href="/img.asp?path=<%=Session("favicon")%>" /><%end if%>
<link rel="alternate" type="application/xml+rss" title="<%=Session("nomeprogetto")%> Sitemap" href="http://<%=servername%>/sitemap_xml.asp" />
<link rel="alternate" type="application/rss+xml" title="Progetti attivi su progettiamo.ch" href="http://<%=servername%>/rss/"/>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="/js/src.site.1.js"></script>
<script type="text/javascript" src="/config/txt.<%=main_lang%>.js"></script>
<script type="text/javascript" src="/source/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="/js/jquery.hypher.js"></script>
    <script type="text/javascript" src="/js/jquery.sharrre.min.js"></script>
<script type="text/javascript" src="/js/jquery.tooltipster.min.js"></script>
   

 
<%if len(Session("headerscript"))>0 then Response.write Session("headerscript")%>

<!--[if lt IE 9]>
<script type="text/javascript">oldIeBrowser = true;</script> 
<![endif]-->
<!--[if lte IE 8]>
<script src="/js/excanvas.min.js"></script>
<![endif]-->
<!--#INCLUDE VIRTUAL="./INCS/load_analytics.asp"-->

       <!--<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
  <script>tinymce.init({ selector:'textarea' });</script>-->


 