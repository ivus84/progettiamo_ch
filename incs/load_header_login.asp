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
    <link type="text/css" rel="stylesheet" href="/source/jquery.fancybox.css" media="all" />
<link type="text/css" rel="stylesheet" href="/css/login.css" media="all" />
<script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/config/txt.<%=main_lang%>.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="/source/jquery.fancybox.pack.js"></script>
 <% if not instr(Request.ServerVariables("URL"),"login") > 0 then %>
    <script src="../js/closure-library/closure/goog/base.js" type="text/javascript"></script>
    <script>
        goog.require('goog.proto2.Message');
</script>
 <script src="../js/i18n/phonenumbers/phonemetadata.pb.js" type="text/javascript"></script>
    <script src="../js/i18n/phonenumbers/phonenumber.pb.js" type="text/javascript"></script>
    <script src="../js/i18n/phonenumbers/metadata.js" type="text/javascript"></script>
    <script src="../js/i18n/phonenumbers/phonenumberutil.js" type="text/javascript"></script>
   <%end if %>


<script type="text/javascript" src="/js/src.site.1.js"></script>
    
<link rel="shortcut icon" href="/prog.ico" />
<meta name="robots" content="noindex"/>
<!--#INCLUDE VIRTUAL="./INCS/load_analytics.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_language_vars.asp"-->
<!--[if lt IE 9]>
<script type="text/javascript">oldIeBrowser = true;</script> 
<![endif]-->
    <% if not instr(Request.ServerVariables("URL"),"login") > 0 then %>
    <script type="text/javascript">
        $(function () {
            <% if instr(Request.ServerVariables("URL"),"newsletter") > 0 then %>
            var content = '<p><%=str_privacy_policy_news %></p>';
            <% else %>
            var content = '<p><%=str_privacy_policy_login %></p>';
            <% end if %>

            parent.$.fancybox({
                title : '<%=str_privacy_policy_title %>',
                content: content,
                autoDimensions: false,
                autoSize: false,
                width: 300,
                height: 200,
                padding: 5,
                helpers: {
                    title: {
                        type: 'inside',
                        position: 'top'
                    }, overlay: { css: { 'background': 'rgba(255, 255, 255, 0.8)' } }
                }
            });
            
        });

    </script>
    <% end if %>
</head>