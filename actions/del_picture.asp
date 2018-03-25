<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
load=request("load")
refb=request("refb")
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
	If Not rec.eof Then
	
	SQL="SELECT * FROM p_pictures WHERE CO_p_projects="&load&" AND ID="&refb
	Set rec=connection.execute(SQL)

	fname=rec("AT_file")

	SQL="DELETE FROM p_pictures where CO_p_projects="&load&" AND ID="&refb
	Set rec=connection.execute(SQL)

		Set fs=Server.CreateObject("Scripting.FileSystemObject")
		uploadsDirVar1=projectspath&fname
			if fs.FileExists(uploadsDirVar1) then
			fs.DeleteFile(uploadsDirVar1)
			end If
		Set fs=nothing

	End if

End if
connection.close%>