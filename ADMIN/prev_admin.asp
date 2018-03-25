<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<%
if len(Session("licensekey"))>0 then
Set Connection1=Server.CreateObject("ADODB.Connection")
Connection1.Open "PROVIDER=Microsoft.Jet.OLEDB.4.0;" & "Data Source=" & licensepath & ";" & "Jet OLEDB:Database Password="&Session("licensekey")
%>
<div id="menu_upmain_admin" style="position:absolute;z-index:99;right:90px;top:0px; width:70px; height:28px; padding:0px;<%=adddispmenu%>">
<a href="edit.asp?tabella=_config_admin&pagina=1"><b>Adv.Config</b></a>
</div>
<%end if%>


