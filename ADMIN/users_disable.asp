<%ON ERROR RESUME NEXT%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
set1=request("set1")
SQL="UPDATE registeredusers SET LO_enabled="&set1
set record=connection.execute(SQL)

%>
<script>
alert("Comando eseguito");
document.location='subscribers.asp';
</script>