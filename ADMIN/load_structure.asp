<%
response.expires = -1500
response.AddHeader "PRAGMA", "NO-CACHE"
response.CacheControl = "PRIVATE"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
disabledeletefolder=False 
refer=Request.ServerVariables("HTTP_REFERER")

if len(maxlentitle)=0 then maxlentitle=60

SQL00="SELECT * FROM limita_contenuti WHERE CO_utenticantieri="&Session("IDuser")
set recordset00=connection.execute(SQL00)

if recordset00.eof then%>

<div style="float:right; width:110px; padding:0px;height:13px;margin-top:-15px;overflow:hidden">
<div class="mMen">Ord</div>
<div class="mMen">New</div>
<div class="mMen">Del</div>
<div class="mMen">Mod</div>
</div>
<div class="stCont" style="background:#fff; margin-top:-1px; border-left:solid 1px #d1d1d1;border-top:solid 1px #d1d1d1;"></div>
<%

limited=False
SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, TA_nome"&Session("refmainlang")&" as TA_nomedef, newsection.sopra"&Session("reflang")&" as sopra, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica, LO_news,LO_menu2,LO_protected FROM newsection WHERE LO_deleted=False AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
else
limited=True
SQL="SELECT DISTINCT newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.TA_nome"&Session("refmainlang")&" as TA_nomedef, newsection.sopra"&Session("reflang")&" as sopra, newsection.ID AS ID, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica,newsection.LO_news,newsection.LO_protected,newsection.LO_menu2 FROM (limita_contenuti INNER JOIN newsection ON limita_contenuti.CO_oggetti = newsection.ID) LEFT JOIN oggetti ON newsection.CO_oggetti = oggetti.ID WHERE newsection.LO_deleted=False AND limita_contenuti.CO_utenticantieri="&Session("IDuser")
end if

set recordset=connection.execute(SQL)


serierefs="|"

numsezio=0
do while not recordset.eof
numsezio=numsezio+1
totlevels=1

ID=recordset("ID")

serierefs=serierefs&ID

nomesezione=recordset("TA_nome")
    nomesezione = convertfromutf8( nomesezione ) 
nome_default=recordset("TA_nomedef")
pubblicas=recordset("LO_pubblica")
isnews=recordset("LO_news")
iscal=recordset("LO_protected")
sopra=recordset("sopra")

nomeprevsec=sopra

nomesezione=Mid(nomesezione,1,maxlentitle)

if IsNull(nomesezione)=True OR len(nomesezione)=0 Or InStr(nomesezione,"Nuova Pagina")>0 Then nomesezione="No name ("&nome_default&")"

classa="lowText"
if pubblicas=True then classa="lowTextP"


SQL="SELECT COUNT(newsection.ID) as macron FROM newsection WHERE CO_oggetti="&ID
set rec1=connection.execute(SQL)
macron=rec1("macron")

arr1="<img src=""/images/vuoto.gif"" style=""width:23px; height:17px; margin-bottom:4px;float:left"" alt=""""/>"

if macron>1 AND isnews<>True then arr1="<a href=""javascript:openEdit('ordina.asp?sezio="&ID&"');"" class=""testoadmn""><img src=""./images/order.png"" border=""0"" alt="""" style=""width:18px; float:left margin-top:2px;margin-left:6px;""/></a>"


img1="page"
if macron>0 then img1="folder"


if len(nomeprevsec)>0 then nomesezione=nomeprevsec&" &raquo; "&nomesezione

linkpage="javascript:void(0);"" onclick=""viewLevel("&ID&",1);"
if macron=0 Then linkpage="javascript:openEdit('edit_page.asp?ref="&ID&"');"

'If Session("hideorder")=True AND ID&""=Session("ref") Then color1="#ffc75a"

If color1="#fff" Then
color1="#f7f7f7"
Else
color1="#fff"
End if

%>

<div class="level_1" title="edit_page.asp?ref=<%=ID%>" style="width:100%;padding:0px;border-top:solid 1px #f2f2f2; padding:2px 0px; background-color:<%=color1%>" onmouseover="$(this).css('background-color','#f2f2f2');" onmouseout="$(this).css('background-color','<%=color1%>');">
<div id="imgLevel<%=ID%>" style="float:left; background: url(images/<%=img1%>.png) -13px top no-repeat;padding-left:25px; width:55%; overflow:hidden;"><a href="<%=linkpage%>"<%=trg%> class="<%=classa%> stContA" onclick="$('.stContA').css('font-weight','normal'); $('.stContA').parent().parent().css('background-color','#fff'); $(this).css('font-weight','bold'); $(this).parent().parent().css('background-color','#c0edfd');"><%=nomesezione%></a></div>
<div style="white-space: nowrap; float:right;padding-right:4px;">
<a href="javascript:openEdit('edit_page.asp?ref=<%=ID%>');" class="macrosezione"><img src="images/edit.png" border="0" alt="EDIT" style="width:18px;margin-left:4px; margin-top:2px;float:left;"/></a>
<a href="javascript:delEdit('del_section.asp?pagina=<%=ID%>');"><img src="images/del.png" border="0" alt="DELETE" style="width:18px; margin-left:6px;margin-top:2px;float:left;"/></a>
<a href="new_pag1.asp?pagina=<%=ID%>" class="suboggetti"><img src="images/new.png" border="0" alt="NEW SUB-PAGE" style="width:18px; float:left; margin-left:6px;margin-top:2px;"/></a>

<%if hideorder<>True then%>
<%if pubblicas=False then%>
<a href="publish_element.asp?tabella=oggetti&ref=<%=ID%>"><img src="images/publish.png" border="0" align="absmiddle" alt="publish"  style="width:18px; float:left;margin-left:6px;margin-top:2px;"/></a>
<%if Session("allow_languages"&numproject)=True And Session("refmainlang")<>Session("reflang") then%><a href="copy_content.asp?ref=<%=ID%>"><img src="images/code.gif" border=0 style="display:none" alt="Copy from main Language"/></a><%end if%>
<%else%>
<%=arr1%>
<%end if%>
<%end if%>
</div>
<div id="submenu_container<%=ID%>" class="loadSt"></div>
</div>
<%
recordset.movenext
Loop
connection.close
%>
<div style="width:100%;float:left;text-align:right;border-top:solid 1px #999999"><input type="button" style="display:none" id="btck" onclick="delSelected();" value="Elimina selezionati"/></div>
##$$##<%
If limited=False then

addlinks="new_pag1.asp?pagina=0,_self,Nuova sezione#"&_
"javascript:openEdit('ordina.asp?sezio=0');,editPage,Ordina sezioni#"&_
""
'"list.asp?tabella=boxes,_self,Offerte#"&_
'"list.asp?tabella=sponsors,_self,sponsors#"&_
addlinks=split(addlinks,"#")

for x=0 to UBound(addlinks)-1
glink=split(addlinks(x),",")
adTarget=glink(1)
adLink=glink(0)
if adTarget="editPage" then 
adTarget=""
else
adTarget=" target="""&adTarget&""""
end if
%>
<div class="ordContent">
<a href="<%=adLink%>" class="macrosezione"<%=adTarget%>><%=glink(2)%></a>
</div>
<%
Next
End if
%>