<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->


<%

ref=request("ref")
ref1=request("ref1")

conferma=request("conferma")


if Len(conferma)>0 then

SQL1="DELETE * FROM defsections WHERE CO_oggetti_="&ref1&" AND CO_oggetti="&ref
set recordset1=connection.execute(SQL1)

SQL="select * from defsections where CO_oggetti_="&ref1
set recordset=connection.execute(SQL)

if recordset.eof then
SQL="UPDATE oggetti set lo_pubblica=False, lo_deleted=True where ID="&ref1
//set recordset3=connection.execute(SQL)
alerta="alert('PAGE MOVED TO RECYCLE BIN'); "
else
alerta="alert('PAGE STILL PUBLISHED ON ANOTHER SECTION');"
end if


%>
<html><body>
<script type="text/javascript">
parent.document.location="main.asp?viewMode=edit_page.asp";
</script>
</body></html><%


else
%>
<script language="Javascript" src="./main_lang/langedit_<%=Session("adminlanguageactive")%>.js"></script>
<body style="font-family:verdana; font-size:10px" bgcolor=#EFEFEF><center>
<center>
<br><script>document.write(txt64c);</script><br><br>
<input type=button id=mybt1 value="CANCEL" onclick="parent.closeDial('upl_sezioni');"><br><bR><input id=mybt2 type=button value="DELETE REFERENCE TO SECTION" onclick="document.location='del_ass_tipo.asp?ref=<%=ref%>&ref1=<%=ref1%>&conferma=True';">
<script>
document.getElementById("mybt1").value=txt62;
document.getElementById("mybt2").value=txt64d;
</script>
<%end if%>
