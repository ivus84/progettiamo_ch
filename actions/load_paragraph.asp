<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%

load=request("load")
ptype=request("ptype")

SQL="SELECT * FROM p_description WHERE TA_type='"&ptype&"' AND CO_p_projects="&load&" ORDER BY IN_ordine ASC, ID ASC"
If ptype="download" Then SQL="SELECT * FROM p_description WHERE TA_type='"&ptype&"' AND IN_dim_file>0 AND CO_p_projects="&load&" ORDER BY IN_ordine ASC, ID ASC"


	Set rec1=connection.execute(SQL)
If rec1.eof Then 
Response.write "<p>nessun elemento presente</p>"
End If

hn=0
Do While Not rec1.eof 
nB=rec1("TA_nome")
    nb = convertfromutf8(nb)
tB=rec1("TX_testo")
    tb = convertfromutf8(tb)
fB=rec1("AT_file")
refB=rec1("ID")
wV=vB
wV=setCifra(wV)

hn=hn+1

SQL="UPDATE p_description SET IN_ordine="&hn&" WHERE ID="&refB
Set rec2=connection.execute(SQL)

If ptype="download" Then
grandezza=rec1("IN_dim_file")
grandezzaw=""
if Len(grandezza)>0 And grandezza>0 then
grandezza=Replace(grandezza,",",".")
	if CInt(grandezza)>1000 then
	grandezzaw=""&Round(grandezza/1000,1)&" MB"
	else
	grandezzaw=""&grandezza&" KB"
	end if
end If


ext=""
If InStr(fB,".") Then ext=UCase(Mid(fB,InStrRev(fB,".")+1))
End if

If ptype="video" Then
advimg=""
dEmbed=rec1("TX_embed")
	vSrc=getVideoSrc(dEmbed)
	advimg="<img class=""vImg"" src=""/images/vuoto.gif"" rel="""&vsrc&""" style=""width:100px; height:65px; margin:15px 15px 0px 0px""/>"

End If

If ptype="about" Then
advimg=""
If Len(fB)>0 Then 	advimg="<img class=""aImg"" src=""/images/vuoto.gif"" style=""width:120px; float:left; height:80px; background-color:#f3f3f3; margin:15px 15px 0px 0px; background-image:url(/"&imgscript&"?path="&fB&"$200); background-size:auto 100%; background-repeat:no-repeat;background-position:center center;""/>"

End If

tB=ClearHTMLTags(tB,0)
If Len(tB)>400 Then tB=truncateTxt(tB,400)&" ..."
%>
<div class="ordP" rel="<%=refB%>_<%=load%>" style="position:relative; float:left; clear:both; min-height:45px; margin-bottom:10px;">
<div style="float:left; margin-left:0px; width:623px; font-size:14px; padding-bottom:0px; text-align:justify;">
<p style="margin:0px 0px 0px 0px; padding-top:15px;font-size:16px;"><b><%=nB%></b></p>
<div style="position:relative; z-index:5;clear:left;float:right; text-align:right;border-bottom: solid 1px #292f3a;  width:100%; margin:-29px 0px 20px 0px;">
<img src="/images/ico_delete.png" style="cursor:pointer; width:45px; float:right;" onclick="javascript:delParagraph(<%=refB%>)" onmouseover="$(this).attr('src','/images/ico_delete_o.png')" onmouseout="$(this).attr('src','/images/ico_delete.png')"/>
<img src="/images/ico_edit.png" style="cursor:pointer; float:right; width:45px; margin-right:1px" onclick="loadprojectForm(); editParagraph(<%=refB%>)" onmouseover="$(this).attr('src','/images/ico_edit_o.png')" onmouseout="$(this).attr('src','/images/ico_edit.png')"/>

</div>
<div style="position:relative; float:left; width:100%;margin:-20px 0px 10px 0px;">
<%=advimg%><p><%=tB%></p>
</div>
<%If ptype="download" Then%><p><a href="/download/?file-uploaded/<%=fB%>" style="color:#292f3a"><img src="/images/ico_download.png" alt="Download" style="float:left; margin:-5px 10px 0px 0px;"/>(<%=ext%>&nbsp;<%=grandezzaw%>)</a></p><%End if%>

<%If ptype="gallery" Then
	SQL="SELECT * FROM p_pictures WHERE len(AT_file)>3 AND CO_p_description="&refB&" AND CO_p_projects="&load&" ORDER BY IN_ordine"
	Set rec2=connection.execute(SQL)
	'If rec2.eof Then Response.write"<p style=""margin:0px"">Nessuna immagine inserita</p>"
	advimg1=""
	hn=0
	Do While Not rec2.eof
	hn=hn+1
	imgdida=rec2("TA_nome")
	refimg=rec2("ID")
	SQL="UPDATE p_pictures set IN_ordine="&hn&" WHERE ID="&refimg
	Set rec3=connection.execute(SQL)

	If Len(imgdida)>0 Then imgdida=Replace(imgdida,Chr(34),"\"&Chr(34))
	gimg="/"&imgscript&"?path="&rec2("AT_file")&"$500"
	advimg1=advimg1&"<div class=""ithumb""><img src=""/images/vuoto.gif"" longdesc="""&imgdida&""" rel="""&refimg&""" class=""thumb"" style=""background-image:url("& gimg &")"" alt="""&imgdida&""" title="""&imgdida&"""/><img src=""/images/ico_edit_t.png"" style=""position:absolute; bottom:-4px; right:52px; cursor:pointer; width:30px;border-right:solid 1px #fff"" onclick=""makeDida($(this).parent().find('img'),"&refB&")"" onmouseover=""$(this).attr('src','/images/ico_edit_t_o.png')"" onmouseout=""$(this).attr('src','/images/ico_edit_t.png')"" title=""didascalia"" alt=""didascalia""/><img src=""/images/ico_delete.png"" style=""cursor:pointer; position:absolute; bottom:-4px; right:22px; width:30px"" onclick=""javascript:delPicture("&refimg&")"" onmouseover=""$(this).attr('src','/images/ico_delete_o.png')"" onmouseout=""$(this).attr('src','/images/ico_delete.png')""/></div>"
	rec2.movenext
	loop
Response.write "<div class=""sortImgs"" rel="""&load&""" style=""float:left; width: 623px; margin-bottom:20px;"">"&advimg1
%>
<form id="fileupload_<%=refB%>" class="fileupload" action="<%=uploadscript%>" method="POST" enctype="multipart/form-data" style="margin:0px">
<p id="fileupload_<%=refB%>_file"  style="float:left; clear:right; margin:0px 0px 10px 0px"><input class="fInput" id="ff<%=refB%>" type="file" name="files[]">
<label for="ff<%=refB%>" style="cursor:pointer; width:103px; height:75px; float:left;"><img src="/images/add_picture.png" class="adt" title="Aggiungi immagine" alt="Aggiungi immagine"/></label></p>
<div class="barContain" style="float:left;width:103px; height:75px;margin-top:0px;"><div class="bar" id="fileupload_<%=refB%>_bar">&nbsp;uploading ...</div></div>
<input type="hidden" name="tabdest" value="p_pictures"/>
</form>
</div>
<form id="fileupload_<%=refB%>_upl" class="formUpld" method="POST" style="margin:0px">
<input type="hidden" class="fieldVal" name="fieldVal" value=""/>
<input type="hidden" class="fieldPro" name="fieldPro" value="<%=load%>"/>
<input type="hidden" class="fieldRef" name="fieldRef" value="<%=refB%>"/>
</form>

<form id="dida_<%=refB%>" class="formDida" method="POST" style="position:relative;width:507px; margin:5px 0px 0px 0px; height:120px; background:#fff; float:left; clear:left; display:none">
<input type="hidden" class="imgproject" name="imgproject" value="<%=load%>"/>
<input type="hidden" class="imgref" name="imgref" value=""/>
Didascalia immagine<br/>
<input type="text" class="imgdida" style="width:507px; border:solid 1px #292f3a; font-size:16px; height:30px; padding:5px" value="" maxlength="255"/><br/>
<input type="submit" class="bt" style="float:right;width:100px;margin-right:-12px;margin-top:10px;" value="salva"/> <input type="button" class="bt" style="float:right; width:100px; margin-right:1px;margin-top:10px;" value="annulla" onclick="$('.formDida').fadeOut(100)"/>
</form>

<%End if%>

</div>
</div>
<%
rec1.movenext
Loop

connection.close%>