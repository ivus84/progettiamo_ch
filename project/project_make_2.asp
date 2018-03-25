<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%
load=request("load")
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
imgp=rec("AT_main_img")
imgp1=rec("AT_banner")
ptitle=rec("TA_nome")
plink=linkMaker(ptitle)

If Len(imgp)=0 Or isnull(imgp) Then imgp="thumb_picture.png"
If Len(imgp1)=0 Or isnull(imgp1) Then imgp1="thumb_picture.png"

%>
<!--#INCLUDE VIRTUAL="./project/project_make_header.asp"-->
<p>
Immagine principale<br/><span style="font-size:12px">(formato png o jpg, minimo 500 x 500 pixel)</span><br/>
</p>
<div class="profileImage" style="background-color:#ccc; height:140px; width:198px; background-size: auto 100%; background-image:url(/<%=imgscript%>?path=<%=imgp%>$324)"></div>
<div style="clear:both"></div>
<p style="margin-top:-6px">
<form id="fileupload_1" class="fileupload" action="<%=uploadscript%>" method="POST" enctype="multipart/form-data" style="margin:0px">
<p id="fileupload_1_file"><input class="fInput" id="ff" type="file" name="files[]">
<label for="ff" style="cursor:pointer;color:#fff; background:#292f3a; padding:6px;">Carica immagine</label></p>
<div class="barContain" style="display:none"><div class="bar" id="fileupload_1_bar">&nbsp;uploading ...</div></div>
<input type="hidden" name="tabdest" value="p_projects"/>
</form>

<form id="fileupload_1_upl" class="formUpld" method="POST" style="opacity:0.0; margin:0px">
<input type="hidden" name="table" value="p_projects"/>
<input type="hidden" name="fieldF" value="AT_main_img"/>
<input type="hidden" class="fieldVal" name="fieldVal" value=""/>
<input type="hidden" name="fieldRef" value="<%=load%>"/>
</form>

</p>
<div style="clear:both"></div>
<p>
Banner homepage<br/><span style="font-size:12px">(formato png o jpg, minimo 1024 x 400 pixel)</span><br/>
</p>
<div class="profileImage" style="height:140px; width:450px; background-size: 100% auto; background-image:url(/<%=imgscript%>?path=<%=imgp1%>$324)"></div>
<div style="clear:both"></div>
<p style="margin-top:-6px">
<form id="fileupload_2" class="fileupload" action="<%=uploadscript%>" method="POST" enctype="multipart/form-data" style="margin:0px">
<p id="fileupload_2_file"><input class="fInput" id="ff1" type="file" name="files[]">
<label for="ff1" style="cursor:pointer;color:#fff; background:#292f3a; padding:6px;">Carica immagine</label></p>
<div class="barContain" style="display:none"><div class="bar" id="fileupload_2_bar">&nbsp;uploading ...</div></div>
<input type="hidden" name="tabdest" value="p_projects"/>
</form>

<form id="fileupload_2_upl" class="formUpld" method="POST" style="opacity:0.0; margin:0px">
<input type="hidden" name="table" value="p_projects"/>
<input type="hidden" name="fieldF" value="AT_banner"/>
<input type="hidden" class="fieldVal" name="fieldVal" value=""/>
<input type="hidden" name="fieldRef" value="<%=load%>"/>
</form>

</p>


<div style="clear:both"></div>

<p style="text-align:right; width:750px;">
<span class="btn"><input type="button" class="bt" value="indietro" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(0)"/>
<input type="button" class="bt" value="avanti" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(1)"/></span>
<input type="hidden" id="edRef" value="<%=load%>" />
</p>

<!--#INCLUDE VIRTUAL="./project/project_make_path.asp"-->

<script src="/js/vendor/jquery.ui.widget.js"></script>
<script src="/js/jquery.iframe-transport.js"></script>
<script src="/js/jquery.fileupload.js"></script>

<script>
$(document).ready(function() {
$('div.ppath span').eq(2).find('span').addClass('active')
make_edit();

$('.formUpld').submit(function(e) {
e.preventDefault();
$.ajax({
  type: "POST",
  url: "/actions/addFileJQ.asp",
  data:  $(this).serialize(),
  timeout: 6000,
  success    : function(msg) {
	
	setTimeout(function() { document.location="/project/project_make_2.asp?load=<%=load%>"; },2000) 
  
  }})

return false;
  });

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
        objBar.html(""+progress+"% - "+ parseInt(data.loaded/1000)+"/"+ parseInt(data.total/1000) + " KB");
		objBar.css('width', progress + '%');
    },
		done: function (e, data) {
            $.each(data.result, function (index, file) {
				objBar.html(""+file.name+ " caricato");
$('#'+mainObj+'_upl input.fieldVal').val(file.url);
$('#'+mainObj+'_upl').submit()
$('<img/>').attr('src','/<%=imgscript%>?path='+file.url+'$324')
            });
        }
    });
	});

})

</script>
</body>
</html>

<%
End if
connection.close%>