<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
If Len(Session("logged_donator"))>0 Then

email=request("email")

If Len(email)>0 Then email=LCase(email)

emailcheck = EnDeCrypt(email, npass, 1)

SQL="SELECT ID from registeredusers  WHERE TA_email='"&emailcheck&"' OR TA_email_recupero='"&emailcheck&"'"
Set rec=connection.execute(SQL)

If Not rec.eof Then
Response.write "Exist"
Response.End
End if




SQL="UPDATE registeredusers SET TA_email_recupero='"&emailcheck&"' WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)

Response.write "OK"
End if
connection.close%>