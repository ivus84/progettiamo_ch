<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->


<%

ref=request("pagina")
ref1=request("re1")
conferma=request("conferma")


if Len(conferma)>0 then

SQL0="SELECT * FROM newsection WHERE CO_oggetti="&ref
set recordset0=connection.execute(SQL0)


	if recordset0.eof then

if len(ref1)>0 then
	SQL1="DELETE * FROM defsections WHERE CO_oggetti_="&ref&" AND CO_oggetti="&ref1
	set recordset1=connection.execute(SQL1)
else
	SQL1="DELETE * FROM defsections WHERE CO_oggetti_="&ref
	set recordset1=connection.execute(SQL1)


end if




	SQL="select * from defsections where CO_oggetti<>0 AND CO_oggetti_="&ref
	set recordset=connection.execute(SQL)

''do while not recordset.eof
''response.write recordset("CO_oggetti_")
''recordset.movenext
''loop

''response.end
	if recordset.eof then

	SQL="UPDATE oggetti set lo_pubblica=False, lo_deleted=True where ID="&ref
	set recordset3=connection.execute(SQL)
	SQL1="DELETE * FROM defsections WHERE CO_oggetti_="&ref&" AND CO_oggetti=0"
	set recordset1=connection.execute(SQL1)
	end if




	response.redirect("main.asp")
	else
	response.write("<script>alert(""Unable to delete this page. Please delete all sub-pages from this page before delete-it"");")
	''response.write("parent.document.location='main.asp'; </script>")

	end if



else
%>
<body style="font-family:verdana" bgcolor="#efefef"><center>
<br><br><br><br>
<center>
Confermi l'eliminazione di questo elemento?<br/><br/>
<input type=button value="ANNULLA" id="mybt1" onclick="$('#mainEdit').html('');"> <input id="mybt2" type=button value="CONFERMA" onclick="document.location='del_section.asp?pagina=<%=ref%>&re1=<%=ref1%>&conferma=True';">

<%end if%>
