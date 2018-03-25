<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%

setval=request("setval")
setfield=request("setfield")
If Len(Session("logged_donator"))>0 Then

SQL="UPDATE registeredusers SET "&setfield&"="&setval&" WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)
Response.write "OK"
'Response.write SQL
End if
connection.close%>