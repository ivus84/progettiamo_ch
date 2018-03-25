<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche.asp"-->
<!--#INCLUDE VIRTUAL="./incs/load_language_notif.asp"-->
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

pwd0=email&numproject&Session("logged_donator")&now()

Dim ObjSHA1

Set ObjSHA1 = New clsSHA1
StrDigest = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing

SQL="SELECT TA_email FROM registeredusers WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)
oldemail=rec("TA_email")

SQL="UPDATE registeredusers SET TA_email_new='"&email&"', TA_confcode='"&StrDigest&"' WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)


HTML=str_txt_notifica_body&chr(10) & str_notifica_modemail &chr(10)& str_txt_notifica_body_end
HTML=replace(HTML,"#StrDigest#",StrDigest)

mailsubject=str_subject_modemail

If Not mailSendDisabled Then
oldemail = EnDeCrypt(oldemail, npass, 2)

sendto=email
sendtobcc=oldemail

Response.codepage = 65001

%>
<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
<%
End if

Response.write "OK"
End if
connection.close%>