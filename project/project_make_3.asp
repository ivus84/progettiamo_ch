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
minima=rec("IN_cifra_minima")
freedonate=rec("LO_free_donate")
		pObj=rec("IN_cifra")
		termine=rec("DT_termine")
		twidget=rec("TX_widget")
plink=linkMaker(ptitle)

If minima=0 Or Len(minima)=0 Then 
minima=10
SQL="UPDATE p_projects SET IN_cifra_minima=10 WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec1=connection.execute(SQL)
End if

%>
<!--#INCLUDE VIRTUAL="./project/project_make_header.asp"-->
<!--#INCLUDE VIRTUAL="./project/project_make_path.asp"-->
<div style="clear:both"></div>

<p>
Inserisci qui la cifra minima per l'offerta.<br/>Importo minimo 10 Fr.<br/><br/>
</p>

<div style="position:relative; width:700px">
<p>
<span style="float:left; margin-right:10px; width:250px; display:none">
Permetti offerta libera <span style="float:right; margin-top:-1px"><input class="cb" id="LOFR" type="checkbox" <%If freedonate then%>checked="checked" <%End if%> onclick="setVals('LO_free_donate',$(this))"/><label for="LOFR"><span></span></label></span>
</span>
</p>
<div style="clear:both"></div>
<p>
<span style="float:left">
Sostegno minimo Fr.<br/>
<input type="number" id="cifra" onfocus="$('.avvia',parent.document).css('display','none'); if ($(this).val().length==0) $(this).val(10); " style="width:128px; border:solid 1px #292f3a; font-size:16px; line-height:16px; height:27px; padding:10px 5px" value="<%=minima%>" onblur="setVals('IN_cifra_minima',$(this))"/>
</span>
</p>
</div>
<div style="clear:both"></div>
<span style="float:left; margin-right:10px;">
<br/>
<%If Len(twidget)>0 AND InStr(twidget,"<script>") AND InStr(twidget,"timerepublik.com") Then
			twidget=Replace(twidget,Chr(34)&Chr(34),Chr(34))
			Response.write "<div id=""wWidget"" style=""position:absolute; width:120px; min-height:60px; max-height:60px; margin-top:0px; left:460px;"">"&twidget&"</div>"
			End if%>
<b>Inserisci qui il codice del widget di Time Republik</b><br/>
<a href="javascript:void(0)" rel="/project/trepublik_guide.html" class="vEmbd">Di cosa si tratta? come si fa? dove lo trovo?</a><br/><br/>
<textarea style="width:412px; border:solid 1px #292f3a; background:#efefef; font-size:16px; height:28px; padding:5px" onfocus="$(this).height(98); $('input.dv').fadeIn()"  onblur="$('#desc').parent().fadeIn(50); $(this).height(28); $('input.dv').css('display','none')" onchange="updateWidget($(this).val())"><%=twidget%></textarea><input type="button" class="bt dd1 dv" value="OK" alt="OK" rel="OK" style="display:none;float:right; clear:left; max-width:60px; margin-top:69px; margin-left:4px;"/>



</span>

<div style="clear:both"></div>
<div class="showPackets"></div>
<div style="clear:both"></div>
<input class="bt adbt" type="button" style="width:159px" value="aggiungi benefit" onclick="loadprojectForm()"/>
<div class="projectForm" style="position:relative; width:700px; display:none">


<div style="clear:both"></div>
<p style="margin:0px">
<b>Benefits per i finanziatori</b>
</p>
<p>
<span style="float:left; margin-right:10px">
Nome benefit<br/>
<input type="text" id="title" style="width:317px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value=""/>
</span>
<span style="clear:left; float:left; margin-top:10px">
Da Cifra Fr.<br/>
<input type="text" id="cifra_" style="width:148px; text-align:right;border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value=""/>
</span>
<span style="float:left; margin-top:10px; margin-left:8px;">
A Cifra Fr.<br/>
<input type="text" id="cifra_a" style="width:148px; text-align:right;border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value=""/>
</span>
</p>


<p>
<span style="clear:left; float:left; margin-right:10px">
<br/>Descrizione Benefit<br/>
<textarea id="desc" style="width:317px; border:solid 1px #292f3a; font-size:16px; height:72px; padding:5px"></textarea>
</span>
</p>

<span class="btn">
<%If Session("log45"&numproject)<>"req895620schilzej" then%>
<%If pObj>0 And isnull(termine)=False then%><input type="button" class="bta avvia" style="display:none;" value="Richiedi approvazione" onclick="$('.myprojectsFrame iframe').attr('src','/project/project_make_8.asp?load=<%=load%>'); $('html, body').animate({scrollTop: 0},400)"/><%End if%>
<input type="button" class="bt" value="anteprima" onclick="document.location='/?progetti/<%=load%>/preview-project'"/>
<%End if%>
<input type="button" class="bt" value="indietro" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(4)"/>
</span>



<div class="ddM"><input type="button" class="bt dd2" value="annulla" onclick="noEditParagraph()"/><input type="button" class="bt dd1" value="salva" alt="salva" rel="salva" onclick="addPacket()"/></div>


</div>

<div style="clear:both">

<p style="text-align:right; width:480px; margin-top:-10px">
<input type="hidden" id="edRef" value="<%=load%>" />
<input type="hidden" id="editRef" value="" />
</p>
</div>
<script>
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


$('div.ppath span').eq(10).find('span').addClass('active')
make_edit(5);
make_editor($('#desc'))
loadBenefits()

setTimeout(function() {
gtVal=$('#cifra').val()
if (gtVal.length>0 && $.isNumeric(gtVal)) { 
	if (gtVal>=10) $('.avvia',parent.document).fadeIn()
}
},500)
})

delBenefit = function(bref) {
gtref=$('#edRef').val()

if (confirm('Eliminare il Benefit?')) {
var data1 = {
load: gtref,
refb: bref
};

$.ajax({
  type: "POST",
  url: "/actions/del_benefits.asp",
  data: data1,
  timeout: 6000,
  success    : function(msg) {
	loadBenefits()
  }});
}
}

addPacket = function() {
gtref=$('#edRef').val()
desc1 = $('#desc').tinymce().getContent();
title1=$('#title').val()
cifra1=$('#cifra_').val()
cifra2=$('#cifra_a').val()
edref=$('#editRef').val()

var data1 = {
load: gtref,
edref: edref,
desc: desc1,
title: title1,
cifra: cifra1,
cifra1: cifra2
};

$.ajax({
  type: "POST",
  url: "/actions/add_benefits.asp",
  data: data1,
  dataType: "html",
  timeout: 6000,
  success    : function(msg) {
		$('#title,#desc,#cifra_,#cifra_a,#editRef').val('')

	loadBenefits()
  }});
}



loadBenefits = function() {
gtref=$('#edRef').val()

var data1 = {
load: gtref
};

$.ajax({
  type: "POST",
  url: "/actions/load_benefits.asp",
  data: data1,
  timeout: 6000,
  success    : function(msg) {
	  $('div.showPackets').html(msg)
setTimeout(function() {
closeprojectForm()
},100)

  }});
}

setVals = function(field, obj) {
gtval="False"

if (field.indexOf('LO_')!=-1) { 
	if (obj.is(':checked')) gtval="True" 
	}
if (field.indexOf('IN_')!=-1) {
	obj.css('border','solid 1px #292f3a')

	gtval=obj.val()

if (!$.isNumeric(gtval)) {
obj.css('border','solid 1px #ff0000')
gtval=10;
obj.val(gtval)
}

if (gtval<10)
{
obj.css('border','solid 1px #ff0000')
gtval=10;
obj.val(gtval)
}

}

gtref=$('#edRef').val()
var data1 = {
setval: gtval,
setref: gtref,
setfield: field
};


$.ajax({
  type: "POST",
  url: "/actions/update_val.asp",
  data: data1,
  timeout: 6000,
  success    : function(msg) {

gtVal=$('#cifra').val()

if (gtVal.length>0 && $.isNumeric(gtVal)) { 
	if (gtVal>=10) $('.avvia',parent.document).fadeIn()
}


  }});


}

updateWidget = function(gtVal) {

$('#wWidget').html('')

gtref=$('#edRef').val()
var data1 = {
vembed: gtVal,
load: gtref
};

$.ajax({
  type: "POST",
  url: "/actions/edit_widget.asp",
  dataType: 'HTML',
  data: data1,
  timeout: 6000,
  success    : function(msg) {
	msg=''+msg;
	$('img.vImg').remove()
	if (msg.length>5)
	{
	parentEdit(5)
	return
	}
  }})

}
</script>
</body>
</html>

<%
End if
connection.close%>