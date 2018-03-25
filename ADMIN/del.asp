<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->

<%
ON ERROR RESUME NEXT

pagina=request("pagina")
da=request("da")
tabella=request("tabella")
conferma=request("conferma")


if Len(conferma)>0 then

if Len(pagina)=0 then
else

at_file=""

if tabella="associa_registeredusers_projects" Then
    SQL="SELECT CO_p_projects,IN_promessa FROM associa_registeredusers_projects WHERE ID="&pagina
    set recordset=connection.execute(SQL)
	If Not recordset.eof Then
	    CO_p_projects=recordset("CO_p_projects")
	    getPromised=recordset("IN_promessa")
	    SQL="UPDATE p_projects SET IN_raccolto=IN_raccolto-"&getPromised&" WHERE ID="&CO_p_projects
	    set recordset=connection.execute(SQL)
	End if
End if

if tabella="networking_files" then
	SQL="SELECT AT_file FROM "&tabella&" WHERE ID="&pagina
	set recordset=connection.execute(SQL)
	at_file=recordset("AT_file")
end if

if tabella="fails" then
	SQL="SELECT TA_nome FROM "&tabella&" WHERE ID="&pagina
	set recordset=connection.execute(SQL)
	at_file=recordset("TA_nome")
end if

if tabella="formulari" then
	SQL="DELETE from associa_ogg_formulari WHERE CO_formulari="&pagina
	set recordset=connection.execute(SQL)

	SQL="DELETE from formulari_dati WHERE CO_formulari="&pagina
	set recordset=connection.execute(SQL)
end if

if tabella="boxes" then
	SQL="DELETE from associa_ogg_boxes WHERE CO_boxes="&pagina
	set recordset=connection.execute(SQL)
End if

if tabella="_immagini_random" then
	SQL="SELECT AT_immagine FROM "&tabella&" WHERE ID="&pagina
	set recordset=connection.execute(SQL)
	at_file=recordset("AT_immagine")
end if

if len(at_file)>0 then

    dim fs
    Set fs=Server.CreateObject("Scripting.FileSystemObject")

    uploadsDirVar1=filespath&at_file
    uploadsDirVar3 = imagespath&at_file

    if fs.FileExists(uploadsDirVar1) then
        fs.DeleteFile(uploadsDirVar1)
    end if
    if fs.FileExists(uploadsDirVar3) then
        fs.DeleteFile(uploadsDirVar3)
    end if
end if

SQL="DELETE FROM " & tabella & " WHERE ID=" & pagina
set recordset=connection.execute(SQL)

if tabella="networking_groups" then
	SQL="DELETE FROM networking_themes WHERE CO_networking_groups="&pagina
	set recordset=connection.execute(SQL)
end if

if tabella="galleries" then
	SQL="DELETE FROM associa_galleries_immagini WHERE CO_galleries="&pagina
	set recordset=connection.execute(SQL)

	SQL="DELETE FROM associa_ogg_galleries WHERE CO_galleries="&pagina
	set recordset=connection.execute(SQL)
end If

if tabella="products" then
	SQL="DELETE FROM immagini_prodotti WHERE CO_products="&pagina
	set recordset=connection.execute(SQL)

	SQL="DELETE FROM fails_prodotti WHERE CO_products="&pagina
	set recordset=connection.execute(SQL)
end if

if tabella="p_comments" then
	SQL="DELETE from p_comments WHERE CO_p_comments="&pagina
	set recordset=connection.execute(SQL)
End if


if tabella="galleries" then Session("refgallery")=""

if tabella="galleries" then
    response.write"<html><body><script type=""text/javascript"">parent.document.location='main.asp?viewmode=edit_page.asp&viewmode1=gallery';</script></body></html>"
    response.end
end if



dalink=da&".asp"
if tabella="videos" then dalink=dalink&"?viewmode=video"
if tabella="associa_registeredusers_projects" Then  dalink = dalink&"?load=" & request("load")

'Response.write dalink
'Response.end
%>
<html><head>
<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script> 
</head><body><script language="javascript" type="text/javascript">
var acttab="<%=tabella%>"
$(document).ready(function() {
if ($('#editing_page', parent.document).size()>0 && acttab!="associa_registeredusers_projects" )
{
	parent.document.location=""+parent.document.location;
} else {
	document.location="<%=dalink%>";

}
closeThis();
});
</script>
</body></html>

<%
end if

else
%>
<html>
<head>
<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script> 
<script type="text/javascript" src="./jscripts/functions_editpage.js"></script>
</head>
<body style="font-family:verdana" bgcolor="#efefef"><center>
<br><br><br><br>
<center>
Confermi l'eliminazione di questo elemento?
<%If tabella="p_comments" then%><br/>Procedendo verranno eliminate anche eventuali risposte al commento<%End if%>

<br><br>
<input type="button" value="ANNULLA" id="mybt1" onclick="closeThis()"> <input type="button" id="mybt2" value="CONFERMA" onclick="document.location='del.asp?da=<%=da%>&pagina=<%=pagina%>&tabella=<%=tabella%>&conferma=True&load=<%=request("load")%>';">
<script language="javascript" type="text/javascript">
$(document).ready(function() {
<%if tabella<>"p_description" AND tabella<>"p_projects" AND tabella<>"p_comments"  AND tabella<>"associa_registeredusers_projects" AND tabella<>"registeredusers" then%>
redimThis();
<%else%>
$('#mybt1').remove()
<%end if%>
});
</script>
</body></html>
<%end If
connection.close%>