<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "./admin/clsSHA-1.asp" -->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche.asp"-->
<!--#INCLUDE VIRTUAL="./incs/load_language_notif.asp"-->
<%
email=request("email")

emailcheck = EnDeCrypt(email, npass, 1)

SQL="SELECT * FROM registeredusers WHERE (TA_email='"&emailcheck&"' OR TA_email_recupero='"&emailcheck&"') AND LO_enabled=True"
set rec=connection.execute(SQL)

if rec.eof then
response.write"EMAIL"
response.end
end if
set getlangnotif=rec("TA_lang_notif")
    If getlangnotif="it" then
	%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_it.asp"-->
	<%elseif getlangnotif="fr" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_fr.asp"-->
	<%elseif getlangnotif="de" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_de.asp"-->
	<%elseif getlangnotif="en" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_en.asp"-->
	<%elseif getlangnotif="di" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche.asp"-->
    <%else%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche.asp"-->
	<%End if

pass=generatePassword(7)
pwd1=pass&numproject

Set ObjSHA1 = New clsSHA1
pwdck = ObjSHA1.SecureHash(pwd1)
Set ObjSHA1 = Nothing

SQL="SELECT TA_email FROM registeredusers WHERE (TA_email='"&emailcheck&"' OR TA_email_recupero='"&emailcheck&"') AND LO_enabled=True"
set rec=connection.execute(SQL)
mainmail=rec("TA_email")
mainmail = EnDeCrypt(mainmail, npass, 2)

SQL="UPDATE registeredusers set TA_password='"&pwdck&"',TA_password_iniziale='"&pass&"' WHERE (TA_email='"&emailcheck&"' OR TA_email_recupero='"&emailcheck&"') AND LO_enabled=True"
set rec=connection.execute(SQL)

Response.codepage = 65001

HTML=str_txt_notifica_body&chr(10) & str_notifica_retrpass &chr(10)& str_txt_notifica_body_end
HTML=replace(HTML,"#user_email#",mainmail)
HTML=replace(HTML,"#user_password#",pass)

mailsubject=str_subject_retrpass



if Not mailSendDisabled Then
sendto=email
%>
<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
<%
end if

response.write "OK"
response.end

connection.close
%>
