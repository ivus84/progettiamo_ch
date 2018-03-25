<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%
load=request("load")
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM QU_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
ptitle=rec("TA_nome")
pcolor=rec("TA_color")
refcat=rec("refcat")
plink=linkMaker(ptitle)

%>
<!DOCTYPE html>
<html lang="it">
<head><title>Progettiamo.ch - Il Ticino insieme - Crowdfunding promosso dagli Enti Regionali per lo Sviluppo del Canton Ticino</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="/css/styles.css" media="all" />
<script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/js/site.min.js"></script>
<script type="text/javascript" src="/admin/jscripts/tiny_mce3.5.10/jquery.tinymce.js"></script>
<link rel="shortcut icon" href="/prog.ico" />
<meta name="robots" content="noindex"/>
</head>
<body class="editing">
<!--#INCLUDE VIRTUAL="./project/project_make_path.asp"-->
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
<input type="button" class="bt" value="avanti" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(3)"/>
<input type="button" class="bt" value="indietro" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(1)"/>
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
$('div.ppath span').eq(4).find('span').addClass('active')
make_edit(2);

make_editor($('#desc'))

loadParagraphs()

if (pcat.length>0) updEditColor('<%=pcolor%>',2)

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
desc = $('#desc').tinymce().getContent();
title=$('#title').val()
edref=$('#editRef').val()

var data1 = {
load: gtref,
edref: edref,
ptype: 'about',
desc: desc,
title: title
};

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

	loadParagraphs()
  }});
}



loadParagraphs = function() {
gtref=$('#edRef').val()

var data1 = {
ptype: 'about',
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