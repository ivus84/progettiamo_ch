<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
''ON ERROR RESUME NEXT
tabella="newsletter"
Session("tabella")=tabella


titletop="Gestione newsletter"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
<div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">
<p class="titolo"> <%=titletop%></p>


<p>
<!-- &nbsp;&nbsp;<a href="newsletter.asp">Gestione Invii</a>//-->

<div id="structureContainerTable" style="position:relative;float:left;width:940px;border:solid 1px #999;margin-top:-1px;margin-left:-1px">

<div id="contentMenu" style="position:relative;float:left; width:215px; height:500px;overflow:hidden;border-right:solid 1px #999;background:#fff">
<input type="button" class="titolo" value="NUOVA NEWSLETTER" style="width:200px;margin:5px;" id="mybt1" onclick="document.location='insert1.asp?tabella=newsletter&amp;TA_nome=%20Nuova%20Newsletter&da=newsletter';"/><br/>
<br/>

<div id="previmgs_c" class="testoadm" style="position:relative; left:18px; top:4px; width:90%; height:87%; overflow-y:auto; overflow-x:hidden; padding:2px">
<ul style="Margin:0; padding:0; list-style: none">
<%
refogg=request("refogg")
if len(refogg)>0 then refogg=CInt(refogg)


SQL="SELECT * FROM newsletter ORDER BY ID DESC"
set recordset=connection.execute(SQL)

vedicampo_="TA_nome"

if not recordset.eof then
mimgs=""
hnr=0
do while not recordset.eof

nn=recordset("ID")
tit=recordset("TA_nome")
    tit = convertfromutf8(tit)
creata=recordset("DT_data")
inviata=recordset("LO_sent")
dtinviata=inviata
If inviata Then dtinviata=recordset("DT_sent")
%>
<li style="float:left;min-height:55px; margin:0px 0px 18px;width:180px;">Newsletter n&ordm; <%=nn%><br/><b><%=tit%></b><br/>Creata il <%=creata%><br/>Inviata: <%=dtinviata%>
<br/>
<input class="btn12" type="button" onclick="$('#edNews').attr('src','newsletter_preview.asp?load=<%=nn%>');" value="View"/>
<%If Not inviata Then%>
<input class="btn12" type="button" onclick="$('#edNews').attr('src','edit.asp?tabella=newsletter&pagina=<%=nn%>');" value="Edit"/>
<input class="btn12" type="button" onclick="$('#edNews').attr('src','newsletter_preview.asp?load=<%=nn%>&mode=send');" value="Salva"/>
<%End if%>
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