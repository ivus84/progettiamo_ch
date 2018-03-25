<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
If Len(Session("logged_donator"))>0 Then

pass1=request("pass1")
pass2=request("pass2")
pass3=request("pass3")

If pass2<>pass3 Then
Response.write"Confirm"
Response.End
End If

SQL="SELECT TA_password from registeredusers  WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)
pass4=rec("TA_password")

pwd0=pass1&numproject

Dim ObjSHA1

Set ObjSHA1 = New clsSHA1
StrDigest = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing

If pass4<>StrDigest Then
Response.write"Pass"
Response.End
End If


pwd0=pass2&numproject
Set ObjSHA1 = New clsSHA1
StrDigest1 = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing


SQL="UPDATE registeredusers SET TA_password='"&StrDigest1&"' WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)
Response.write "OK"
End if
connection.close%>