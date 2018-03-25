<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"--><%
load=request("load")
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM QU_projects WHERE LO_deleted=False AND ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
If rec.eof Then
Response.End
End If
ptitle=rec("TA_nome")
pcolor=rec("TA_color")
refcat=rec("refcat")
plink=linkMaker(ptitle)
%>
<!--#INCLUDE VIRTUAL="./project/project_make_header.asp"-->
<!--#INCLUDE VIRTUAL="./project/project_make_path.asp"-->
<div class="showPackets"></div>
<div style="clear:both"></div>
<input class="bt adbt" type="button" style="width:159px" value="nuovo file" onclick="loadprojectForm()"/>
<div class="projectForm" style="position:relative; width:700px; display:none">
<form id="fileupload_1_upl" class="formUpld" method="POST" style="margin:0px">
<input type="hidden" class="fieldVal" name="fieldVal" value=""/>
<input type="hidden" class="fieldDim" name="fieldDim" value=""/>

<p>
<span style="float:left; margin-right:10px">
Titolo file<br/>
<input type="text" id="title" class="str" style="width:537px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value=""/>
</span>
</p>

<p>
<span style="float:left; margin-right:10px">
<br/>Descrizione file<br/>
<textarea id="desc" class="str" style="width:377px; border:solid 1px #292f3a; font-size:16px; height:118px; padding:5px"></textarea>
</span>
</p>

</form>

<span class="btn">
<input type="button" class="bt" value="avanti" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(5)"/>
<input type="button" class="bt" value="indietro" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(3)"/>
<input type="button" class="bt" value="anteprima" onclick="document.location='/?progetti/<%=load%>/preview-project'"/>
</span>

<div class="ddM" style="width:549px">
<input type="button" class="bt dd2" value="annulla" onclick="noEditParagraph()"/><input type="button" class="bt dd1 fUp1" value="salva" alt="salva" rel="salva" onclick="$('.formUpld').submit()" style="display:none"/>

<form id="fileupload_1" class="fileupload" action="<%=uploadscript%>" method="POST" enctype="multipart/form-data" style="margin:0px 29px 40px -15px; float:right; width:110px;">
<p id="fileupload_1_file"  class="fButt"><input class="fInput" id="ff" type="file" name="files[]"/>
<label for="ff" class="lblUpload fUp" style="width:110px;">SCEGLI FILE</label><br/><span style="font-size:11px">Dimensione&nbsp;max&nbsp;5&nbsp;MB</span></p>
<div class="barContain" style="display:none;float:left; margin-top:0px;"><div class="bar" id="fileupload_1_bar">uploading ...</div></div>
<input type="hidden" name="tabdest" value="p_projects"/>
</form>

</div>
</div>

<div style="clear:both">

<p style="text-align:right; width:480px; margin-top:-10px">
<input type="hidden" id="edRef" value="<%=load%>" />
<input type="hidden" id="editRef" value="" />
</p>
</div>

<script src="/js/vendor/jquery.ui.widget.js"></script>
<script src="/js/jquery.iframe-transport.js"></script>
<script src="/js/jquery.fileupload.js"></script>

<script>
var pcat="<%=refcat%>";
$(document).ready(function () {
    
if (oldIeBrowser)
{
$('#ff').css('display','inline')
$('#ff').css('filter','alpha(opacity=0)')
}

$('div.ppath span').eq(8).find('span').addClass('active')
make_edit(4);
make_editor($('#desc'))

loadParagraphs()
if (pcat.length>0) updEditColor('<%=pcolor%>',4)

$('.formUpld').submit(function(e) {
e.preventDefault();
addParagraph()
return false;
  });

$('.fileupload').each(function () {
$(this).fileupload({
        dataType: 'json',
        
		
add: function (e, data) {
	$('p.dispError').remove()

        var goUpload = true;
        var uploadFile = data.files[0];
        if (!(/\.(jpg|jpeg|png|gif|pdf|doc|docx|ppt|pptx|xls|xlsx|zip|rar|dxf|dwg|mp3|eps|mov|mp4|m4v|m4a|rtf|txt)$/i).test(uploadFile.name)) {
            $('<p class="dispError" style="margin:0px;">Formato file non consentito</p>').appendTo($(this));
            goUpload = false;
        }
        if (uploadFile.size > 5150000) { 
			$('<p class="dispError" style="margin:0px;">Dimensione massima file: 5MB</p>').appendTo($(this));
            goUpload = false;
        }
        if (goUpload == true) {
            jqXHR = data.submit();
        }
    },

start: function() {
		mainObj =  $(this).attr("id");
		objBar = $("#"+mainObj+"_bar");
		objFile = $("#"+mainObj+"_file");
		objBar.parent().fadeIn(200);
		objFile.fadeOut(100);
        objBar.html('<p style="text-align:center"><span></span><br/><br/><a href="javascript:abortUpload($(\'#'+mainObj+'_file\'),$(\'#'+mainObj+'_bar\'))">ANNULLA</a></p>');
	},
		progress: function (e, data) {
    	var progress = parseInt(data.loaded / data.total * 100, 10);
        objBar.find('span').html(progress+'%');
    },	
		done: function (e, data) {
        $.each(data.result, function (index, file) {
		objBar.html(""+file.name+ " caricato");
		$('#'+mainObj+'_upl input.fieldVal').val(file.url);
		$('#'+mainObj+'_upl input.fieldDim').val(parseInt(file.size/1000));
		$('#'+mainObj+'_upl').submit()
        });
        }
    });
	});



})

delParagraph = function(bref) {
gtref=$('#edRef').val()

if (confirm('Eliminare il paragrafo?')) {
var data1 = {
load: gtref,
refb: bref
};

$.ajax({
  type: "POST",
  url: "/actions/del_paragraph.asp",
  data: data1,
  timeout: 6000,
  success    : function(msg) {
	loadParagraphs()
  }});
}
}

addParagraph = function() {
gtref=$('#edRef').val()
desc1 = $('#desc').tinymce().getContent();
title1=$('#title').val()
fname=$('.fieldVal').val()
fdim=$('.fieldDim').val()
edref=$('#editRef').val()

var data1 = {
load: gtref,
edref: edref,
fdim: fdim,
ptype: 'download',
desc: desc1,
fname: fname,
title: title1
};

//var data2 = gtref+"/"+fdim+"/"+desc+"/"+fname+"/"+title


$.ajax({
  type: "POST",
  url: "/actions/add_paragraph.asp",
  data: data1,
  dataType: "html",
  timeout: 6000,
  success    : function(msg) {
	$('#editRef').val('');
	$('#desc').val('')
	$('#title').val('')
//document.location="/project/project_make_6.asp?load=<%=load%>&ssid="+ Math.floor(Math.random()*99999);
//return;
	loadParagraphs()
$('.barContain div').fadeOut();
$('.formUpld input.str, .formUpld textarea').val('')
$('.barContain').fadeOut();
$('.fButt').fadeIn();

$('p.dispError').remove()
  }});
}



loadParagraphs = function() {
gtref=$('#edRef').val()

var data1 = {
ptype: 'download',
load: gtref
};

$.ajax({
  type: "POST",
  url: "/actions/load_paragraph.asp",
  data: data1,
  timeout: 6000,
  success    : function(msg) {
	  $('div.showPackets').html(msg)
setTimeout(function() {
//$('div.myprojectsFrame', parent.document).css('height', $('div.showPackets').offset().top+$('div.showPackets').innerHeight()+50+'px')
//$('div.pText', parent.document).css('height',$('div.myprojectsFrame', parent.document).height()+180+'px')
makeSortedParagraphs()
closeprojectForm()
},100)
  }});
}

</script>
</body>
</html>

<%
End if
connection.close%>