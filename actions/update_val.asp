<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%

setval=request("setval")
setfield=request("setfield")
setref=request("setref")
If Len(Session("logged_donator"))>0 Then

SQL="UPDATE p_projects SET "&setfield&"="&setval&" WHERE CO_registeredusers="&Session("logged_donator")&" AND ID="&setref
Set rec=connection.execute(SQL)

'Response.write SQL
Response.write "OK"

End if
connection.close%>