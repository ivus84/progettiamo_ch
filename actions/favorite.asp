<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%

project=request("project")
If Len(Session("logged_donator"))>0 Then

SQL="SELECT * FROM registeredusers WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)

favorites=rec("TX_favorites")

If Len(favorites)=0 OR isnull(favorites) Then favorites=","

favorites=favorites& project&","


SQL="UPDATE registeredusers SET TX_favorites='"&favorites&"' WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)
Session("p_favorites")=favorites
Response.write "OK"

SQL="SELECT * FROM p_projects WHERE ID="&project
Set rec=connection.execute(SQL)
If Not rec.eof Then
SQL="UPDATE p_projects set IN_favorite=IN_favorite+1 WHERE ID="&project
Set rec=connection.execute(SQL)
End if
End if
connection.close%>