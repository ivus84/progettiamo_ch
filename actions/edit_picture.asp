<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
fval=request("fval")
fpro=request("fpro")
fref=request("fref")

If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE ID="&fpro&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
	If Not rec.eof Then
		If Len(fval)>0 Then fval=Replace(fval,"'","''")

		SQL="UPDATE p_pictures SET TA_nome='"&fval&"' WHERE CO_p_projects="&fpro&" AND ID="&fref
		Set rec=connection.execute(SQL)

	End if

End if
connection.close%>