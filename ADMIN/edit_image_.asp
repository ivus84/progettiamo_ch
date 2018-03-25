<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<% Response.CacheControl = "no-cache" %>
<% Response.AddHeader "Pragma", "no-cache" %>
<% Response.Expires = -1 %>
<%
nobg=True
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
mode=request("mode")
if mode="deleted" then%>
<script type="text/javascript">
parent.document.form2.submit();</script><%end if%>

<%
path=request("path")

SQL="SELECT * FROM immagini WHERE TA_nome='"&path&"'"
set recordset=connection.execute(SQL)

ii=1

refimg=0
if not recordset.eof Then refimg=recordset("ID")%>
<body >

<div style="position:absolute;z-index:1000;right:5px; top:5px;">
<input type="button" value="X CHIUDI" style="margin:0px; width:80px;" class="editBtns" onclick="closeThis();">
</div>

<div id="container">
<div id="content"><%

SQL="SELECT DISTINCT associa_galleries_immagini.CO_galleries AS ref,'gallery' as mode FROM associa_galleries_immagini WHERE CO_immagini="&refimg&" UNION SELECT DISTINCT oggetti.ID as ref,'text' as mode FROM oggetti WHERE Instr(LCase(TX_testo),LCase('"&path&"'))>0 OR Instr(TX_testo_1,'"&path&"')>1 OR Instr(TX_testo_2,'"&path&"')>1 OR Instr(TX_testo_3,'"&path&"')>1 OR Instr(TX_testo_4,'"&path&"')>1 UNION SELECT DISTINCT oggetti.ID as ref,'int' as mode FROM oggetti WHERE AT_image='"&path&"'"

Set RecordSet = Server.CreateObject("ADODB.Recordset")
RecordSet.PageSize = 50
RecordSet.CacheSize = 50
RecordSet.Open SQL, Connection, adOpenStatic, adLockReadOnly

ispublishedon=0
if not recordset.eof then ispublishedon=RecordSet.RecordCount



dim myImg, fs

strFilePath = imagespath&path

larg1=340

on error resume next
noexist=True
Set filesys = CreateObject("Scripting.FileSystemObject")
if filesys.FileExists(strFilePath) then noexist=False



%>

<div style="width:100%">
<%if noexist=False then
Set f = filesys.GetFile(strFilePath)
datecreated=f.DateCreated
datemodified=f.DateLastModified
filetype=f.Type
filesized=f.size
filesized=Round(filesized/1000,0)
set filesys=nothing
set f=nothing
%><div style="position:relative; width:100%; text-align:center; margin:8px 0px;">
<img id="viewImage" src="../images/vuoto.gif" style="width:330px; height:250px; border:solid 1px #666666;background-color:#ffffff; background-repeat:no-repeat; background-position:center center; background-size: auto 100%"/></div>

<div style="position:relative; width:100%; text-align:center">
<div style="width:330px; margin:10px auto; text-align:left;">
<div style="float:left; clear:left;width:80px;">Image size:&nbsp;</div><div style="float:left"><span id="wImg"></span></div>

<div style="float:left; clear:left;width:80px;">File size:&nbsp;</div><div style="float:left"><%=filesized%> KB</div>
<div style="float:left; clear:left;width:80px;">File type:&nbsp;</div><div style="float:left"><%=filetype%></div>
<div style="float:left; clear:left;width:80px;">Uploaded on:&nbsp;</div><div style="float:left"><%=datecreated%></div>
<div style="float:left; clear:left;width:80px;">Last modified:&nbsp;</div><div style="float:left"><%=datemodified%></div>

<form name="form1" action="resample_image.aspx" method="GET"><input type="hidden" name="filename" value="<%=path%>">
<div style="float:left; clear:left;width:80px;">Downsize to&nbsp;</div><div style="float:left"><input type="text" name="towidth" class="testoadm" style="text-align:right" value="" onchange="javascript:setproportion(this.value);" size=4 maxlenght=4>x<input type=text name="toheight" class="testoadm" style="text-align:right" value="" size="3" maxlenght="4" disabled="disabled">px <input class="testoadm" type="submit" value="RESAMPLE">
</div></form>
<%else%>
<%End if%>
<div style="float:left; clear:left">Published on:</div><div style="clear:left;float:left">
<%if noexist=True then%>
Original file not found <a href="delImg.asp?path=<%=path%>&da=edit_image_.asp?mode=deleted"><img src="./images/delete1.gif" border="0" align="bottom"/></a><br/>
<%end if%>
<%if ispublishedon=0 then%>Not published <a href="delImg.asp?path=<%=path%>&da=edit_image_.asp?mode=deleted"><img src="./images/delete1.gif" border="0" align="bottom"/></a>

<%Else
do while not recordset.eof

ref=recordset("ref")
mode=recordset("mode")

If InStr(mode,"link_")>0 Then 
mode=Replace(mode,"link_","")
response.write mode
else
If mode="text" Or mode="int" then
SQL="SELECT TA_nome as nome from oggetti WHERE ID="&ref
set rec=connection.execute(SQL)
nome=rec("nome")
response.write"<a href=""edit_page.asp?ref="&ref&""" target=""_top"">"&nome&"</a><br/>"
Else
SQL="SELECT TA_nome as nome from galleries WHERE ID="&ref
set rec=connection.execute(SQL)
nome=rec("nome")
response.write nome&"<br/>"

End If
End if
recordset.movenext
loop
End if
%></div>
</div></div>
</div></div>
<script type="text/javascript">
$(document).ready(function() {
redimThis();
getImageSize('<%=path%>');
});

function isNumeric(x) {
var RegExp = /^(-)?(\d*)(\.?)(\d*)$/;
var result = x.match(RegExp);
return result;
}

var xmlHttp
function getImageSize(dest) {
isfotosrc="../img.asp?path="+dest;
setw=350; 
fotoprev=isfotosrc+"&width="+setw;

$("<img/>") 
    .attr("src", isfotosrc)
    .load(function() {
        pic_real_width = this.width;
        pic_real_height = this.height;

$("#wImg").html(pic_real_width+"x"+pic_real_height+" px");
document.form1.towidth.value=pic_real_width;
document.form1.toheight.value=pic_real_height;

 $("#viewImage").css("background-image","url("+fotoprev+")");
});
}

function setproportion(larg)
{
var img=document.getElementById("viewImage");
var wI=img.width;
var hI=img.height;
alta2=parseInt((hI*larg)/wI);
document.form1.toheight.value=alta2;
}


</script>
<%connection.close%>
</body>
</html>
