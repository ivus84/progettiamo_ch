<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<%
function RepText(strHTML)
    dim strTagLess
    strTagless = strHTML
    if len(strTagless)>0 then
	    strTagless=Replace(strTagless,"�","&#39;")
	    strTagless=Replace(strTagless,"�","&#39;")
	    strTagless=Replace(strTagless,"�","&quot;")
	    strTagless=Replace(strTagless,"�","&quot;")
	    strTagless=Replace(strTagless,"�","&agrave;")
	    strTagless=Replace(strTagless,"�","&egrave;")
	    strTagless=Replace(strTagless,"�","&ugrave;")
	    strTagless=Replace(strTagless,"�","&uacute;")
	    strTagless=Replace(strTagless,"�","&igrave;")
	    strTagless=Replace(strTagless,"�","&iacute;")
	    strTagless=Replace(strTagless,"�","&ograve;")
	    strTagless=Replace(strTagless,"�","&oacute;")
	    strTagless=Replace(strTagless,"�","&eacute;")
	    strTagless=Replace(strTagless,"�","&aacute;")
	    strTagless=Replace(strTagless,"�","&uuml;")
	    strTagless=Replace(strTagless,"�","&auml;")
	    strTagless=Replace(strTagless,"�","&ouml;")
	    strTagless=Replace(strTagless,"�","&ecirc;")
	    strTagless=Replace(strTagless,"�","&ucirc;")
	    strTagless=Replace(strTagless,"�","&icirc;")
	    strTagless=Replace(strTagless,"�","&ocirc;")
	    strTagless=Replace(strTagless,"�","&ccedil;")
	    strTagless=Replace(strTagless,"�","&Uuml;")
	    strTagless=Replace(strTagless,"�","&Ugrave;")
        strTagless=replace(strTagless,"&#45;","-")
        strTagless=replace(strTagless,"&#40;","(")
        strTagless=replace(strTagless,"&#41;",")")
        strTagless=replace(strTagless,"&#39;","'")
    end if
    RepText = strTagLess
end function

encryptedFields=",TA_telefono,TA_natel,TA_email,"
encodedFields =",TX_testo_bonus,"
forceRefresh=false

if len(request("lang"))>0 then Session("lang")=request("lang")
if Session("lang")>0 then Session("reflang")="_" & Session("lang")

pagina=request("pagina")
tabella=request("tabella")
sel0=request("sel0")
da=request("da")
sel1=request("sel1")
mode=request("mode")

if len(da)=0 Then da="main"

if len(tabella)>0 then
    Session("tab")=tabella
    Session("tabella")=tabella
end if

if Session("tab")="_config_main" then tabtitel="Config"
if Session("tab")="registeredusers" then tabtitel="Users"
if Session("tab")="boxes" then tabtitel="Tags"
if Session("tab")="_config_video" then tabtitel="Video Home"


winput=400
hinput=60
if Session("tab")="galleries" then winput=180
if Session("tab")="videos" then winput=160
if Session("tab")="newsletter" Or Session("tab")="intranet_groups"  then winput=300
if Session("tab")="_config_video" then 
    winput=300
    hinput=100
end if
if Session("tab")="associa_galleries_immagini" then winput=200
if Session("tab")="videos" then hinput=80


if len(pagina)>0 then Session("pagina")=pagina
nobg=True
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->


<p class="titolo"><%=tabtitel%></p>
<form id="mainForm" name="form2" method="POST" action="edit1.asp">

<input type="hidden" name="pagina" value="<%=Session("pagina")%>">
<input type="hidden" name="sel0" value="<%=sel0%>">
<input type="hidden" name="sel1" value="<%=sel1%>">
<input type="hidden" name="group" value="<%=request("group")%>">
<input type="hidden" name="da" value="<%=da%>">
<input type="hidden" name="mode" value="<%=mode%>">
<input type="hidden" name="tabella" value="<%=Session("tab")%>">
<input type="hidden" name="requiredfields" value="<%=Session("required")%>"/>
<input type="hidden" name="maxlengthfields" value="<%=Session("maxlength")%>"/>


<div style="float:left;margin-top:20px;">

<table width="100%" celllpadding="3" cellspacing="2"><tr><td>
<!--#INCLUDE VIRTUAL="./admin/load_allowed_columns.asp"-->
<%

if Session("tab")="_config_video" then forceRefresh=true

Set rstSchema = connection.OpenSchema(adSchemaColumns,Array(Empty, Empty, "" & Session("tab") & ""))
i=0
'VB se passo l'id 0 inserisco una nuova riga vuota, che verrà cancellata dopo il loop, solo per la creazione dei campi della form
maxid=0
if Session("pagina")=0 then 
    set record0=connection.execute("select max(id) as maxid from " & Session("tab"))
    maxid=record0("maxid")+1
    connection.execute("INSERT INTO " & Session("tab") & " (id) values(" & maxid & ")")
    Session("pagina")=maxid
end if

SQL="SELECT * FROM " & Session("tab") &" WHERE ID=" & Session("pagina")
Set recordtem=connection.execute(SQL)

addCFunc=""
do Until rstSchema.EOF
    colName = rstSchema("COLUMN_NAME")
   
    if InStr(allowed_columns," " & colName & " ")>0 then
   
        Session("test"&i)=rstSchema("DESCRIPTION")

        If Len(Session("test"&i))=0 OR IsNull(Session("test"&i))=True then
            Session("test"&i)=Mid(colName,4,Len(colName))
            Session("test"&i)=Replace(Session("test"&i),"_"," ")
        end if

        translated=Session("test"&i)
        'response.Write translated
        'response.End
%>
<!--#INCLUDE FILE="./translate_columns.asp"-->
<%
Session("test" & i)=translated

Session("val" & i)=recordtem("" & colName)

inputItem=Mid(colName, 1, 2)

valore=Session("val" & i)
if tabella="fails" then valore=Replace(valore,"   ","")

if inputItem="TA" Then
    If InStr(encryptedFields,colname) Then valore = EnDeCrypt(valore, npass, 2)
    if len(valore)>0 then valore=RepText(valore)
end if

if inputItem="TX" And colname<>"TX_testo" AND Session("tab")<>"oggetti" AND Session("tab")<>"p_comments" Then

    if len(valore)>0 then valore=RepText(valore)
    valore = convertfromutf8(valore)
	if colName="TX_datadef" then
	    Session("test"&i)="Definizione campi"
	    inidatadef=valore
	    apply="<b>Aggiungi campo</b><br/>Domanda <input type=""text"" class=""testoadm"" name=""fieldname"" style=""width:220px; margin-left:24px; margin-bottom:2px""/><br/>Valore default <input type=""text"" class=""testoadm"" name=""fieldvalue"" style=""width:220px""/><br/><br/>Obbl. <input type=""checkbox"" class=""testoadm"" name=""mandvalue"" value=""True""/> | Testo lungo <input type=""checkbox"" class=""testoadm"" name=""multvalue"" value=""True""/> Scelta singola <input type=""checkbox"" class=""testoadm"" name=""checkvalue"" value=""True""/> Scelta multipla <input type=""checkbox"" class=""testoadm"" name=""multcheckvalue"" value=""True""/> Menu' tendina <input type=""checkbox"" class=""testoadm"" name=""selectvalue"" value=""True""/><input type=""button"" onclick=""javascript:upd_datadef()"" class=""testoadm"" style=""width:50px"" value=""ADD""/><br/><br/><div id=""datadefcontent"" style=""background-color:#FFFFFF; padding:12px; width:490px;border:solid 1px #666666"">"&valore&"</div><br/>Per Scelta singola, multipla e Tendina inserire le opzioni separate da / come valore default<br/><br/>"
	else
        valore = HTMLDecode (valore)
	    testo=valore
	    %>
	    <!--#INCLUDE VIRTUAL="./ADMIN/replace_text.asp"-->
	    <%
	    if len(testo)>0 then testo=Replace(testo,"<br />",CHR(10))
	    apply="<textarea name=""" & colName & """ style=""width:" & (winput-4) & "px; border:solid 1px #666666; background:#efefef; font-family:arial; font-size:11px; height:" & hinput-30 & "px"" class=""teston"">" & testo & "</textarea>"

	end If

ElseIf inputItem="TE" OR (inputItem="TX" And Session("tab")="oggetti") Or (inputItem="TX" And Session("tab")="p_description") Or (inputItem="TX" And Session("tab")="p_comments") Then

	If Len(valore)>0 Then
	valore = Replace(valore, CHR(34)&CHR(34), CHR(34))

		for x=1 to 31
		    chrF=Eval("CHR(" & x & ")")
		    valore = Replace(valore, chrF,"")
		Next
        'valore = HTMLDecode (valore)
	testo=valore
	%>
	<!--#INCLUDE VIRTUAL="./ADMIN/replace_text.asp"-->
	<%
	valore=testo
    End if
apply="<textarea name="""&colName&""" class=""tEditor"">"&valore&"</textarea>"

elseif inputItem="DT" then

	if Len(valore)>5 then
	    valore=recordtem(""&colName)
	else
	    valore=Now()
	end if

    giorno=Day(valore)
    mese=Month(valore)
    anno=Year(valore)
    valore=mese&"/"&giorno&"/"&anno
    valore=giorno&"."&mese&"."&anno

    apply="<span class=""vDate""></span><input type=""text"" name="""&colName&""" value="""&valore&""" class=""dtPicker""/>"


elseif inputItem="CX" Then

    opts=Session("test"&i)
    if len(valore)>1 Then valore=replace(valore,",,",",")

    Session("test"&i)=Mid(colName,4,Len(colName))
    Session("test"&i)=Replace(Session("test"&i),"_"," ")

    apply=CHR(10)&"<input type=""hidden"" name="""&colName&""" value="""&valore&"""/>"&_
    "<select style=""border:solid 1px #666666; width:"&winput&"px; font-family:Verdana; font-size:11px"" name='sl"&colName&"' onchange=""document.form2."&colName&".value=document.form2."&colName&".value+','+this.options[this.selectedIndex].value; document.form2.submit();"">"
    apply=apply&"<option value='0' selected>scegliere</option>"
    opts=Split(opts,",")
    For x=0 To UBound(opts)
        apply=apply&"<option value="""&opts(x)&""">"&opts(x)&"</option>"
    next

    apply=apply&"</select>"

    if len(valore)>1 Then
        apply=apply&"<br/>"
        preval=SPlit(valore,",")

        for z=0 to UBound(preval)
            getX=preval(z)
            if Len(getX)>0 then apply=apply& "<a href=""javascript:document.form2."&colName&".value=document.form2."&colName&".value.replace('"&getX&"',''); document.form2.submit();""><img src=""images/delete1.gif"" border=""0"" style=""margin-right:3px; margin-bottom:0px;margin-top:4px""/></a> "&getX&"<br/>"
        Next
    end If

elseif inputItem="CL" Then

    addCFunc=CHR(10) & addCFunc
    addCFunc=addCFunc & "$('#sCPiker_"&colName&"').bind('colorpicked', function () {"
    addCFunc=addCFunc & "     $('#"&colName&"').val($(this).val()); document.form2.submit();"
    addCFunc=addCFunc & "    });"&CHR(10)

    apply="<input type=""hidden"" maxlength=""255"" id="""&colName&""" name="""&colName&""" value="""&valore&"""/>Click-> <input type=""color"" id=""sCPiker_"&colName&""" style=""border:0;width:1px;height:1px;cursor:pointer"" value=""#ffffff"" data-hex=""true""/>"
    If Len(valore)>1 Then
        apply=apply & "&nbsp;<a href=""javascript:delColor1('"&valore&"','"&colName&"');""><img src=""/images/vuoto.gif"" width=""15"" align=""middle"" style=""margin-top:-2px; background-color:"&valore&";border:solid 1px #000""/></a>&nbsp;"
    End if


elseif inputItem="CI" Then
    If Len(valore)>1 Then valore=Replace(valore,",,",",")

    addCFunc=CHR(10)&addCFunc
    addCFunc=addCFunc&"$('#sCPiker_"&colName&"').bind('colorpicked', function () {"
    addCFunc=addCFunc&"     preval=$('#"&colName&"').val(); $('#"&colName&"').val(preval+','+$(this).val()); document.form2.submit();"
    addCFunc=addCFunc&"    });"&CHR(10)

    apply="<input type=""hidden"" maxlength=""255"" id="""&colName&""" name="""&colName&""" value="""&valore&"""/>Click-> <input type=""color"" id=""sCPiker_"&colName&""" style=""border:0;width:1px;height:1px;cursor:pointer"" value=""#ffffff"" data-hex=""true""/>"
    If Len(valore)>1 Then
        valori=Split(valore,",")
        For x=1 To UBound(valori)
            apply=apply&"&nbsp;<a href=""javascript:delColor('"&valori(x)&"','"&colName&"');""><img src=""/images/vuoto.gif"" width=""15"" align=""middle"" style=""margin-top:-2px; background-color:"&valori(x)&";border:solid 1px #000""/></a>&nbsp;"
        Next
    End if

elseif inputItem="CR" then
    nometab=Mid(colName, 4)

    if len(valore)=0 or IsNull(valore) then valore=","
    apply=CHR(10)&"<input type=""hidden"" name="""&colName&""" value="""&valore&"""/><select style=""border:solid 1px #666666; width:250px; font-family:Verdana; font-size:11px"" name='sl"&colName&"' id='sl"&colName&"' onchange=""document.form2."&colName&".value=document.form2."&colName&".value+this.options[this.selectedIndex].value+','; document.form2.submit();"">"
    apply=apply&"<option value='0' selected>scegliere</option>"

    preval=valore
    valore=0

    If nometab="oggetti" then
        adScript=adScript&"getSlect('sl"&colName&"',maxlevs,'void(0)');"&chr(10)
    else
        SQL="SELECT * from "&nometab&" ORDER BY TA_nome ASC"
        If nometab="products" Or nometab="products2" Then SQL="SELECT ID, TA_codice&' '&TA_linea&' '&TA_dimensioni AS TA_nome from products ORDER BY TA_codice, TA_linea ASC"
        If nometab="products1" Then SQL="SELECT ID, TA_codice&' '&TA_linea&' '&TA_dimensioni AS TA_nome from products WHERE CO_oggetti=497 ORDER BY TA_codice, TA_linea ASC"
        If nometab="p_projects" Then SQL="SELECT * from "&nometab&" WHERE ID<>"&Session("pagina")&" AND LO_confirmed ORDER BY TA_nome ASC"

        Set rec=Connection.execute(SQL)
        Do While Not rec.eof
            apply=apply&"<option value="""&rec("ID")&""">"&rec("TA_nome")&"</option>"
            rec.movenext
        loop
    End If

    apply=apply&"</select>"

    if len(preval)>1 then
        apply=apply&"<br/>"
        preval=mid(preval,1,len(preval)-1)
        preval=SPlit(preval,",")

        for z=LBound(preval) to UBound(preval)
            refz=preval(z)
            If Len(refz)>0 then
                SQL="SELECT TA_nome AS nome FROM "&nometab&" where ID="&preval(z)
                If nometab="products" Or nometab="products1" OR nometab="products2" Then SQL="SELECT ID, TA_codice&' '&TA_linea&' '&TA_dimensioni AS nome from products where ID="&preval(z)

                set rec=connection.execute(SQL)
                if not rec.eof then apply=apply& "<span style=""float:left; margin-right:7px""><a href=""javascript:document.form2."&colName&".value=document.form2."&colName&".value.replace(',"&preval(z)&",',','); document.form2.submit();""><img src=""images/delete1.gif"" border=""0"" style=""margin-right:3px; margin-bottom:0px;margin-top:4px""/> "&rec("nome")&"</a></span>"
            End if  
        Next
    end If

elseif inputItem="LO" then
        
    if valore=True then
        val="CHECKED"
    else
        val=""
    end if

    If colName="LO_realizzato" And valore=True Then 
        allowed_columns=allowed_columns&" , AT_post_img ,"
        apply="<input type=""hidden"" name="""&colName&""" value=""True""/>"
        Session("test"&i)="&nbsp;"
    ElseIf colName="LO_realizzato" And valore=False Then 
        apply="<input type=""hidden"" name="""&colName&""" value=""False""/>"
        Session("test"&i)="&nbsp;"
    elseif colname = "LO_video_embed" then
        apply="<input type=""checkbox"" style=""border:solid 1px #666666; font-family:arial; font-size:11px"" value=""True"" name="""&colName&""" "&val&" onclick=""$('#mainForm').submit()""/><span>Video in slideshow home (solo progetti in evidenza!)</span>"
    Else
        apply="<input type=""checkbox"" style=""border:solid 1px #666666; font-family:arial; font-size:11px"" value=""True"" name="""&colName&""" "&val&" onclick=""$('#mainForm').submit()""/>"
    End if

elseif inputItem="IN" then
    if IsNull(valore) then
        valore="0"
    end if
    valore=Replace(valore, ",", ".")
    apply=" <input type='text' style=""border:solid 1px #666666; font-family:arial; font-size:11px"" size='5' maxlength=""20"" name='"&colName&"' value='"&valore&"' class=titolo>"

elseif inputItem="CO" then

    lunghezza=Len(colName)
    nometab=Mid(colName, 4, lunghezza)

    apply=CHR(10)&"<select style=""border:solid 1px #666666; width:250px; font-family:Verdana; font-size:11px"" name="""&colName&""" id="""&colName&""">"

    if nometab="oggetti" then

        ref=Session("pagina")

        if len(valore)=0 Or isnull(valore) then 
            adScript=adScript&"getSlect('"&colName&"',maxlevs,'void(0)');"&chr(10)
        Else
            adScript=adScript&"getSlect('"&colName&"',maxlevs,'$(\'#"&colName&"\').val("&valore&")');"&chr(10)
        End If

        else
	        if nometab="networking_themes" then
	            SQLtab="SELECT * FROM "&nometab&" WHERE CO_networking_groups="&request("group")&" AND CO_networking_themes=0"
	        elseif nometab="lingue" then
	            SQLtab="SELECT IN_valore AS ID, TA_nome FROM "&nometab&" WHERE LO_enabled=True AND ID>0"
	        else
	            SQLtab="SELECT * FROM "&nometab&" WHERE ID>0"
        end if

    if nometab="registeredusers" Then 
        SQLtab=SQLtab&" AND LO_projects=True"
        If Session("adm_area")>0 Then SQLtab=SQLtab&" AND CO_p_area="&Session("adm_area")
        SQLtab=SQLtab&" ORDER BY TA_cognome ASC"
        session("test"&i)="promotore"
    End if

    if nometab=tabella Then SQLtab=Replace(SQLtab,"WHERE","WHERE ID<>"&pagina&" AND ")

    set rec_tab=connection.execute(SQLtab)

    if valore=0 then
        apply=apply&"<option value='0' selected><script>document.write(unde1);</script></option>"
    end if

    do while not rec_tab.eof
        IDrec=rec_tab("ID")
        valo=rec_tab("TA_nome")

        if nometab="utenticantieri" OR nometab="intranet_users" then
            valo=valo & " " & rec_tab("TA_cognome")
        end if

        if nometab="registeredusers" OR nometab="utenticantieri" OR nometab="intranet_users" then
            valo=rec_tab("TA_ente")&" "&valo&" "&rec_tab("TA_cognome")
        end if

        sell=""
        if isnull(valore) then valore=0
        if len(valore)>0 AND CInt(IDrec)=CInt(valore) Then sell="selected"

        apply=apply & CHR(10) & "<option value='" & IDrec & "' " & sell & ">" & valo & "</option>"
        rec_tab.movenext
    loop

    apply=apply&"<option value='0'><script>document.write(unde1);</script></option>"
    end if
    apply=apply&CHR(10)&"</select>"

ElseIf inputItem="RS" then

    apply=" <input type=""hidden"" maxlength=""255"" size=""125"" name='" & colName & "' value=""" & valore & """ class=""testo""/>"
    valview=valore
	If Len(valview)>0 Then
	    valview=Split(valore,"/")
	    For yy=0 To UBound(valview)
	        apply=apply&"Risposta "&yy+1&": "&valview(yy)&"<br/>" 
	    Next
	Else apply=apply&"Nessuna risposta registrata"
	End if

''START FILE SECTION
elseif inputItem="AT" OR (colName="TA_nome" AND tabella="fails") then
isimg=" , jpg , jpeg , gif , ico , bmp , png , tiff , tif ,"
apply=" <input type=""hidden"" size=""5"" maxlength=""20"" id=""" & colName & "_fileval"" name=""" & colName & """ value=""" & valore & """>"

if len(valore)>0 then
	for x=1 to 32
	    chrF=Eval("CHR("&x&")")
	    valore = Replace(valore, chrF,"")
	Next
end if
wadd="Inserisci "
wfloat="left"
if Len(valore)>4 then
    wadd="Modifica "
    wfloat="right"
    imgview="/"&imgscript&"?path="&valore
    ext=LCase(mid(valore,instrrev(valore,".")+1))
	    if instr(isimg,", "&ext&" ,")>0 then
		    wimg=60
			if Lcase(right(valore,3))="ico" then wimg=32
			apply=apply&CHR(10)&"<div style=""float:left; width:"&wimg&"px; max-height:"&wimg&"px; overflow:hidden; border:solid 1px #333333;""><a href="""&imgview&"$500"" target=""_blank"">"&_
			"<img src=""/images/vuoto.gif"" style=""background-image:url("&imgview&"$"&wimg&"); background-size: auto 100%; background-repeat:no-repeat; background-position:center center; width:"&wimg&"px; height:"&wimg&"px;"" border=""0"" alt=""View""/></a></div>"&chr(10)
	    else
	        tipo=""
	        if instr(tabella,"networking")>0 then tipo="networking_files"
	        apply=apply&"<div style=""float:left;width:25px;height:14px; margin-right:18px;margin-top:-2px;padding:2px;color:#fff;background:#999; border-radius:5px;text-align:center; font-size:9px"">"&UCASE(ext)&"</div><a href=""../download.asp?nome="&valore&"&tipo="&tipo&""" target=""_blank"" style=""margin-left:10px"">download</a>"
	    end if

    apply=apply&" <a href=""javascript:delFile('mode=update&vars="&tabella&","&pagina&",,,,"&colName&",','"&colName&"');""><img src=""/images/vuoto.gif"" alt=""del"" style=""float:left; border:solid 1px; width:15px; height:15px; margin:-2px 0px 0px -15px;background:#fff url(./images/delete1.gif) center center no-repeat;""/></a>"&chr(10)
end if

apply=apply&"<p id="""&colName&"_file"" style=""font-size:11px;float:"&wfloat&""">"&wadd&"file <input class=""fileupload"" id="""&colName&""" type=""file"" name=""files[]"" data-url=""uploadJQuery.aspx"" style=""font-size:11px;""></p>"&chr(10)
apply=apply&"<div class=""barContain""><div class=""bar"" id="""&colName&"_bar"" style=""width: 0%;"">&nbsp;uploading ...</div></div>"

''END FILE SECTION

elseif colName="TA_password" Then

    If Len(valore)=0 Then valore=generatePassword(6)

    apply=" <input style=""width:"&winput&"px; border:solid 1px #666666; font-family:arial; font-size:11px"" type=""password"" size=""125"" name="""&colName&""" value="""&valore&""" class=""testo""/>"&chr(10)
    
    else
        If colName="TA_email" Then email=valore
        apply=" <input style=""width:"&winput&"px; border:solid 1px #666666; font-family:arial; font-size:11px"" type=""text"" maxlength=""255"" size=""125"" name='"&colName&"' value="""&valore&""" class=""testo"">"&chr(10)
    end if

    response.write "<tr><td align=""left"" valign=""middle"" class=""testoadm"" nowrap=""nowrap"" style=""text-transform:capitalize"">"&Session("test"&i)&"</td><td class=""testoadm"" valign=""top"">"&apply&"</td></tr>"

    i=i+1

    rstSchema.MoveNext

    else

    rstSchema.MoveNext

    end if

    Loop
    'Elimino la riga fake creata
    if maxid<>0 then 
        connection.execute("delete from " & Session("tab") & " where id=" & maxid)
    end if
    rstSchema.Close

dalink=da & ".asp"

if Session("tab")="galleries" then  dalink=dalink & "?refgallery=" & pagina
%>
<tr><td>&nbsp;</td>
<td>

<input type="hidden" name="contacampi" value="<%=i%>">
<input type="hidden" name="datadef" value="">

<%if tabella="formulari" then%>
<!--#INCLUDE VIRTUAL="./ADMIN/function_forms.asp"-->
<%end if%>
</td></tr>


</table>
<%if Session("tab")<>"newsletter" And Session("tab")<>"p_projects" And Session("tab")<>"p_description" And Session("tab")<>"p_comments" And Session("tab")<>"associa_galleries_immagini" AND mode<>"notmodal" then%>
<div style="position:relative;clear:both; float:right;margin-top:-20px; margin-right:5px;margin-bottom:10px">
<%if Session("tab")="registeredusers" And len(email)>5 AND instr(email,"@")>0 then%>
<input type="button" class="editBtns" style="width:240px;" value="invia password" onclick="document.location='send_password.asp?email=<%=email%>';"/><br/>
<%end if%>
<input type="BUTTON" value="X CHIUDI" id="mybt1" class="editBtns" onclick="closeThis(<%=LCase(forceRefresh)%>);">
<input type="submit" value="&raquo; SALVA"  id="mybt2"  class="editBtns";>


</div>
<%End if%>

<%if Session("tab")="associa_galleries_immagini" then%>
<div style="position:relative;clear:both; float:right;margin-top:-20px; margin-right:5px;margin-bottom:10px">
<input type="BUTTON" value="X CHIUDI" id="mybt1" class="editBtns" onclick="document.location='edit_galleries.asp';">
<input type="submit" value="&raquo; SALVA"  id="mybt2"  class="editBtns">
</div>
<%End if%>

<%if Session("tab")="newsletter" OR Session("tab")="p_projects" OR Session("tab")="p_description" OR Session("tab")="p_comments" Or mode="notmodal" then%>
<div style="position:relative;clear:both; float:right;margin-top:-20px;margin-right:20px;">
<%if Session("tab")="registeredusers" And len(email)>5 AND instr(email,"@")>0 then%>
<input type="button" class="editBtns"   style="width:120px;" value="invia password" onclick="document.location='send_password.asp?email=<%=email%>';"/><br/>
<%end if%>

<input type="submit" value="&raquo; SALVA"  id="mybt2"  class="editBtns">
</div>
<%End if%>

</form>

<%if len(Session("licensekey"))>0 And Session("tab")="_config_admin" then%>
<form action="changeNumProject.asp" method="post" style="Margin:50px 0px">
Change SITE Id <input type="text" class="testoadm" name="siteId"/>
<input type="submit" value="&raquo; CAMBIA" id="mybt2"  class="editBtns"/>
</form>
<%End if%>
</div>

<form name="form2a" action="edit.asp" method="post">
    <input type="hidden" name="pagina" value="<%=Session("pagina")%>"/>
    <input type="hidden" name="tabella" value="<%=Session("tab")%>"/>
    <input type="hidden" name="da" value="<%=da%>"/>
</form>

<script type="text/javascript" src="/js/datepicker.it.js"></script>

<script language="javascript" type="text/javascript">
var maxlevs=3;
var loadedStructure="";
$(document).ready(function() {
    $.datepicker.setDefaults( $.datepicker.regional[ "it" ]);
    $( ".dtPicker" ).datepicker({
       onSelect: function(dateText, inst) { 
            $('#mainForm').submit()
    }
});

//VB Aggiungo controllo per i campi required e max length
   $('#mainForm').submit(function() {
        var required = $("[name='requiredfields']").val();
        var array = required.split(',');
        for(var i = 0; i < array.length; i++) {
            var requiredField = $("[name='" + array[i] + "']").val();
            if (requiredField=="") {
                 alert(array[i] + " Richiesto!" );
                 return false;
            }
        }
        var maxlength = $("[name='maxlengthfields']").val();
        if (maxlength!="") {
            var arrayMaxLength = maxlength.split(',');
            for(var i = 0; i < arrayMaxLength.length; i++) {
                fieldName=arrayMaxLength[i].split('~')[0];
                maxLengthValue=arrayMaxLength[i].split('~')[1];
                var maxLengthField = $("[name='" + fieldName + "']").val();
                if (maxLengthField.length>maxLengthValue) {
                     alert("La lunghezza " + maxLengthField.length + " di " + fieldName + " supera la dimensione consentita (" + maxLengthValue + ")");
                     return false;
                }
            }
        }
        
        return true;
    });

//    function refreshParent() {
//   	    window.parent.location.reload(false);
//    }

$("#mybt2").val(save1);
$('body').css('margin','10px 0px 0px 10px')
$('p').css('text-shadow','1px 1px 1px #fff')
<%if len(adScript)>0 then
response.write adScript
end if%>

    $('.fileupload').each(function() {
		var jqXHR = $(this).fileupload({
        dataType: 'json',
		formData: {tabdest:  $(this).attr("id")},
		 progress: function (e, data) {
		$('.fileupload').css("display","none");
	   mainObj =  $(this).attr("id");

		objBar = $("#"+mainObj+"_bar");
		objFile = $("#"+mainObj+"_file");
		objFile.fadeOut(100);
		objBar.parent().fadeIn(200);
		objBar.bind("click", function() { jqXHR.abort(); });
        var progress = parseInt(data.loaded / data.total * 100, 10);
        objBar.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+progress+"% - "+ parseInt(data.loaded/1000)+"/"+ parseInt(data.total/1000) + " KB");
		objBar.css('width',progress + '%');
    },
        done: function (e, data) {
			getId=$(this).attr("id");
			$.each(data.result, function (index, file) {
              $('.fileupload').remove();
			  $('#'+getId+'_fileval').val(file.url);
			  $('#mainForm').submit();
            });
        }
    });
	});


<%if Session("tab")<>"newsletter" AND Session("tab")<>"p_projects" AND Session("tab")<>"p_description" AND Session("tab")<>"p_comments" AND Session("tab")<>"associa_galleries_immagini" AND mode<>"notmodal" then%>
redimThis();
<%end if%>
<%if Session("tab")<>"associa_galleries_immagini" then%>
load_editorSmall(402,200);
<%end if%>
<%=addCFunc%>

});


function delFile(urladd,destfield) {
    if (confirm('Eliminare l\'elemento selezionato?')) { 
        getUrl="delFileJQ.asp?"+urladd;
        $.ajax({
          url: getUrl,
          context: document.body,
          success: function(msg){
            $('#'+destfield+'_fileval').val('');
            $('#mainForm').submit();
            }
        });
    }
}

function delColor(val,tdref) {
    obj=document.getElementById(tdref);
    val1=obj.value;
    var re = new RegExp(","+val,"g");
    val1=val1.replace(re,"");
    obj.value=val1;
	document.form2.submit();
}

function delColor1(val,tdref) {
    obj=document.getElementById(tdref);
    val1=obj.value;
    val1=val1.replace(val,"");
    obj.value=val1;
	document.form2.submit();
}

</script>

<%=addtoend%>
</body></html>
<%connection.close%>

