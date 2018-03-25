<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

sel0=request("sel0")
sel1=request("sel1")
sel2=request("sel2")
sel3=request("sel3")
sel4=request("sel4")

if Len(sel0)=0 then
sel0=0
end if

if Len(sel1)=0 then
sel1=0
end if

if Len(sel2)=0 then
sel2=0
end if

if Len(sel3)=0 then
sel3=0
end if

if Len(sel4)=0 then
sel4=0
end if


%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->

 <div id="content_page" style="position:absolute;left:180px;top:20px;width:600px">

<form name="form1" method="POST" action="ordina_sezioni1.asp">

<table width=100% border=0 align=left cellpadding=0 cellspacing=0>

<tr><td class="testoadm" width=30% valign=top nowrap>
<font class="titolo"><b><script>document.write(txt6b);</script></b></font><br><br>
<table width=100% cellspacing=0 cellpadding=4 border=0>
<%

SQL="SELECT ID, IN_ordine,newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE LO_deleted=False AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordset=connection.execute(SQL)

i=0
do while not recordset.eof
i=i+1
recordset.movenext
loop
recordset.movefirst

n=0
do while not recordset.eof
nome=recordset("TA_nome")
pos=recordset("IN_ordine")
ref=recordset("ID")
%><tr><td class=testoadm nowrap>
<li class=testoadm><input type="hidden" name="ref<%=n%>" value="<%=ref%>"><b><%=nome%></b></td><td class=testoadm nowrap>&raquo;pos. <select class=formtext name="ord<%=n%>">
<%z=0
do while z<i+1
if z=pos then
selle=" selected"
else
selle=""
end if
%><option value="<%=z%>"<%=selle%>><%=z%></option>
<%z=z+1
loop%>
</select></tr>
<%
n=n+1
recordset.movenext
loop
%>
<input type="hidden" name="totalfield" value="<%=i%>">
<input type="hidden" name="sezio" value="<%=sezio%>">
<tr><td colspan=2 align=center><input type="button" value="&laquo; BACK" id="mybt1" class="formtext" onclick="document.location='main.asp?sel0=<%=sezio%>&sel1=<%=macrosezio%>';">&nbsp;<input type="submit" value="&raquo; SAVE" id="mybt2" class="formtext">
</table>
</td>
</tr></table>
<script>
document.getElementById("mybt1").value=back1;
document.getElementById("mybt2").value=save1;
</script>

</td>
</tR>



</table></div>
<input type="hidden" name="sel0" value="<%=sel0%>">
<input type="hidden" name="sel1" value="<%=sel1%>">
<input type="hidden" name="sel2" value="<%=sel2%>">
<input type="hidden" name="sel3" value="<%=sel3%>">
<input type="hidden" name="sel4" value="<%=sel3%>">

</form>
</body>
</html>



