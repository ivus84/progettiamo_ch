<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<%

sel0=request("sel0")
sel1=request("sel1")
sel2=request("sel2")
sel3=request("sel3")
sel4=request("sel4")
sel5=request("sel5")

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

if Len(sel5)=0 then
sel5=0
end if

refi=request("refi")

if Len(refi)>0 then
Session("refi")=refi
end if


if Len(Session("apertopanel"))=0 then
Scriva="onload=""window.open('panel.asp','','width=300,height=200,left=50,top=50');"" "
Session("apertopanel")="True"
else
scriva=""
end if

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->

<div id="content_page">

<p class="titolo"><script>document.write(menu3);</script></p>





<%
sPageURL = Request.ServerVariables("SCRIPT_NAME")
SQL="SELECT ID, IN_letto, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE LO_deleted=True AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordout=connection.execute(SQL)

if recordout.eof then
response.write"<br/><br/><script>document.write(txt17a);</script>"
else
response.write"<p><input type=""button"" class=""titolo"" style=""width:200px; margin-left:0px"" value="""" id=mybt1 onclick=""document.location='svuota_cestino.asp';""></p>"
end if

%>
<br/>
<table border="0">
<%
do while not recordout.eof

nomeoggetto=Mid(recordout("TA_nome"), 1, 80)
pubbl2=recordout("LO_pubblica")
letto=recordout("IN_letto")
ref=recordout("ID")

				if pubbl2=True then
				stile2="formtext2"
				else
				stile2="formtext4"
				end if

%>
<tr><td colspan=3 class=testoadm valign=top style="padding-left:0px; border-bottom: solid 1px #e1e1e1; width:290px">
&nbsp;<a href="del.asp?da=cestino&pagina=<%=ref%>&tabella=oggetti" target="editing_page" onclick="setEditing();"><img src="images/delete1.gif" border=0 alt="DELETE"></a>&nbsp;<b><a href="edit.asp?tabella=oggetti&pagina=<%=ref%>" target="editing_page" onclick="setEditing();" style="width:180px"><img src="images/new.gif">&nbsp;<%=nomeoggetto%></a></b>&nbsp;&nbsp;<a href="republish.asp?ref=<%=ref%>" class="teston" style="float:right"><script>document.write(txt18);</script></a><br/>
</td>
</tr>

<%
recordout.movenext
loop%>
</table></div>
</form>

<script type="text/javascript">
$(document).ready(function() {
$('.mMenu').not('.hMenu').eq(1).addClass('active');
$('#mybt1').val(txt17)
})
</script>
</body>
</html>