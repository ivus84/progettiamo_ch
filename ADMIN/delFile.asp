<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

conferma=request("conferma")
mode=request("mode")
vars=request("vars")


if Len(conferma)>0 then

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
End If

dim fs
Set fs=Server.CreateObject("Scripting.FileSystemObject")
uploadsDirVar=filespath&nomefile
if fs.FileExists(uploadsDirVar) then fs.DeleteFile(uploadsDirVar)

uploadsDirVar=imagespath&nomefile
if fs.FileExists(uploadsDirVar) then fs.DeleteFile(uploadsDirVar)

set fs=nothing
End if

''If InStr(urldest,"edit_galleries")>0 Then urldest="edit_oggetto1"
''response.end

If urldest="closedialog" then
%>
<html><body>
<script type="text/javascript">
parent.document.getElementById('editing_page').style.display="none";
parent.document.form2.submit();
</script>
</body></html>
<%
else
response.redirect(urldest)
End if


Else
nobg=True

gfrom=request.servervariables("HTTP_REFERER")
makeClose="history.back();" 

If InStr(gfrom,"/default.asp")>0 Then makeclose="openEdit('edit_page.asp')"
%>

<p style="text-align:center;font-size:14px;font-weight:bold;font-family:arial"><br/><br/>
<b>Confermi l'eliminazione di questo elemento?</b><br/><br/>
<br/><br/>
<input type=button value="ANNULLA" id="mybt1"  onclick="<%=makeClose%>"> <input id="mybt2"  type=button value="CONFERMA" onclick="document.location='delFile.asp?conferma=True&mode=<%=mode%>&vars=<%=vars%>';">
</p>

<%
end If

connection.close
%>
