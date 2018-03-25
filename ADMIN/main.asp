<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

livelli=max_level

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_langref.asp"-->
<%

if Len(Session("apertopanel"))=0 then
Scriva="onload=""window.open('panel.asp','','width=300,height=200,left=50,top=50');"" "
Session("apertopanel")="True"
else
scriva=""
end If


%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->

 <div id="content_page" style="float:left; clear:both">
<%if Session("allow_contenuti"&numproject)=True then%>
<p class="titolo"><script type="text/javascript">document.write(txt1);</script><br/>
<input type="text" value="search ..." style="border:solid 1px #bbb; border-radius:5px; color:#666; font-size:11px;padding:3px; width:120px" onfocus="searchVal($(this), $(this).val())" onkeypress="if (event.keyCode==13){ searchPost($(this).val()) }"/></p>
<form name="form1" method="post" action="main.asp">
	<%if Session("allow_languages"&numproject)=True then%>
	<%SQL="SELECT LO_pubblica,ID FROM lingue WHERE IN_valore="&Session("lang")
	set reclang=connection.execute(SQL)

		if not reclang.eof then
		pubblicalang=reclang("LO_pubblica")
		reflang=reclang("ID")
		if pubblicalang=True then
		chekka="checked"
		statolingua=""
		else
		chekka=""
		statolingua="a"
		end if
		end if
	%>

	<p class="titolo" style="font-size:11px">

	<script type="text/javascript">document.write(txt2);</script> <%=Session("nomelangv")%> <script type="text/javascript">document.write(txt2a);</script></b> <font class="testoadm">(<script type="text/javascript">document.write(txt3<%=statolingua%>);</script>)</font></p>
	<span style="float:left"><script type="text/javascript">document.write(txt4);</script>: <select name="lang" onchange="document.location='main.asp?lang='+this.options[this.selectedIndex].value;" class="testoadm">
	<option value="">...</option>
	<%
	if limitedlanguage=True then
	SQL="SELECT lingue.* FROM limita_lingue INNER JOIN lingue ON lingue.ID=limita_lingue.CO_lingue WHERE lingue.LO_attiva=True AND limita_lingue.CO_utenticantieri="&Session("IDuser")&" ORDER BY lingue.LO_main, lingue.IN_ordine ASC"
	else
	SQL="SELECT * FROM lingue WHERE LO_attiva=True ORDER BY IN_valore ASC"
	end if

	set record=connection.execute(SQL)



	do while not record.eof
	nomel=record("TA_nome")
	vall=record("IN_valore")
	refl=record("ID")

	if CInt(Session("lang")+1)<>CInt(refl) then
	%>
	<option value="<%=vall%>"<%=checcl%>><%=nomel%></option>
	<%
	end if
	record.movenext
	loop%></select></span> 
	<%end if%>

<%
Session("hideorder")=False
%></form>

<!--#INCLUDE VIRTUAL="./ADMIN/load_structure_new.asp"-->

<%end if%>
</div>

<script type="text/javascript">
var prevval;
function searchVal(objS, gtVal) {
prevval=gtVal;
if (gtVal=="search ...") objS.val('')
objS.bind('blur', function() {
if ($(this).val().length==0) $(this).val(prevval)
})
}


function searchPost(gtVal) {
gtVal=encodeURIComponent(gtVal);

gUrl="searchPosts.asp?load="+gtVal;
$.fancybox({
	href: gUrl,
	width: 750,
	height: 465,
	autoSize: false,
	type : 'iframe',
	iframe: {
	scrolling : 'auto',
	preload   : true
	},
	helpers	: {
			overlay : {
            css : {
                'background' : 'rgba(0, 0, 0, 0.35)'
            }}
	}});
}

</script>
</body>
</html>