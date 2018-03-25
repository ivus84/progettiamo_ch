<%
dtpage=""


if len(Session("refadmin"))>0 then
session("pagina1")=Session("refadmin")
dtpage="page.asp?load="&session("pagina1")
end if
response.redirect("../"&dtpage)

%>