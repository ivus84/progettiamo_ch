<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
connection.close
prevlang=Session("lang")
prevlangref=Session("reflang")
prevreflang=Session("langref")

Session.abandon
'Response.redirect("http://www.progettiamo.ch/")

Response.redirect("/logout_lang.asp?lang="&prevlang&"&reflang="&prevlangref&"&langref="&prevreflang)
%>