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

If Len(Session("adm_area"))>0 Then
SQL="SELECT TA_nome FROM p_area WHERE ID="&Session("adm_area")
set rec=connection.execute(SQL)
If Not rec.eof Then Session("name_areap")=rec("TA_nome")
End if
titletop=titletop&" "&Session("name_areap")
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
<div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">
<p class="titolo"> <%=titletop%></p>


<p>
|&nbsp;<a href="projects.asp" style="font-size:12px"><b>In Corso</b></a> | <a href="projects.asp?vMode=in_preparazione" style="font-size:12px">In preparazione</a> | <a href="projects.asp?vMode=scaduti" style="font-size:12px">Scaduti</a> | <a href="projects.asp?vMode=chiusi" style="font-size:12px">Archiviati</a> | <a href="projects.asp?vMode=in_evidenza" style="font-size:12px">In evidenza</a> | <a href="projects.asp?vMode=newsletter" style="font-size:12px">Pr.Newsletter</a> | <a href="promoters.asp" style="font-size:12px">Gestione promotori</a> | <a href="projects_updates.asp" style="font-size:12px">Aggiornamenti progetti (<b><%=upd_open%></b> da approvare)</a> | <a href="projects_comments.asp" style="font-size:12px">Commenti progetti</a> 


<div id="structureContainerTable" style="position:relative;float:left;width:960px; min-height:400px; border:solid 1px #999;margin-top:-1px;margin-left:-1px">

<div id="contentMenu">

<div id="previmgs_c" class="testoadm">
<%
vMode=request("vMode")

SQL="SELECT * FROM QU_projects WHERE (LO_toconfirmed=True OR LO_confirmed=True) AND LO_deleted=False AND ID>0"
If vMode="chiusi" Then SQL="SELECT * FROM QU_projects WHERE LO_deleted=True AND ID>0"


If Session("adm_area")>0 Then SQL=SQL&" AND CO_p_area="&Session("adm_area")
preSQL=SQL

If Len(vMode)=0 Then SQL=SQL&"AND dateDiff('d',Now(),DT_termine)>=0"
If vMode="scaduti" Then SQL=SQL&"AND dateDiff('d',Now(),DT_termine)<0"


If vMode="in_evidenza" Then SQL=SQL&" AND LO_in_evidenza"
If vMode="newsletter" Then SQL=SQL&" AND LO_newsletter=True"

If vMode="in_preparazione" Then 
SQL="SELECT * FROM QU_projects WHERE LO_toconfirmed=False AND LO_confirmed=False AND LO_deleted=False AND ID>0 AND instr(TA_nome,'Nuovo progetto')=false"
If Session("adm_area")>0 Then SQL=SQL&" AND CO_p_area="&Session("adm_area")
End If



If vMode="in_preparazione" Then 
SQL=SQL&" ORDER BY [p_projects].DT_apertura DESC"
else
SQL=SQL&" ORDER BY LO_confirmed DESC, LO_realizzato DESC, DT_termine ASC, category ASC, TA_nome ASC"
end if
set rec=connection.execute(SQL)

SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises)"
If Session("adm_area")>0 Then SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_area="&Session("adm_area")&")"
Set rec1=connection.execute(SQL)
tot_subscribers=rec1("subscribers")

%>

<%If vMode="in_preparazione" Then%>
<p style="padding:0px 5px 10px 5px; font-weight:bold; font-size:14px; border-bottom:solid 1px #999">Progetti in preparazione</p>
<%End if%>



<%If vMode="in_evidenza" then%>
<p style="padding:0px 5px 10px 5px; font-weight:bold; font-size:14px; border-bottom:solid 1px #999">Progetti in evidenza</p>
<p style="padding:0px 10px">Aggiungi progetto "In evidenza"<br/>
<select name="refproject" style="width:220px" onchange="$('#edNews').attr('src','projects_set.asp?tab=LO_in_evidenza&val=True&load='+$(this).val())"><option value="">...</option>
<%
SQL=preSQL&" AND LO_in_evidenza=False"
Set recpre=connection.execute(SQL)
Do While Not recpre.eof
Response.write "<option value="""&recpre("ID")&""">"&convertfromutf8(recpre("TA_nome"))&"</option>"
recpre.movenext
loop%>
</select></p>
<%End if%>

<%If vMode="newsletter" then%>
<p style="padding:0px 5px 10px 5px; font-weight:bold; font-size:14px; border-bottom:solid 1px #999">Progetti Newsletter</p>
<p style="padding:0px 10px">Aggiungi progetto a "Newsletter"<br/>
<select name="refproject" style="width:220px"  onchange="$('#edNews').attr('src','projects_set.asp?tab=LO_newsletter&val=True&load='+$(this).val())"><option value="">...</option>
<%
SQL=preSQL&" AND LO_newsletter=False"
Set recpre=connection.execute(SQL)
Do While Not recpre.eof
Response.write "<option value="""&recpre("ID")&""">"&convertfromutf8(recpre("TA_nome"))&"</option>"
recpre.movenext
loop%>
</select></p>
<%End if%>

<ul style="margin:0; padding:0; list-style: none">
<%

if not rec.eof then
mimgs=""
hnr=0
do while not rec.eof

nn=rec("ID")
tit=rec("TA_nome")
If Len(tit)>0 Then tit=Replace(tit,"#","'")
tit=convertfromutf8(tit)
pLink=linkMaker(tit)
confirmed=rec("LO_confirmed")
toconfirmed=rec("LO_toconfirmed")
realizzato=rec("LO_realizzato")
evidenza=rec("LO_in_evidenza")
newsletter=rec("LO_newsletter")
category=rec("category")
colore=rec("TA_color")
refU=rec("CO_registeredusers")
usrC=rec("usrC")
usrN=rec("usrN")
usrE=rec("usrE")
    usre=convertfromutf8(usre)

termine=rec("DT_termine")
refProject=rec("ID")
cifra=rec("IN_cifra")
mezzi=rec("IN_mezzi_propri")
raccolto=rec("IN_raccolto")
raccolto=raccolto+mezzi

visto=rec("IN_viewed")

diffdaysReal=dateDiff("d",Now(),termine)*-1
diffdays=diffdaysReal
status=""
If cifra>0 Then status=Round(raccolto/cifra*100,1)
If diffdays<=0 Then 
diffdays=", "&diffdays&"gg. alla chiusura"
Else
diffdays=", scaduto"
End if
If realizzato Then diffdays=", realizzato"

tit=tit&"<br/><span style=""color:"&colore&"; font-size:11px"">"&category&"</span>"
If evidenza Then tit=tit&"&nbsp;<span style=""color:#7ac943; font-size:11px"">in evidenza</span>"
If newsletter Then tit=tit&"&nbsp;<span style=""color:#349a42; font-size:11px"">newsletter</span>"
''creata=recordset("DT_data")
''inviata=recordset("LO_sent")
''If inviata=True Then inviata=recordset("DT_data_invio")

SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_projects="&nn&")"
Set rec1=connection.execute(SQL)
num_subscribers=rec1("subscribers")

If Len(usrE)=0 Or isnull(usrE) Then 
usrE = usrC&"&nbsp;"&usrN
End if

SQL="SELECT * FROM registeredusers WHERE ID="&refU
Set rec1=connection.execute(SQL)
If Not rec1.eof then
%>
<li class="pp">
<span style="float:right; margin-top:11px;width:10px; height:10px; border:solid 1px #666; border-radius:10px; background:<%=colore%>; margin-right:8px;"></span>
<p style="margin-bottom:3px;cursor:pointer;" onclick="$('#edNews').attr('src','projects_project.asp?load=<%=nn%>')"><b style="font-size:12px"><%=tit%></b><br/><br/>
<%If Not confirmed And toconfirmed then%>
<span style="color:#ff0000">In attesa di conferma</span>
<%ElseIf Not confirmed And Not toconfirmed then%>
<span style="color:#ff0000">In preparazione</span>
<%else%>
<b><%=status%>%</b><%=diffdays%><span style="float:right"><%=visto%> visite</span>
<%End if%>

</p>
<p style="margin:0px">promotore: <a href="promoters.asp?load=<%=refU%>"><b><%=usrE%></b></a></p>


	<%If vMode="in_evidenza" then%>	<input class="btn12" type="button" style="float:left; width:63px;margin:4px 4px; " onclick="$('#edNews').attr('src','projects_set.asp?tab=LO_in_evidenza&val=False&load=<%=nn%>');" value="RIMUOVI"/><%End if%>
	<%If vMode="newsletter" then%>	<input class="btn12" type="button" style="float:left; width:63px;margin:4px 4px; " onclick="$('#edNews').attr('src','projects_set.asp?tab=LO_newsletter&val=False&load=<%=nn%>');" value="RIMUOVI"/><%End if%>


</li>
<%
End if
rec.movenext
loop
rec.movefirst
End if

setWImg=640

%>





</ul></div></div>
<div id="EditNewsletter" class="testoadm" style="position:relative;float:left; margin-top:10px;margin-left:10px; width:<%=setWImg%>px;height:100%;">
<iframe id="edNews" scrolling="auto" src="projects_stats.asp" style="position:relative; width:<%=setWImg%>px; height:97%;border:solid 0px"></iframe>
</div>
</div>

<script type="text/javascript">

$(document).ready(function() {
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
connection.close
%>