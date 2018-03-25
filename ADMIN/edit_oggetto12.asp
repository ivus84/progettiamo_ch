<%
ref=Session("ref")

SQL8="SELECT COUNT(newsection.CO_oggetti) as contaover FROM newsection INNER JOIN oggetti on oggetti.ID=newsection.CO_oggetti WHERE newsection.ID="&ref&" AND IsNUll(newsection.CO_oggetti)=False AND newsection.CO_oggetti<>0"
set recordset8=connection.execute(SQL8)
contaover=recordset8("contaover")

SQL8="SELECT newsection.CO_oggetti, oggetti.TA_nome"&Session("reflang")&" as sopra FROM newsection INNER JOIN oggetti on oggetti.ID=newsection.CO_oggetti WHERE newsection.ID="&ref&" AND IsNUll(newsection.CO_oggetti)=False AND newsection.CO_oggetti<>0"
set recordset8=connection.execute(SQL8)

Sezioni="<b>Over pages</b>: <font class=testo style=""color:#00a0e3"">"

h=0
h=h+1
do while not recordset8.eof
Sopra=recordset8("sopra")
ref1=recordset8("CO_oggetti")
presez="<a href=""javascript:delTipo('del_ass_tipo.asp?ref="&ref1&"&ref1="&ref&"','','width=480,height=200');"">"
nomesez=Sopra
postsez="</a>"

if contaover>1 then
sezioni=sezioni&presez&nomesez&postsez&" | "
else
sezioni=sezioni&nomesez&" | "
end if
recordset8.movenext
loop

Sezioni=Sezioni&"</font>"
%>

<b>Definisci posizione pubblicazione</b><br/><br/>
Imposta come sottopagina di:
<form name="formp"><select name="newsectionref" id="selsections2" class="testoadm" style="width:220px" onchange="javascript:addTipo(<%=ref%>);">
<option value="0">...</option>
</select>
<br/></form>
<br/><font class="titoloadm">&darr;</font> <font class="testoadm">Selezionare il nome della sezione per eliminarla<br/><br/>
<%=sezioni%>
</font>
<br/><iframe id="upl_sezioni" src="" name=""  scrolling="no" style="position:relative; left:0px;top:5px;width:0px; height:0px; border:solid 0px #999999;overflow:visible;visibility:hidden;padding:0px;" frameborder="0"></iframe>

