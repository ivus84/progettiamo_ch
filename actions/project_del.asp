<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
load=request("load")
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
If Not rec.eof Then

pImg=rec("AT_main_img")
If Len(pImg)>0 Then
Set fs=Server.CreateObject("Scripting.FileSystemObject")
		uploadsDirVar1=projectspath&pImg
		if fs.FileExists(uploadsDirVar1) Then fs.DeleteFile(uploadsDirVar1)
Set fs=nothing
End If

pImg=rec("AT_banner")
If Len(pImg)>0 Then
Set fs=Server.CreateObject("Scripting.FileSystemObject")
		uploadsDirVar1=projectspath&pImg
		if fs.FileExists(uploadsDirVar1) Then fs.DeleteFile(uploadsDirVar1)
Set fs=nothing
End If


SQL="SELECT * FROM p_description WHERE CO_p_projects="&load
Set rec=connection.execute(SQL)
Do While Not rec.eof

afile=rec("AT_file")
refdesc=rec("ID")

If Len(afile)>0 Then
Set fs=Server.CreateObject("Scripting.FileSystemObject")
		uploadsDirVar1=projectspath&afile
		if fs.FileExists(uploadsDirVar1) Then fs.DeleteFile(uploadsDirVar1)
Set fs=nothing
End If

SQL="SELECT * FROM p_pictures WHERE CO_p_projects="&load&" AND CO_p_description="&refdesc
Set rec1=connection.execute(SQL)
Do While Not rec1.eof
afile=rec1("AT_file")
If Len(afile)>0 Then
Set fs=Server.CreateObject("Scripting.FileSystemObject")
		uploadsDirVar1=projectspath&afile
		if fs.FileExists(uploadsDirVar1) Then fs.DeleteFile(uploadsDirVar1)
Set fs=nothing
End If

rec1.movenext
loop


rec.movenext
loop


SQL="DELETE FROM p_description WHERE CO_p_projects="&load
Set rec=connection.execute(SQL)

SQL="DELETE FROM p_pictures WHERE CO_p_projects="&load
Set rec=connection.execute(SQL)

SQL="DELETE FROM p_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)


End if

Response.redirect("/myprojects/")
End if
connection.close%>