<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->
<!--#INCLUDE VIRTUAL="./incs/load_language_notif.asp"-->

<%
If Len(Session("logged_donator"))>0 Then


pwd0="accountCancelRequest"&numproject&Session("logged_donator")&now()

Dim ObjSHA1

Set ObjSHA1 = New clsSHA1
StrDigest = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing

SQL="SELECT TA_email FROM registeredusers WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)
email=rec("TA_email")

SQL="UPDATE registeredusers SET TA_confcode='"&StrDigest&"' WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)

email = EnDeCrypt(email, npass, 2)

Response.codepage = 65001

HTML=str_txt_notifica_body&chr(10) & str_notifica_delaccount &chr(10)& str_txt_notifica_body_end
HTML=replace(HTML,"#StrDigest#",StrDigest)

mailsubject=str_subject_delaccount

If Not mailSendDisabled Then


sendto=email
%>
<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
<%
End if

Response.write "OK"
End if
connection.close%>