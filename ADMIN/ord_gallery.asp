<%
response.expires = -1500
response.AddHeader "PRAGMA", "NO-CACHE"
response.CacheControl = "PRIVATE"
%>
<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
ref=request("ref")
ord=request("ord")
mode=request("mode")
gallery=request("gallery")

SQL="SELECT COUNT(associa_galleries_immagini.ID) as totimg from associa_galleries_immagini INNER JOIN immagini ON immagini.ID=associa_galleries_immagini.CO_immagini WHERE CO_galleries="&gallery
set record=connection.execute(SQL)
totimg=record("totimg")



	if mode=0 then
	SQL="SELECT * FROM associa_galleries_immagini WHERE CO_galleries="&gallery&" AND IN_ordine<"&ord&" ORDER BY IN_ordine DESC"
	set record1=connection.execute(SQL)


		if not record1.eof then
		ref1=record1("ID")
		ord1=ord
		SQL="UPDATE associa_galleries_immagini SET IN_ordine="&ord1&" WHERE ID="&ref1
		set record1=connection.execute(SQL)
		end if

	ord=ord-1
		if ord>0 then
		SQL="UPDATE associa_galleries_immagini SET IN_ordine="&ord&" WHERE ID="&ref
		set record1=connection.execute(SQL)
		end if

	end if


	if mode=1 then
	SQL="SELECT * FROM associa_galleries_immagini WHERE CO_galleries="&gallery&" AND IN_ordine>"&ord&" ORDER BY IN_ordine ASC"
	set record1=connection.execute(SQL)


		if not record1.eof then
		ref1=record1("ID")
		ord1=ord

		if ord1>0 then
		SQL="UPDATE associa_galleries_immagini SET IN_ordine="&ord1&" WHERE ID="&ref1
		set record1=connection.execute(SQL)
		end if
		end if

	ord=ord+1
		if ord<=totimg then
		SQL="UPDATE associa_galleries_immagini SET IN_ordine="&ord&" WHERE ID="&ref
		set record1=connection.execute(SQL)
		end if

	end if



Randomize
MyNewRandomNum = (Rnd * 10000)+1
response.redirect("galleryShow.asp?refgallery="&gallery&"&ssid="&MyNewRandomNum)
connection.close
response.end
%>