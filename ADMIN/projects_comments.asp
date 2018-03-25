<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
''ON ERROR RESUME NEXT

titletop="Gestione Commenti Progetti"

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
|&nbsp;<a href="projects.asp" style="font-size:12px">Lista progetti</a> | <a href="promoters.asp" style="font-size:12px">Gestione promotori</a>  | <a href="projects_updates.asp" style="font-size:12px">Aggiornamenti progetti</a> | <a href="projects_comments.asp" style="font-size:12px"><b>Commenti progetti</b></a> 

<div id="structureContainerTable" style="position:relative;float:left;width:960px; min-height:400px; border:solid 1px #999;margin-top:-1px;margin-left:-1px">

<div id="contentMenu">

<div id="previmgs_c" class="testoadm">
<%
SQL="SELECT * FROM QU_comments WHERE CO_p_comments=0 ORDER BY DT_apertura"

If Session("adm_area")>0 Then 
SQL=SQL&" AND CO_p_area="&Session("adm_area")
End If

set rec=connection.execute(SQL)


%>
<p style="padding:8px;background:#efefef;margin:0px;font-size:12px; line-height:18px;">&nbsp;</p>
<ul style="margin:0; padding:0; list-style: none">
<%

if not rec.eof then
mimgs=""
hnr=0
do while not rec.eof

nn=rec("ID")
'tit=rec("p_name")
titN=rec("project")
termine=rec("DT_data")
user_n=rec("TA_ente")&" "&rec("TA_cognome")&" "&rec("user_n")

diffdays=dateDiff("d",Now(),termine)*-1

diffdays="Inserito da "&user_n&" "&diffdays&" giorni fa"

testo=rec("TX_testo")
If Len(testo)>0 Then testo=ClearHTMLTags(testo,0)
If Len(testo)>160 Then testo=Mid(testo,1,160)&" ..."


%>
<li class="pp">
<p style="margin-bottom:3px;cursor:pointer;" onclick="$('#edNews').attr('src','edit.asp?tabella=p_comments&pagina=<%=nn%>');"><b style="font-size:12px"><%=titN%></b><br/><br/>
Testo commento<br/><b><%=testo%></b><br/><br/>
 <%=diffdays%>
</p>
<p style="margin:0px"></p>
<input class="btn12" type="button" style="float:left; width:70px;margin:4px 5px; " onclick="$('.wW').css('display','none'); $('#edNews').attr('src','del.asp?tabella=p_comments&pagina=<%=nn%>');" value="elimina"/>
<input class="btn12" type="button" style="float:right; width:50px; margin:4px 5px;" onclick="$('.wW').css('display','none'); $('#edNews').attr('src','edit.asp?tabella=p_comments&pagina=<%=nn%>');" value="Edit"/>
</li>
<%

SQL="SELECT * FROM QU_comments WHERE CO_p_comments="&nn&" ORDER BY DT_data"

If Session("adm_area")>0 Then 
SQL=SQL&" AND CO_p_area="&Session("adm_area")
End If

set rec1=connection.execute(SQL)
do while not rec1.eof

nn1=rec1("ID")
termine=rec1("DT_data")
user_n=rec1("TA_ente")&" "&rec1("TA_cognome")&" "&rec1("user_n")

diffdays=dateDiff("d",Now(),termine)*-1

diffdays="Inserito da "&user_n&" "&diffdays&" giorni fa"

testo=rec1("TX_testo")

If Len(testo)>0 Then testo=ClearHTMLTags(testo,0)

If Len(testo)>160 Then testo=Mid(testo,1,160)&" ..."


%>
<li class="pp" style="padding-left:10%;width:90%">
<p style="margin-bottom:3px;cursor:pointer;" onclick="$('#edNews').attr('src','edit.asp?tabella=p_comments&pagina=<%=nn1%>');">
Testo risposta<br/><b><%=testo%></b><br/><br/>
 <%=diffdays%>
</p>
<p style="margin:0px"></p>
	<input class="btn12" type="button" style="float:left; width:70px;margin:4px 5px; " onclick="$('.wW').css('display','none'); $('#edNews').attr('src','del.asp?tabella=p_comments&pagina=<%=nn1%>');" value="elimina"/>

<input class="btn12" type="button" style="float:right; width:50px; margin:4px 5px;" onclick="$('.wW').css('display','none'); $('#edNews').attr('src','edit.asp?tabella=p_comments&pagina=<%=nn1%>');" value="Edit"/>
</li>
<%
rec1.movenext
loop



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