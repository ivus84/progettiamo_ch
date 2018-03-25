	<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%if Session("allow_contenuti"&numproject)=True Then

nobg=True%>

<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<%addtarget=" target=""_top"""
hideorder=True
mode="list"
SQL="SELECT * FROM _config_menu"
set record=connection.execute(SQL)
livelli=CInt(record("IN_levels"))
maxlentitle=15
 Session("hideorder")=True
%>
<div id="content_page" style="position:relative; width:99%;min-width:260px; left:0px; padding-bottom:50px; top:0px; background: url(./images/bg_page.png) left bottom repeat-x;">
<!--#INCLUDE VIRTUAL="./ADMIN/load_structure_new.asp"-->
</div>

<%end if%>