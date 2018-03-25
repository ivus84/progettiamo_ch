<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->
<!--#INCLUDE VIRTUAL="/incs/load_language_vars.asp"-->
<%
getcode=request.querystring
If Len(getcode)>0 Then 

SQL="SELECT * FROM registeredusers WHERE LO_enabled=True AND TA_confcode='"&getcode&"'"
Set rec=connection.execute(SQL)

	If rec.eof Then
	Response.write"<html><body style=""margin:10%;font-family:arial""><p><b>progettiamo.ch</b><br/><br/>"&str_confirm_email_error&"</p></body></html>"
	Response.end
	End if

uref=rec("ID")
newmail=rec("TA_email_new")
oldmail=rec("TA_email")

emailcheck = EnDeCrypt(newmail, npass, 1)

SQL="SELECT ID from registeredusers  WHERE TA_email<>'"&oldmail&"' AND (TA_email='"&emailcheck&"' OR TA_email_recupero='"&emailcheck&"')"
Set rec=connection.execute(SQL)

If Not rec.eof Then
	Response.write"<html><body style=""margin:10%;font-family:arial""><p><b>progettiamo.ch</b><br/><br/>"&str_confirm_change_email_err&"</p></body></html>"
	Response.end
End if

SQL="UPDATE registeredusers SET TA_email='"&emailcheck&"',TA_confcode='',TA_email_new='' WHERE ID="&uref
Set rec=connection.execute(SQL)

gotopage=site_mainurl

	
	Response.write"<html><body style=""margin:10%;font-family:arial""><p><b>progettiamo.ch</b><br/><br/>"&str_confirm_change_email&"<br/><br/><a href="""&gotopage&""" style=""color:#ff0000"">"&str_continua_su&" progettiamo.ch</a></p><script type=""text/javascript"">setTimeout(function() {document.location='"&gotopage&"'},3000)</script></body></html>"
	Response.end

End if
connection.close%>