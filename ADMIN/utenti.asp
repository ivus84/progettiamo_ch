<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

sel0=1
sel1=21
sel2=request("sel2")
sel3=request("sel3")
sel4=request("sel4")
cercanome=request("cercanome")

if Len(sel0)=0 then
sel0=0
end if

if Len(sel1)=0 then
sel1=0
end if

if Len(sel2)=0 then
sel2=0
end if

if Len(sel3)=0 then
sel3=0
end if

if Len(sel4)=0 then
sel4=0
end if

Session("idcantedit")=0
Session("admpage")="utenti.asp"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->

 <div id="content_page">

<p class="titolo">Utenti admin sito web</p>

<table style="width:+00%;border:0px; padding:0px;margin-top:10px" cellspacing="0">
<tr><td colspan="1"><input type="button" class="titolo" style="width:200px; margin-left:5px" value="Aggiungi utente" id="mybt1" onclick="document.location='cantiere_creautente.asp';"><br>
</td></tr>
<tr><td><table cellspacing="0" style="width:255px;border:solid 1px #999999;padding:4px;margin-top:20px">


<%

SQL="SELECT count(ID) as contau FROM utenticantieri WHERE TA_nome<>'Utente eliminato' AND TA_login<>'admin' AND TA_login<>'Ut.Eliminato' AND LO_amministrazione=True"
set record1=connection.execute(SQL)

contau=record1("contau")

sel2=5
%><%

SQL0="SELECT * FROM utenticantieri WHERE TA_nome<>'Utente eliminato' AND TA_login<>'admin' AND TA_login<>'Ut.Eliminato' AND LO_amministrazione=True ORDER BY TA_cognome ASC"
set record0=connection.execute(SQL0)

do while not record0.eof

ref=record0("ID")
nome=LCase(record0("TA_nome"))
cognome=LCase(record0("TA_cognome"))

if colore="#FFFFFF" then
colore="#EFEFEF"
else
colore="#FFFFFF"
end if

%>

<tr style="background-color:<%=colore%>"><td class="testoadm" style="padding:4px"> <a href="cantiere_utente.asp?ref1=<%=ref%>&sel2=<%=sel2%>" target="editing_page" onclick="setEditing();"><img src="images/edit.gif" border="0" style="float:right"/></a> <a href="del.asp?tabella=utenticantieri&pagina=<%=ref%>&da=utenti" target="editing_page" onclick="setEditing();"><img src="images/delete1.gif" border="0" style="float:right"/></a><b><%=cognome%></b> <%=nome%></td></tr>



<%
record0.movenext
Loop

page=request("page")
%>

<script type="text/javascript">
$(document).ready(function() {
$('.mMenu').not('.hMenu').eq(7).addClass('active');

<%
If Len(page)>0 Then
%>
$('#editing_page').attr('src','cantiere_utente.asp?ref1=<%=page%>');
setEditing();
<%
End if
%>
})
</script>


</table>
</body>
</html>



