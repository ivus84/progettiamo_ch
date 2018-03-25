<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%nobg=True%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<%pagina=request("pagina")

if len(pagina)=0 then
response.end
end if

SQL="SELECT COUNT(ID) as allegati from fails_prodotti where CO_oggetti="&pagina
set recordset=connection.execute(SQL)
''response.write SQL

allegati=recordset("allegati")

if allegati>0 then
SQL1="SELECT * FROM fails_prodotti WHERE CO_oggetti="&pagina&" ORDER BY IN_ordine"
set recordset1=connection.execute(SQL1)
end if

title=request("title")
If Len(title)>0 Then Session("titp")=title

Session("product")=pagina
%>
<div style="float:right">
<input type="BUTTON" value="X CHIUDI" id="mybt1" class="testoadm" onclick="closeThis();">
</div>

<font color="#FF0000"><b><%=Session("titp")%> - Convocazioni</b></font><br/><br/>
<table border=0 cellpadding="0" cellspacing="0">
<tr><td class=testoadm colspan=4>
<form name="form1" action="makeUpload_or.asp" method="POST" EncType="multipart/form-data">
<input type="hidden" name="table" value="fails_prodotti"/>
<input type="hidden" name="fieldF" value="TA_nome"/>
<input type="hidden" name="connectTable" value=""/>
<input type="hidden" name="addFields" value="CO_oggetti,TA_titolo,TA_grandezza"/>
<input type="hidden" name="returnurl" value="files_products.asp?pagina=<%=pagina%>"/>

<p class=testoadm><b>Titolo</b>
<input type="text" class="testoadm" style="width:250px" maxlength="255" name="TA_titolo_1"> File&nbsp;<input type="hidden" name="CO_oggetti_1" value="<%=pagina%>"/>
<input type="file" name="File1" class=testoadm style="width:200px"> <input type="submit" value="UPLOAD" id="mybt2" class=testoadm style="width:90px">
</td></tr>
</form>


<%
if allegati>0 then%><table border=0><%
ii=1
do while not recordset1.eof
idfile=recordset1("ID")
TA_nome=recordset1("TA_nome")
TA_titolo=recordset1("TA_titolo")
TA_grandezza=recordset1("TA_grandezza")
IN_ordine=recordset1("IN_ordine")

if len(in_ordine)=0 OR isnull(in_ordine)=true then
in_ordine=ii
end if
if len(TA_titolo)>0 then
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"  "," ")
end if

if Len(TA_grandezza)>5 then

grande=Replace(TA_grandezza," ","")

if Len(grande)>0 then
grande=CInt(grande)
	If grande>1000 Then
	grande=CInt(grande/1000)&" MB"
	else
	grande=grande&" KB"
	End if
end if
end if
%>

<form name="formfile<%=ii%>" method="POST" action="edit_all_titolo_product.asp"><tr><td class=formtext><input type="text" name=titolo onchange="document.formfile<%=ii%>.submit();" size=20 maxlength=255 class=formtext value="<%=TA_titolo%>" style="width:205px"> ord.<input type="text" name=ordine onchange="document.formfile<%=ii%>.submit();" size=1 maxlength=2 class=testoadm value="<%=IN_ordine%>" style="width:18px; text-align:right">&nbsp;<a href="../download.asp?nome=<%=TA_nome%>" style="color:#00a0e3"><%=UCASE(right(TA_nome,3))%>&nbsp;<%=grande%></a>&nbsp;<a href="delFile.asp?vars=fails_prodotti,<%=idfile%>,,,<%=pagina%>,TA_nome,files_products.asp?pagina=<%=pagina%>"><img src=images/delete1.gif border=0 align=absmiddle></a></td></tr><input type=hidden name=idfile class=formtext value="<%=idfile%>"><input type=hidden name=pagina class=formtext value="<%=pagina%>"></form>
<%ii=ii+1
recordset1.movenext
loop%></table><%
end if%>
</td></tr>
</table>
<script type="text/javascript">

setTimeout("redimThis();",100);



</script>


