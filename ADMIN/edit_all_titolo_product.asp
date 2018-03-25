<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

ref=request("idfile")
titolo = request("titolo")
ordine = request("ordine")
pagina=request("pagina")


if len(titolo)>0 then
titolo=replace(titolo,"'","&#39;")


SQL="UPDATE fails_prodotti set TA_titolo='"&titolo&"' WHERE ID="&ref
set recordset=connection.execute(SQL)
if len(ordine)>0 AND IsNumeric(ordine)=True then
SQL="UPDATE fails_prodotti set IN_ordine="&ordine&" WHERE ID="&ref
set recordset=connection.execute(SQL)

end if
end if


da="files_products.asp?pagina="&pagina
response.redirect(""&da)
response.end
connection.close%>