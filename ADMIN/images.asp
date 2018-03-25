<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<%
titletop="<script>document.write(menu11);</script>"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
 <div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">

<b> <%=titletop%></b>

<div id="menu_ecommerce" style="position:absolute; left:65px; top:0px; display:none">
>&nbsp;&nbsp;<a href="javascript:setDest('diaporama.asp');">Immagini Intestazione</a> | <a href="javascript:setDest('list_images1.asp');">Immagini Contenuti</a> | 
</div></div>
<iframe id="edit_ecommerce" width="800" height="480" style="position:absolute; left:16px; top:120px; height:770px; border:solid 0px #EFEFEF; width:800px; overflow:auto" frameborder="no" src="diaporama.asp" ></iframe>
<form name="form1" action="list_images1.asp" method="POST">
</form>
<script type="text/javascript">
function setDest(dest) { document.getElementById("edit_ecommerce").src=dest; }
</script>
</body>
</html>
