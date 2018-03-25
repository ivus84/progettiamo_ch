<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
''ON ERROR RESUME NEXT

titletop="Gestione Progetti"

SQL="SELECT COUNT(ID) as upd_open FROM QU_updates WHERE LO_confirmed=False "
If Session("adm_area")>0 Then 
SQL=SQL&" AND CO_p_area="&Session("adm_area")
End If
set rec=connection.execute(SQL)
upd_open=rec("upd_open")


SQL="SELECT COUNT(ID) as upd_closed FROM QU_updates WHERE LO_confirmed=True "
If Session("adm_area")>0 Then 
SQL=SQL&" AND CO_p_area="&Session("adm_area")
End If
set rec=connection.execute(SQL)
upd_closed=rec("upd_closed")

titletop=titletop&" "&Session("name_areap")

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
<div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">
<p class="titolo"> <%=titletop%></p>


<p>
|&nbsp;<a href="projects.asp" style="font-size:12px">Lista progetti</a> | <a href="promoters.asp" style="font-size:12px">Gestione promotori</a>  | <a href="projects_updates.asp" style="font-size:12px"><b>Aggiornamenti progetti</b> (<b><%=upd_open%></b> da approvare)</a>  | <a href="projects_comments.asp" style="font-size:12px">Commenti progetti</a> 

<div id="structureContainerTable" style="position:relative;float:left;width:960px; min-height:400px; border:solid 1px #999;margin-top:-1px;margin-left:-1px">

<div id="contentMenu">

<div id="previmgs_c" class="testoadm">
<p style="padding:8px;background:#fff;margin:0px;font-size:12px; line-height:18px;">Visualizza <a style="font-size:12px;text-decoration:underline;" href="projects_updates.asp?mode=unapproved">da approvare</a> - <a style="font-size:12px;text-decoration:underline;" href="projects_updates.asp?mode=approved">approvati</a></p>
<%

SQL="SELECT * FROM QU_updates WHERE LO_confirmed=False "
wInt=upd_open&" aggiornamenti da approvare"

If request("mode")="approved" Then 
SQL="SELECT * FROM QU_updates WHERE LO_confirmed=True"
wInt=upd_closed&" aggiornamenti approvati"
End if

If Session("adm_area")>0 Then 
SQL=SQL&" AND CO_p_area="&Session("adm_area")
End If

If request("mode")="approved" Then 
SQL=SQL&" ORDER BY DT_data DESC"
else
SQL=SQL&" ORDER BY DT_data ASC"
End if
set rec=connection.execute(SQL)


%>
<p style="padding:8px;background:#efefef;margin:0px;font-size:12px; line-height:18px;"><b><%=wInt%></b></p>
<ul style="margin:0; padding:0; list-style: none">
<%

if not rec.eof then
mimgs=""
hnr=0
do while not rec.eof

nn=rec("ID")
tit=rec("p_name")
titN=rec("TA_nome")
pLink=linkMaker(tit)
confirmed=rec("LO_confirmed")
category=rec("category")
colore=rec("TA_color")

termine=rec("DT_data")

diffdays=dateDiff("d",Now(),termine)*-1

diffdays="Inserito da "&diffdays&"gg."

testo=rec("TX_testo")
im=rec("AT_file")

addTx="<div id=""w"&nn&""" class=""wW"" style=""position:absolute; background:#fff; display:none; left:302px;padding:30px;z-index:200; width:595px; min-height:350px;white-space:normal; font-size:12px; line-height:15px"" onmouseOut=""$(this).fadeOut()"">"
If Len(im)>0 Then addTx=addTx&"<img src=""/"&imgscript&"?path="&im&"$300""/><br/>"
addTx=addTx&"<b>"&titN&"</b><br/><br/>"&testo&"</div>"

tit=tit&"<br/><span style=""color:"&colore&"; font-size:11px"">"&category&"</span>"
If evidenza Then tit=tit&"&nbsp;<span style=""color:#7ac943; font-size:11px"">in evidenza</span>"
''creata=recordset("DT_data")
''inviata=recordset("LO_sent")
''If inviata=True Then inviata=recordset("DT_data_invio")

SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_projects="&nn&")"
Set rec1=connection.execute(SQL)
num_subscribers=rec1("subscribers")

%>
<li class="pp">
<span style="float:right; margin-top:11px;width:10px; height:10px; border:solid 1px #666; border-radius:10px; background:<%=colore%>; margin-right:8px;"></span>
<p style="margin-bottom:3px;cursor:pointer;" onclick="$('#edNews').attr('src','edit.asp?tabella=p_description&pagina=<%=nn%>');"><b style="font-size:12px"><%=tit%></b><br/><br/>
Titolo aggiornamento:<br/><b><%=titN%></b><br/><br/>
<%If Not confirmed then%>
<span style="color:#ff0000">In attesa di conferma</span> 
<%End if%> <%=diffdays%>
</p>
<p style="margin:0px"></p>
	<input class="btn12" type="button" style="float:left; width:70px;margin:4px 5px; " onclick="$('.wW').css('display','none'); $('#w<%=nn%>').fadeIn();" value="leggi"/>
	<%If Not confirmed then%>
	<input class="btn12" type="button" style="float:left; width:70px;margin:4px 5px; " onclick="$('.wW').css('display','none'); $('#edNews').attr('src','projects_confirm.asp?mode=updates&load=<%=nn%>');" value="approva"/>
	<input class="btn12" type="button" style="float:left; width:70px;margin:4px 5px; " onclick="$('.wW').css('display','none'); $('#edNews').attr('src','del.asp?tabella=p_description&pagina=<%=nn%>');" value="elimina"/>
	<%End if%>

<input class="btn12" type="button" style="float:right; width:50px; margin:4px 5px;" onclick="$('.wW').css('display','none'); $('#edNews').attr('src','edit.asp?tabella=p_description&pagina=<%=nn%>');" value="Edit"/>
<%=addTx%>
</li>
<%

rec.movenext
loop
rec.movefirst
End if

setWImg=640

%>





</ul></div></div>
<div id="EditNewsletter" class="testoadm" style="position:relative;float:left; margin-top:10px;margin-left:10px; width:<%=setWImg%>px;height:100%;">
<iframe id="edNews" scrolling="auto" style="position:relative; width:<%=setWImg%>px; height:97%;border:solid 0px"></iframe>
</div>
</div>

<script type="text/javascript">

$(document).ready(function() {
$('.wW').appendTo($('#structureContainerTable'))
resizeWin()
$(window).resize(function() {resizeWin()})
});

resizeWin=function() {
$('#structureContainerTable').height($(window).height()-$('#structureContainerTable').offset().top-20)
}

</script>
</body>
</html>
<%response.End
%>