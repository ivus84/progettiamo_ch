<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->

<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->

<img src=images/edcolors.gif  border=0 align=right>Admin Text Styles</td></tr>
<tr><td class=testo style=padding-left:20px>
<%
SQL="SELECT * FROM STILI ORDER BY IN_ordine,TA_nome ASC"
set record=connection.execute(SQL)

do while not record.eof
ref=record("ID")
nome=record("TA_nome")
%>
<li> <a class=macrosezione href=edit.asp?tabella=stili&da=styles&pagina=<%=ref%>><%=nome%></a><br>
<%
record.movenext
loop%>
<br>
</body>
</html>



