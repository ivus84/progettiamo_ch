<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->
<%
email=request("setmail")
setId=request("setId")
refer=Request.ServerVariables("HTTP_REFERER")
refurl=Request.ServerVariables("HTTP_HOST")

If InStr(refer,refurl)=0 Then
    Response.End
End if

email=LCase(email)
emailcheck = EnDeCrypt(email, npass, 1)
SQL="SELECT * FROM registeredusers WHERE LO_enabled=True AND LO_deleted=False AND TA_email='"&emailcheck&"'"

Set rec=connection.execute(SQL)

If rec.eof Then
	Response.write"EMAIL"
	Response.end
End if


fbid=rec("TA_fbid")

If setId<>fbid Then
	SQL="UPDATE registeredusers SET TA_fbid='"&fbid&"' WHERE LO_enabled=True AND TA_email='"&emailcheck&"'"
	Set rec=connection.execute(SQL)

	Response.write"RECHECK"
	Response.end
End If


gname=rec("TA_nome")
sname=""
If Len(gname)>0 Then sname=Mid(gname,1,1)
Session("logged_donator")=rec("ID")
Session("islogged"&numproject)="hdzufzztKJ89ei"
Session("logged_name")=gname&" "&rec("TA_cognome")
Session("logged_name_short")=sname&"."&rec("TA_cognome")
Session("p_favorites")=rec("TX_favorites")
Session("projects_promoter")=rec("LO_projects")
Session("promoter_last_login")=rec("DT_last_login")
SQL="UPDATE registeredusers SET DT_last_login=Now() WHERE ID="&rec("ID")
Set rec=connection.execute(SQL)

Response.write "OK"

connection.close%>