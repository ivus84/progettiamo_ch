<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%
load=request("load")
edref=request("edref")

If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT TA_nome FROM p_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
ptitle=rec("TA_nome")
plink=linkMaker(ptitle)

If Len(edref)>0 Then
SQL="SELECT * FROM p_description WHERE CO_p_projects="&load&" AND ID="&edref
Set rec=connection.execute(SQL)
If Not rec.eof Then
edTitle=rec("TA_nome")
edTExt=rec("TX_testo")
edEmbd=rec("TX_embed")

If Len(edTExt)>0 Then edTExt=Replace(edTExt,Chr(34)&Chr(34),Chr(34))
If Len(edEmbd)>0 Then edEmbd=Replace(edEmbd,Chr(34)&Chr(34),Chr(34))


End if
End if
%>
<!DOCTYPE html>
<html lang="it">
<head><title>Progettiamo.ch - Il Ticino insieme - Crowdfunding promosso dagli Enti Regionali per lo Sviluppo del Canton Ticino</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="/css/styles.1.css" media="all" />
<script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/js/src.site.1.js"></script>
<script type="text/javascript" src="/admin/jscripts/tiny_mce3.5.10/jquery.tinymce.js"></script>
<link rel="shortcut icon" href="/prog.ico" />
<meta name="robots" content="noindex"/>
</head>
<body class="editing">
<p><b>Aggiungi una news sul progetto</b></p>
<p style="clear:both">Titolo<br/><input type="text" id="title" style="width:587px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value="<%=edTitle%>"/></p>

<p style="clear:both"><span style="float:left; margin-right:10px">
Codice embed video <a href="javascript:void(0)" rel="/project/embed_guide.html" class="vEmbd">(?)</a><br/>
<textarea id="embd" style="width:587px; border:solid 1px #292f3a; background:#efefef; font-size:16px; height:28px; padding:4px" onfocus="$(this).height(98);"  onblur="$(this).height(28);"><%=edEmbd%></textarea>
</span>
</p>
<input id="edRef1" type="hidden" value="<%=edref%>"/>

<p style="clear:both"><textarea class="editarea"><%=edTExt%></textarea></p>
<div style="Position:relative; width:597px;">
<form id="fileupload_1" class="fileupload" action="<%=uploadscript%>" method="POST" enctype="multipart/form-data" style="float:left">

<p id="fileupload_1_file"  style="float:left; margin:11px 5px 0px 0px"><input class="fInput" id="ff" type="file" name="files[]">
<label for="ff" style="cursor:pointer;color:#fff; font-size:13px;background:#292f3a; padding:13px 9px; width:150px; text-align:center">AGGIUNGI IMMAGINE</label></p>
<div class="barContain" style="display:none;float:left; margin-top:-1px; width:130px"><div class="bar" id="fileupload_1_bar">&nbsp;uploading ...</div></div>
<input type="hidden" name="tabdest" value="p_projects"/>
</form>

<input type="button" class="bt" value="salva news" onclick="SaveForm()" style="float:right; margin-left:1px;"/>
<input type="button" class="bt" value="annulla" onclick="$('#title, .editarea, #imgadd').val(''); parent.closeFormAdd()" style="float:right"/>

</div>
<input type="hidden" id="edRef" value="<%=load%>" />
<input type="hidden" id="imgadd" value="" />

<script src="/js/vendor/jquery.ui.widget.js"></script>
<script src="/js/jquery.iframe-transport.js"></script>
<script src="/js/jquery.fileupload.js"></script>


<script>
$(document).ready(function() {
	$('#title').focus()

$('a.vEmbd').click(function() {
gtUrl=$(this).attr('rel')
parent.$.fancybox({
href: gtUrl,
autoDimensions: false,
autoSize: false,
width: 581,
height: 450,
type: 'iframe',
padding:10,

		helpers	: {
			overlay : {
            css : {
            'background' : 'rgba(255, 255, 255, 0.8)'
            }}
	}});
})

$('.editarea').tinymce({
script_url : '/admin/jscripts/tiny_mce3.5.10/tiny_mce.js',
translate_mode : true,
		language : "it",
		width : 597,
		height : 90,
        theme : "advanced",
                        plugins : "inlinepopups,paste",
       theme_advanced_buttons1 : "bold,italic,link,unlink",
                        theme_advanced_toolbar_location : "bottom",
						theme_advanced_statusbar_location : "none",
                        theme_advanced_resizing : false,
invalid_elements : "span,div",
paste_text_sticky : true,
setup : function(ed) {
    ed.onInit.add(function(ed) {
      ed.pasteAsPlainText = true;
    });
  }

});

$('.fileupload').each(function () {
$(this).fileupload({
        dataType: 'json',
       add: function (e, data) {
        $('p.dispError').remove()
		var goUpload = true;
        var uploadFile = data.files[0];
        if (!(/\.(jpg|jpeg|png|gif)$/i).test(uploadFile.name)) {
            $('<p class="dispError" style="float:left; width:160px;padding-left:10px">Scegliere un file in formato png, gif o jpg</p>').appendTo($(this));
            goUpload = false;
        }
        if (uploadFile.size > 3100000) { 
			$('<p class="dispError" style="float:left; width:110px;margin:-2px 10px;text-align:left;">Dimensione massima consentita per immagine: 3MB</p>').appendTo($(this));
            goUpload = false;
        }
        if (goUpload == true) {
            jqXHR=data.submit();
        }
    },
	start: function() {
		mainObj =  $(this).attr("id");

		objBar = $("#"+mainObj+"_bar");
		objFile = $("#"+mainObj+"_file");
		objBar.parent().fadeIn(200);
		objFile.fadeOut(100);
	        objBar.html('<p style="text-align:center"><span></span><br/><a href="javascript:abortUpload($(\'#'+mainObj+'_file\'),$(\'#'+mainObj+'_bar\'))">ANNULLA</a></p>');

	},

		progress: function (e, data) {
    	var progress = parseInt(data.loaded / data.total * 100, 10);
        objBar.find('span').html(progress+'%');
    },

		done: function (e, data) {
            $.each(data.result, function (index, file) {
				objBar.html("upload terminato");
				$('#imgadd').val(file.url);
				cob=$('#fileupload_1').parent();
				$('#fileupload_1').css('display','none')
				$('<img src="/<%=imgscript%>?path='+file.url+'$300" style="width:100px"/>').prependTo(cob)
				//SaveForm()
            });
        }
    });
	});


})

SaveForm = function() {
ed = $('.editarea').tinymce().getContent();
edref=$('#edRef').val();
edref1=$('#edRef1').val();
title=$('#title').val();
embd=$('#embd').val();
imgadd=$('#imgadd').val();
var data1 = {
  myTextarea: ed,
  ref: edref,
  edref: edref1,
  imgadd: imgadd,
  title: title,
  embd: embd

};

$.ajax({
  type: "POST",
  dataType: "html",
  url: "/actions/project_update_save.asp",
  data: data1
}).done(function( msg ) { 

prevlocation=""+parent.document.location.href;
if (prevlocation.indexOf('/addnews/')==-1) prevlocation+='/addnews/';
$('#title, .editarea, #imgadd').val(''); parent.closeFormAdd()
$('<div class="modal" style="position:absolute; left:18%; z-index:999; padding:90px; top:11%; width:420px; height:60px; background:#fff; box-shadow:1px 1px 6px 5px #cbcbcb;">Aggiornamento di progetto salvato<br/><br/><input type="button" style="border:0px; color:#fff; background:#292f3a;padding:10px 14px; font-size:13px; cursor:pointer;" value="CHIUDI" onclick="document.location=\''+prevlocation+'\'"/></div>').prependTo($('div.pText', parent.document))
setTimeout(function() {
parent.document.location=prevlocation;
},4000)
});

}


</script>
</body>
</html>

<%
End if
connection.close%>