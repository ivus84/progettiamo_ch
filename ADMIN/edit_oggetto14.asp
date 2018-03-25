<%
ref=Session("ref")

SQL8="SELECT * FROM videos WHERE CO_oggetti="&ref&" ORDER BY IN_ordine ASC"
set recordset8=connection.execute(SQL8)



if recordset8.eof then response.write"Nessun video trovato"

response.write"&raquo; <a href=""new_video.asp?refogg="&Session("ref")&"&title="&titlepage&""">Crea nuovo video</a><br/><br/>"

if not recordset8.eof then 
do while not recordset8.eof
response.write"- <a href=""del.asp?tabella=videos&pagina="&recordset8("ID")&"&da=edit_oggetto1"" ALT=""del""><img src=images/delete1.gif border=0 align=absmiddle></a> <a href=""javascript:editVideo("&recordset8("ID")&");"">"&recordset8("TA_nome")&"</a><br/>"
lastID=recordset8("ID")
recordset8.movenext
loop
%>
<iframe id="edit_video" class="gallframe1" src="blank.asp" name="edit_video" scrolling="no" style="position:relative; left:-10px;top:10px;width:300px; height:0px; overflow:hidden;visibility:visible" frameborder="0"></iframe>

<script type="text/javascript">
function editVideo(ref) {
var obj=document.getElementById("edit_video")
obj.src="edit.asp?tabella=videos&pagina="+ref;
obj.style.height='275px';
obj.style.borderBottom='solid 1px #666666';
obj.style.borderLeft='solid 1px #666666';
obj.style.borderRight='solid 1px #666666';


}

</script>

<%end if%>