<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_language_vars.asp"-->
<%
load=request("load")
mode=request("mode")

modeHome=1

'Header progetti home logged
'IB 160915 - CARICAMENTO MAX 4 PROJ X AREA
SQLAree = "SELECT DISTINCT ID FROM P_AREA"
set rec = connection.execute(SQLAREE)
if not rec.eof then
SQL="SELECT top 4 * FROM QU_projects WHERE len(AT_banner)>0 AND LO_deleted=False AND LO_in_evidenza=True AND LO_confirmed=True and co_p_area="&rec("ID")&" ORDER BY rnd(ID), DT_termine ASC "
rec.movenext
while not rec.eof 
SQL=SQL&"union (SELECT top 4 * FROM QU_projects WHERE len(AT_banner)>0 AND LO_deleted=False AND LO_in_evidenza=True AND LO_confirmed=True and co_p_area="&rec("ID")&" ORDER BY rnd(id), DT_termine ASC ) "
rec.movenext
wend
end if
'IB 160915 - CARICAMENTO MAX 4 PROJ X AREA
If load=2 Then SQL="SELECT * FROM QU_projects WHERE len(AT_banner)>0 AND LO_realizzato=True AND LO_confirmed=True ORDER BY DT_apertura DESC"
If load=3 Then SQL="SELECT * FROM QU_projects WHERE len(AT_banner)>0 AND LO_confirmed=True ORDER BY IN_viewed DESC, ID ASC"
If load=1 Then SQL="SELECT * FROM QU_projects WHERE len(AT_banner)>0 AND IN_raccolto>0 AND (fondi_raccolti>=IN_cifra) AND LO_realizzato=False AND LO_confirmed=True ORDER BY DT_apertura DESC"

If Len(mode)>0 And Session("islogged"&numproject)<>"hdzufzztKJ89ei" Then
    Response.End
End if

If Len(mode)>0 And Session("islogged"&numproject)="hdzufzztKJ89ei" Then
modeHome=0

'Header progetti utente logged

If mode=0 Then SQL="SELECT DISTINCT QU_projects.* FROM QU_donators INNER JOIN QU_projects ON QU_donators.CO_p_projects = QU_projects.ID WHERE QU_projects.LO_confirmed=True AND QU_projects.LO_realizzato=False AND QU_donators.ID="&Session("logged_donator")
If mode=1 Then SQL="SELECT DISTINCT QU_projects.* FROM QU_donators INNER JOIN QU_projects ON QU_donators.CO_p_projects = QU_projects.ID WHERE QU_projects.LO_confirmed=True AND ((IN_raccolto+IN_mezzi_propri)/IN_cifra*100)>=100 AND QU_donators.ID="&Session("logged_donator")
	If mode=2 Then 
	SQL1="SELECT TX_favorites FROM QU_donators WHERE len(TX_favorites)>1 AND QU_donators.ID="&Session("logged_donator")
	Set rec1=connection.execute(SQL1)
		If rec1.eof Then 
		Response.write "<p style=""color:#292f3a"">"&str_no_favorites&"</p>"
		Response.end
		Else
		favorites=Split(rec1("TX_favorites"),",")
			For y=1 To ubound(favorites)-1
			adSql=adSql&" OR QU_projects.ID="&favorites(y)
			Next
		adSql=Mid(adSql,5)
		SQL="SELECT DISTINCT QU_projects.* FROM QU_projects WHERE LO_confirmed=True AND ("&adSql&")"
		End if
	End if

End if
'Response.write "Sql:"&sql

'Set rec=Server.CreateObject("ADODB.Recordset")
'rec.CursorLocation=3
'Rec.Open sql,connection
Set rec=connection.execute(SQL)

'response.write " RecordCount: "&rec.RecordCount
	If rec.eof Then
	msgWrite="<p style=""color:#292f3a"">"&str_no_projects_category&"</p>"

If modeHome=0 Then
		If mode=0 Then msgWrite="<p style=""color:#292f3a"">"&str_no_promises&"</p>"
		If mode=1 Then msgWrite="<p style=""color:#292f3a"">"&str_nofound2&"</p>"
		If mode=2 Then msgWrite="<p style=""color:#292f3a"">"&str_no_favorites&"</p>"
End if
Response.write msgWrite
else
		maxnum=7
        ''' IB aumento progetti home BEGIN
		'If modeHome=1 Then maxnum=11
        If modeHome=1 Then maxnum=15
        ''' IB aumento progetti home END
		For x=0 To maxnum
		If Not rec.eof Then
		imgb=rec("AT_banner")
		imgb1=rec("AT_post_img")
		imgb0=rec("AT_main_img")
		If modeHome=0 Then imgb=imgb0

		color=rec("TA_color")
		pTitle=rec("TA_nome")
        If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")
		
        'IB 170322 aggiunta subtitle
        pSubtitle = rec("TA_nome_1")
        If Len(pSubtitle)>0 Then psubTitle=Replace(psubTitle,"#","'")
        'IB 170322 aggiunta subtitle

		pEmotion=rec("TA_emotional")
		pCat=rec("category")
		refCat=rec("CO_p_category")

		pText=rec("TE_abstract")
        pText = ConvertFromUTF8(pText)
		pTot=rec("fondi_raccolti")
		pObj=rec("IN_cifra")
		realizzato=rec("LO_realizzato")
		aperto=rec("LO_aperto")
        
        isVideoEmbed = rec("LO_video_embed")
        
        pVideo = ""
        addVideo = ""
        if isVideoEmbed then
            pVideo = rec("TX_video_embed")
            If Len(pVideo)>0 Then
				If InStr(pVideo,"<iframe ")Then
				    pVideo=Replace(pVideo,Chr(34)&Chr(34),Chr(34))
				    pVideoGet=getVideoSrc(pVideo)
				Else 
					pVideoGet=pVideo
				End If
				
				If Len(pVideoGet)>0 Then 
                    addVideo = StringFormat("<img class='vImg' src='../images/bottone_video.png' rel='{0}' onclick='videoOpen(this)'/>", Array(pVideoGet))
                end if
            end if
        end if
        
		p100=false
		If pTot>=pObj Then p100=True

		If realizzato Then
		If Len(imgb1)>0 Then imgb=imgb1
		End if
		
		pRef=rec("ID")
		termine=rec("DT_termine")
		diffdays=dateDiff("d",Now(),termine)*-1

		SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_projects="&pRef&")"
		Set rec1=connection.execute(SQL)
		num_subscribers=rec1("subscribers")

		If modeHome=0 Then 
		TotDonato=0

			SQL="SELECT SUM(IN_promessa) As TotDonato FROM associa_registeredusers_projects WHERE CO_registeredusers="&Session("logged_donator")&" AND CO_p_projects="&pRef
			Set rec1=connection.execute(SQL)
			If Not rec1.eof Then 
			TotDonato=rec1("TotDonato")
			End if
		End if

		sperc=CInt(pTot/pObj*100)
        
pObjw=setCifra(pObj)
pObtw=setCifra(pTot)

		If Len(imgb)>0 Then 
		If modeHome=0 Then imgb="/"&imgscript&"?path="&imgb&"$600"
		If modeHome=1 Then imgb="/"&imgscript&"?path="&imgb&"$1280"
		Else
		imgb="/images/vuoto.gif"
		End If

pText=ClearHTMLTags(pText,0)
If Len(pText)>0 Then pText=Trim(pText)
lenabs=320-Len(pTitle)
If Len(pText)>lenabs Then pText=truncateTxt(pText,lenabs)

pLink=linkMaker(pTitle)
wobj=str_obiettivo
If modeHome=0 Then 
pText=""
pObt=sperc&"%"
pObj=num_subscribers&"&nbsp;&nbsp;&nbsp;"
wobj=str_obiettivo
End if

ico_donation="ico_donate.png"
bgi_donation=" style=""background-image: url(/images/"&Replace(color,"#","")&".png);background-size:62% 70%"""
adi_donation=""

	If modeHome=1 Then 

		If realizzato then
		    pCat=str_realizzato
		    ico_donation="ico_realizzato_home.png"
		    bgi_donation=""
		ElseIf p100 Then 
		    adi_donation="<img class=""img100"" src=""/images/ico_100_"&refCat&".png"" alt=""""/>"
		    If aperto=False Then ico_donation="ico_winprogress.png"
		End If

	End if

nomec=pCat
If Len(nomec)>0 Then nomec=Replace(nomec,"Sosteniamo",str_sosteniamo)
If Len(nomec)>0 Then nomec=Replace(nomec,"Doniamo",str_doniamo)
If Len(nomec)>0 Then nomec=Replace(nomec,"Finanziamo",str_finanziamo)
pCat=nomec

plink1="/?progetti/"&pRef&"/"&pLink
plink2="/?progetti/"&pRef&"/"&pLink&"/donate/"

If realizzato Then plink2="/?progetti/"&pRef&"/"&pLink&"/news/"

    colortext = "white"
		Response.write "<div rel=""p"" class=""main"" style=""background-image:url("&imgb&")"" alt="""&imgb&"""><div class=""over"" style=""background:"&color&"""></div><div class=""textcont"">"&adi_donation&"<span class=""video"">"&addVideo&"</span><div class=""overtext"" onclick=""document.location='"&plink1&"'""><div class=""donate"" style=""color:"&colortext&""" onclick=""document.location='"&pLink2&"'""><img src=""/images/"&ico_donation&""""&bgi_donation&"/><br/>"&pCat&"<br/></div><div class=""titcont""><p><b>"&ConvertFromUTF8(pTitle)&"</b><br/><b>"&ConvertFromUTF8(pSubtitle)&"</b></p></div><p class=""overAbstract"">"&pText&"</p><div class=""cifre""><div><span class=""cifre"">"&str_funds&":</span><span class=""cifre dCifre"">"&pObtw&"</span></div><div><span class=""cifre"">"&wobj&":</span><span class=""cifre dCifre"">"&pObjw&"</span></div>"
		
		'Add promessa in header user logged
		If modeHome=0 And TotDonato>0 Then 
            Response.write "<div><span class=""cifre"">"&str_promessa&":</span><span class=""cifre dCifre"">"&setCifra(TotDonato)&"</span></div>"
		end if
		'Add termine in header home
		If load=0 AND modeHome=1 And diffdays<=0 Then  Response.write "<div><span class=""cifre"">"&diffdays*-1&" "&str_cf_daysto&"</span></div>"
		
		response.Write "</div></div></div></div>"

		rec.movenext
		End if
		Next
End If

		%>
<%connection.close%>
