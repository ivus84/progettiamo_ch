<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="/incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/common_functions.asp"-->
<%
load=request("load")
refpage=request("refpage")

complex=request.querystring

If Len(complex)>0 Then 
	complex=Replace(complex,"%2F","/")
	If InStr(complex,"&")>0 Then complex=Mid(complex,1,InStr(complex,"&")-1)
End if

If InStr(complex,"load=")=0 And InStr(complex,"/")>0 Then
	
	If Mid(complex,1,6)="image/" Then
	    imgcomplex=Mid(complex,7)
	    gtWidth=Mid(imgcomplex,1,InStr(imgcomplex,"/")-1)
	    gtPath=Mid(imgcomplex,InStrRev(imgcomplex,"/")+1)
	    Response.redirect("/"&imgscript&"?path="&gtPath&"$"&gtWidth)
	    Response.end
	End if

	If InStr(complex,"progetti/") Then
	    pagemode="progetti"
	    complex=Mid(complex,10)
	    load=Mid(complex,1,InStr(complex,"/")-1)
	ElseIf InStr(complex,"edit-project/") Then
	    pagemode="editproject"
	    complex=Mid(complex,14)
	    load=Mid(complex,1,InStr(complex,"/")-1)

	Else
	    pagemode="page"
	    load=Mid(complex,1,InStr(complex,"/")-1)
	    complex=Mid(complex,InStr(complex,"/")+1)
		If InStr(complex,"/")>0 Then
		t2ndref=Mid(complex,InStr(complex,"/")+1)
		End if
	End if
End if

if len(refpage)>0 then load=refpage
if len(load)>0 then Session("pagina1")=load end if

If pagemode="progetti" Then
	addclassBody=" class=""progetti"""

	refProject=load
	SQL="SELECT * FROM QU_projects WHERE ID="&refProject
	Set rec=connection.execute(SQL)
	If Not rec.eof Then

	    imgb1=rec("AT_banner")
	    pImage=rec("AT_main_img")
	    If Len(pImage)=0 OR isnull(pImage) Then pImage=imgb1
	    addDesc=rec("TE_abstract")
	    setTitle=rec("TA_nome")
        'settitle = convertfromutf8(settitle)
	    addKeys=rec("TX_keywords")
	    If Len(addKeys)>0 Then addKeywords=addKeys
	End If
	Set rec=nothing
	If Session("log45"&numproject)="req895620schilzej" Then addscriptP=addscriptP&"if (confirm('Visualizzazione scheda progetto "&setTitle&"')) { self.focus(); } else { self.close();}"

	%>
	<!--#INCLUDE VIRTUAL="./incs/load_body.asp"-->
	<!--#INCLUDE VIRTUAL="./project/load_projects_menu.asp"-->
	<!--#INCLUDE VIRTUAL="./project/load_project.asp"-->
	<!--#INCLUDE VIRTUAL="./incs/load_bottom.asp"-->
	<%Response.End
End If

If pagemode="editproject" Then
	addclassBody=" class=""progetti editproject"""
	If Session("log45"&numproject)="req895620schilzej" Then addscriptP=addscriptP&"if (confirm('Scheda progetto aperta in modalità promotore. Abbiate cura di modificare un solo progetto alla volta.')) { self.focus(); } else { self.close();}"
	ishomepage = false
    %>
	<!--#INCLUDE VIRTUAL="./incs/load_body.asp"-->
	<!--#INCLUDE VIRTUAL="./project/load_projects_menu.asp"-->
	<!--#INCLUDE VIRTUAL="./project/load_project_edit.asp"-->
	<!--#INCLUDE VIRTUAL="./incs/load_bottom.asp"-->
	<%
	Response.End
End If

If pagemode="profilo" Then
	addclassBody=" class=""progetti"""
	%>
	<!--#INCLUDE VIRTUAL="./incs/load_body.asp"-->
	<!--#INCLUDE VIRTUAL="./project/load_projects_menu.asp"-->
	<!--#INCLUDE VIRTUAL="./profilo/load_profile.asp"-->
	<%addscript=""%>
	<!--#INCLUDE VIRTUAL="./incs/load_bottom.asp"-->
	<%

	Response.End
End If

If pagemode="myprojects" Then
	addclassBody=" class=""progetti"""
	%>
	<!--#INCLUDE VIRTUAL="./incs/load_body.asp"-->
	<!--#INCLUDE VIRTUAL="./project/load_projects_menu.asp"-->
	<!--#INCLUDE VIRTUAL="./project/load_myprojects.asp"-->
	<%addscript=""%>
	<!--#INCLUDE VIRTUAL="./incs/load_bottom.asp"-->
	<%Response.End
End If



refid=Session("pagina1")
issection=False

SQL="SELECT oggetti.ID FROM defsections INNER JOIN oggetti ON oggetti.ID=defsections.CO_oggetti_ WHERE defsections.CO_oggetti_="&refid&" AND defsections.CO_oggetti=0"
set recordset1=connection.execute(SQL)
if not recordset1.eof Then issection=True


SQL="SELECT * from retrievepath WHERE ID="&refid
set recordset1=connection.execute(SQL)
if not recordset1.eof Then 
    ref1=recordset1("ID1")
    ref2=recordset1("ID2")
    ref3=recordset1("ID3")
    If isnull(ref1) Then issection=True

    If isnull(ref1)=false Then isupsection=ref1
    If isnull(ref2)=false Then isupsection=ref2
    If isnull(ref3)=false Then isupsection=ref3

End if


SQL="SELECT newsection.DT_data, newsection.AT_image AS img_default, newsection.AT_image"&Session("reflang")&" as featured_image ,newsection.TA_linkto, newsection.TA_linkto"&Session("reflang")&" as subtitle, newsection.LO_homepage,newsection.ref_redirect, newsection.CO_oggetti,newsection.TA_nome"&Session("reflang")&" AS TA_nome,newsection.sopra"&Session("reflang")&" AS namesection,newsection.TX_keywords"&Session("reflang")&" AS TX_keywords, newsection.TX_testo"&Session("reflang")&" AS TX_testo, newsection.LO_pubblica"&Session("reflang")&" as pubblica,TX_embed,isnews,LO_news,LO_protected,LO_hidetitleonpage,LO_contact_page,LO_networking,LO_commerce,LO_menu2,LO_protected,gallery_element,LO_list_section,LO_reserved FROM newsection WHERE ID="&refid
if len(t2ndref)>0 and isnumeric(t2ndref) then SQL=SQL &" AND CO_oggetti="&t2ndref
If Session("log45"&numproject)<>"req895620schilzej" Then SQL=SQL &" AND LO_pubblica"&Session("reflang")&"=True"


set recordset1=connection.execute(SQL)

If recordset1.eof Then mainTitle ="Pagina non trovata"


if not recordset1.eof Then
    ref_redirect=recordset1("ref_redirect")
    if isnull(ref_redirect)=false AND ref_redirect>0 then
        response.redirect("/?"&ref_redirect&"/")
        response.end
    end if

    pubblica=recordset1("pubblica")
    setTitle=recordset1("TA_nome")
    addKeywords=recordset1("TX_keywords")
    ishomepage=recordset1("LO_homepage")
    addDesc=recordset1("TX_testo")
    pImage=recordset1("featured_image")
    If Len(pImage)=0 Or isnull(pImage) Then pImage=recordset1("img_default")
    embdvideo=recordset1("TX_embed")

    hidetitleonpage=recordset1("LO_hidetitleonpage")
    client=recordset1("TA_linkto")
    mainData=recordset1("DT_data")
    subtitle=recordset1("subtitle")
    gallery_element=recordset1("gallery_element")

    mainTxt =  addDesc
    mainTitle =  setTitle
    mainAbstract = abstract
    mainImg = pImage

    namesection=recordset1("namesection")
    mainsectionName=""
    mainsectionName = namesection
    ishome=ishomepage
	
    isnews=recordset1("isnews")
    isnewsarchive=recordset1("LO_protected")
    news_set=recordset1("LO_news")
    upsection =	recordset1("CO_oggetti")
    If Len(namesection)>0 Then setTitle=namesection&" - "&setTitle
    If Len(abstract)>0 Then addDesc=abstract
    If gallery_element Then 
        'addscript=addscript&Chr(10)&"openGalleryElement("&refid&")"
        refid=upsection
        mainTitle=namesection
        containGallery=true
    End if

    If Len(session("ModeNews"))>0 And isnews Then upsection=session("ArchiveNews")

end if


addclassBody=""
If ishome Then addclassBody=" class=""home"""
If news_set Then addclassBody=" class=""news"""
If containGallery Then addclassBody=" class=""gallery"""

disableredirect=False

if len(mainTxt)>0 then disableredirect=True
If containGallery Or Reserved Then disableredirect=True

%>
	<!--#INCLUDE VIRTUAL="./incs/load_body.asp"-->
  
<%
setImgP=""
if len(refid)=0 then refid=Session("pagina1")

	if len(refid)>0 then
	Session("pagina1")=refid

	if ishomepage then%>
	<!--#INCLUDE VIRTUAL="/incs/load_home_content.asp"-->

    <!--#INCLUDE VIRTUAL="./project/load_news_home.asp"-->

	<%end if%>
    
	<!--#INCLUDE VIRTUAL="./project/load_projects_menu.asp"-->

	<!--#INCLUDE VIRTUAL="./incs/load_page.asp"-->

	<%end if%>

<!--#INCLUDE VIRTUAL="./incs/load_bottom.asp"-->
