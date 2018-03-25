<%
'response.redirect("list_images1.asp")
'response.end
%>
<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
''ON ERROR RESUME NEXT
tabella="_immagini_random"
Session("tabella")=tabella


titletop="Slide Show"
viewimg=""
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
 <div id="content_page">
<p class="titolo"> <%=titletop%></p>

<div id="structureContainerTable" style="position:relative;float:left;width:980px;margin-top:5px;margin-left:-1px">
<div id="contentMenu" style="position:relative;float:left; width:215px; height:500px;overflow:hidden">
<input type="button" class="titolo" value="NUOVA IMMAGINE" style="width:200px;margin:5px;" id="mybt1" onclick="document.location='insert_imgrandom.asp?CO_oggetti=<%=refogg%>';"/><br/>
&nbsp; Click sull'immagine da modificare<br/>
<div id="previmgs_c" class="testoadm" style="position:relative; left:5px; top:8px; width:210px; height:450px; overflow:auto; padding:2px">
<ul style="margin: 0px; width: 100%; padding: 0; list-style: none">
<%
refogg=request("refogg")
if len(refogg)>0 then refogg=CInt(refogg)


SQL="SELECT [_immagini_random].* FROM _immagini_random"
SQL=SQL&" ORDER BY IN_ordine, TA_nome ASC, [_immagini_random].ID DESC"
set recordset=connection.execute(SQL)

vedicampo_="TA_nome"

if not recordset.eof then
mimgs=""
hnr=0
do while not recordset.eof
diapo1=recordset("LO_no_diaporama")
diapoW="False"
if diapo1=True then diapoW="True"
if len(viewimg)=0 then viewimg=recordset("ID")
mimgs=mimgs&recordset("ID")&"|"&recordset("TA_nome")&"|"&recordset("AT_immagine")&"|0|"&diapoW&"|0|"&recordset("IN_intimage_crop")&"|"&recordset("CO_oggetti")&"$"
recordset.movenext
loop
recordset.movefirst

mimgs=Mid(mimgs,1,len(mimgs)-1)
mimgs=Split(mimgs,"$")



''ON ERROR RESUME NEXT
setWImg=400
setHImg=240


for x=LBound(mimgs) to UBound(mimgs)
currimg=mimgs(x)

currimg=Split(currimg,"|")

hnr=hnr+1
vedicampo=currimg(1)
ID=currimg(0)
img1=currimg(2)
ordine=currimg(3)
diapo=currimg(4)
setselected=currimg(5)
IN_intimage_crop=currimg(6)
objr=currimg(7)

if len(vedicamo)>0 then vedicampo=replace(vedicampo,"&#39;","'")
if len(sottotitolo)>0 then sottotitolo=replace(sottotitolo,"&#39;","'")
if len(setselected)>0 then setselected=CInt(setselected)
classe="class='textarea2'"

if colore="#FFFFFF" then
colore="#EFEFEF"
else
colore="#FFFFFF"
end if

editpage="edit.asp"

if isnull(ordine)=True then ordine=0
if ordine=0 or len(ordine)=0 then
SQL="UPDATE _immagini_random SET in_ordine="&hnr&" WHERE ID="&ID
set record=connection.execute(SQL)
ordine=hnr
end if
setdisp="none"

%>


<li style="float:left;margin:0px 6px 8px 0px; width:93px;height:52px; overflow:hidden"><a href="javascript:getImage(<%=ID%>);"><img class="gims" id="gi_<%=ID%>" rel="<%=objr%>" longdesc="<%=IN_intimage_crop%>" title="<%=ordine%>" alt="<%=img1%>" src="../images/vuoto.gif" style="border:solid 1px #e1e1e1"/></a></li>

<%
Next
%>
</ul></div></div>
<div style="float:left;  border:solid 3px #e1e1e1; background:#e1e1e1; width:600px; height:400px; border-radius:8px">
<div id="EditImage" class="testoadm" style="display:none;margin-top:49px;margin-left:90px;width:<%=setWImg+10%>px;">

<div id="viewimg" style="position:relative; left:0px;  width:<%=setWImg%>px; overflow:hidden;border:solid 1px #c1c1c1;margin-bottom:10px;">
<div id="cropimg" style="position:absolute;  width:<%=setWImg%>px; height:<%=setHImg%>px; background-color:#333; filter: alpha(opacity=20); -moz-opacity: 0.2; opacity: 0.2; cursor:move;"></div>
<img src="./images/vuoto.gif" id="viewimgp" width="<%=setWImg%>" style="margin-top:0px; margin-left:0px; margin-bottom:0px">
</div>

<form id="formImg" action="edit_imgrandom.asp" method="POST" style="margin:0px;">
	
	<input type="hidden" id="pagina" name="pagina" value="">
	<input type="hidden" name="tabella" value="_immagini_random">
	<input type="hidden" name="da" value="diaporama">

	<input type="text" id="ordine" name="IN_ordine" class="testoadm" maxlength="3" style=" width:12px;text-align:right;border:solid 0px #fff; background-color:#efefef;"/>
	<input class="testoadm" name="IN_intimage_crop" id="setcrop" type="text" style="width:48px;border:solid 0px #fff; background-color:#efefef;display:none" onfocus="this.blur();"/>

Collega a <select name="CO_oggetti" id="CO_oggetti" class="testoadm" style="width:182px; border: solid 1px #666666;"><option value="">...</option></select>

<input type="button" value="ELIMINA" style="margin:0px; width:80px;" class="editBtns" onclick="delImg();">
<input type="submit" value="SALVA" style="margin:0px;width:80px;" class="editBtns">
</form>

<br/>
<form id="fileupload_1" class="fileupload" action="uploadJQuery.aspx" method="POST" enctype="multipart/form-data"  style="margin:0px;">
<p id="fileupload_1_file" style="width:100%">Carica/Cambia immagine <%=h%>&nbsp;<input class="fInput"  type="file" name="files[]"></p>
<div class="barContain"><div class="bar" id="fileupload_1_bar" style="width: 0%;">&nbsp;uploading ...</div></div>
</form>


<form id="form1" name="form1" action="addFileJQ.asp" method="POST">
<input type="hidden" name="table" value="_immagini_random"/>
<input type="hidden" name="fieldF" value="AT_immagine"/>
<input type="hidden" name="connectTable" value=""/>
<input type="hidden" name="addFields" value=""/>
<input type="hidden" id="modeupl" name="modeupl"/>
<input type="hidden" id="fieldVal" name="fieldVal"/>
<input type="hidden" id="returnurl" name="returnurl" value="diaporama.asp"/>
</form>
</div>
</div>
</div>

<script type="text/javascript">
var maxlevs=4;
var loadedStructure="";

function delImg() {
$('#formImg').attr("action","del.asp");
$('#formImg').attr("target","editing_page");
$('#formImg').submit();
setEditing();
}

$(document).ready(function() {


getSlect('CO_oggetti', maxlevs,'void(0)');


$('.fileupload').each(function () {
var jqXHR = $(this).fileupload({
        dataType: 'json',
        progress: function (e, data) {
    mainObj =  $(this).attr("id");
	objBar = $("#"+mainObj+"_bar");
    objFile = $("#"+mainObj+"_file");
	objBar.unbind("click");
	objBar.bind("click",function() { jqXHR.abort(); });
	objFile.fadeOut(100);
	objBar.parent().fadeIn(200);
     var progress = parseInt(data.loaded / data.total * 100, 10);
     objBar.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+progress+"% - "+ parseInt(data.loaded/1000)+"/"+ parseInt(data.total/1000) + " KB");
     objBar.css('width', progress + '%');
    },
		done: function (e, data) {
            $.each(data.result, function (index, file) {
                $('#fieldVal').val(file.url);
				$('#form1').submit();
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


$('.gims').each(function(index) {
gsr=$(this).attr("alt");
if (gsr.length>0) {
$(this).css("background","url(../img.asp?width=<%=setWImg%>&path="+gsr+") center center no-repeat");
$(this).css("background-size","100%");
} else {
$(this).css("background","#f4f4f4");
}});


<%
if len(request("viewimg"))>0 then viewimg=request("viewimg")
if len(viewimg)>0 then response.write "setTimeout(""getImage("&viewimg&")"",1500);"
%>

});

function getImage(ref) {
$('#EditImage').css('display','none');
obj=$("#gi_"+ref);
gsr=obj.attr("alt"); 
cropi=obj.attr("longdesc"); 
ord=obj.attr("title");
objr=obj.attr("rel");


if (gsr.length>0) {
$('#viewimgp').attr("src","../img.asp?width=<%=setWImg%>&path="+gsr);
$('#viewimgp').css("height","auto");
} else {
$('#viewimgp').attr("src","../img.asp?width=<%=setWImg%>&path=vuoto.jpg");
$('#viewimgp').css("height","<%=setHImg%>px");
}
$('#pagina').val(ref);
$('#modeupl').val('update,'+ref);
$('#returnurl').val('diaporama.asp?viewimg='+ref);
$('#CO_oggetti').val('');
if (objr.length>0)
{
$('#CO_oggetti').val(objr);
}

$('#ordine').val(ord);
$('#setcrop').val(cropi);

cropY=0; cropX=0;
if (cropi.length>0) {
cropi=cropi.split("-L:")
cropY=cropi[0];

cropY=parseInt(cropY.substring(2));
cropX=parseInt(cropi[1]);

if (cropY<0) cropY=0;
if (cropX<0) cropX=0;
}

$('#cropimg').css("left",cropX+"px");
$('#cropimg').css("top",cropY+"px");

$( "#cropimg" ).draggable({ axis: 'y', containment: 'parent', drag: function (event, ui) {
isx=($( "#cropimg" ).position().left);
isy=($( "#cropimg" ).position().top);
$('#setcrop').val("T:"+(isy)+"-L:"+(isx));
}  });
$('#EditImage').fadeIn('normal');
}

</script>



</body>
</html>
<%response.End
End if%>