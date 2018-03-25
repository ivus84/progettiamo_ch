<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->


<%
key = request("key")
dim users 
SQL="SELECT distinct ID FROM registeredusers WHERE LO_enabled=True AND LO_deleted=False AND (TA_ente like '%"&key&"%' OR TA_nome like '%"&key&"%' OR TA_Cognome like '%"&key&"%')"
Set rec=connection.execute(SQL)

do while not rec.eof
users = users &"~"&rec("ID")
rec.movenext
loop

response.Write users
response.End

%>







<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>

</body>
</html>
