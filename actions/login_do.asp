<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
    Response.CharSet = "ISO-8859-1"
Response.CodePage = 28591
email=request("email")
password=request("password")
gotoloc=request("goto")


If Len(email)>0 Then 
email=LCase(email)
email = EnDeCrypt(email, npass, 1)
SQL="SELECT * FROM registeredusers WHERE LO_enabled=True AND LO_deleted=False AND TA_email='"&email&"'"
Set rec=connection.execute(SQL)

	If rec.eof Then
	Response.write"EMAIL"
	Response.end
	End if

checkpass=rec("TA_password")
pwd0=password&numproject

Dim ObjSHA1

Set ObjSHA1 = New clsSHA1
StrDigest = ObjSHA1.SecureHash(pwd0)
   
Set ObjSHA1 = Nothing

	If checkpass<>StrDigest Then

	Response.write"PASSWORD"
	Response.end
	End If


gname=rec("TA_nome")

'set rec = connection.execute("insert into logs(LogText,Data) values ('gname: "&gname&"','"&dton(Now)&"')")
sname=""
If Len(gname)>0 Then sname=Mid(gname,1,1)

Session.Timeout=120

Session("log45"&numproject)="none"
Session("logged_donator")=rec("ID")
Session("islogged"&numproject)="hdzufzztKJ89ei"
Session("logged_name")=gname&" "&rec("TA_cognome")
Session("logged_ente")=rec("TA_ente")
Session("logged_name_short")=sname&"."&rec("TA_cognome")
Session("p_favorites")=rec("TX_favorites")
Session("projects_promoter")=rec("LO_projects")
Session("promoter_last_login")=rec("DT_last_login")
Session("lang")=rec("CO_lingue")
Session("langref")=rec("TA_lang")

SQL="UPDATE registeredusers SET DT_last_login=Now() WHERE ID="&rec("ID")
Set rec=connection.execute(SQL)

If Session("projects_promoter")=True Then

	If Len(gotoloc)>0 And InStr(gotoloc,"/donate") Then
	gotoLoc=replace(gotoloc,"//progettiamo","//www.progettiamo")
	gotoLoc=replace(gotoloc,"http://","https://")
	Else
	gotoLoc="/myprojects/"
	End if


'Response.write "OKP"
Else 
	If Len(gotoloc)>0 Then
	gotoLoc=replace(gotoloc,"//progettiamo","//www.progettiamo")
	gotoLoc=replace(gotoloc,"http://","https://")
	End if
End If

Response.redirect(""&gotoLoc)

Else
Response.redirect("/login")
End If

connection.close%>