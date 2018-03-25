<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
ref=request("ref")
ord=request("ord")
mode=request("mode")
pagina=request("pagina")

SQL="SELECT COUNT(immagini_prodotti.ID) as totimg from immagini_prodotti WHERE CO_products="&pagina
set record=connection.execute(SQL)
totimg=record("totimg")



	if mode=0 then
	SQL="SELECT * FROM immagini_prodotti WHERE CO_products="&pagina&" AND IN_ordine<"&ord&" ORDER BY IN_ordine DESC"
	set record1=connection.execute(SQL)


		if not record1.eof then
		ref1=record1("ID")
		ord1=ord
		SQL="UPDATE immagini_prodotti SET IN_ordine="&ord1&" WHERE ID="&ref1
		set record1=connection.execute(SQL)
		end if

	ord=ord-1
		if ord>0 then
		SQL="UPDATE immagini_prodotti SET IN_ordine="&ord&" WHERE ID="&ref
		set record1=connection.execute(SQL)
		end if

	end if


	if mode=1 then
	SQL="SELECT * FROM immagini_prodotti WHERE CO_products="&pagina&" AND IN_ordine>"&ord&" ORDER BY IN_ordine ASC"
	set record1=connection.execute(SQL)


		if not record1.eof then
		ref1=record1("ID")
		ord1=ord

		if ord1>0 then
		SQL="UPDATE immagini_prodotti SET IN_ordine="&ord1&" WHERE ID="&ref1
		set record1=connection.execute(SQL)
		end if
		end if

	ord=ord+1
		if ord<=totimg then
		SQL="UPDATE immagini_prodotti SET IN_ordine="&ord&" WHERE ID="&ref
		set record1=connection.execute(SQL)
		end if

	end if




response.redirect("images_products.asp?pagina="&pagina)
connection.close
response.end
%>