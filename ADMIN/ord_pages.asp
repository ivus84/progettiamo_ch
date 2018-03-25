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
section=request("section")

SQL="SELECT IN_ordine from oggetti WHERE ID="&ref
set record=connection.execute(SQL)
prevord=record("IN_ordine")

mode=0
if prevord<cint(pos) then mode=1

SQL="SELECT COUNT(ID) as totpage from newsection WHERE CO_oggetti="&section
set record=connection.execute(SQL)
totpage=record("totpage")

if cint(pos)>totpage then pos=totpage

'if prevord<>cint(pos) then


SQL="UPDATE oggetti SET IN_ordine="&pos&" WHERE ID="&ref
set record1=connection.execute(SQL)


	if mode=1 then

	SQL="SELECT * FROM newsection WHERE CO_oggetti="&section&" AND ID <>"&ref&" AND IN_ordine<="&pos&" AND IN_ordine>="&prevord&" ORDER BY IN_ordine ASC"
	set record1=connection.execute(SQL)

xpos=pos
		do while not record1.eof
		ref1=record1("ID")
		ord1=record1("IN_ordine")
		xpos=xpos-1
		if xpos<=0 then xpos=1
		
		SQL="UPDATE oggetti SET IN_ordine="&xpos&" WHERE ID="&ref1
		set record2=connection.execute(SQL)
		record1.movenext
		loop


	else

	SQL="SELECT * FROM newsection WHERE CO_oggetti="&section&" AND ID <>"&ref&" AND IN_ordine>="&pos&" AND IN_ordine<"&prevord&" ORDER BY IN_ordine ASC"
	set record1=connection.execute(SQL)

xpos=pos

		do while not record1.eof
		ref1=record1("ID")
		ord1=record1("IN_ordine")
		xpos=xpos+1
		if xpos<=0 then xpos=1
		
		SQL="UPDATE oggetti SET IN_ordine="&xpos&" WHERE ID="&ref1
		set record2=connection.execute(SQL)
		record1.movenext
		loop


	end if
'end if

connection.close
response.end
%>