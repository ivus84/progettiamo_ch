<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_language_vars.asp"-->

<%
getcode=request.querystring
If Len(getcode)>0 Then 

SQL="SELECT * FROM registeredusers WHERE LO_enabled=True AND TA_confcode='"&getcode&"'"
Set rec=connection.execute(SQL)

'Response.write SQL
	If rec.eof Then
	Response.write"<html><body style=""margin:10%;font-family:arial""><p><b>progettiamo.ch</b><br/><br/>"&str_confirm_email_error&"</p></body></html>"
	Response.end
	End if

uref=rec("ID")
newmail=rec("TA_email_new")
oldmail=rec("TA_email")
pprojects=rec("LO_projects")


SQL="UPDATE registeredusers SET TA_confcode='',LO_enabled=False,TA_password='',LO_deleted=True,LO_no_notifica=True,LO_projects=False,TA_email_new='"&oldmail&"',TA_email='' WHERE ID="&uref
Set rec=connection.execute(SQL)

SQL="SELECT * FROM associa_registeredusers_projects WHERE CO_registeredusers="&uref
Set rec=connection.execute(SQL)

If rec.eof And pprojects=false Then
SQL="DELETE FROM registeredusers WHERE ID="&uref
Set rec=connection.execute(SQL)
End if

gotopage=site_mainurl

	session.abandon
	Response.write"<html><body style=""margin:10%;font-family:arial""><p><b>progettiamo.ch</b><br/><br/>"&str_confirm_delete_account&".<br/><br/><a href="""&gotopage&""" style=""color:#ff0000"">"&str_continua_su&" progettiamo.ch</a></p><script type=""text/javascript"">setTimeout(function() {document.location='"&gotopage&"'},3000)</script></body></html>"
	Response.end

End if
connection.close%>