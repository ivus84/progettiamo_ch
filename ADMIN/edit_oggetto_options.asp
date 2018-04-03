<div id="bg_options" style="position:absolute; z-index:4; left:0px; top:19px; display:inline;background:url(./images/bg_menu.png) left 0px repeat-x;background-color:#EFEFEF; width:300px; height:<%=h_prev+15%>px; border:solid 1px #999;"></div>


<div id="p_menu" style="position:absolute; z-index:5; left:0px; top:0px; display:inline; width:310px;">

<div id="menu_options" class="optss" style="border-bottom: solid 1px #c4bebe; background:#c4bebe">
<a href="javascript:displayMenu('options')" style="text-decoration:none; line-height:11px">Attributi</a></div>


<div id="menu_title" class="optss" style="width:36px"><a href="javascript:displayMenu('title')" style="text-decoration:none; line-height:11px">Titolo</a></div>

<div id="menu_publish" class="optss"><a href="javascript:displayMenu('publish')" style="text-decoration:none; line-height:11px">Sezione</a></div>

<%If isauthor=False then%>
<div id="menu_files" class="optss"><a href="javascript:displayMenu('files')" style="text-decoration:none; line-height:11px">Downloads</a></div>
<%end if%>

<%if Session("allow_galleries"&numproject)=True then%>
<div id="menu_galleries" class="optss"><a href="javascript:displayMenu('galleries');" onclick="$('#linkGallery').trigger('click');" style="text-decoration:none; line-height:11px">Immagini</a></div>
<%end if%>

<%
dispvideomenu="none"
%>
<div id="menu_video" class="optss" style="display:<%=dispvideomenu%>"><a href="javascript:displayMenu('video')" style="text-decoration:none; line-height:11px">Video</a></div>

</div>

<%
reflang=session("reflang")
%>
<form id="saveForm" name="frm" method="post" action="save.asp">
<input type="hidden" name="ref" id="edRef" value="<%=ref%>"/>
<input type="hidden" name="lang" id="edLang" value="<%=reflang%>"/>

<div id="page_title" class="testoadm opts" style="position:absolute; z-index:6;left:10px; top:34px; width:285px; display:none">

<%

SQL00="SELECT lingue.* FROM limita_lingue INNER JOIN lingue ON lingue.ID=limita_lingue.CO_lingue WHERE lingue.LO_attiva=True AND limita_lingue.CO_utenticantieri="&Session("IDuser")&" ORDER BY lingue.LO_main, lingue.IN_ordine ASC"
set recordset00=connection.execute(SQL00)

if not recordset00.eof Then limitedlanguage=True


if limitedlanguage=True then
SQL="SELECT lingue.* FROM limita_lingue INNER JOIN lingue ON lingue.ID=limita_lingue.CO_lingue WHERE lingue.LO_attiva=True AND limita_lingue.CO_utenticantieri="&Session("IDuser")&" ORDER BY lingue.LO_main, lingue.IN_ordine ASC"
else
SQL="SELECT * FROM lingue WHERE LO_attiva=True ORDER BY IN_valore ASC"
end if

set record_language=connection.execute(SQL)

%>
<b>Titolo</b><p align="right">


<%
do while not record_language.eof
nomel=Mid(record_language("TA_nomev"),1,2)
vall=record_language("IN_valore")
vallv="_"&vall
if vall=0 then vallv=""
vallangtitle=recordset("TA_nome"&vallv)
%>
<%=nomel%>. <input type="text"  class="testoadm" maxlength="255" name="TA_nome<%=vallv%>" value="<%=vallangtitle%>" style="border: solid 1px #999999; width:260px" onchange="javascript: sendSaveForm()"/><br/>
<%record_language.movenext
Loop
record_language.movefirst
%></p>

<b>Keywords</b>
<p align="right">
<%
do while not record_language.eof
nomel=Mid(record_language("TA_nomev"),1,2)
vall=record_language("IN_valore")
vallv="_"&vall
if vall=0 then vallv=""
vallangtitle=recordset("TX_keywords"&vallv)
%>
<%=nomel%>. <input type="text"  class="testoadm" maxlength='255' name="TX_keywords<%=vallv%>" value="<%=vallangtitle%>" style="border: solid 1px #999999; width:260px" onchange="javascript: sendSaveForm()"/><br/>
<%record_language.movenext
Loop
record_language.movefirst%></p>
<b>Etichetta men&ugrave;</b>
<p align="right">
<%
do while not record_language.eof
nomel=Mid(record_language("TA_nomev"),1,2)
vall=record_language("IN_valore")
vallv="_"&vall
if vall=0 then vallv=""
vallangtitle=recordset("TA_linkto"&vallv)
%>
<%=nomel%>. <input type="text"  class="testoadm" maxlength='255' name="TA_linkto<%=vallv%>" value="<%=vallangtitle%>" style="border: solid 1px #999999; width:260px" onchange="javascript: sendSaveForm()"/><br/>
<%record_language.movenext
Loop
record_language.movefirst%></p>
</div>
<div id="page_options" class="testoadm opts" style="position:absolute; z-index:6;left:10px; top:24px; width:285px; height:475px; display:<%=disp_options%>">
<%if Session("allow_languages"&numproject)=True then%>
<div id="langChng" style="float:right;margin-top:5px; margin-bottom:-5px;height:20px;">
<b>Edit Lingua</b> -> <select name="lang" onchange="document.location='main.asp?viewmode=edit_page.asp&lang='+this.options[this.selectedIndex].value;" class="testoadm">
<option value="">...</option>
<%
If Not record_language.eof Then
	do while not record_language.eof
	nomel=record_language("TA_nome")
	refl=record_language("ID")
	vall=record_language("IN_valore")
	mainlang=record_language("LO_main")


		if CInt(Session("lang")+1)=CInt(refl) then
		checcl=" selected"
		actuallanguageedit=nomel

		else
		checcl=""
		if mainlang=True then manlang=nomel
		end if
	%>
	<option value="<%=vall%>"<%=checcl%>><%=nomel%></option>
	<%record_language.movenext
	loop
record_language.movefirst%></select></div>

<%if len(manlang)>0 then%><input type="button" value="copy from <%=manlang%>" class="testoadm" onclick="document.location='copy_content.asp?ref=<%=ref%>';" style="display:none"/><%end if%>
<br/><br/>

<%end if%>
<%end if%>

<input type="CHECKBOX" name="LO_pubblica<%=reflang%>" <%=chekka%> onclick="makePublic('LO_pubblica<%=reflang%>','<%=LO_pubblica%>',<%=ref%>);"> <%=actuallanguageedit%>&nbsp;<%=statooggetto%>
<br/>
<br/>
&nbsp;<b>Data</b>:   &nbsp;<span id="view_datapage"><%=Day(DT_data)%>/<%=Month(DT_data)%>/<%=Year(DT_data)%></span><input type="hidden" id="data_page" name="data_page" value="<%=Month(DT_data)%>/<%=Day(DT_data)%>/<%=Year(DT_data)%>"/>
<img src="images/calender.gif" alt="calender" border="0" align="absmiddle" onclick="gCalendar();" style="margin-right:10px;margin-top:0px"/>

<div id="datepicker" style="position:absolute;z-index:9999; left:2px;top:70px;display:none"></div>

<%If LO_pubblica=False then%>
<br/><br/>&nbsp;Pubblica il: (g/m/a h:m)<input type="text"  class="testoadm" name="TA_duedate" value="<%=TA_duedate%>" maxlength="16" style="border:solid 1px #999;width:89px; height:15px; margin-left:11px " onchange="javascript: sendSaveForm();"/><%End if%> 

<br/><br/>

<input type="CHECKBOX" name="LO_hidetitleonpage" <%=chekka11%> onclick="makePublic('LO_hidetitleonpage','<%=LO_hidetitleonpage%>',<%=ref%>);" > Nascondi titolo<br/>


<br/>
<%if issection=True then%>
<input type="CHECKBOX" name="LO_homepage" <%=chekka1%> onclick="makePublic('LO_homepage','<%=LO_homepage%>',<%=ref%>);"> Homepage<br/>
<input type="CHECKBOX" name="LO_hidemainmenu" <%=chekka13%> onclick="makePublic('LO_hidemainmenu','<%=LO_hidemainmenu%>',<%=ref%>);"> Nascondi nel men&ugrave;<br/>
<input type="CHECKBOX" name="LO_menu2" <%=chekka12%> onclick="makePublic('LO_menu2','<%=LO_menu2%>',<%=ref%>);"> Menù footer<br/>

<%else%>
<input type="CHECKBOX" name="LO_hidemainmenu" <%=chekka13%> onclick="makePublic('LO_hidemainmenu','<%=LO_hidemainmenu%>',<%=ref%>);"> Nascondi nel men&ugrave;<br/>

		<%if isnewselement=True then%>
		<input type="hidden"  class="testoadm" name="TA_boxes" value="<%=TA_boxes%>" style="border:solid 1px #999;width:140px; height:15px; margin-left:21px;display:none;" onchange="javascript: sendSaveForm();"/> <br/>
			<%
			SQL="SELECT * FROM boxes ORDER BY TA_nome ASC"
			Set recb=connection.execute(SQL)

			If Not recb.eof Then
			%>&nbsp;Aggiungi Tag -> <select name="CO_boxes" style="width:150px; display:none" class="testoadm" onchange="addBox($(this).val(),<%=ref%>,1)"><option value="">...</option>
			<%
			do while not recb.eof
			Response.write "<option value="""&recb("ID")&""">"&recb("TA_nome")&"</option>"
			recb.movenext
			Loop
			%></select><p><%
		SQL="SELECT boxes.TA_nome, boxes.ID FROM associa_ogg_boxes INNER JOIN boxes ON associa_ogg_boxes.CO_boxes=boxes.ID WHERE associa_ogg_boxes.CO_oggetti="&ref
		Set recb=connection.execute(SQL)
			do while not recb.eof
			Response.write "<span style=""float:left; margin-right:5px;margin-left:10px;display:none""><a href=""javascript:addBox("&recb("ID")&","&ref&",0)"" style=""text-decoration:none""><img src=""./images/delete1.gif"" border=""0""/>&nbsp;"&recb("TA_nome")&"</a></span>"
			recb.movenext
			Loop
		%></p><%
			End if
		End if%>
	<div id="emedTxt" style="position:relative;z-index:1000; float:left;clear:left; margin-top:18px;margin-right:15px;display:none"><b>Abstract</b><br/>
	<textarea name="TX_abstract" id="TX_abstract" class="embed" wrap="virtual" onchange="sendSaveForm();"><%=TX_abstract%></textarea><Br/>
	</div>
	<%end if%>

<%
unused=false
if unused=true then%>
<input type="CHECKBOX" name="LO_news" <%=chekka2%> onclick="makePublic('LO_news','<%=LO_news%>',<%=ref%>);"> Sezione NEWS<br/>
<input type="CHECKBOX" name="LO_protected" <%=chekka10%> onclick="makePublic('LO_protected','<%=LO_protected%>',<%=ref%>);"> Archivio NEWS<br/>
<input type="CHECKBOX" name="LO_contact_page" <%=chekka14%> onclick="makePublic('LO_contact_page','<%=LO_contact_page%>',<%=ref%>);"> Pagina match center<br/>
		<input type="CHECKBOX" name="LO_networking" <%=chekka16%> onclick="makePublic('LO_networking','<%=LO_networking%>',<%=ref%>);"> Sezione partite<br/>
		<input type="CHECKBOX" name="LO_commerce" <%=chekka3%> onclick="makePublic('LO_commerce','<%=LO_commerce%>',<%=ref%>);"> Template squadra<br/>
		<input type="CHECKBOX" name="LO_list_section" <%=chekka15%> onclick="makePublic('LO_list_section','<%=LO_list_section%>',<%=ref%>);"> Template squadra giovanili<br/>
<input type="CHECKBOX" name="LO_reserved" <%=chekka18%> onclick="makePublic('LO_reserved','<%=LO_reserved%>',<%=ref%>);"> Area riservata giovanili<br/>
<%End if%>
<%if issection=false then%>
<div id="emedTxt" style="position:relative;z-index:1000; clear:both; float:left;margin-top:18px;margin-right:15px;display:inline"><b>Embed Code</b><br/>
<textarea name="TX_embed" id="TX_embed" class="embed" wrap="virtual" onchange="sendSaveForm();"><%=TX_embed%></textarea><Br/>
</div>
<%End if%>
<input id="refRedir" type="hidden" name="CO_oggetti" value="<%=ref_redir%>"/>
</form>

<div id="emedTxt" style="position:relative;z-index:1000; clear:both; float:left;margin-top:18px;margin-right:15px;display:inline">
Page link<br/>
<input class="testoadm" style="border:0px;background:transparent;width:280px;font-weight:bold" onclick="this.select();" value="<%=linkPage%>"/>
<br/><br/>


</div>


<input id="IconEditor" type="button" name="btnc" value="MODIFICA TESTO" onclick="load_editor();" class="editBtns" style="position:absolute;left:0px; bottom:10px; "/>
<%SQL="SELECT CO_oggetti,sopra FROM newsection WHERE ID="&ref
		set recordset1=connection.execute(SQL)
		if not recordset1.eof then
		isupsection=recordset1("CO_oggetti")
		if isnull(isupsection)=false and isupsection>0 then
		%>
		<input type="button"  value="Crea pagina in <%=recordset1("sopra")%>" onclick="document.location='new_pag1.asp?pagina=<%=isupsection%>';" class="editBtns" style="position:absolute;bottom:10px; right:5px;width:150px"/>
		<%
		end if
		end if
		%>
<%
salva_it="SALVA"
salva_en="SAVE"
salva_de="SPEICHERN"
salvabt=Eval("salva_"&Session("adminlanguageactive"))
		%>
		<div id="saveBtns" style="position:absolute; left:0px; bottom:10px; display:none;">
		<input type="button" name="btnc" value="CHIUDI" onclick="closeEditor();" class="editBtns" style="margin-top:210px"/><br/>
		<input type="button" name="save" value="<%=salvabt%>"  onclick="saveTxt();" class="editBtns" style="margin-top:4px"/>
		</div>

</div>






<div id="page_video" class="testoadm opts" style="position:absolute;   z-index:5;left:10px; top:25px;  display:<%=disp_videos%>">
<%disablevideos=True
if disablevideos=False then%>
<!--#INCLUDE VIRTUAL="./ADMIN/edit_oggetto14.asp"-->
<%end if%></div>

<div id="page_files" class="testoadm opts" style="position:absolute; z-index:5; left:10px; top:25px; display:<%=disp_files%>">
<iframe id="edit_files" class="gallframe" src="edit_oggetto11.asp" name="edit_files"  scrolling="no" allowTransparency="true" style="background-color: transparent; position:relative; z-index:100;left:0px;top:0px;width:289px; height:460px; border:0px; overflow:hidden;" frameborder="0"></iframe>
</div>
<%if Session("allow_galleries"&numproject)=True then%>
<div id="page_galleries" class="testoadm opts" style="position:absolute;  z-index:5;left:10px; top:25px; width:285px;display:<%=disp_gallery%>">

<div style="float:left;z-index:1;bottom:10px;width:120px; margin-top:2px;clear:both;">

<%
vImage=eval("AT_image"&session("reflang"))

if len(vImage)=0 OR isnull(vImage)=True then%>

<form id="formUpld_inside" name="form1" action="addFileJQ.asp" method="POST">
<input type="hidden" name="table" value="oggetti"/>
<input type="hidden" name="fieldF" value="AT_image<%=session("reflang")%>"/>
<input type="hidden" name="connectTable" value=""/>
<input type="hidden" name="addFields" value=""/>
<input type="hidden" id="fieldVal" name="fieldVal"/>
<input type="hidden" name="modeupl" value="update,<%=ref%>"/>
<input type="hidden" name="returnurl" value="main.asp?viewmode=edit_page.asp"/>
</form>

<form id="fileupload_1" class="fileuploadOpt" action="uploadJQuery.aspx" method="POST" enctype="multipart/form-data" style="margin-top:5px; margin-bottom:5px">
<p id="fileupload_1_file" style="width:100%"><b>Immagine principale <%=Session("nomelangv")%></b><br/><input class="fInput"  type="file" name="files[]"></p>
<div class="barContain"><div class="bar" id="fileupload_1_bar" style="width: 0%;">&nbsp;uploading ...</div></div>
</form>



<%Else
%>
<b>Immagine principale</b><br/>

<img src="../images/vuoto.gif" style="float:left; border:solid 1px #999999; margin:10px 0px 5px 5px; background:url(../img.asp?path=<%=vImage%>&width=120) center center no-repeat; background-size:100%; width:100px; height:70px;"/>
<a href="javascript:delFileInline('mode=update&vars=oggetti,<%=ref%>,,,,AT_image<%=session("reflang")%>,',<%=ref%>);"><img src="./images/delete1.gif" border="0" style="float:left; margin-left:-5px; margin-top:70px"/></a><br/>

<br/>

<%end if%>
</div>
<div style="clear:both; display:none">
<!--#INCLUDE VIRTUAL="./ADMIN/edit_oggetto13.asp"-->
</div>
</div>
<%end if%>
<%
ref=Session("ref")
ref=0%>
<div id="page_publish" class="testoadm opts" style="position:absolute; left:10px; top:38px; z-index:5;display:<%=disp_position%>; width:200px"">
<!--#INCLUDE VIRTUAL="./ADMIN/edit_oggetto12.asp"-->
<br/><br/>
Redirect to page<br/> 
<select id="selsections3" class="testoadm" style="width:220px" onchange="$('#refRedir').val($(this).val()); sendSaveForm();">
<option value="">...</option>
</select>

</div>
