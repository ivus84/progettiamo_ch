<%
refid=Session("pagina1")

Session.abandon

response.redirect("/?"&refid&"/")
response.end
%>