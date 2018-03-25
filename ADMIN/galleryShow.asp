<%
response.expires = -1500
response.AddHeader "PRAGMA", "NO-CACHE"
response.CacheControl = "PRIVATE"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

refgallery=request("refgallery")
addimg=request("addimg")


SQL="SELECT COUNT(immagini.ID) as contoimg, max(associa_galleries_immagini.IN_ordine) as maxord from associa_galleries_immagini INNER JOIN immagini ON immagini.ID=associa_galleries_immagini.CO_immagini WHERE associa_galleries_immagini.CO_galleries="&refgallery
set record=connection.execute(SQL)

if not record.eof then
contoimg=record("contoimg")
maxord=record("maxord")
else
contoimg=0
end if
if isnull(maxord) then maxord=0

if len(addimg)>3 then
maxord=maxord+1
SQL="INSERT INTO immagini (TA_nome) VALUES ('"&addimg&"')"
set record=connection.execute(SQL)

SQL="SELECT ID FROM immagini WHERE TA_nome='"&addimg&"'"
set record=connection.execute(SQL)
refimg=record("ID")

SQL="INSERT INTO associa_galleries_immagini (CO_immagini,CO_galleries,IN_ordine) VALUES ("&refimg&","&refgallery&","&maxord&")"
set record=connection.execute(SQL)


end if

SQL="SELECT immagini.*,associa_galleries_immagini.ID as refass, associa_galleries_immagini.IN_ordine as reford from associa_galleries_immagini INNER JOIN immagini ON immagini.ID=associa_galleries_immagini.CO_immagini WHERE CO_galleries="&refgallery&" ORDER BY associa_galleries_immagini.IN_ordine, associa_galleries_immagini.ID ASC"
set record=connection.execute(SQL)

if not record.eof then
h=0
do while not record.eof
h=h+1
file=record("TA_nome")
refi=record("ID")
refass=record("refass")


ord=record("reford")

if isnumeric(ord)=false Then ord=0
SQL="UPDATE associa_galleries_immagini SET IN_ordine="&h&" WHERE ID="&refass
set record1=connection.execute(SQL)
ord=h

%>
<li class="cImage" id="drag_<%=refass%>">
<div class="gImage" onclick="viewThumb('<%=file%>');" style="background-image: url(../img.asp?path=<%=file%>&amp;width=95)"></div>
<a href="javascript:delFile('vars=immagini,<%=refi%>,associa_galleries_immagini,CO_galleries,<%=refgallery%>,TA_nome,galleryShow.asp?refgallery=<%=refgallery%>');"><img src="./images/delete1.gif" border="0" alt="DELETE"/></a>
<a href="edit.asp?pagina=<%=refass%>&amp;tabella=associa_galleries_immagini&amp;da=edit_galleries"><img src="./images/left_just.gif" border="0" align="absmiddle" alt="DESCRIPTION" style="display:none"/></a>
</li>
<%
record.movenext
loop

end if
connection.close
%>
