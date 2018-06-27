<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche_it.asp"-->

<%
Response.CharSet = "ISO-8859-1"
Response.CodePage = 28591
getform=request.form
getform = convertfromutf8(getform)
If Len(getform)>0 Then 
If Len(getform)>0 Then getform=Replace(getform,"+"," ")
If Len(getform)>0 Then getform=Replace(getform,"%40","@")
If Len(getform)>0 Then getform=Replace(getform,"%2F","/")


getform=Split(getform,"&")
email=request("TA_email")
If Len(email)>0 Then email=lcase(email)
emailclean=email

email = EnDeCrypt(email, npass, 1)

SQL="SELECT * FROM registeredusers WHERE TA_email='"&email&"' OR TA_email_recupero='"&email&"'"
Set rec=connection.execute(SQL)

If Not rec.eof Then
    Response.write"Exist"
    Response.end
End if

checkpass=request("TA_password")
pwd0=checkpass&numproject

Dim ObjSHA1

Set ObjSHA1 = New clsSHA1
StrDigest = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing

pwd0=email&numproject&checkpass&now()

Set ObjSHA1 = New clsSHA1
StrDigest1 = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing

encryptedFields="TA_email,TA_telefono,TA_natel"

SQL="INSERT INTO registeredusers ("
SQL1=" VALUES ("
For x=0 To Ubound(getform)
	gtval=getform(x)
	gtval=Split(gtval,"=")
	nval=gtval(0)
	vval=gtval(1)

	If Mid(nval,1,3)="TA_" And nval<>"TA_password" And nval<>"TA_password_1" Then 
		If Len(vval)>0 Then vval=Replace(vval,"'","''")
		If vval="ente/ragione sociale" Then vval=""
		SQL=SQL&nval&", "

		If InStr(encryptedFields,nval) Then 
			if nval="TA_email" then
				vval = EnDeCrypt(emailclean, npass, 1)
			else 
				'response.write nval
				'response.write vval
				vval = URLDecode(vval)
				vval = EnDeCrypt(vval, npass, 1)
			end if
		
		Else
			vval = URLDecode(vval)
		End if
		SQL1=SQL1&"'"&vval&"', "
	End if


	If Mid(nval,1,3)="CO_" Then 
	SQL=SQL&nval&", "
	SQL1=SQL1&""&vval&", "
	End if

	If Mid(nval,1,3)="DT_" Then 
	vvalg=split(vval,".")
	SQL=SQL&nval&", "
	SQL1=SQL1&"#"&vvalg(1)&"/"&vvalg(0)&"/"&vvalg(2)&"#, "
	End if


Next

logginDonation=Session("project_wanted")&"#"&Session("chf_wanted")
If Len(Session("langref"))=0 Then Session("langref")="it"
If Len(Session("lang"))=0 Then Session("lang")=0

SQL=SQL&"LO_enabled,TA_password,TA_confcode,TA_logging_donation,TA_lang,CO_lingue,TA_lang_notif)"
SQL1=SQL1&"False,'"&StrDigest&"','"&StrDigest1&"','"&logginDonation&"','"&Session("langref")&"',"&Session("lang")&",'"&Session("langref")&"')"
SQL=SQL&SQL1

Set rec=connection.execute(SQL)

HTML=str_txt_notifica_body&chr(10) & str_notifica_signup &chr(10)& str_txt_notifica_body_end
HTML=replace(HTML,"#StrDigest#",StrDigest1)

mailsubject=str_subject_signup

If Not mailSendDisabled Then
sendto=emailclean
%>
<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
<%
End if
Response.write "OK"
End if

connection.close%>