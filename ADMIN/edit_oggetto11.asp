
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%nobg=True%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->

<%ref=Session("ref")%>

<p class="testoadm"><b>Carica file</b></p>

<form id="fileupload_1" class="fileupload" action="uploadJQuery.aspx" method="post" enctype="multipart/form-data" style="margin-top:80px">
<p id="fileupload_1_file" style="width:100%">Seleziona file &nbsp;<input class="fInput"  type="file" name="files[]"></p>
<div class="barContain"><div class="bar" id="fileupload_1_bar" style="width: 0%;">&nbsp;uploading ...</div></div>
</form>

<form id="formUpld" action="addFileJQ.asp" method="post" style="margin-top:-100px">
<input type="hidden" name="table" value="fails"/>
<input type="hidden" name="fieldF" value="TA_nome"/>
<input type="hidden" name="connectTable" value="associa_ogg_files,CO_oggetti,<%=ref%>"/>
<input type="hidden" name="addFields" value="TA_titolo,TA_grandezza"/>
<input type="hidden" name="returnurl" value="edit_oggetto11.asp"/>
<input type="hidden" id="fieldVal" name="fieldVal"/>
<input type="hidden" id="TA_grandezza" name="TA_grandezza"/>
<input type="hidden" name="modeupl" value="insert"/>
<!--Per inserire video embed (youtube/vimeo)<br/>inserire solo l'url del video nel titolo//-->
<br/><p class="testoadm"><b>Titolo/nome</b></p>
<input type="text" class="testoadm" style="width:250px" maxlength="255" name="TA_titolo" onchange="checkVid($(this).val())">
</form>


<div id="showFiles" style="margin-top:40px; width:289px; height:320px; overflow:auto">
</div>

<script type="text/javascript">

$(document).ready(function() {
$('body').css("background","transparent");
	getUploads_f();
});

function checkVid(val) {
if (val.indexOf("http://")!=-1 || val.indexOf("https://")!=-1) {
$('#fieldVal').val(val);
$('#TA_grandezza').val("0");
$('#formUpld').submit();
}
}

function changeField(fld,valx,ref) {
getUrl="edit_file.asp?ssid=" + Math.floor((Math.random()*111111)+1)+"&"+fld+"="+valx+"&idfile="+ref;
$.ajax({
  url: getUrl,
  context: document.body,
  success: function(msg){
showFiles();
}});

}

function showFiles() {
getUrl="filesShow.asp?ssid=" + Math.floor((Math.random()*111111)+1);
$.ajax({
  url: getUrl,
  context: document.body,
  success: function(msg){
$("#showFiles").html('');
$( "#listFiles" ).remove();
$("#showFiles").html(msg);
makeSorted();
}});
}

function delFile(urladd) {
if (confirm('Eliminare l\'elemento selezionato?')) { 
getUrl="delFileJQ.asp?ssid=" + Math.floor((Math.random()*111111)+1) + "&" + urladd;
$.ajax({
  url: getUrl,
  context: document.body,
  success: function(msg){
$("#showFiles").html(msg);
makeSorted();

}});
}
}

function makeSorted() {
$( "#listFiles" ).sortable({  
update: function (event, ui) {
newPos = ui.item.index()+1;
getRefi=ui.item.attr("id");
MoveFile=getRefi.substring(getRefi.indexOf("_")+1);
changeField('IN_ordine',newPos,MoveFile);
}  });
}




function getUploads_f() {

	$('.fileupload').each(function () {

var jqXHR = $(this).fileupload({
        dataType: 'json',
	formData: {tabdest: 'fails'},
        progress: function (e, data) {
    mainObj =  $(this).attr("id");

	objBar = $("#"+mainObj+"_bar");
    objFile = $("#"+mainObj+"_file");
	objBar.unbind("click");
	objBar.bind("click", function() { jqXHR.abort(); });
		objFile.fadeOut(100);
		objBar.parent().fadeIn(200);
        var progress = parseInt(data.loaded / data.total * 100, 10);
        objBar.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+progress+"% - "+ parseInt(data.loaded/1000)+"/"+ parseInt(data.total/1000) + " KB");
		objBar.css(
            'width',
            progress + '%'
        );
    },
		done: function (e, data) {
            $.each(data.result, function (index, file) {
	$('#fieldVal').val(file.url);
	$('#TA_grandezza').val(parseInt(file.size/1000));

				objBar.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+file.name+ " successfully uploaded");
				objBar.unbind("click");
				objBar.bind("click",function() {
				$(this).parent().fadeOut(100);
				$(this).parent().parent().find("p").fadeIn(100);
				});
gtTitle = $('input[name="TA_titolo"]').val();
if (gtTitle.length==0)
{
gtFileN=file.name;
gtFileN=gtFileN.substring(0,gtFileN.lastIndexOf('.')-1);
$('input[name="TA_titolo"]').val(gtFileN)
}

$('#formUpld').submit();
            });
        }
    });
	});


	showFiles();
}
</script>
</body>
</html>


