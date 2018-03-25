<%
if len(request("lang"))>0 then
Session("lang")=request("lang")
Session("reflang")=""
if Session("lang")>0 then Session("reflang")="_"&Session("lang")
end if

if len(Session("lang"))=0 OR isNull(Session("lang"))=True then
Session("reflang")
SQL1="SELECT * FROM lingue WHERE LO_main=True"
set record=connection.execute(SQL1)

if not record.eof then
Session("lang")=record("IN_valore")
Session("nomelang")=record("TA_nome")
Session("mainlang")=record("IN_valore")
Session("reflang")="_"&Session("lang")
else
SQL1="SELECT * FROM lingue WHERE LO_attiva=True ORDER BY IN_ordine ASC"
set record=connection.execute(SQL1)
if not record.eof then
Session("lang")=record("IN_valore")
Session("nomelang")=record("TA_nome")
Session("mainlang")=record("IN_valore")
Session("reflang")="_"&Session("lang")
else
Response.write "No active content languages found, please check the Languages configuration"
response.end
end if
end if

else

SQL1="SELECT TA_nome,TA_nomev FROM lingue WHERE ID="&Session("lang")+1
set record=connection.execute(SQL1)

Session("nomelang")=record("TA_nome")
Session("nomelangv")=record("TA_nomev")

end if

if Session("lang")=0 then Session("reflang")=""

SQL00="SELECT lingue.* FROM limita_lingue INNER JOIN lingue ON lingue.ID=limita_lingue.CO_lingue WHERE lingue.LO_attiva=True AND limita_lingue.CO_utenticantieri="&Session("IDuser")&" ORDER BY lingue.LO_main, lingue.IN_ordine ASC"
set recordset00=connection.execute(SQL00)

if not recordset00.eof then
limitedlanguage=True
Session("lang")=recordset00("IN_valore")
Session("nomelang")=recordset00("TA_nome")
Session("nomelangv")=recordset00("TA_nomev")
end if

if IsNull(Session("reflang"))=True then Session("reflang")=""

if Session("mainlang")<>0 then
Session("refmainlang")="_"&Session("mainlang")
else
Session("refmainlang")=""
end if
%>