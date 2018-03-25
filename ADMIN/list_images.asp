<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<%
nobg=True
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<%
mode=request("mode")

startfrom=request("startfrom")
if len(startfrom)=0 then startfrom=0

SQL="SELECT * FROM immagini WHERE ID<"&startfrom&" ORDER BY ID DESC"
if startfrom=0 then SQL="SELECT * FROM immagini ORDER BY ID DESC"
set recordset=connection.execute(SQL)

addscript=""
if request("mode")="uploaded" then
if not recordset.eof then addscript="chooseImage('"&recordset("TA_nome")&"');"
end if%>

<form id="formUpld" name="form1" action="addFileJQ.asp" method="POST">
<input type="hidden" name="table" value="immagini"/>
<input type="hidden" name="fieldF" value="TA_nome"/>
<input type="hidden" name="connectTable" value=""/>
<input type="hidden" name="addFields" value=""/>
<input type="hidden" id="fieldVal" name="fieldVal"/>
<input type="hidden" name="modeupl" value="insert"/>
<input type="hidden" name="returnurl" value="list_images.asp?mode=uploaded"/>
</form>

<form id="fileupload_1" class="fileupload" action="uploadJQuery.aspx" method="POST" enctype="multipart/form-data" style="margin-top:5px; margin-bottom:5px">
<p id="fileupload_1_file" style="width:100%">File &nbsp;<input class="fInput"  type="file" name="files[]"></p>
<div class="barContain"><div class="bar" id="fileupload_1_bar" style="width: 0%;">&nbsp;uploading ...</div></div>
</form>

<%
viewImages=request("viewImages")

viewImages="True" 
iPageSize = 25

%>
<div style="width:100%">
<!--#INCLUDE VIRTUAL="./ADMIN/load_images.asp"-->
</div>


<script type="text/javascript">

$(function () {

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
		objBar.css(
            'width',
            progress + '%'
        );
    },
		done: function (e, data) {
            $.each(data.result, function (index, file) {
                $('#fieldVal').val(file.url);
				$('#formUpld').submit();
				objBar.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+file.name+ " successfully uploaded");
				objBar.unbind("click");
            });
        }
    });
	});

	});



$('body').css('background','#fff');
var setw;
function chooseImage(dest) {
isfotosrc="../<%=imgscript%>?path="+dest+"$500";
$("<img/>") 
    .attr("src", isfotosrc)
    .load(function() {
        pic_real_width = this.width;
        pic_real_height = this.height;

	setw=500; 
	if (pic_real_height>pic_real_width) {
	setw=parseInt(setw / pic_real_height * pic_real_width);
	}

$('#src', window.parent.document).val(isfotosrc);
$('#width', window.parent.document).val(setw);
$('#alt', window.parent.document).val('Image');
$('#title', window.parent.document).val('Image');
$('#frameImages', window.parent.document).fadeOut('fast');
$('#imgPrev', window.parent.document).css('display','inline');
$('.hdCol', window.parent.document).css('display','inline');
setTimeout("setT("+pic_real_width+","+pic_real_height+");",500);
parent.ImageDialog.showPreviewImage(isfotosrc);
});
 }

function setT(setw,seth) {

tow=parseInt(200 / seth * setw);
$('#previewImg', window.parent.document).css('width',tow+'px');
$('#previewImg', window.parent.document).css('height','200px');
$('#prev', window.parent.document).css('height','180px');
$('#prev', window.parent.document).css('text-align','center');
}


<%=addscript%>

</script>


<%connection.close%>
</body>
</html>
