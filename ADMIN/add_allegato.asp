<%
ref=request("ref")
mode=request("mode")
%>
<!DOCTYPE html>
<html lang="it">
<head><title>dSm</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link rel="stylesheet" href="/admin/admstyles.css" type="text/css">
<script language="Javascript" src="./main_lang/langedit_<%=Session("adminlanguageactive")%>.js"></script>
<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script> 
<script src="jscripts/vendor/jquery.ui.widget.js"></script>
<script src="jscripts/jquery.iframe-transport.js"></script>
<script src="jscripts/jquery.fileupload.js"></script>
</head>
<body style="background:transparent; margin:0px;font-family:arial; font-size:11px">

<form id="fileupload_1" class="fileupload" action="uploadJQuery.aspx" method="post" enctype="multipart/form-data" style="margin-top:45px; margin-bottom:5px">
<p id="fileupload_1_file" style="width:100%">Seleziona file &nbsp;<input class="fInput"  type="file" name="files[]"></p>
<div class="barContain"><div class="bar" id="fileupload_1_bar" style="width: 0%;">&nbsp;uploading ...</div></div>
</form>

<form id="formUpld" name="form1" action="addFileJQ.asp" method="post" style="margin-top:-65px; margin-bottom:5px">
<input type="hidden" name="table" value="fails"/>
<input type="hidden" name="fieldF" value="TA_nome"/>
<input type="hidden" name="connectTable" value=""/>
<input type="hidden" name="addFields" value="TA_titolo,TA_grandezza"/>
<input type="hidden" name="returnurl" value="add_allegato.asp?mode=reload"/>
<input type="hidden" id="fieldVal" name="fieldVal"/>
<input type="hidden" id="TA_grandezza" name="TA_grandezza"/>
<input type="hidden" name="modeupl" value="insert"/>
<p class="testoadm"><b><script type="text/javascript">document.write(txt60);</script></b><br/>
<input type="text" class="testoadm" style="width:250px" maxlength="255" name="TA_titolo"><br/>
</form>

<script type="text/javascript">

$(function () {

var jqXHR = $('.fileupload').fileupload({
    dataType: 'json',
	formData: {tabdest: 'fails'},
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
                $('#TA_grandezza').val(parseInt(file.size/1000));
				$('#formUpld').submit();
				objBar.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+file.name+ " successfully uploaded");
				objBar.unbind("click");
            });
        }
    });

	});


<%If mode="reload" then%>
parent.document.location="./jscripts/tinymce/plugins/advlink/link.htm?ssid="+Math.random();
<%End if%>
</script>
</body>
</html>
