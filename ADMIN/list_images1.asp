<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
titletop="Immagini"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
<div id="content_page">
<p class="titolo"> <%=titletop%></p>


<p style="display:none">&gt;&nbsp;&nbsp;<a href="diaporama.asp">Immagini Sfondo</a> | <a href="list_images1.asp">Immagini Contenuti</a> | </p>

<form id="formUpld" name="form1" action="addFileJQ.asp" method="POST">
<input type="hidden" name="table" value="immagini"/>
<input type="hidden" name="fieldF" value="TA_nome"/>
<input type="hidden" name="connectTable" value=""/>
<input type="hidden" name="addFields" value=""/>
<input type="hidden" id="fieldVal" name="fieldVal"/>
<input type="hidden" name="modeupl" value="insert"/>
<input type="hidden" name="returnurl" value="list_images1.asp?mode=uploaded"/>
</form>

<form id="fileupload_1" class="fileupload" action="uploadJQuery.aspx" method="POST" enctype="multipart/form-data" style="margin-top:20px">
<p id="fileupload_1_file" style="width:100%">Seleziona file &nbsp;<input class="fInput"  type="file" name="files[]"></p>
<div class="barContain"><div class="bar" id="fileupload_1_bar" style="width: 0%;">&nbsp;uploading ...</div></div>
</form>

<div id="tPage" style="position:relative;margin-left:0px;margin-top:20px;width:420px" class="testoadm">

<%
mode=request("mode")
iPageSize = 36

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_images.asp"-->


</div>

<form name="form2" action="list_images1.asp" method="POST"><input type="hidden" name="page" value="<%=iCurrentPage%>"/></form>
<%connection.close%>

<script type="text/javascript">

$(document).ready(function() {

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


function chooseImage(ogge) {
$('#editing_page').css("width","390px");
$('#editing_page').css("left","400px");
$('#editing_page').attr('src','edit_image_.asp?path='+ogge)
setEditing();
}
<%=addscript%>
</script>


</body>
</html>
