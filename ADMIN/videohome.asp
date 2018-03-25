<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%


Session("idcantedit")=0
Session("admpage")="utenti.asp"

Session("required")="TA_video_title"
Session("maxlength")="TA_video_title~70,TX_video_subtitle~95"

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->

<!--Serve per il ritorno al menù principale-->
 <div id="content_page">

<p class="titolo">Video Home</p>

<table style="width:100%;border:0px; padding:0px;margin-top:10px" cellspacing="0">
    <tr>
        <td colspan="1">
          <a href="edit.asp?tabella=_config_video&amp;pagina=0&da=videohome" target="editing_page" onclick="setEditing();"><img alt"Aggiungi Video" src="IMAGES/newdata.gif"/>Aggiungi Video Home</a>
        </td>
    </tr>
</table>

<table cellspacing="0" style="width:255px;border:solid 1px #999999;padding:4px;margin-top:20px">

<%
SQL="SELECT * FROM _config_video"
set record0=connection.execute(SQL)

do while not record0.eof

    ref=record0("ID")
    titolo=record0("TA_video_title")

    if colore="#FFFFFF" then
        colore="#EFEFEF"
    else
        colore="#FFFFFF"
    end if
    %>
        <tr style="background-color:<%=colore%>"><td class="testoadm" style="padding:4px"><b> <%=titolo%></td><td> <a href="edit.asp?tabella=_config_video&amp;pagina=<%=ref%>&da=videohome" target="editing_page" onclick="setEditing();"><img src="images/edit.gif" border="0" style="float:right"/></a> </td><td> <a href="del.asp?tabella=_config_video&pagina=<%=ref%>&da=videohome" target="editing_page" onclick="setEditing();"><img src="images/delete1.gif" border="0" style="float:right"/></a></td></tr>
    <%
    record0.movenext
Loop

page=request("page")
%>
</table>