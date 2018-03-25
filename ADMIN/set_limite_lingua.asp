<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

ref=request("ref1")
limita=request("limita1")



SQL="SELECT * FROM limita_lingue WHERE CO_utenticantieri="&ref&" AND CO_lingue="&limita
set recordset=connection.execute(SQL)

if recordset.eof AND len(limita)>0 then

SQL="INSERT INTO limita_lingue (CO_lingue,CO_utenticantieri) VALUES ("&limita&","&ref&")"
set recordset=connection.execute(SQL)



end if


response.redirect("cantiere_utente.asp?ref1="&ref)


connection.close%>