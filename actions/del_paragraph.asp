<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
load=request("load")
refb=request("refb")
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
	If Not rec.eof Then
	
	SQL="SELECT * FROM p_description WHERE CO_p_projects="&load&" AND ID="&refb
	Set rec=connection.execute(SQL)

	mode=rec("TA_type")
	fname=rec("AT_file")

	SQL="DELETE FROM p_description where CO_p_projects="&load&" AND ID="&refb
	Set rec=connection.execute(SQL)

		If mode="download" Then

		Set fs=Server.CreateObject("Scripting.FileSystemObject")
		uploadsDirVar1=projectspath&fname
			if fs.FileExists(uploadsDirVar1) then
			fs.DeleteFile(uploadsDirVar1)
			end If
		Set fs=nothing


		End if
	End if

End if
connection.close%>