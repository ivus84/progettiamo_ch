<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
''ON ERROR RESUME NEXT
tabella="products"

if len(Tabella)>0 Then Session("tabella")=tabella

tabella=Session("tabella")


titletop_en="Admin Projects"
titletop_de="Admin Produkte"
titletop_it="Gestione progetti"
titletop=Eval("titletop_"&langedit)

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
 <div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">

<b><%=titletop%></b>

<p>
<input type="button" class="titolo" style="width:200px; margin-left:15px" value="" id=mybt1 onclick="document.location='insert1.asp?TA_nome=%20Nuovo%20progetto&tabella=<%=tabella%>&da=products';"></p>
<script type="text/javascript">
document.getElementById("mybt1").value="Aggiungi progetto";
</script>

<font class="testoadm">
<%stringsearch=request("stringsearch")
SQL="SELECT "&tabella&".*,oggetti.TA_nome as ogg, collezione.TA_nome as coll FROM  ("&tabella&" LEFT JOIN oggetti ON "&tabella&".CO_oggetti = oggetti.ID) LEFT JOIN collezione ON "&tabella&".CO_collezione = collezione.ID"
if len(stringsearch)>0 then
SQL=SQL&" WHERE instr("&tabella&".TA_nome,'"&stringsearch&"')>0 OR  instr("&tabella&".TA_codice,'"&stringsearch&"')>0"
end if

SQL=SQL&" ORDER BY "&tabella&".TA_codice, "&tabella&".TA_nome ASC"
nofound_it="Nessun file trovato... <a href=""javascript:history.back()"" >&laquo; indietro</a>"
nofound_en="No files found... <a href=""javascript:history.back()"">&laquo; back</a>"
nofound_de="Anh&auml;nge nichts gefunden ... <br/><br/><a href=""javascript:history.back()"" >&laquo; Zurueck</a>"
nofound=Eval("nofound_"&langedit)


sPageURL = "products.asp"
iCurrentPage = Request("Page")
If iCurrentPage = "" Or Len(iCurrentPage)=0 Then iCurrentPage = 1
iPageSize = 6
sSQLStatement = SQL

Set RecordSet = Server.CreateObject("ADODB.Recordset")
RecordSet.PageSize = iPageSize
RecordSet.CacheSize = iPageSize
RecordSet.Open sSQLStatement, Connection, adOpenStatic, adLockReadOnly


if recordset.eof then
response.write nofound
else
RecordSet.AbsolutePage = iCurrentPage
Totale=RecordSet.RecordCount

''response.write "<tr><td class=""testoadm"" align=""center"">"
found_it="Lista "&totale&" risultati, pagina "&iCurrentPage&" di "&RecordSet.PageCount
found_en="Result list "&totale&", page "&iCurrentPage&" of "&RecordSet.PageCount
found_de=totale&" gefundenen Seiten, Seite "&iCurrentPage&" von "&RecordSet.PageCount
found=Eval("found_"&langedit)

cambia_de="AENDERN"
cambia_it="CAMBIA"
cambia_en="CHANGE"
cambia=Eval("cambia_"&langedit)

searchTxt_en="Search Born"
searchTxt_de="Newborn Suchen"
searchTxt_it="Cerca inserimento"
searchTxt=Eval("searchTxt_"&langedit)

response.write found&" - "


if RecordSet.PageCount>1 then
	if CInt(iCurrentPage) > 1 then
	iii=CInt(iCurrentPage)-1
	Response.Write "<a href=""" & sPageURL & "?Page=" & iii &"&stringsearch="&stringsearch&""" class=linkint>&laquo;</a>"
	else
	Response.Write "<img src=images/vuoto.gif border=0 align=absbottom>"
	end if
response.write "[&nbsp;"
	For i = 1 to RecordSet.PageCount
	If i = CInt(iCurrentPage) Then
	Response.Write "" & i & "&nbsp;"
	Else
	Response.Write "<a href=""" & sPageURL & "?Page=" & i &"&stringsearch="&stringsearch&""" class=linkint>" & i & "</a>&nbsp;"
	End If
	Next
response.write "&nbsp;]"

	if CInt(iCurrentPage) < RecordSet.PageCount then
	ii=CInt(iCurrentPage)+1
	Response.Write "<a href=""" & sPageURL & "?Page=" & ii &"&stringsearch="&stringsearch&""" class=linkint>&raquo;</a>"
	end if

end if

end if

if totale>0 then response.write "<div style=""position:absolute; left:260px; top:24px;"" class=""testoadm""><form name=""search"" method=""post"" action=""products.asp"">"&searchTxt&" <input type=""text"" name=""stringsearch"" value="""&stringsearch&""" class=""testoadm"" style=""width:180px;font-weight:bold""/><input type=""submit"" class=""testoadm"" value="">>""/></form></div>"


vedicampo_="TA_nome"

%>

<table width="250" cellpadding="2" cellspacing="0"><tr bgcolor="#FFFFFF"><%
hnr=0
intCurrentRecord = 1

uploadsDirVar=filespath


do While intCurrentRecord <= iPageSize
if not recordset.eof then
hnr=hnr+1
ID=recordset("ID")
vedicampo=Mid(recordset(""&vedicampo_), 1, 60)
namefile=recordset("TA_nome")
img1=recordset("AT_image")
classe="class='textarea2'"
editpage="edit.asp"
TA_codice=recordset("TA_codice")
TA_dimensioni=recordset("TA_dimensioni")
TA_linea=recordset("TA_linea")
TA_peso=recordset("TA_peso")
ogg=recordset("ogg")
coll=recordset("coll")

if len(vedicampo)>0 then vedicampo=Replace(vedicampo,"   ","")
if len(sesso)>0 then sesso=LCase(sesso)

imgv=""
if len(img1)>0 then imgv="<div style=""height:46px;margin-top:4px;width:83px;""><img class=""vImg"" src=""../images/loading.gif"" alt=""../img.asp?path="&img1&""" width=""25"" border=""0"" style=""float:center"" /></div>"


if colore="#EFEFEF" then
colore="#FFFFFF"
else
colore="#EFEFEF"
end if

%><form name="ffile<%=ID%>" id="ffile<%=ID%>" action="edit_products.asp" method="post">
	<input type="hidden" name="da" value="products.asp?page=<%=iCurrentPage%>&stringsearch=<%=stringsearch%>"/>
	<input type="hidden" name="idfile" value="<%=ID%>"/>
<tr bgcolor="<%=colore%>">
<td class="testoadm" width="100%" valign="top">
	<table width=100% style="border:solid 1px #999999" border=0 cellspacing=0 cellpadding=3>
	<tr><td class=testoadm>
	<div style="float:right;width:85px;height:85px; background-color: #c5c5c5; text-align:center;border:solid 1px #cccccc;padding:4px"><b>Immagine</b>
	<%if len(img1)>0 then%>
	<%=imgv%><br/>
	<a href="uplimg.asp?campo=AT_image&tabella=products&pagina=<%=id%>&file=<%=namefile%>" target="editing_page" onclick="setEditing();"><%=cambia%></a> - <a href="delFile.asp?mode=update&vars=products,<%=id%>,,,,AT_image,confirmUpload.asp" target="editing_page" onclick="setEditing();">DEL</a><%else%><br/><br/><br/><a href="uplimg.asp?campo=AT_image&tabella=products&pagina=<%=id%>&file=<%=namefile%>" target="editing_page" onclick="setEditing();">INSERISCI</a><%end if%></div>

	<div style="float:left"><b><%=ogg%>&nbsp;>&nbsp;<%=coll%></b><br/>
		Nome: <input type="text" name="TA_nome" value="<%=namefile%>" class="testoadm" style="margin-left:4px;width:90px;font-weight:bold" onchange="document.ffile<%=ID%>.submit();"/><br/>
Luogo: <input type="text" name="TA_codice" value="<%=TA_codice%>" class="testoadm" style="margin-left:2px;width:90px;font-weight:bold" onchange="document.ffile<%=ID%>.submit();"/>
	<br/>Anno/i: <input type="text" name="TA_linea" value="<%=TA_linea%>" class="testoadm" style="margin-left:0px;width:90px;font-weight:bold" onchange="document.ffile<%=ID%>.submit();"/>
<br/><br/>
	<img src="images/vuoto.gif" height="1" width="45"/>
	 <a href="edit.asp?tabella=<%=tabella%>&pagina=<%=ID%>" target="editing_page" onclick="setEditing();"><img src="images/edit.gif" border="0" alt="EDIT" title="EDIT"/></a>&nbsp;
	 <a href="del.asp?tabella=<%=tabella%>&pagina=<%=ID%>&da=products"><img src="images/delete1.gif" border="0" alt="DEL" title="DEL"/></a>&nbsp;	
	 <a href="images_products.asp?tabella=<%=tabella%>&pagina=<%=ID%>&amp;title=<%=namefile%>" target="editing_page" onclick="setEditing();"><img src="images/image.gif" border="0" alt="IMG" title="IMG" width="18" style="vertical-align:top;margin-top:-1px"/></a>&nbsp;
	 <a href="files_products.asp?tabella=<%=tabella%>&pagina=<%=ID%>&amp;title=<%=namefile%>" target="editing_page" onclick="setEditing();"><img src="images/downl.gif" border="0" alt="FILES" title="FILES" height="13" style="vertical-align:top;margin-top:0px"/></a></div>


	</td></tr>
	</table>
</td></tr>
</form>
<%

''if instr(hnr/2,".")=0 AND instr(hnr/2,",")=0 then
''response.write"</tr><tr bgcolor="""&colore&""">"
''end if
recordset.movenext
end if

intCurrentRecord=intCurrentRecord+1
loop
%>
</td></tr>

<tr><td>&nbsp;</td>
</tr>
<%connection.close%>
<tr><td colspan=2>&nbsp;
</td></tr></table>
<script type="text/javascript">
$("#editing_page").css("top","+=78");

function loadPds() {
setw=60;
$('.vImg').each(function(index, domEle) {


chkImg=$(domEle).attr("alt");

chkImg=chkImg+"&width=";
isfoto=chkImg+setw;
$(domEle).css('width',setw+'px');
$(domEle).attr('src',isfoto);

img = $('<img/>').load(function(){
imgHeight = this.height; imgWidth = this.width;
if (imgHeight>imgWidth)
{
newsetw=parseInt(setw / imgHeight * imgWidth);
$(domEle).css('width',newsetw+'px');
}
});

$(domEle).attr('src',isfoto);
img.attr("src", isfoto);



});
}

loadPds();
</script>

<form name="form2" action="products.asp?page=<%=iCurrentPage%>" method="POST"></form>
</body>
</html>

<%
response.end
%>

