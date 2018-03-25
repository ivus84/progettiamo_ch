<%
if request.querystring="Home" then
Session("issection"&numproject)=0
session("page1")=0
response.redirect("/")
response.end
end if

If Len(session("sethome"))=0 then
session("sec")=0
Session("issection"&numproject)=0
%>
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
session("sec")=0

ishomepage=True

SQL="SELECT ID FROM newsection WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND LO_homepage=True AND LO_deleted=False AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set record=connection.execute(SQL)

if record.eof then
SQL="SELECT ID FROM newsection WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND LO_deleted=False AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set record=connection.execute(SQL)
end if

	if not record.eof then
	refid=record("ID")
	Session("pagina1")=refid
	Session("issection"&numproject)=refid
	End if

connection.close
session("sethome")="setted"
End if
%>
<!--#INCLUDE VIRTUAL="./page.asp"-->