<%SQL="SELECT associa_ogg_galleries.ID as refass, associa_ogg_galleries.CO_galleries, galleries.TA_nome"&Session("reflang")&" as namegall FROM associa_ogg_galleries INNER JOIN galleries on associa_ogg_galleries.co_galleries=galleries.ID WHERE associa_ogg_galleries.CO_oggetti="&Session("ref")&" ORDER BY galleries.ID ASC"
set recordg=connection.execute(SQL)%>
<br/><b>PhotoGallery</b><br/>
<%if recordg.eof then%><a style="color:#00a0e3" href="new_gallery.asp?refogg=<%=Session("ref")%>&title=<%=titlepage%>">Crea Gallery</a><%End if%><br/><%

if not recordg.eof then
containgallery=True

do while  not recordg.eof
ID=recordg("CO_galleries")
nomegall=recordg("namegall")
refass=recordg("refass")
If Len(nomegall)>40 Then nomegall=Mid(nomegall,1,40)
%>

<a class="testoadm" href="del.asp?tabella=galleries&pagina=<%=ID%>&da=main.asp?viewmode=edit_page.asp&viewmode1=gallery" target="editing_page" onclick="setEditing();"><img src="./images/delete1.gif" border="0" align="absmiddle"></a> 

<a style="display:none" class="testoadm" href="javascript:editGallery('edit.asp?tabella=galleries&pagina=<%=ID%>&da=edit_galleries');"><img src="./images/edit.gif" border="0" align="absmiddle"></a> 
<a id="linkGallery" href="javascript:void(0)" onclick="editGallery('edit_galleries.asp?refgallery=<%=ID%>');" style="text-decoration:none"><b><%=nomegall%></b></a><br/>


<br/>
<%
lastID=ID
recordg.movenext
loop%>

<iframe id="edit_gallery" class="gallframe" src="blank1.asp" name="edit_gallery"  scrolling="auto" style="position:relatve;float:left;clear:both;z-index:100;width:289px; border:0px; overflow:auto;" frameborder="0"></iframe>
<script type="text/javascript">
var GallSetted=0;
function editGallery(dest) {
var obj=$("#edit_gallery")
obj.attr("src",dest); 
hh=obj.parent().parent().height()-obj.offset().top-2;
if (GallSetted==0)
{
obj.css("height",hh+"px");
obj.css("min-height",hh+"px");
GallSetted=1;
}}


</script>
<%end if%>