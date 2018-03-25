<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
vote=request("vote")
project=request("project")
If Len(Session("logged_donator"))>0 Then

SQL="SELECT * FROM registeredusers WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)

rated=rec("TX_rated")

If Len(rated)=0 OR isnull(rated) Then rated=","

rated=rated& project&","


SQL="UPDATE registeredusers SET TX_rated='"&rated&"' WHERE ID="&rec("ID")
Set rec=connection.execute(SQL)

Response.write "OK"

SQL="SELECT * FROM p_projects WHERE ID="&project
Set rec=connection.execute(SQL)
If Not rec.eof Then
SQL="UPDATE p_projects set IN_votes=IN_votes+1, IN_rated=IN_rated+"&vote&" WHERE ID="&project
Set rec=connection.execute(SQL)
End if
End if
connection.close%>