<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
ref=request("idfile")
titolo = request("titolo")
ordine = request("ordine")
grandezza = request("grandezza")
nome = request("nome")

if IsEmpty(nome)=False AND len(nome)>0 then
SQL="UPDATE fails set TA_nome='"&nome&"' WHERE ID="&ref
set recordset=connection.execute(SQL)
end if

if IsEmpty(titolo)=False then
if len(titolo)>0 then titolo=replace(titolo,"'","&#39;")
SQL="UPDATE fails set TA_titolo='"&titolo&"' WHERE ID="&ref
set recordset=connection.execute(SQL)
end if

if IsEmpty(grandezza)=False AND len(grandezza)>0 then
SQL="UPDATE fails set TA_grandezza='"&grandezza&"' WHERE ID="&ref
set recordset=connection.execute(SQL)
end if

if len(ordine)>0 AND IsNumeric(ordine)=True then
SQL="UPDATE associa_ogg_files set IN_ordine="&ordine&" WHERE CO_fails="&ref&" AND CO_oggetti="&session("ref")
set recordset=connection.execute(SQL)
end if

da=request("da")
if len(da)=0 then da="main.asp?viewmode=edit_page.asp&viewmode1=files"
response.redirect(""&da)
response.end

connection.close
%>