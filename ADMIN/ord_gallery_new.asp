<%
response.expires = -1500
response.AddHeader "PRAGMA", "NO-CACHE"
response.CacheControl = "PRIVATE"
%>
<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
ref=request("ref")
pos=request("newpos")
gallery=request("gallery")

SQL="SELECT IN_ordine from associa_galleries_immagini WHERE ID="&ref
set record=connection.execute(SQL)
prevord=record("IN_ordine")

mode=0
if prevord<cint(pos) then mode=1

SQL="SELECT COUNT(associa_galleries_immagini.ID) as totimg from associa_galleries_immagini INNER JOIN immagini ON immagini.ID=associa_galleries_immagini.CO_immagini WHERE CO_galleries="&gallery
set record=connection.execute(SQL)
totimg=record("totimg")

if cint(pos)>totimg then pos=totimg

if prevord<>cint(pos) then


SQL="UPDATE associa_galleries_immagini SET IN_ordine="&pos&" WHERE ID="&ref
set record1=connection.execute(SQL)


	if mode=1 then

	SQL="SELECT * FROM associa_galleries_immagini WHERE CO_galleries="&gallery&" AND ID <>"&ref&" AND IN_ordine<="&pos&" AND IN_ordine>"&prevord&" ORDER BY IN_ordine ASC"
	set record1=connection.execute(SQL)


		do while not record1.eof
		ref1=record1("ID")
		ord1=record1("IN_ordine")
		ord1=ord1-1
		if ord1<=0 then ord1=1
		
		SQL="UPDATE associa_galleries_immagini SET IN_ordine="&ord1&" WHERE ID="&ref1
		set record2=connection.execute(SQL)
		record1.movenext
		loop


	else

	SQL="SELECT * FROM associa_galleries_immagini WHERE CO_galleries="&gallery&" AND ID <>"&ref&" AND IN_ordine>="&pos&" AND IN_ordine<"&prevord&" ORDER BY IN_ordine ASC"
	set record1=connection.execute(SQL)


		do while not record1.eof
		ref1=record1("ID")
		ord1=record1("IN_ordine")
		ord1=ord1+1
		if ord1<=0 then ord1=1
		
		SQL="UPDATE associa_galleries_immagini SET IN_ordine="&ord1&" WHERE ID="&ref1
		set record2=connection.execute(SQL)
		record1.movenext
		loop


	end if
end if


Randomize
MyNewRandomNum = (Rnd * 10000)+1
response.redirect("galleryShow.asp?refgallery="&gallery&"&ssid="&MyNewRandomNum)
connection.close
response.end
%>