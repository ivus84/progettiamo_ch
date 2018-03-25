<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
''ON ERROR RESUME NEXT

titletop="Gestione Intranet"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
<div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">
<p class="titolo"> <%=titletop%></p>


<p>
>&nbsp;&nbsp;<a href="intranet.asp">Gestione Gruppi</a> | <a href="list.asp?tabella=intranet_users">Gestione utenti</a> | <a href="list.asp?tabella=formulari">Gestione Sondaggi</a>  

<div id="structureContainerTable" style="position:relative;float:left;width:940px;border:solid 1px #999;margin-top:-1px;margin-left:-1px">

<div id="contentMenu" style="position:relative;float:left; width:215px; height:500px;overflow:hidden;border-right:solid 1px #999;background:#fff">
<input type="button" class="titolo" value="NUOVO GRUPPO" style="width:200px;margin:5px;" id="mybt1" onclick="document.location='insert1.asp?tabella=intranet_groups&amp;TA_nome=%20Nuovo%20Gruppo&da=intranet';"/><br/>
<br/>

<div id="previmgs_c" class="testoadm" style="position:relative; left:18px; top:4px; width:90%; height:87%; overflow:auto; padding:2px">
<ul style="Margin:0; padding:0; list-style: none">
<%


SQL="SELECT * FROM intranet_groups ORDER BY ID DESC"
set recordset=connection.execute(SQL)

vedicampo_="TA_nome"

if not recordset.eof then
mimgs=""
hnr=0
do while not recordset.eof

nn=recordset("ID")
tit=recordset("TA_nome")
''creata=recordset("DT_data")
''inviata=recordset("LO_sent")
''If inviata=True Then inviata=recordset("DT_data_invio")
%>
<li style="float:left;min-height:55px; margin:0px 0px 18px;width:180px;">Gruppo <b><%=tit%></b><br/>
<br/>
<input class="btn12" type="button" onclick="$('#edNews').attr('src','edit.asp?tabella=intranet_groups&pagina=<%=nn%>');" value="Edit"/>
</li>
<%

recordset.movenext
loop
recordset.movefirst


ON ERROR RESUME NEXT
setWImg=695

%>





</ul></div></div>
<div id="EditNewsletter" class="testoadm" style="float:left; margin-top:10px;margin-left:10px; width:<%=setWImg%>px;">
<iframe  id="edNews" scrolling="auto" style="width:<%=setWImg%>px; height:480px;border:solid 0px"></iframe>
</div>
</div>

<script type="text/javascript">

$(document).ready(function() {

});

function adCr(val) {
adv=$('#CR_oggetti').val();
$('#CR_oggetti').val(adv+val+",");
$('#formImg').submit();
}

function delCr(val) {

adv=$('#CR_oggetti').val();
adv=adv.replace(","+val+",",",");
$('#CR_oggetti').val(adv);
$('#formImg').submit();

}
</script>



</body>
</html>
<%response.End
End if%>