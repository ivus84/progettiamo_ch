<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<%

load=request("load")


	SQL="SELECT * FROM registeredusers WHERE LO_projects=True AND ID="&load
	set rec=connection.execute(SQL)
	if not rec.eof then
	
SQL="SELECT * FROM p_projects WHERE CO_registeredusers="&load
set rec=connection.execute(SQL)
If Not rec.eof Then%>
<p style="font-family:arial">IMPOSSIBILE EFFETTUARE LA CONVERSIONE,<br/>L'UTENTE HA APERTO ALCUNE SCHEDE PROGETTO<br/>NON INVIATE PER APPROVAZIONE</p>
<%
Response.End
End if
	
	SQL="UPDATE registeredusers SET LO_projects=False WHERE ID="&load
	set rec=connection.execute(SQL)
%>
<p style="font-family:arial">ACCOUNT CONVERTITO IN SOLO FINANZIATORE</p>
<script>
setTimeout(function() {
parent.document.location='promoters.asp?ssid=' + Math.floor((Math.random()*111111)+1);
},2000)

</script>
<%
Response.end
End if
connection.close%>