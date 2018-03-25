<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
newNum=request("siteId")

if len(Session("licensekey"))>0 AND Len(newNum)>10 then


newPass=generatePassword(6)
pwd0=newPass&newNum

Dim ObjSHA1

Set ObjSHA1 = New clsSHA1
StrDigest = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing


SQL="UPDATE _config_admin SET IN_numproject='"&newNum&"'"
set recordset=connection.execute(SQL)

SQL="UPDATE utenticantieri SET TA_password='"&StrDigest&"' WHERE TA_login='admin'"
set recordset=connection.execute(SQL)

Response.write "New admin password: "&newPass&"<br/><a href=""logout.asp"">ESCI</a>"
Else
Response.write "Not changed"
End If

connection.close
response.end
%>
