<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="/incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->
<%

SQL="SELECT * FROM utenticantieri WHERE LO_attivo=True AND LO_amministrazione=True AND (TA_login='"&request("user1")&"' OR TA_email='"&request("user1")&"') AND instr(TA_email,'@')"
set recordset=connection.execute(SQL)

if recordset.eof then
response.redirect("admin.asp?mode=not_Found")
response.end
end if

newPass=generatePassword(6)

pwd0=newPass&numproject

Dim ObjSHA1

Set ObjSHA1 = New clsSHA1
StrDigest = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing

refuser=recordset("ID")
email=recordset("TA_email")
login=recordset("TA_login")

SQL="UPDATE utenticantieri SET TA_password='"&StrDigest&"' WHERE LO_attivo=True AND LO_amministrazione=True AND ID="&refuser
set recordset=connection.execute(SQL)

sendto=email
mailsubject="DSm - reset password"
HTML = "<html><body style=""font-family:arial"">Nuova password per la gestione del sito web "&Request.ServerVariables("HTTP_HOST")&"<br/><br/>"
HTML = HTML &"Login: "&login&"<br/>"
HTML = HTML &"Nuova password: "&newPass&"<br/><br/>"
HTML = HTML &"Potete modificare la password all'interno del sistema di gestione dei contenuti<br/><br/>"
HTML = HTML &"Richiesta nuova password  effettuata il "&Now()&" da indirizzo ip: "&Request.ServerVariables ("REMOTE_ADDR")
HTML = HTML & "</body></html>"

'Response.write HTML
'Response.write StrDigest
If Not mailSendDisabled then%>
<!--#INCLUDE VIRTUAL="/incs/load_mailcomponents.asp"-->
<%
End if
response.redirect("admin.asp?mode=reset")
response.end
%>