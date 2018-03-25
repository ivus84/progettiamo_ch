<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

ref=request("ref")
SQL="SELECT lingue.* FROM lingue WHERE lingue.LO_main=True"
set rec=connection.execute(SQL)
if not rec.eof then
refmain=rec("IN_valore2")
if len(refmain)>0 then refmainlang="_"&refmain
end if



SQL="SELECT TA_nome"&refmainlang&" AS TA_nome,TX_testo"&refmainlang&" AS TX_testo from oggetti WHERE ID="&ref
set rec=connection.execute(SQL)

SQL="UPDATE oggetti set TA_nome"&Session("reflang")&"='"&rec("TA_nome")&"',TX_testo"&Session("reflang")&"='"&rec("TX_testo")&"' WHERE ID="&ref
set rec=connection.execute(SQL)

response.redirect("main.asp?viewmode=edit_page.asp")
response.end
connection.close%>