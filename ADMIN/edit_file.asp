<%
response.expires = -1500
response.AddHeader "PRAGMA", "NO-CACHE"
response.CacheControl = "PRIVATE"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

ref = request("idfile")
titolo = request("TA_titolo")
ordine = request("IN_ordine")

if IsEmpty(titolo)=False then
if len(titolo)>0 then titolo=replace(titolo,"'","&#39;")
SQL="UPDATE fails set TA_titolo='"&titolo&"' WHERE ID="&ref
set recordset=connection.execute(SQL)
end if

if IsEmpty(ordine)=False then
if len(ordine)>0 AND IsNumeric(ordine)=True then

	pos=cint(ordine)
	SQL="SELECT IN_ordine from associa_ogg_files WHERE CO_fails="&ref&" AND CO_oggetti="&session("ref")
	set record=connection.execute(SQL)
	prevord=record("IN_ordine")

	mode=0
	if prevord<pos then mode=1

	SQL="SELECT COUNT(ID) as totpage from associa_ogg_files WHERE CO_oggetti="&session("ref")
	set record=connection.execute(SQL)
	totpage=record("totpage")

	if pos>totpage then pos=totpage
	if prevord<>pos then


	SQL="UPDATE associa_ogg_files set IN_ordine="&pos&" WHERE CO_fails="&ref&" AND CO_oggetti="&session("ref")
	set recordset=connection.execute(SQL)

if mode=1 then

	SQL="SELECT * FROM associa_ogg_files WHERE CO_oggetti="&session("ref")&" AND CO_fails <>"&ref&" AND IN_ordine<="&pos&" AND IN_ordine>"&prevord&" ORDER BY IN_ordine ASC"
	set record1=connection.execute(SQL)


		do while not record1.eof
		ref1=record1("ID")
		ord1=record1("IN_ordine")
		ord1=ord1-1
		if ord1<=0 then ord1=1
		
		SQL="UPDATE associa_ogg_files SET IN_ordine="&ord1&" WHERE ID="&ref1
		set record2=connection.execute(SQL)
		record1.movenext
		loop


	else

	SQL="SELECT * FROM associa_ogg_files WHERE CO_oggetti="&session("ref")&" AND CO_fails <>"&ref&" AND IN_ordine>="&pos&" AND IN_ordine<"&prevord&" ORDER BY IN_ordine ASC"
	set record1=connection.execute(SQL)


		do while not record1.eof
		ref1=record1("ID")
		ord1=record1("IN_ordine")
		ord1=ord1+1
		if ord1<=0 then ord1=1
		
		SQL="UPDATE associa_ogg_files SET IN_ordine="&ord1&" WHERE ID="&ref1
		set record2=connection.execute(SQL)
		record1.movenext
		loop


	end if
end if

end if
end if

response.end
connection.close%>