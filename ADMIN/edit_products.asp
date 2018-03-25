<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

ref=request("idfile")
TA_linea = request("TA_linea")
TA_codice = request("TA_codice")
TA_nome = request("TA_nome")
TA_peso = request("TA_peso")

if len(TA_nome)>0 then TA_nome=replace(TA_nome,"'","&#39;")
if len(TA_codice)>0 then TA_cognome=replace(TA_codice,"'","&#39;")
if len(TA_linea)>0 then TA_peso=replace(TA_linea,"'","&#39;")


SQL="UPDATE products set TA_nome='"&TA_nome&"',TA_codice='"&TA_codice&"',TA_linea='"&TA_linea&"' WHERE ID="&ref
response.write SQL
set recordset=connection.execute(SQL)


da=request("da")
response.redirect(""&da)
response.end
connection.close%>