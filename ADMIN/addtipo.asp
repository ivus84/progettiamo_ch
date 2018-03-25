<%


ref1=request("ref1")
ref=request("ref")


if ref<>"0" AND ref1<>"0" then
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
SQL="SELECT * FROM defsections WHERE CO_oggetti="&ref1&" AND CO_oggetti_="&ref
set recordset=connection.execute(SQL)

if recordset.eof then

SQL="SELECT * FROM defsections WHERE CO_oggetti=0 AND CO_oggetti_="&ref
set recordset=connection.execute(SQL)
if not recordset.eof then
SQL="DELETE * FROM defsections WHERE CO_oggetti=0 AND CO_oggetti_="&ref
set recordset=connection.execute(SQL)
end if

SQL="INSERT INTO defsections (CO_oggetti,CO_oggetti_) values ("&ref1&","&ref&")"
set recordset=connection.execute(SQL)

end if

end if



connection.close
%>
<html><body>
<script type="text/javascript">
parent.document.location="main.asp?viewmode=edit_page.asp";
</script>
</body></html>