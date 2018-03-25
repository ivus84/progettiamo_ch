<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%
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
<p>
<a class="lblUpload bactive" href="/project/project_make_9.asp?load=<%=load%>" style="margin-right:1px; padding: 10px 25px; font-size:14px">Fotogallery</a>
<a class="lblUpload" href="/project/project_make_7.asp?load=<%=load%>" style="margin-right:1px; padding: 10px 25px; font-size:14px">Videogallery</a>
</p>

<div class="showPackets"></div>
<div style="clear:both"></div>
<input class="bt adbt" type="button" style="width:173px" value="nuova gallery" onclick="loadprojectForm()"/>
<div class="projectForm" style="position:relative; width:700px; display:none">
<p>
<span style="float:left; margin-right:10px">
Titolo gallery<br/>
<input type="text" id="title" style="width:537px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value=""/>
</span>
</p>

<p>
<span style="float:left; margin-right:10px">
<br/>Descrizione gallery<br/>
<textarea id="desc" style="width:377px; border:solid 1px #292f3a; font-size:16px; height:118px; padding:5px"></textarea>
</span>
</p>


<span class="btn">
<input type="button" class="bt" value="avanti" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(4)"/>
<input type="button" class="bt" value="indietro" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(2)"/>
<input type="button" class="bt" value="anteprima" onclick="document.location='/?progetti/<%=load%>/preview-project'"/>
</span>


<div class="ddM"><input type="button" class="bt dd2" value="annulla" onclick="noEditParagraph()"/><input type="button" class="bt dd1" value="salva" alt="salva" rel="salva" onclick="addParagraph()"/></div>




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
    var pcat = "<%=refcat%>";

$(document).ready(function() {
    //VB:Sezione Foto Gallery 
    $('div.ppath span').eq(6).find('span').addClass('active')
    make_edit(3);
    make_editor($('#desc'))
    loadParagraphs()
    if (pcat.length>0) updEditColor('<%=pcolor%>',3)
})

var fileInProgress = false; //Aggiunta per evitare upload multiplo in caso di gallery multiple
setUploads = function () {
    $('.fileupload').each(function () {
        $(this).fileupload({
            dataType: 'json',
            //dropZone: $('.adt'), VB:Modificata la DropZone per problema su gallery multiple
            dropZone: $(this),
            add: function (e, data) {
                $('p.dispError').remove()
                var goUpload = true;
                if (!fileInProgress) {
                    fileInProgress = true;
                    var uploadFile = data.files[0];
                    if (!(/\.(jpg|jpeg|png|gif)$/i).test(uploadFile.name)) {
                        $('<p class="dispError" style="float:left; width:160px;padding-left:10px">Scegliere un file in formato png, gif o jpg.</p>').appendTo($(this));
                        goUpload = false;
                    }
                    if (uploadFile.size > 6100000) {
                        $('<p class="dispError" style="float:left; width:110px;margin:-2px 10px;text-align:left;">Dimensione massima consentita per immagine: 6MB</p>').appendTo($(this));
                        goUpload = false;
                    }
                    if (goUpload == true) {
                        jqXHR = data.submit();
                    }
                }
            },
            start: function () {
                mainObj = $(this).attr("id");
                objBar = $("#" + mainObj + "_bar");
                objFile = $("#" + mainObj + "_file");
                objBar.parent().fadeIn(200);
                objFile.fadeOut(100);
                objBar.html('<p style="text-align:center"><span></span><br/><br/><a href="javascript:abortUpload($(\'#' + mainObj + '_file\'),$(\'#' + mainObj + '_bar\'))">ANNULLA</a></p>');
            },
            progress: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                objBar.find('span').html(progress + '%');
            },
            done: function (e, data) {
                
                $.each(data.result, function (index, file) {
                    objBar.html("Upload completato");
                    $('#' + mainObj + '_upl input.fieldVal').val(file.url);
                    $('#' + mainObj + '_upl').submit()
                });
                fileInProgress = false;
            },
            error: function (xhr, status, error) {
                alert(error);
            }
        });
    });

    $('.formUpld').submit(function (e) {
        e.preventDefault();
        fval = $(this).find('.fieldVal').val()
        fpro = $(this).find('.fieldPro').val()
        fref = $(this).find('.fieldRef').val()

        var data1 = { fval: fval, fpro: fpro, fref: fref };

        $.ajax({
            type: "POST",
            url: "/actions/add_picture.asp",
            data: data1,
            timeout: 6000,
            success: function (msg) {
                loadParagraphs()
            }
        });

        return false;
    });

    $('.formDida').submit(function (e) {
        e.preventDefault();
        fval = $(this).find('.imgdida').val()
        fpro = $(this).find('.imgproject').val()
        fref = $(this).find('.imgref').val()
        alert(fref)
        var data1 = { fval: fval, fpro: fpro, fref: fref };
        $.ajax({
            type: "POST",
            url: "/actions/edit_picture.asp",
            data: data1,
            timeout: 6000,
            success: function (msg) {
                loadParagraphs()
            }
        });
        return false;
    })
}

delPicture = function(iref) {
gtref=$('#edRef').val()

if (confirm('Eliminare l\'immagine?')) {
var data1 = {
load: gtref,
refb: iref
};

$.ajax({
  type: "POST",
  url: "/actions/del_picture.asp",
  data: data1,
  timeout: 6000,
  success    : function(msg) {
	loadParagraphs()
  }});
}
}


delParagraph = function(bref) {
gtref=$('#edRef').val()

if (confirm('Eliminare la gallery?')) {
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
edref=$('#editRef').val()

var data1 = {
load: gtref,
edref: edref,
ptype: 'gallery',
desc: desc1,
title: title1
};

$.ajax({
  type: "POST",
  url: "/actions/add_paragraph.asp",
  data: data1,
  dataType: "html",
  timeout: 6000,
  success    : function(msg) {
loadParagraphs()
	$('#title,#desc,#editRef').val('')

  }});
}



loadParagraphs = function() {
gtref=$('#edRef').val()

var data1 = {
ptype: 'gallery',
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
	setUploads()
makeSorted();


$('img.thumb').hover(function() {
$(this).attr('src','/images/thumb_o.png')
},function() {$(this).attr('src','/images/vuoto.gif')})
for (xv=0; xv<$('img.vImg').size(); xv++)
{
videoImg=$('img.vImg').eq(xv)	
videoSrc=videoImg.attr("rel");
getVideoImg(videoImg,videoSrc)

}


//$('div.myprojectsFrame', parent.document).css('height', $('div.showPackets').offset().top+$('div.showPackets').innerHeight()+50+'px')
//$('div.pText', parent.document).css('height',$('div.myprojectsFrame', parent.document).height()+180+'px')
closeprojectForm()
makeSortedParagraphs()

if (oldIeBrowser)
{
$('.fInput').css('display','inline')
$('.fInput').css('width','50px')
//$('.fInput').css('filter','alpha(opacity=0)')
}

},100)
  }});
}


makeDida = function(obj,ref) {
objid=obj.attr('rel');
objtx=obj.attr('longdesc');
$('#dida_'+ref).fadeIn(100);
$('#dida_'+ref+' input.imgdida').val(objtx)
$('#dida_'+ref+' input.imgref').val(objid)
$('#dida_'+ref+' input.imgdida').focus();
closeprojectForm()
}

makeSorted = function () {
$("div.sortImgs").sortable({  
items: "div.ithumb",
update: function (event, ui) {
objmove=ui.item;
newPos = objmove.index()+1;
gtref = objmove.find('img').attr('rel')
contref = objmove.parent().attr('rel')
$.ajax({

  url: "ord_pictures.asp?ref="+gtref+"&refp="+contref+"&newpos="+newPos+"&ssid=" + Math.floor((Math.random()*111111)+1),
  context: document.body,
  success: function(msg){ 
loadParagraphs()
}
  });
}
});
}


</script>
</body>
</html>

<%
End if
connection.close%>