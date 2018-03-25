<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%nobg=True%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<%refgallery=request("refgallery")

if len(refgallery)>0 then
session("refgalledit")=request("refgallery")
end if
refgallery=session("refgalledit")
SQL="SELECT galleries.TA_nome"&Session("reflang")&" as namegall FROM galleries WHERE ID="&refgallery&" ORDER BY galleries.IN_ordine ASC"
set recordg=connection.execute(SQL)

do while  not recordg.eof
nomegall=recordg("namegall")

If Len(nomegall)>20 Then nomegall=Mid(nomegall,1,20)

%>
<a name="<%=ID%>g"></a>

Carica # <select name="conto" class="testoadm" onchange="document.location='edit_galleries.asp?refgallery=<%=refgallery%>&amp;conto='+this.options[this.selectedIndex].value;">
<option value="1">...</option>
<%For x=1 To 5%>
<option value="<%=x%>"><%=x%></option>
<%next%>
</select> immagini
<%
conto=request("conto")
if len(conto)>0 then Session("conto")=conto

if len(Session("conto"))=0 then Session("conto")=1

h=0
do while h<CInt(Session("conto"))
h=h+1
%>


<form id="fileupload_<%=h%>" class="fileupload" action="uploadJQuery.aspx" method="POST" enctype="multipart/form-data">
<p id="fileupload_<%=h%>_file">File <%=h%>&nbsp;<input class="fInput"  type="file" name="files[]"></p>
<div class="barContain"><div class="bar" id="fileupload_<%=h%>_bar" style="width: 0%;">&nbsp;uploading ...</div></div>
</form>

<%loop%>
</div>
<br/>
Drag &amp; Move to a new position to change the order
<ul id="contImg">
</ul>
<p id="tt"></p>
<%
recordg.movenext
loop%>


<script type="text/javascript">

$(document).ready(function() {
$('body').css("background","transparent");

$('.fileupload').each(function () {
var jqXHR = $(this).fileupload({
        dataType: 'json',
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
                showGallery(<%=refgallery%>,file.url);
				objBar.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+file.name+ " successfully uploaded");
				objBar.unbind("click");
				objBar.bind("click",function() {
$(this).parent().fadeOut(100);
$(this).parent().parent().find("p").fadeIn(100);
});

            });
        }
    });
	});
showGallery(<%=refgallery%>,'');
});


function showGallery(refg,addimg) {
getUrl="galleryShow.asp?refgallery="+refg+"&ssid="+Math.floor((Math.random()*111111)+1);
if (addimg.length>0) getUrl+="&addimg="+addimg;
$.ajax({
  url: getUrl,
  context: document.body,
  success: function(msg){
$("#contImg").html(msg);
makeSorted()
}});
}

function delFile(urladd) {
if (confirm('Eliminare l\'elemento selezionato?')) { 
getUrl="delFileJQ.asp?"+urladd+"&ssid=" + Math.floor((Math.random()*111111)+1);
$.ajax({
  url: getUrl,
  context: document.body,
  success: function(msg){
$("#contImg").html(msg);
makeSorted();
}});
}
}

var prevPos=0; var newPos; var MoveImg; var setPos;

function makeSorted() {
$( "#contImg" ).sortable({  
update: function (event, ui) {
newPos = ui.item.index()+1;
getRefi=ui.item.attr("id");
MoveImg=getRefi.substring(getRefi.indexOf("_")+1);
$.ajax({
  url: "ord_gallery_new.asp?ref="+MoveImg+"&gallery=<%=refgallery%>&newpos="+newPos+"&ssid=" + Math.floor((Math.random()*111111)+1),
  context: document.body,
  success: function(msg){
showGallery(<%=refgallery%>,'');
}});
}  });
}

var isVisi=0;

</script>
</body>
</html>