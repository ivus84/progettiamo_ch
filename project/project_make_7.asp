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
plink=linkMaker(ptitle)

If len(termine)>0 Then termine=datevalue(termine)
%>
<!--#INCLUDE VIRTUAL="./project/project_make_header.asp"-->
<!--#INCLUDE VIRTUAL="./project/project_make_path.asp"-->
<p>
<a class="lblUpload" href="/project/project_make_9.asp?load=<%=load%>" style="margin-right:1px; padding: 10px 25px; font-size:14px">Fotogallery</a>
<a class="lblUpload bactive" href="/project/project_make_7.asp?load=<%=load%>" style="margin-right:1px; padding: 10px 25px; font-size:14px">Videogallery</a>
</p>

<div class="showPackets"></div>
<div style="clear:both"></div>
<input class="bt adbt" type="button" style="width:173px" value="nuovo video" onclick="loadprojectForm()"/>
<div class="projectForm" style="position:relative; width:700px; display:none">
<p>
<span style="float:left; margin-right:10px">
Titolo video<br/>
<input type="text" id="title" style="width:537px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value=""/>
</span>
</p>

<p>
<span style="float:left; margin-right:10px">
<br/>Descrizione video<br/>
<textarea id="desc" style="width:377px; border:solid 1px #292f3a; font-size:16px; height:118px; padding:5px"></textarea>
</span>
</p>


<p>
<span style="float:left; margin-right:10px">
<br/>Codice embed <a href="javascript:void(0)" rel="/project/embed_guide.html" class="vEmbd">(?)</a><br/>
<textarea id="embd" style="width:537px; border:solid 1px #292f3a; background:#efefef; font-size:16px; height:28px; padding:5px" onfocus="$('#desc').parent().css('display','none'); $(this).height(178)"  onblur="$('#desc').parent().fadeIn(50); $(this).height(28)"></textarea>
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
<script>
//VB:Sezione MEDIA - Video Gallery 
    $(document).ready(function () {
        $('div.ppath span').eq(6).find('span').addClass('active')
        make_edit(3);
        make_editor($('#desc'))
        loadParagraphs()

        $('a.vEmbd').click(function () {
            gtUrl = $(this).attr('rel')
            parent.$.fancybox({
                href: gtUrl,
                autoDimensions: false,
                autoSize: false,
                width: 581,
                height: 450,
                type: 'iframe',
                padding: 10,

                helpers: {
                    overlay: {
                        css: {
                            'background': 'rgba(255, 255, 255, 0.8)'
                        }
                    }
                }
            });
        })
    })

delParagraph = function(bref) {
gtref=$('#edRef').val()

if (confirm('Eliminare il video?')) {
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
embd1=$('#embd').val()
title1=$('#title').val()
edref=$('#editRef').val()

var data1 = {
load: gtref,
edref: edref,
ptype: 'video',
desc: desc1,
embd: embd1,
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
	$('#title,#desc,#embd,#editRef').val('')

  }});
}



loadParagraphs = function() {
gtref=$('#edRef').val()

var data1 = {
ptype: 'video',
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
makeSortedParagraphs()
closeprojectForm()

for (xv=0; xv<$('img.vImg').size(); xv++)
{
videoImg=$('img.vImg').eq(xv)	
videoSrc=videoImg.attr("rel");

	getVideoImg(videoImg,videoSrc)

}

},100)
  }});
}

</script>
</body>
</html>

<%
End if
connection.close%>