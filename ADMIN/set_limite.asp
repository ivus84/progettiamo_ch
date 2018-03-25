<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

ref=request("ref1")
limita=request("limita")



SQL="SELECT * FROM limita_contenuti WHERE CO_utenticantieri="&ref&" AND CO_oggetti="&limita
set recordset=connection.execute(SQL)

if recordset.eof AND len(limita)>0 then

SQL="INSERT INTO limita_contenuti (CO_oggetti,CO_utenticantieri) VALUES ("&limita&","&ref&")"
set recordset=connection.execute(SQL)



end if


response.redirect("cantiere_utente.asp?ref1="&ref)


connection.close%>