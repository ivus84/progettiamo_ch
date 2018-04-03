<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
nobg=True

function reptext(testo)
if len(testo)>0 then
testo=replace(testo,"&#45;","-")
testo=replace(testo,"&#40;","(")
testo=replace(testo,"&#41;",")")
testo=replace(testo,"&#39;","'")
end if
reptext=testo
end function

ref=request("ref")

if len(ref)>0 then Session("ref")=ref

if len(request("lang"))>0 then
Session("lang")=request("lang")
if Session("lang")>0 then
Session("reflang")="_"&Session("lang")
else
Session("reflang")=""
end if
end if

Session("refadmin")=Session("ref")

issection=False
isnewselement=False
isauthor=False

SQL="SELECT oggetti.*, oggetti.CO_oggetti AS refredir, oggetti.TA_nome"&Session("reflang")&" as TA_nome_ac,oggetti.LO_pubblica"&Session("reflang")&" AS pubblica,oggetti.TX_testo"&Session("reflang")&" as testo_Edit, newsection.isnews,  newsection.CO_oggetti AS refcontainer FROM oggetti INNER JOIN newsection ON oggetti.ID=newsection.ID WHERE oggetti.LO_deleted=False AND oggetti.ID="&Session("ref")
mainSQL=SQL
set recordset=connection.execute(SQL)

if not recordset.eof then
TA_nome_ac=recordset("TA_nome_ac")
LO_Pubblica=recordset("pubblica")
testo=recordset("testo_Edit")

isnewselement=recordset("isnews")


containersection=recordset("refcontainer")
If containersection=0 Or IsNull(containersection) then issection=True

previewreference=Session("ref")
If iscomitato=True Then previewreference=containersection
If isdownload=True Then previewreference=containersection


TA_duedate=recordset("TA_duedate")
TA_linkto=recordset("TA_linkto"&Session("reflang"))
TA_boxes=recordset("TA_boxes")
TX_embed=recordset("TX_embed")
DT_data=recordset("DT_data")
LO_homepage=recordset("LO_homepage")
LO_news=recordset("LO_news")
LO_commerce=recordset("LO_commerce")
LO_protected=recordset("LO_protected")
LO_menu2=recordset("LO_menu2")
AT_image=recordset("AT_image")
AT_image_1=recordset("AT_image_1")
AT_image_2=recordset("AT_image_2")
AT_image_3=recordset("AT_image_3")
AT_image_4=recordset("AT_image_4")
LO_hidetitleonpage=recordset("LO_hidetitleonpage")
LO_hidemainmenu=recordset("LO_hidemainmenu")
LO_contact_page=recordset("LO_contact_page")
LO_networking=recordset("LO_networking")
LO_list_section=recordset("LO_list_section")
LO_reserved=recordset("LO_reserved")
ref_redir=recordset("refredir")

chekka=""
Statooggetto="non pubblicato"

if LO_Pubblica=True then
chekka="checked=""checked"""
Statooggetto="pubblicato"
else
	LO_Pubblica=False
end if

chekka1=""
if LO_homepage=True then chekka1="checked=""checked"""

chekka2=""
if LO_news=True then chekka2="checked=""checked"""

chekka3=""
if LO_commerce=True then chekka3="checked=""checked"""

chekka10=""
if LO_protected=True then chekka10="checked=""checked"""

chekka11=""
if LO_hidetitleonpage=True then chekka11="checked=""checked"""

chekka12=""
if LO_menu2=True then chekka12="checked=""checked"""

chekka13=""
if LO_hidemainmenu=True then chekka13="checked=""checked"""

chekka14=""
if LO_contact_page=True then chekka14="checked=""checked"""

chekka16=""
if LO_networking=True then chekka16="checked=""checked"""

chekka15=""
if LO_list_section=True then chekka15="checked=""checked"""

chekka18=""
if LO_reserved=True then chekka18="checked=""checked"""


if Isnull(CO_suppliers)=True then CO_suppliers=0

if Len(TA_nome)>0 then
TA_nome = Replace(TA_nome,"&#40;", "(")
TA_nome = Replace(TA_nome,"&#41;" , ")")
TA_nome = Replace(TA_nome, "&nbsp;&nbsp;",  CHR(32) & CHR(32))
TA_nome = Replace(TA_nome, "&quot;", CHR(34))
TA_nome = Replace(TA_nome, "&nbsp;", CHR(37))
    ta_nome = convertfromutf8( ta_nome )
end if

if Len(TA_linkto)>0 Then TA_linkto = Replace(TA_linkto,"&#39;", "'")
if Len(TA_linkto_1)>0 Then TA_linkto_1 = Replace(TA_linkto_1,"&#39;", "'")
if Len(TX_embed)>0 Then TX_embed = Replace(TX_embed,"&#39;", "'")


titlepage=TA_nome_ac
title1=TA_nome_ac

TX_testo=recordset("TX_testo"&Session("reflang"))
end if

h_prev=464

leftdivs=650

viewmode=request("viewmode")
disp_options="inline"
disp_position="none"
disp_files="none"
disp_gallery="none"
disp_videos="none"

if viewmode="position" then
disp_options="none"
disp_position="inline"
end if

if viewmode="files" then
disp_options="none"
disp_files="inline"
end if

if viewmode="gallery" then
disp_options="none"
disp_gallery="inline"
end if

if viewmode="video" then
disp_options="none"
disp_videos="inline"
end if


nlink=linkMaker(TA_nome_ac)

linkPage="http://"&Request.ServerVariables("HTTP_HOST")&"/?"&Session("ref")&"/"&nlink
%>



<div id="contentEdit" style="position;relative; float:left; width:70%; margin-top:-60px;">
	<div class="titolo" style="position:relative; float:left; padding:3px 0px 4px 10px; width:100%; height:15px;  border-left:solid 1px #c1c1c1; border-top:solid 1px #c1c1c1; background:url(./images/bg_menu.png) left -35px repeat-x;"><%=titlepage%>
	</div>

<div id="overEditor" class="edPage" style="position:absolute; left:0px; display:inline;z-index:999; top:-30px; left:px;width:70%;height:<%=h_prev+70%>px;border:solid 0px">
<a href="javascript:movePreview();"><img src="images/vuoto.gif" border="0" width="100%" height="100%"/></a>
</div>


<iframe id="txtPreview" class="normalPreview" name="txtPreview" scrolling="no" allowTransparency="true" src="../page.asp?modeview=preview&load=<%=previewreference%>&getsubref=<%=Session("ref")%>"></iframe>
</div>

<%ref=Session("ref")%>


<div id="optContainer" style="position:absolute; right:0px; width:300px;margin-top:-60px;">
<!--#INCLUDE VIRTUAL="./ADMIN/edit_oggetto_options.asp"-->
</div>



<div id="prevImgPicContainer"><img src="../images/vuoto.gif" id="prevImgPic" style="position:relative; margin:auto" alt=""/></div>


<%ref=Session("ref")%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_editor_tmce.asp"-->

<%connection.close%>