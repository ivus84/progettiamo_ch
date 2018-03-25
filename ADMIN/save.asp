<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

ref=request("ref")
mode=request("mode")
data = request("data_page")

lang=request("lang")
TA_password=request("TA_password")
TX_embed=request("TX_embed")
TX_abstract=request("TX_abstract")
CO_oggetti=request("CO_oggetti")
TA_duedate=request("TA_duedate")


SQL="SELECT lingue.* FROM limita_lingue INNER JOIN lingue ON lingue.ID=limita_lingue.CO_lingue WHERE lingue.LO_attiva=True AND limita_lingue.CO_utenticantieri="&Session("IDuser")&" ORDER BY lingue.LO_main, lingue.IN_ordine ASC"
set record_language=connection.execute(SQL)

if record_language.eof then
SQL="SELECT * FROM lingue WHERE LO_attiva=True ORDER BY TA_nomev, IN_valore ASC"
set record_language=connection.execute(SQL)
end if

do while not record_language.eof
vall=record_language("IN_valore")
vallv="_"&vall
if vall=0 then vallv=""

TA_nome=request("TA_nome"&vallv)
if Len(TA_nome)>0 then
TA_nome = Replace(TA_nome, "(","&#40;" )
TA_nome = Replace(TA_nome, ")","&#41;" )
TA_nome = Replace(TA_nome, "-","&#45;" )
TA_nome = Replace(TA_nome,  CHR(32) & CHR(32), "&nbsp;&nbsp;")
TA_nome = Replace(TA_nome,  "'", "&#39;")
TA_nome = Replace(TA_nome, CHR(34), "&quot;")
TA_nome = Replace(TA_nome, CHR(37), "&nbsp;")
End If

SQL="UPDATE oggetti SET TA_nome"&vallv&"='"&TA_nome&"' WHERE ID="&ref
SQLv=SQL
SET recordset=connection.execute(SQL)



TX_keywords=request("TX_keywords"&vallv)
if Len(TX_keywords)>0 Then TX_keywords = Replace(TX_keywords,  "'", "&#39;")

SQL="UPDATE oggetti SET TX_keywords"&vallv&"='"&TX_keywords&"' WHERE ID="&ref
SET recordset=connection.execute(SQL)

TA_linkto=request("TA_linkto"&vallv)
if Len(TA_linkto)>0 Then TA_linkto = Replace(TA_linkto,  "'", "&#39;")
if len(TA_linkto)>255 Then TA_linkto = Mid(TA_linkto, 1, 255)

SQL="UPDATE oggetti SET TA_linkto"&vallv&"='"&TA_linkto&"' WHERE ID="&ref
SET recordset=connection.execute(SQL)

record_language.movenext
loop

mSQL="UPDATE oggetti SET "

if isdate(data)=True Then
Addtvalue=TimeValue(Now())
mSQL=mSQL&"DT_data=#"&data& " "&addtvalue&"#, "
end if

''TA_linkto = Replace(TA_linkto,  CHR(10), "<br/>")
if len(TX_embed)>0 Then TX_embed = Replace(TX_embed,  "'", "&#39;")
if len(TX_abstract)>0 Then TX_abstract = Replace(TX_abstract,  "'", "&#39;")
if len(TA_duedate)>0 Then TA_duedate = Replace(TA_duedate,  "'", "")

if len(CO_oggetti)=0 or isnull(CO_oggetti) then CO_oggetti=0
if isnumeric(CO_oggetti) AND CO_oggetti>0 then 
mSQL=mSQL&"CO_oggetti="&CO_oggetti&","
else
mSQL=mSQL&"CO_oggetti=Null,"
end if

mSQL=mSQL&"TA_duedate='"&TA_duedate&"',TX_embed='"&TX_embed&"' WHERE ID="&ref
SET recordset=connection.execute(mSQL)


If mode="noredir" Then 
response.write"Salvando i dati"
Else
response.redirect("edit_page.asp?ref="&ref)
End if
connection.close

%>