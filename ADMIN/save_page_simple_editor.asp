<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

TX_testo = request("myTextarea")
ref = request("ref")
lang = request("lang")

if Len(TX_testo)>0 then
TX_testo=replace(TX_testo,"\"&CHR(34),CHR(34))
TX_testo = Replace(TX_testo,  "'", "&#39;")
TX_testo = Replace(TX_testo,  "%22", CHR(34))
TX_testo = Replace(TX_testo,  "%20", " ")
''TX_testo = Replace(TX_testo,  "<p></p>", "")
''TX_testo = Replace(TX_testo,  "<P></P>", "")
TX_testo=replace(TX_testo,"&amp;","&")
end if

SQL="UPDATE oggetti SET TX_testo"&lang&"='"&TX_testo&"' WHERE ID="&ref
SET recordset=connection.execute(SQL)

mode=request("mode")

response.write "Salvando i dati"
''response.redirect("./edit_page.asp")

connection.close

response.end

%>