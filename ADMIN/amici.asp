<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%


Session("idcantedit")=0
Session("admpage")="utenti.asp"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->

 <div id="content_page">

<p class="titolo">Amici di Progettiamo.ch</p>

<table style="width:100%;border:0px; padding:0px;margin-top:10px" cellspacing="0">
    <tr><td colspan="1"><input type="button" class="titolo" style="width:200px; margin-left:5px" value="Aggiungi utente" id="mybt1" onclick="document.location='amici_creautente.asp';"><br/></td></tr>
</table>
<table cellspacing="0" style="width:255px;border:solid 1px #999999;padding:4px;margin-top:20px">

<%
toAppend=""
if Session("adm_area")<>0 then toAppend=" and co_p_area=" & Session("adm_area") & " "
'VB:Calcolo il numero dei fixed
SQL="SELECT count(ID) as contau FROM friends where fixed=true and lo_pubblica=true" & toAppend 
set record1=connection.execute(SQL)
Session("nFixed")=record1("contau")

SQL0="SELECT * FROM friends where 1=1 " & toAppend & " ORDER BY p_name ASC"
set record0=connection.execute(SQL0)

do while not record0.eof

    ref=record0("ID")
    nome=record0("p_name")
    titolo=record0("TA_title")

    if colore="#FFFFFF" then
        colore="#EFEFEF"
    else
        colore="#FFFFFF"
    end if
    imgDisabled=""
    if record0("lo_pubblica")=False then imgDisabled="<img src=""images/utenti_off.gif"" border=""0"" alt=""disabled"" style=""float:right""/>" 
    %>
        <tr style="background-color:<%=colore%>"><td class="testoadm" style="padding:4px"><b><%=nome%></b> <%=titolo%></td><td> <a href="amici_utente.asp?ref1=<%=ref%>" target="editing_page" onclick="setEditing();"><img src="images/edit.gif" border="0" style="float:right"/></a> </td><td> <a href="del.asp?tabella=friends&pagina=<%=ref%>&da=utenti" target="editing_page" onclick="setEditing();"><img src="images/delete1.gif" border="0" style="float:right"/></a></td><td><%=imgDisabled %></td></tr>
    <%
    record0.movenext
Loop

page=request("page")
%>
</table>
<script type="text/javascript">
$(document).ready(function() {
$('.mMenu').not('.hMenu').eq(7).addClass('active');

<%
If Len(page)>0 Then
%>
$('#editing_page').attr('src','amici_utente.asp?ref1=<%=page%>');
setEditing();
<%
End if
%>
})
</script>




