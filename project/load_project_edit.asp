
<%
'Response.CodePage  = 65001
refProject=load
SQL="SELECT * FROM QU_projects WHERE  ID="&refProject
Set rec=connection.execute(SQL)
If Not rec.eof Then
pCat=rec("refCat")
If isnull(pCat) Then pCat=0
pCatName=rec("category")
pColor=rec("TA_color")
pImg=rec("AT_main_img")
		pTitle=rec("TA_nome")
        
'IB 170220 Fix titolo in finestra modifica progetto
If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")
'IB 170220 Fix titolo in finestra modifica progetto
'IB 170322 aggiunta subtitle
pSubtitle = rec("TA_nome_1")
If Len(pSubtitle)>0 Then psubTitle=Replace(psubTitle,"#","'")
'IB 170322 aggiunta subtitle
ptitle = ConvertFromUTF8(ptitle)
pSubTitle = ConvertFromUTF8(pSubTitle)

If isnull(pColor) Then pColor="#9ba1b3"
confirmed=rec("LO_confirmed")
toconfirmed=rec("LO_toconfirmed")
deleted=rec("LO_deleted")
puser=rec("CO_registeredusers")

If puser<>Session("logged_donator") Then
Response.End
End If

If Len(Session("logged_donator"))=0 Then
Response.redirect(pagelog)
Response.End
End If



If (confirmed=True OR toconfirmed=True) AND Session("log45"&numproject)<>"req895620schilzej" Then
Response.redirect("/?progetti/"&refProject&"/"&plink)
End If

		luogo=ConvertFromUTF8(rec("TA_luogo"))
		nazione=rec("TA_nazione")
		pText=rec("TE_abstract")
		pObj=rec("IN_cifra")

		cifraObiettivo=pObj
		cifraObiettivo=setCifra(cifraObiettivo)


		pPropri=rec("IN_mezzi_propri")
		pObt=rec("IN_raccolto")
		pMancante=(pObj-pObt-pPropri)*-1
		pRef=rec("ID")
		termine=rec("DT_termine")
		rated=rec("IN_rated")
		visite=rec("IN_viewed")
		voti=rec("IN_votes")
		minimo=rec("IN_cifra_minima")
		minvalue=minimo
		free_donate=rec("LO_free_donate")

		closed=rec("LO_realizzato")
		
		If pObj>0 Then sperc=CInt(pObt/pObj*100)
		If pObj>0 Then sperc1=CInt(pPropri/pObj*100)
		svotes=0

		mCol="#00b450" 
		wManca="finanziato"
		If pMancante<0 Then 
		mCol="#e20613"
		wManca="mancano ancora"
		pMancante=setCifra(pMancante)
		Else
		If pMancante>0 Then pMancante="+"&setCifra(pMancante)
		End if
		If (voti>0) Then svotes=round(rated/voti,1)

		subCategories=rec("CR_p_subcategory")
diffdays=dateDiff("d",Now(),termine)
diffmonths=dateDiff("m",Now(),termine)
wdiff="giorni"
wdays=diffdays
If diffdays>60 Then 
wdiff="mesi"
wdays=diffmonths
End if

If Len(pImg)>0 Then
addimg=imgscript&"?path="&pImg&"$400"
Else
addimg="/images/thumb_picture.png"
End if


SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_projects="&refProject&")"
Set rec1=connection.execute(SQL)
num_subscribers=rec1("subscribers")

	SQL="SELECT  COUNT(ID) as newscount FROM p_description WHERE TA_type='update' AND LO_confirmed=True AND CO_p_projects="&refProject
	Set rec1=connection.execute(SQL)
newscount=rec1("newscount")

If newscount>0 Then
newscount="<div class=""newscount"">"&newscount&"</div>"
Else
newscount=""
End if

If Len(subCategories)>1 Then
subCategories=Split(subCategories,",")
For y=1 To UBound(subCategories)-1
SQL="SELECT * FROM p_subcategory WHERE ID="&subCategories(y)
Set rec1=connection.execute(SQL)
If Not rec1.eof Then addcats=addcats&" - "&rec1("TA_nome")
Next
End If



If Len(puser)>0 Then
SQL="SELECT * from registeredusers WHERE LO_projects=True AND LO_enabled=True AND ID="&puser
Set rec1=connection.execute(SQL)
if Not rec1.eof then

wPromo=rec1("TA_ente")
If Len(wPromo)=0 Then wPromo=rec1("TA_nome")&"&nbsp;"&rec1("TA_cognome")

addinfo="<p style=""margin-bottom:0px; padding:0px;""><b>Promotore</b><br/>"&wPromo&"<br/><br/>"
fb=rec1("TA_facebook")
If Len(fb)>0 Then addinfo=addinfo&"<a href="""&fb&""" target=""_blank""><img src=""/images/img_fb.png""></a>&nbsp;&nbsp;"

tw=rec1("TA_twitter")
If Len(tw)>0 Then addinfo=addinfo&"<a href="""&tw&""" target=""_blank""><img src=""/images/img_tw.png""></a>&nbsp;&nbsp;"

lk=rec1("TA_linkedin")
If Len(lk)>0 Then addinfo=addinfo&"<a href="""&lk&""" target=""_blank""><img src=""/images/img_lk.png""></a>&nbsp;&nbsp;"

addinfo=addinfo&"</p>"

End If
End if


%>
<div id="maincolor"><%=pColor%></div>
<div id="maincat"><%=pCat%></div>

<div class="pContainer" style="min-height:710px">
	<div class="pText" style="min-height:550px">

	<div class="pButton a<%=pCat%> edit" onclick="getEdit(1,<%=refProject%>,$(this))"><img src="/images/p_1.png" longdesc="/images/p_1.png" rel="/images/p_1<%=pCat%>.png"/><br/>Info</div>
	<div class="pButton a<%=pCat%> edit" onclick="getEdit(4,<%=refProject%>,$(this))"><img src="/images/p_1.png" longdesc="/images/p_1.png" rel="/images/p_1<%=pCat%>.png"/><br/>Il progetto</div>
	<div class="pButton a<%=pCat%> edit" onclick="getEdit(5,<%=refProject%>,$(this))"><img src="/images/p_2.png" longdesc="/images/p_2.png" rel="/images/p_2<%=pCat%>.png"/><br/>Chi siamo</div>
	<div class="pButton a<%=pCat%> edit" onclick="getEdit(9,<%=refProject%>,$(this))"><img src="/images/p_3.png" longdesc="/images/p_3.png" rel="/images/p_3<%=pCat%>.png"/><br/>Media</div>
	<div class="pButton a<%=pCat%> edit" onclick="getEdit(6,<%=refProject%>,$(this))"><img src="/images/p_4.png" longdesc="/images/p_4.png" rel="/images/p_4<%=pCat%>.png"/><br/>Downloads</div>
	<div class="pButton fin edit" onclick="getEdit(3,<%=refProject%>,$(this))"><img src="/images/p_5.png" longdesc="/images/p_5.png" rel="/images/p_51.png"/><br/>Finanzia</div>
	
        <div class="pButton"  onclick="getEdit(8,<%=refProject%>,$(this))" style="display:none"><img src="/images/p_6.png" longdesc="/images/p_6.png" rel="/images/p_6.png"/><br/>Avvio</div>
        
<div style="clear:both"></div>
<div class="pLeft">
<img src="/images/vuoto.gif" alt="<%=pTitle%>" style="cursor:pointer; background-image: url(<%=addimg%>)" />
<img src="/images/ico_edit.png" class="edit" style="position:absolute; cursor:pointer; display:none; left:0px; top:117px; width:45px; height:42px;"  onclick="getEdit(2,<%=refProject%>,$(this))"/>
</div>
<div class="pCenter" style="position:relative; width:780px;">
<div class="pInfo">
<h1 style="color:<%=pColor%>"><%=pTitle%></h1>
<h1 style="color:<%=pColor%>" class="subtitle"><%=psubTitle%></h1>
<h2 style="color:<%=pColor%>"><%=luogo%>, <%=nazione%></h2>
<div class="info_p" style="float:left; z-index:99; position:relative; min-width:300px; display:none; margin:0px; padding:0px;"><%=addinfo%></div>
</div>

<div class="myprojectsFrame"><iframe scrolling="0" marginheight="0" marginwidth="0" frameborder="0" allowtransparency></iframe></div>

	<div class="pDesc"><p> </p><p>&nbsp;</p>
	<div class="anchor"></div>
	</div>

	<div class="pDesc"><p> </p><p>&nbsp;</p>
		<div class="anchor"></div>
	</div>

	<div class="pDesc"><p> </p><p>&nbsp;</p>
		<div class="anchor"></div>
</div>

	<div class="pDesc"><p> </p><p>&nbsp;</p>
		<div class="anchor"></div>
</div>

	<div class="pDesc"><p> </p><p>&nbsp;</p>
		<div class="anchor"></div>
</div>

	<div class="pDesc"><p> </p><p>&nbsp;</p>
		<div class="anchor"></div>
</div>
    

	</div>

</div>

<div class="addbottom" style="position:relative; z-index:10; background:#fff; width:100%; margin-top:-37px; margin-bottom:37px; height:42px;"></div>
</div>
<%
firstDo=0
If InStr(complex,"/donate/") Then firstDo=4
If InStr(complex,"/edit/") Then firstDo=0
firstaction="javascript:$('div.pButton').eq("&firstDo&").trigger('click')"


If InStr(complex,"/avvio/") Then firstaction="javascript:$('div.myprojectsFrame iframe').attr('src','/project/project_make_8.asp?load="&refProject&"')"

%>
<a style="display:none" class="firstAction" href="<%=firstaction%>"></a>
<%End if%>