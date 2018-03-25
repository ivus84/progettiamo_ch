<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

ref=request("ref1")
ref0=request("ref0")
tipo=request("tipo")

if tipo="lingue" then
SQL="DELETE FROM limita_lingue WHERE CO_lingue="&ref0&" AND CO_utenticantieri="&ref
else
SQL="DELETE FROM limita_contenuti WHERE CO_oggetti="&ref0&" AND CO_utenticantieri="&ref
end if
set recordset=connection.execute(SQL)


response.redirect("cantiere_utente.asp?ref1="&ref)


connection.close%>