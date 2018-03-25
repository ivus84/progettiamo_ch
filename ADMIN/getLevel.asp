<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

load=request("load")
lev=request("lev")
If Len(lev)=0 Then lev=1
maxlentitle=20

If IsNumeric(load)=True then
refer=Request.ServerVariables("HTTP_REFERER")
If InStr(Session("openedStructure"), ","&load&"#"&lev&",")=0 Then Session("openedStructure")=Session("openedStructure") & ","&load&"#"&lev&","
islevel=lev+1

''addtarget=" target=""editPage"""


SQL1="SELECT newsection.ID,  newsection.DT_data, newsection.TA_nome"&Session("reflang")&" as TA_nome,  newsection.TA_nome"&Session("refmainlang")&" as TA_nomedef, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica, oggetti.LO_news,oggetti.LO_menu2 FROM newsection INNER JOIN oggetti ON oggetti.ID=newsection.CO_oggetti WHERE newsection.CO_oggetti="&load&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordset=connection.execute(SQL1)

If Not recordset.eof Then
LO_news=recordset("LO_news")
LO_menu2=recordset("LO_menu2")
	If LO_news=True Then

		SQL1="SELECT newsection.ID,  newsection.DT_data, newsection.TA_nome"&Session("reflang")&" as TA_nome,  newsection.TA_nome"&Session("refmainlang")&" as TA_nomedef, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica, oggetti.LO_news,oggetti.LO_menu2 FROM newsection INNER JOIN oggetti ON oggetti.ID=newsection.CO_oggetti WHERE newsection.CO_oggetti="&load&" ORDER BY newsection.DT_data DESC, newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"

		set recordset=connection.execute(SQL1)

newselement=True
	End if
End if

	do while not recordset.eof
	ID=recordset("ID")
	nomesezione=recordset("TA_nome")
	viewdata=recordset("DT_data")
	nome_default=recordset("TA_nomedef")

	pubblicas=recordset("LO_pubblica")

viewdata=Day(viewdata)&"."&Month(viewdata)
if IsNull(nomesezione)=True OR len(nomesezione)=0 Or InStr(nomesezione,"Nuova Pagina")>0 Then nomesezione="No name ("&nome_default&")"

classa="lowText"
if pubblicas=True then classa="lowTextP"


SQL="SELECT COUNT(newsection.ID) as macron FROM newsection WHERE CO_oggetti="&ID
set rec1=connection.execute(SQL)
macron=rec1("macron")

arr1="<img src=""/images/vuoto.gif"" style=""width:23px; height:17px; margin-bottom:4px;float:left""/>"
img1="page"
linkpage="javascript:void(0); viewLevel("&ID&","&islevel&");"

if macron>0 then 
img1="folder"
if macron>1 then arr1="<a href=""javascript:openEdit('ordina.asp?sezio="&ID&"');"""&addtarget&"><img src=""./images/order.png"" border=""0"" alt="""" style=""width:18px; margin-top:2px;float:left""/></a>"
else
linkpage="javascript:openEdit('edit_page.asp?ref="&ID&"');"
End if

if newselement=True OR isevent=True then  
nomesezione=viewdata&" "&nomesezione
islevel=max_level
End if

nomesezioneorig=nomesezione
'nomesezione=Mid(nomesezione,1,maxlentitle)


If color1="#fff" Then
color1="#f7f7f7"
Else
color1="#fff"
End if
'If ID&""=Session("ref") Then color1="#ffc75a"
%>
<div class="sLevelDiv" style="position:relative; float:left;clear:left; width:100%;white-space:nowrap;border-top:solid 1px #f2f2f2; padding:2px 0px; background-color:<%=color1%>" onmouseover="$(this).css('background-color','#f2f2f2');" onmouseout="$(this).css('background-color','<%=color1%>');">
	<div id="imgLevel<%=ID%>" class="elmntStr" style="float:left;white-space:nowrap; height:22px; width:60%; overflow:hidden; background: url(images/<%=img1%>.png) -2px top no-repeat;cursor: pointer;" onclick="<%=linkpage%>">
	<%If macron=0 then%>
	<input type="checkbox" onclick="chb(<%=ID%>);" style="float:left;margin-right:18px;z-index:999;"/>
	<%else%>
	<img src="/images/vuoto.gif" style="height:1px; width:14px;margin-right:18px"/>
	<%End if%>
	<a title="<%=nomesezioneorig%>" href="javascript:void(0)" class="<%=classa%> stContA" style="text-decoration:none" onclick="$('.stContA').css('font-weight','normal'); $('.stContA').parent().parent().css('background-color','#fff'); $(this).css('font-weight','bold'); $(this).parent().parent().css('background-color','#c0edfd');"<%=addtarget%>><%=nomesezione%></a>
	</div>

<div class="elmntBts" style="white-space: nowrap; float:right;padding-right:4px;">

<a href="javascript:openEdit('edit_page.asp?ref=<%=ID%>');" class="macrosezione"<%=addtarget%>><img src="images/edit.png" border="0" alt="EDIT" title="EDIT" style="width:18px;float:left;margin-top:2px"/></a>

<a href="javascript:delEdit('del_section.asp?pagina=<%=ID%>');"<%=addtarget%>><img src="images/del.png" border="0" alt="DELETE" title="DELETE" style="width:18px;float:left; margin-left:6px;margin-top:2px;"></a>

<%if islevel<max_level then%>
<a href="new_pag1.asp?pagina=<%=ID%>" class="suboggetti"<%=addtarget%>><img src="images/new.png" border="0" alt="ADD SUB-PAGE" title="ADD SUB-PAGE" style="width:18px;float:left; margin-left:6px;margin-top:2px;"/></a>
<%else%>
<img src="/images/vuoto.gif" style="width:17px; height:5px; margin-right:3px;float:left"/>
<%end if%>


<%If Session("hideorder")<>True then%>
<%if pubblicas=False then%><a href="publish_element.asp?tabella=oggetti&ref=<%=ID%>"><img src="images/publish.png" border="0" alt="publish" title="publish" style="width:18px;float:left;margin-left:6px;margin-top:2px;"></a>
<%if Session("allow_languages"&numproject)=True And Session("refmainlang")<>Session("reflang") then%><a href="copy_content.asp?ref=<%=ID%>"<%=addtarget%>><img src="images/code.gif" border="0" style="float:left;display:none" alt="Copy from main Language"></a><%end if%>
<%else%>
<%=arr1%>
<%end if%>
<%End if%>

</div>
</div>
<div id="submenu_container<%=ID%>" style="float:left; position:relative; clear:left;width:100%;display:none;float:left; width:98%;padding-left:2%; background:#fff;"></div>

<%recordset.movenext
loop
End if
connection.close
%>