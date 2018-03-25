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
pVideo=rec("TX_video_embed")
If Len(pVideo)>0 Then 
pVideo=Replace(pVideo,Chr(34)&Chr(34),Chr(34))
pVideoo=pVideo
		vSrc=getVideoSrc(pVideoo)
		advimg="<img class=""vImg"" src=""/images/vuoto.gif"" rel="""&vsrc&""" style=""width:130px; height:85px; border:solid 1px; float:right; cursor:pointer; margin:-85px 153px 0px 0px; background-position:center center; background-size:auto 100%; background-repeat:no-repeat;""/>"

End if
plink=linkMaker(ptitle)

%>
<!--#INCLUDE VIRTUAL="./project/project_make_header.asp"-->
<!--#INCLUDE VIRTUAL="./project/project_make_path.asp"-->
<p><strong class="tit">Video di presentazione</strong></p>
<p>
Inserisci un video di presentazione del tuo progetto <br/>
per incentivare le persone al suo finanziamento.<br/>
Chi inserisce un video ha più possibilità di essere finanziato!
</p>
<p class="vEmbed" >
<%=advimg%>
<span style="float:left; margin-right:10px">
<br/>Codice embed <a href="javascript:void(0)" rel="/project/embed_guide.html" class="vEmbd">(?)</a><br/>
<textarea style="width:412px; border:solid 1px #292f3a; background:#efefef; font-size:16px; height:28px; padding:5px" onfocus="$('#desc').parent().css('display','none'); $(this).height(98); $('input.dv').fadeIn()"  onblur="$('#desc').parent().fadeIn(50); $(this).height(28); $('input.dv').css('display','none')" onchange="updateVideo($(this).val())"><%=pVideo%></textarea><input type="button" class="bt dd1 dv" value="OK" alt="OK" rel="OK" style="display:none;float:right; clear:left; max-width:60px; margin-top:69px; margin-left:4px;"/>
</span>
</p>
<div style="clear:both; margin-bottom:50px;"></div>

<p style="margin:0px;"><strong class="tit">Descrizione del progetto</strong></p>
<div class="showPackets"></div>
<div style="clear:both"></div>

<input class="bt adbt" type="button" style="width:159px" value="nuovo paragrafo" onclick="loadprojectForm()"/>

<div class="projectForm" style="position:relative; width:700px; display:none">

<p>
<span style="float:left; margin-right:10px">
Titolo paragrafo<br/>
<input type="text" id="title" style="width:537px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value=""/>
</span>
</p>

<p>
<span style="float:left; margin-right:10px">
<br/>Testo paragrafo<br/>
<textarea id="desc" style="width:377px; border:solid 1px #292f3a; font-size:16px; height:118px; padding:5px"></textarea>
</span>
</p>

<span class="btn">
<input type="button" class="bt" value="avanti" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(2)"/>
<input type="button" class="bt" value="indietro" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(0)"/>
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
var pcat="<%=refcat%>";
$(document).ready(function() {

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

if ($('img.vImg').size()>0)
{
videoImg=$('img.vImg')	
videoSrc=videoImg.attr("rel");
getVideoImg(videoImg,videoSrc)
}

$('div.ppath span').eq(2).find('span').addClass('active')
make_edit(1);
make_editor($('#desc'))

loadParagraphs()

if (pcat.length>0) updEditColor('<%=pcolor%>',1)
})




addParagraph = function() {

gtref=$('#edRef').val()
desc1 = $('#desc').tinymce().getContent();
title1=$('#title').val()
edref=$('#editRef').val()


var data1 = {
load: gtref,
edref: edref,
ptype: 'description',
desc: desc1,
title: title1
};

$.ajax({
  type: "POST",
  url: "/actions/add_paragraph.asp",
  dataType: "html",
  data: data1,
  timeout: 6000,
  success    : function(msg) {
	$('#desc').val('')
	$('#title').val('')
	$('#editRef').val('');
	loadParagraphs()
	closeprojectForm()
  }});
}

updateVideo = function(gtVal) {
gtref=$('#edRef').val()
var data1 = {
vembed: gtVal,
load: gtref
};

$.ajax({
  type: "POST",
  url: "/actions/edit_video.asp",
  dataType: 'HTML',
  data: data1,
  timeout: 6000,
  success    : function(msg) {
	msg=''+msg;
	$('img.vImg').remove()
	if (msg.length>5)
	{
	$(''+msg).prependTo($('p.vEmbed'))
	videoImg=$('img.vImg')	
	videoSrc=videoImg.attr("rel");
	getVideoImg(videoImg,videoSrc)

	}
  }})

}

loadParagraphs = function() {
gtref=$('#edRef').val()

var data1 = {
ptype: 'description',
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
closeprojectForm()
makeSortedParagraphs()
},100)

  }});
}


</script>
</body>
</html>

<%
End if
connection.close%>