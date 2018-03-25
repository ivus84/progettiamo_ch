<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%nobg=True%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->

<%pagina=request("pagina")
if len(pagina)=0 then
response.end
end if

title=request("title")
If Len(title)>0 Then Session("titp")=title

Session("product")=pagina
%>
<div style="float:right">
<input type="BUTTON" value="X CHIUDI" id="mybt1" class="testoadm" onclick="closeThis();">
</div>


<font color="#FF0000"><b><%=Session("titp")%> - Immagini</b></font><br/><br/>
<a name="<%=ID%>g">
<form name="form1" action="makeUpload_or.asp" method="POST" EncType="multipart/form-data">
<input type="hidden" name="table" value="immagini_prodotti"/>
<input type="hidden" name="fieldF" value="TA_nome"/>
<input type="hidden" name="connectTable" value=""/>
<input type="hidden" name="addFields" value="CO_products"/>
<input type="hidden" name="returnurl" value="images_products.asp?pagina=<%=pagina%>"/>

<input type="hidden" name="gallery" value="<%=refgallery%>">
<input type="hidden" name="da" value="edit_galleries">
Carica # <select name="conto" class="testoadm" onchange="document.location='images_products.asp?pagina=<%=pagina%>&conto='+this.options[this.selectedIndex].value;">
<option value=1>...</option>
<option value=1>1</option>
<option value=2>2</option>
<option value=3>3</option>
<option value=4>4</option>
<option value=5>5</option>
<option value=6>6</option>
<option value=7>7</option>
</select> immagini
<%
conto=request("conto")
if len(conto)>0 then Session("conto")=conto

if len(Session("conto"))=0 then Session("conto")=1

h=0
do while h<CInt(Session("conto"))
h=h+1
%>
<br/>File <%=h%>&nbsp;
<input type="hidden" name="CO_products_<%=h%>" value="<%=pagina%>"/>

<input class="testoadm" type="file" name="File<%=h%>" style="width:140px">
<%
loop%>

<input class=testoadm type="submit" value="carica" class="titoloadm"  style="margin-left:8px;width:62px"><br/></form>

<%SQL="SELECT COUNT(immagini_prodotti.ID) as contoimg from immagini_prodotti WHERE CO_products="&pagina
set record=connection.execute(SQL)
contoimg=record("contoimg")
%>

<table cellpadding="0" cellspacing="1" border="0" style="margin-top:20px;"><tr><%
SQL="SELECT immagini_prodotti.* from immagini_prodotti WHERE CO_products="&pagina&" ORDER BY IN_ordine ASC"
set record=connection.execute(SQL)

if not record.eof then
h=0
do while not record.eof
h=h+1
file=record("TA_nome")
refi=record("ID")

ord=record("IN_ordine")

SQL="UPDATE immagini_prodotti SET IN_ordine="&h&" WHERE ID="&refi
set record1=connection.execute(SQL)
ord=h

%>
<td><div style="position:relative; left:0px; top:0px; width:50px; height:42px; overflow:hidden; border: solid 1px #efefef"><img src="../img.asp?path=<%=file%>&width=95" width="60" border="0" onmouseover="viewThumb('<%=file%>');" onmouseout="hideThumb();"/></div>
<a href="delFile.asp?vars=immagini_prodotti,<%=refi%>,,,,TA_nome,images_products.asp?pagina=<%=pagina%>"><img src=./images/delete1.gif border=0 alt="DELETE"></a> 
<%if h>1 then%><a href="ord_gallery_product.asp?ref=<%=refi%>&ord=<%=ord%>&mode=0&pagina=<%=pagina%>"><img src="../images/black_arrow_b.gif" border="0" alt="" style="margin-right:3px"/></a><%end if%><%if h<contoimg then%><a href="ord_gallery_product.asp?ref=<%=refi%>&ord=<%=ord%>&mode=1&pagina=<%=pagina%>"><img src="../images/black_arrow.gif" border="0" alt=""/></a><%end if%>
</td>
<%
if h=7 Then
response.write"</tr><tr>"
h=0
End if
record.movenext
loop
%><%end if%></tr></table>


<img src="../images/vuoto.gif" id="prevImgPic"  style="position:absolute;right:10px;top:40px;display:none;border:solid 25px #ffffff" />


<script type="text/javascript">


setTimeout("redimThis();",100);

var isVisi=0;

function viewThumb(thumb) {
isVisi=1; setw=250; 
isfotosrc="../img.asp?path="+thumb+"&width="+setw;
objimg=$('#prevImgPic')

$("<img/>") 
    .attr("src", isfotosrc)
    .load(function() {
        pic_real_width = this.width;
        pic_real_height = this.height;
if (pic_real_height>pic_real_width) { 
	setw=parseInt(setw / pic_real_height * pic_real_width);
isfotosrc="../img.asp?path="+thumb+"&width="+setw;
}

objimg.css('width',setw+'px');
objimg.attr('src',isfotosrc);
objimg.fadeIn('normal', function() {
isVisi=0;
});

});
}

function hideThumb(thumb) {
objimg=$('#prevImgPic')
if (isVisi==0)
{
objimg.css('display','none');
objimg.attr('src','./images/vuoto.gif');
}
}

</script>
</body>
</html>