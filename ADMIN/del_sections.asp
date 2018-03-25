<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->


<%

refs=request("refs")
conferma=request("conferma")


if Len(conferma)>0 then

refs=Split(refs,",")
For x=1 To UBound(refs)
ref=refs(x)
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

	if recordset.eof then

	SQL="UPDATE oggetti set lo_pubblica=False, lo_deleted=True where ID="&ref
	set recordset3=connection.execute(SQL)
	SQL1="DELETE * FROM defsections WHERE CO_oggetti_="&ref&" AND CO_oggetti=0"
	set recordset1=connection.execute(SQL1)
	end if




	response.write("<script>")
	response.write("document.location='main.asp'; </script>")
	else
	response.write("<script>alert(""Unable to delete a page. Please delete all sub-pages from a page before delete-it"");")
	response.write("document.location='main.asp'; </script>")

	end if

Next

else
%>
<body style="font-family:verdana" bgcolor=#d4d0c8><center>
<script language="Javascript" src="./main_lang/langedit_<%=Session("adminlanguageactive")%>.js"></script>
<br><br><br><br>
<center>
<script>document.write(txt64);</script><br><br>
<input type=button value="CANCEL" id="mybt1" onclick="javascript:history.back();"> <input id="mybt2" type=button value="CONFIRM" onclick="document.location='del_sections.asp?refs=<%=refs%>&conferma=True';">
<script>
document.getElementById("mybt1").value=txt62;
document.getElementById("mybt2").value=txt65;
</script>

<%end if%>
