<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
''ON ERROR RESUME NEXT
tabella="fails"

if len(Tabella)>0 then
Session("tabella")=tabella
end if
tabella=Session("tabella")


if tabella="fails" then
titletop_en="Admin Attachments"
titletop_de="Admin Anh&auml;nge"
titletop_it="Gestione File"
titletop=Eval("titletop_"&langedit)
end if

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
 <div id="content_page">
<p class="titolo"><%=titletop%></p>
<p>
<input type="button" class="titolo" style="width:200px; margin-left:0px" value="" id=mybt1 onclick="document.location='insert1.asp?TA_nome=%20NEW&TA_titolo=%20New%20File&tabella=<%=tabella%>&da=files';"></p>
<script type="text/javascript">
document.getElementById("mybt1").value="Aggiungi file";
</script>
<p class="testoadm">
<%
stringsearch=request("stringsearch")
sord=request("sord")
smode=request("smode")

if len(sord)>0 then session("sord")=sord
if len(smode)>0 then session("smode")=smode
if len(session("smode"))=0 then session("smode")="ID"
if len(session("sord"))=0 then session("sord")="DESC"

SQL="SELECT * FROM "&tabella
if len(stringsearch)>0 then SQL=SQL&" WHERE instr(TA_titolo,'"&stringsearch&"')>0"


SQL=SQL&" ORDER BY "&session("smode")&" "&session("sord")

nofound_it="Nessun file trovato"
nofound_en="No files found... <a href=""javascript:history.back()"">&laquo; back</a>"
nofound_de="Anh&auml;nge nichts gefunden ... <br/><br/><a href=""javascript:history.back()"" >&laquo; Zurueck</a>"
nofound=Eval("nofound_"&langedit)


sPageURL = "files.asp"
iCurrentPage = Request("Page")
If iCurrentPage = "" Or Len(iCurrentPage)=0 Then iCurrentPage = 1
iPageSize = 21
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

searchTxt_en="Search File"
searchTxt_de="Anhang Suchen"
searchTxt_it="Cerca file"
searchTxt=Eval("searchTxt_"&langedit)

sty_1="font-weight:normal"
sty_2="font-weight:normal"
sty_3="font-weight:normal"
sty_4="font-weight:normal"
if session("smode")="TA_titolo" then sty_1="font-weight:bold"
if session("smode")="ID" then sty_2="font-weight:bold"
if session("sord")="ASC" then sty_3="font-weight:bold"
if session("sord")="DESC" then sty_4="font-weight:bold"


wwrite="Ordina per <a href="""& sPageURL &"?stringsearch="&stringsearch&"&smode=TA_titolo"" style="""&sty_1&""">Nome</a> | <a href="""& sPageURL &"?stringsearch="&stringsearch&"&smode=ID"" style="""&sty_2&""">Data</a> | <a href="""& sPageURL &"?stringsearch="&stringsearch&"&sord=ASC"" style="""&sty_3&""">Ascendente</a> | <a href="""& sPageURL &"?stringsearch="&stringsearch&"&sord=DESC"" style="""&sty_4&""">Discendente</a>"
response.write wwrite&" - "&found&" - "


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

if totale>0 then response.write "<div style=""position:absolute; left:228px; top:26px;"" class=""testoadm""><form name=""search"" method=""post"" action=""files.asp"">"&searchTxt&" <input type=""text"" name=""stringsearch"" value="""&stringsearch&""" class=""testoadm"" style=""width:180px;font-weight:bold""/><input type=""submit"" class=""testoadm"" value="">>""/></form></div>"


vedicampo_="TA_nome"
if tabella="fails" then vedicampo_="TA_titolo"

%>

<div style="width:98%;position:relative; margin-top:10px;"><%
hnr=0
intCurrentRecord = 1

uploadsDirVar=filespath


do While intCurrentRecord <= iPageSize
if not recordset.eof then
hnr=hnr+1
ID=recordset("ID")
vedicampo=Mid(recordset(""&vedicampo_), 1, 60)
namefile=recordset("TA_nome")
classe="class='textarea2'"
editpage="edit.asp"
strFilePath=uploadsDirVar&recordset("TA_nome")

filetype=""
filesized=0
Set filesys = CreateObject("Scripting.FileSystemObject")
If (filesys.FileExists(strFilePath))=True then
Set f = filesys.GetFile(strFilePath)
datecreated=f.DateCreated
datemodified=f.DateLastModified
datemodified=DateValue(datemodified)
filetype=f.Type
filesized=f.size
filesized=Round(filesized/1000,0)
set filesys=nothing
set f=nothing
else
filetype="File not found"
end if

If IsNull(vedicampo)=False and instr(vedicampo,"   ")>0 Then 
vedicampo=Replace(vedicampo,"   ","")
vedicampo=Replace(vedicampo,"   ","")
vedicampo=Replace(vedicampo,"  "," ")
SQL="UPDATE fails SET TA_titolo='"&vedicampo&"' WHERE ID="&ID
set rec=connection.execute(SQL)
end if

If InStr(namefile,".") Then 
ext=LCase(mid(namefile,InStrRev(namefile,".")+1))
Else
ext=LCase(Right(namefile,3))
End If

imgico="generic"
videoextensions=" flv , wmv , rm , ram , rv , mov , qt , mp4 , mp2 , mpa , mpe , mpeg , mpg , mpv2 , m4v ,"
exts=" doc , docx , ppt , pps , pdf , zip , txt , psd , rar , mp3 , rtf , ai , htm , html , css , swf ,"
imgextensions=" jpg , peg , png , gif , bmp , tif , iff "
Isvid=False
	IF Instr(videoextensions, ext)<>0 THEN 
	imgico="mul.gif"
	Isvid=True
	End if
	
	IF Instr(imgextensions, ext)<>0 THEN imgico="img"
	IF Instr(videoextensions, ext)<>0 THEN imgico="mp4"
	IF Instr(exts, ext)<>0 THEN imgico=ext
	if ext="csv" then imgico="xls"


%><div style="position:relative;float:left;width:158px;min-height:120px;margin:0px 10px 10px 0px; padding:5px;overflow:hidden; border:solid 1px #e1e1e1;background:#fff; border-radius:10px; text-align:center">
<form id="file<%=ID%>_form" name="ffile<%=ID%>" action="edit_all_titolo.asp" method="post">

<input type="hidden" name="da" value="files.asp?page=<%=iCurrentPage%>&stringsearch=<%=stringsearch%>"/><input type="hidden" id="file<%=ID%>_name" name="nome" value=""/><input type="hidden" id="file<%=ID%>_size" name="grandezza" value=""/> <input type="hidden" name="idfile" value="<%=ID%>"/>

<img src="./exts/<%=imgico%>.png" style="width:64px; margin:-2px 5px 5px 0px"/><br/>
<textarea name="titolo" class="fileTitle" onchange="document.ffile<%=ID%>.submit();"><%=vedicampo%></textarea>
<br/><%=filetype%><br/><%=filesized%> KB - <%=datemodified%><br/>
<%if filetype<>"File not found" then%>
<%if Isvid=True then%>Emb: <input type="text" onclick="this.select()" style="width:123px;font-size:10px;height:11px; border:solid 1px #e1e1e1" value="<iframe src=/videoEmbed.asp?<%=namefile%> width=628 height=400 scrolling=no></iframe>"/>
<%else%>
<a href="/download.asp?file=<%=namefile%>" style="line-height:11px">/download.asp?file=<%=namefile%></a>
<%End if%>
<%end if%><br/><br/>
<div style="position:absolute; right:6px; top:43px;border-radius:8px; background:#999;padding:4px"><a href="javascript:delFile('mode=delete&vars=fails,<%=ID%>,,,,TA_nome,');" style="color:#fff;text-decoration:none"><script>document.write(txt65a);</script></a></div>

	<div align="right">
	<p id="file<%=ID%>_file" style="font-size:11px;margin:0px">File <input class="fileupload" id="file<%=ID%>" type="file" name="files[]" data-url="uploadJQuery.aspx" style="font-size:11px;"></p>
	<div class="barContain"><div class="bar" id="file<%=ID%>_bar" style="width: 0%;">&nbsp;uploading ...</div></div>
	</div>

</form>

<p style="padding:4px; background:#CCCCCC;margin:4px 0px 2px 0px;border-radius:8px;min-height:12px;" class="testoadm">
<%

langfile=""
if instr(namefile,".")>0 and len(namefile)>4 then
SQL="SELECT oggetti.TA_nome"&langfile&" as TA_nome, oggetti.ID, associa_ogg_files.CO_lingue from oggetti INNER JOIN associa_ogg_files ON oggetti.ID=associa_ogg_files.CO_oggetti WHERE associa_ogg_files.CO_fails="&ID&" UNION SELECT oggetti.TA_nome"&langfile&" as TA_nome, oggetti.ID, 0 as CO_lingue from oggetti WHERE Instr(TX_testo,'"&namefile&"')>0 UNION SELECT oggetti.TA_nome"&langfile&" as TA_nome, oggetti.ID, 1 as CO_lingue from oggetti WHERE Instr(TX_testo_1,'"&namefile&"')>0 UNION SELECT oggetti.TA_nome"&langfile&" as TA_nome, oggetti.ID, 2 as CO_lingue from oggetti WHERE Instr(TX_testo_2,'"&namefile&"')>0 UNION SELECT oggetti.TA_nome"&langfile&" as TA_nome, oggetti.ID, 3 as CO_lingue from oggetti WHERE Instr(TX_testo_3,'"&namefile&"')>0 UNION SELECT oggetti.TA_nome"&langfile&" as TA_nome, oggetti.ID, 4 as CO_lingue from oggetti WHERE Instr(TX_testo_4,'"&namefile&"')>0"



set record=connection.execute(SQL)

	if record.eof then%>File not published<%
	else
	nn=0
	do while not record.eof
	nomex=record("TA_nome")
	lang=record("CO_lingue")
	refx=record("ID")
	if lang=0 then langw="it"
	if lang=1 then langw="en"
	if lang=2 then langw="de"
	if lang=3 then langw="fr"
if len(nomex)>35 then nomex=Mid(nomex,1,32)&"..."
	if nn>0 then response.write "&nbsp;|&nbsp;" 
	response.write "<a href=""main.asp?viewMode=edit_page.asp?ref="&refx&"&lang="&lang&""" style=""text-decoration:underline;line-height:11px"">"&nomex&" ("&langw&")</a>"
	nn=nn+1
	record.movenext
	loop
	end if
end if%></p>
</div>
<%

if instr(hnr/2,".")=0 AND instr(hnr/2,",")=0 then
if colore="#EFEFEF" then
colore="#FFFFFF"
else
colore="#EFEFEF"
end if
response.write"</tr><tr bgcolor="""&colore&""">"
end if
recordset.movenext
end if

intCurrentRecord=intCurrentRecord+1
loop
%>
<%If loadUnused=True then%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_files.asp"-->
<%End if%>
</div>

<%connection.close%>


<form id="mainForm" name="form2" action="files.asp?page=<%=iCurrentPage%>" method="POST"></form>

<script type="text/javascript">


$(document).ready(function() {

    $('.fileupload').each(function() {

	var jqXHR = $(this).fileupload({
        dataType: 'json',
		formData: {tabdest: 'fails'},
		 progress: function (e, data) {
$('.fileupload').css("display","none");
mainObj =  $(this).attr("id");

		objBar = $("#"+mainObj+"_bar");
		objFile = $("#"+mainObj+"_file");
		objFile.fadeOut(100);
		objBar.parent().fadeIn(200);
		objBar.bind("click", function() { jqXHR.abort(); });
        var progress = parseInt(data.loaded / data.total * 100, 10);
        objBar.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+progress+"% - "+ parseInt(data.loaded/1000)+"/"+ parseInt(data.total/1000) + " KB");
		objBar.css(
            'width',
            progress + '%'
        );
    },
        done: function (e, data) {
			getId=$(this).attr("id");
			$.each(data.result, function (index, file) {
              $('.fileupload').remove();
			  $('#'+getId+'_name').val(file.url);
			  $('#'+getId+'_size').val(parseInt(file.size/1000));
			  $('#'+getId+'_form').submit();
            });
        }
    });
	});

	});


function delFile(urladd) {
if (confirm('Eliminare l\'elemento selezionato?')) { 
getUrl="delFileJQ.asp?"+urladd;
$.ajax({
  url: getUrl,
  context: document.body,
  success: function(msg){
$('#mainForm').submit();
}});
}
}

</script>
</body>
</html>

<%
response.end
%>

