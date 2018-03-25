<%
response.expires = -1500
response.AddHeader "PRAGMA", "NO-CACHE"
response.CacheControl = "PRIVATE"
%>
<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

conferma=request("conferma")
mode=request("mode")
vars=request("vars")


vars=Split(vars,",")

tab=vars(0)
ref=vars(1)
cntTb=vars(2)
cntFl=vars(3)
cntVl=vars(4)
campo=vars(5)
urldest=vars(6)

SQL0="SELECT "&campo&" as nome from "&tab&" WHERE ID="&ref
set recordset0=connection.execute(SQL0)

If Not recordset0.eof then
nomefile=recordset0("nome")

If mode="update" Then
SQL="UPDATE "&tab&" SET "&campo&"='' WHERE ID="&ref
set recordset=connection.execute(SQL)

else
SQL="DELETE FROM "&tab&" WHERE ID="&ref
set recordset=connection.execute(SQL)

If Len(cntTb)>0 then
SQL1="DELETE * FROM "&cntTb&" WHERE CO_"&tab&"="&ref&" AND "&cntFl&"="&cntVl
set recordset1=connection.execute(SQL1)
End if

if tab="fails" then
	SQL="DELETE FROM associa_ogg_files WHERE CO_fails="&ref
	set recordset=connection.execute(SQL)
end if


End If

dim fs
Set fs=Server.CreateObject("Scripting.FileSystemObject")
uploadsDirVar=filespath&nomefile
if fs.FileExists(uploadsDirVar) then fs.DeleteFile(uploadsDirVar)

uploadsDirVar=imagespath&nomefile
if fs.FileExists(uploadsDirVar) then fs.DeleteFile(uploadsDirVar)

set fs=nothing
End if

Randomize
MyNewRandomNum = (Rnd * 10000)+1

if len(urldest)>0 then 
	if instr(urldest,"?")=0 then 
	urldest=urldest&"?"&MyNewRandomNum
	else
	urldest=urldest&"&"&MyNewRandomNum
	end if

response.redirect(urldest)
end if

connection.close
%>
