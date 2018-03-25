<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<!-- #include VIRTUAL = "./admin/clsSHA-1.asp" -->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche.asp"-->
<!--#INCLUDE VIRTUAL="./incs/load_language_notif.asp"-->
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link media="all" type="text/css" href="/css/styles.1.css" rel="stylesheet" /></head><body style="background:#efefef;margin:15%">
<%
email=request("email")
confirm=request("confirm")

	emailCheck = EnDeCrypt(email, npass, 1)


if confirm="True" then
SQL="SELECT * FROM registeredusers WHERE TA_email='"&emailCheck&"'"

set rec=connection.execute(SQL)


if rec.eof then

response.write"<p class=""testo""><br/><br/>L'indirizzo e-mail indicato non risulta appartenere a nessuno degli utenti registrati, si prega di riprovare</p></body></html>"

response.end
end if

pass=generatePassword(7)
pwd1=pass&numproject

Set ObjSHA1 = New clsSHA1
pwdck = ObjSHA1.SecureHash(pwd1)
Set ObjSHA1 = Nothing

SQL="UPDATE registeredusers set TA_password='"&pwdck&"',TA_password_iniziale='"&pass&"' WHERE TA_email='"&emailCheck&"'"
set rec=connection.execute(SQL)


Response.codepage = 65001

HTML=str_txt_notifica_body&chr(10) & str_notifica_sendpass &chr(10)& str_txt_notifica_body_end
HTML=replace(HTML,"#user_email#",email)
HTML=replace(HTML,"#user_password#",pass)

mailsubject=str_subject_sendpass

sendto=email

if Not mailSendDisabled then
%>
<!--#INCLUDE virtual="./incs/load_mailcomponents.asp"-->
<%
end if

response.write("Password inviata a "&email)
response.end
else

response.write"<form action=""send_password.asp?confirm=True&email="&email&""" method=""POST""><center><p style=""font-family:arial""><br/>Inviare la password a "&email&"?<br/><br/><input type=""button"" value=""NO"" onclick=""history.back();""/> <input type=""submit"" value=""INVIA""/></form></p></body></html>"

end if

%>
