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

titletop=titletop&" "&Session("name_areap")

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
<div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">
<p class="titolo"> <%=titletop%></p>


<p>
|&nbsp;<a href="projects.asp" style="font-size:12px">Lista progetti</a> | <a href="promoters.asp" style="font-size:12px"><b>Gestione promotori</b></a> | <a href="projects_updates.asp" style="font-size:12px">Aggiornamenti progetti (<b><%=upd_open%></b> da approvare)</a>   

<div id="structureContainerTable" style="position:relative;float:left;width:960px; min-height:400px; border:solid 1px #999;margin-top:-1px;margin-left:-1px">

<div id="contentMenu">

<div id="previmgs_c" class="testoadm">
<%
load=request("load")

SQL="SELECT * FROM registeredusers WHERE LO_projects=True "
SQL1="SELECT COUNT(ID) as totp FROM registeredusers WHERE LO_projects=True "
If Session("adm_area")>0 Then 
SQL=SQL&" AND CO_p_area="&Session("adm_area")
SQL1=SQL1&" AND CO_p_area="&Session("adm_area")
End If

SQL=SQL&" ORDER BY TA_ente,TA_cognome"
set rec=connection.execute(SQL)
set rec1=connection.execute(SQL1)
totp=rec1("totp")


%>
<p style="padding:8px;background:#efefef;margin:0px;font-size:12px; line-height:18px;"><b><%=totp%> promotori
<input class="btn12" type="button" style="float:right; width:120px; margin:0px 2px;" onclick="$('#edNews').attr('src','projects_addpromoter.asp')" value="Crea promotore"/>

</p>
<ul style="margin:0; padding:0; list-style: none">
<%

if not rec.eof then
mimgs=""
hnr=0
do while not rec.eof

nn=rec("ID")
usrN=rec("TA_nome")
usrC=rec("TA_cognome")
usrE=rec("TA_ente")
usrEm=rec("TA_email")

''creata=recordset("DT_data")
''inviata=recordset("LO_sent")
''If inviata=True Then inviata=recordset("DT_data_invio")

SQL="SELECT COUNT(ID) as totprojects FROM (SELECT DISTINCT ID FROM p_projects WHERE (LO_confirmed OR LO_toconfirmed) AND CO_registeredusers="&nn&")"
Set rec1=connection.execute(SQL)
totprojects=rec1("totprojects")

SQL="SELECT COUNT(CO_p_projects) as totprojects1 FROM (SELECT DISTINCT CO_p_projects FROM QU_donators WHERE ID="&nn&")"
Set rec1=connection.execute(SQL)
totprojects1=rec1("totprojects1")

%>
<li class="pp">
<p style="margin-bottom:3px;cursor:pointer;"><b style="font-size:12px"><%=usrE%></b> <%=usrC%>&nbsp;<%=usrN%><br/><br/>
<%=totprojects%> progetti
</p>
<%If totprojects=0 then%>
<input class="btn12" type="button" style="float:left; width:153px; margin:4px 5px;" onclick="$('#edNews').attr('src','projects_convertpromoter1.asp?load=<%=nn%>');" value="Converti in finanziatore"/>
<%If totprojects1=0 then%>
<input class="btn12" type="button" value="del" onclick="$('#edNews').attr('src','del.asp?tabella=registeredusers&pagina=<%=nn%>&da=promoters')"/>
<%End if%>
<%End if%>

<input class="btn12" type="button" style="float:right; width:50px; margin:4px 5px;" onclick="$('#edNews').attr('src','edit.asp?tabella=registeredusers&pagina=<%=nn%>&mode=notmodal');" value="Edit"/>
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
resizeWin()
$(window).resize(function() {resizeWin()})

<%if len(load)>0 then%>
$('#edNews').attr('src','edit.asp?tabella=registeredusers&pagina=<%=load%>&mode=notmodal');
<%end if%>

});

resizeWin=function() {
$('#structureContainerTable').height($(window).height()-$('#structureContainerTable').offset().top-20)
}

</script>
</body>
</html>
<%response.End
%>