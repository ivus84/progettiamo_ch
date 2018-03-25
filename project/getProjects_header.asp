<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_language_vars.asp"-->
<%

load=request("load")
mode=request("mode")

modeHome=1

'VB Sezione gestione VideoHome - Uniformo la labella _config_video alla vista QU_projects
sub replaceField(byref fullString,original,toreplace)
    if fullString="" then
        if original=toreplace then 
            fullString=original
        else
            fullString=original & " as " & toreplace
        end if
    else
        if original=toreplace then 
            fullString=fullString & "," & original
        else
            fullString=fullString & "," & original & " as " & toreplace
        end if
    end if
end sub

fields4Query="ID,DT_termine,AT_banner,AT_post_img,AT_main_img,TA_color,TA_nome,TA_nome_1,TA_emotional,category,CO_p_category,TE_abstract,fondi_raccolti,IN_cifra,LO_realizzato,LO_aperto,LO_video_embed,TX_video_embed"
fields4QueryArray=Split(fields4Query,",")

fields4QUPROJECTS=""
for each field in fields4QueryArray
    if fields4QUPROJECTS="" then
        fields4QUPROJECTS="QU_projects." & field
    else
        fields4QUPROJECTS=fields4QUPROJECTS & "," & "QU_projects." & field
    end if
next
fields4QUPROJECTS=fields4QUPROJECTS & ",Rnd(-10000000*TimeValue(Now())*[QU_projects.id]) as randomId"

fields4VIDEOHOME=""

for each field in fields4QueryArray
    select case field
        case "ID"
            call replaceField(fields4VIDEOHOME,0,field)
        case "TX_video_embed"
            call replaceField(fields4VIDEOHOME,field,field)
        case "DT_termine"
            call replaceField(fields4VIDEOHOME,"'" & Date & "'",field) 
        case "TA_nome"
            call replaceField(fields4VIDEOHOME,"TA_video_title",field)
        case "TA_color"
            call replaceField(fields4VIDEOHOME,"'#292f3a'",field)  
        case "TA_nome_1"
            call replaceField(fields4VIDEOHOME,"TX_video_subtitle",field)
        case "TA_emotional"
            call replaceField(fields4VIDEOHOME,"''",field)
        case "category"
            call replaceField(fields4VIDEOHOME,"''",field)
        case "CO_p_category"
            call replaceField(fields4VIDEOHOME,0,field)
         case "TE_abstract"
            call replaceField(fields4VIDEOHOME,"''",field)
        case "fondi_raccolti"
            call replaceField(fields4VIDEOHOME,0,field)
        case "IN_cifra"
            call replaceField(fields4VIDEOHOME,0,field)
        case "LO_video_embed"  
            call replaceField(fields4VIDEOHOME,1,field)
        case "LO_aperto"  
            call replaceField(fields4VIDEOHOME,0,field)
        case "LO_realizzato"  
            call replaceField(fields4VIDEOHOME,0,field)
        case "AT_banner"
            call replaceField(fields4VIDEOHOME,"AT_snapshot",field)
        case else
            call replaceField(fields4VIDEOHOME,"null",field)  
    end select
next
'VB Se video in posizione random valorizzo il RandomId altrimenti fisso a 0
fields4VIDEOHOME=fields4VIDEOHOME & ",switch(lo_video_position=0,0,lo_video_position<>0,Rnd(-10000000*TimeValue(Now())*[id])) as randomId"

'VB Fine sezione preliminare video home

SQL=""
'Header progetti home logged
'IB 160915 - CARICAMENTO MAX 4 PROJ X AREA
SQLAree = "SELECT DISTINCT ID FROM P_AREA"
set rec = connection.execute(SQLAREE)

'VB Prendo random un solo video dalla _config_video
SQL="select " & fields4VIDEOHOME & " from _config_video  where LO_disabilitato<>-1 " 

if not rec.eof then
    If Session("islogged" & numproject)="hdzufzztKJ89ei" Then
        SQL="SELECT top 4 " & fields4QUPROJECTS & " FROM QU_projects WHERE len(AT_banner)>0 AND LO_deleted=False AND LO_in_evidenza=True AND LO_confirmed=True and co_p_area=" & rec("ID")
    End If 
    while not rec.eof 
        SQL=SQL & "union (SELECT top 4 " & fields4QUPROJECTS & " FROM QU_projects WHERE len(AT_banner)>0 AND LO_deleted=False AND LO_in_evidenza=True AND LO_confirmed=True and co_p_area=" & rec("ID") & ") "
        rec.movenext
    wend
end if

'if mode=0 then Response.End
'IB 160915 - CARICAMENTO MAX 4 PROJ X AREA

toAppend=""
If Len(load)>0 Then
    If load=2 Then
        if SQL<>"" then
            SQL=SQL=" union ("
            toAppend=")"
        end if 
        SQL=SQL & "SELECT " & fields4QUPROJECTS & " FROM QU_projects WHERE len(AT_banner)>0 AND LO_realizzato=True AND LO_confirmed=True ORDER BY DT_apertura DESC" & toAppend
    end if

    If load=3 Then 
        if SQL<>"" then
            SQL=SQL=" union ("
            toAppend=")"
        end if 
        SQL=SQL & "SELECT " & fields4QUPROJECTS & " FROM QU_projects WHERE len(AT_banner)>0 AND LO_confirmed=True ORDER BY IN_viewed DESC, ID ASC" & toAppend
    end if

    If load=1 Then 
        if SQL<>"" then
            SQL=SQL=" union ("
            toAppend=")"
        end if 
        SQL=SQL & "SELECT " & fields4QUPROJECTS & " FROM QU_projects WHERE len(AT_banner)>0 AND IN_raccolto>0 AND (fondi_raccolti>=IN_cifra) AND LO_realizzato=False AND LO_confirmed=True ORDER BY DT_apertura DESC" & toAppend
    end if
End If

If Len(mode)>0 And Session("islogged" & numproject)<>"hdzufzztKJ89ei" Then Response.End

orderString=" ORDER BY randomId,DT_termine ASC"

If Session("islogged" & numproject)="hdzufzztKJ89ei" Then
    'VB 20/12/2017 Non eseguo alcun ordinamento se l'utente è loggato. !!!ATTENZIONE!!! non impostare ordinamenti con la query in Distinct....
    orderString=""
    modeHome=0
    If mode=0 Then SQL="SELECT DISTINCT " & fields4QUPROJECTS & " FROM QU_donators INNER JOIN QU_projects ON QU_donators.CO_p_projects = QU_projects.ID WHERE QU_projects.LO_confirmed=True AND QU_projects.LO_realizzato=False AND QU_donators.ID=" & Session("logged_donator")
    If mode=1 Then SQL="SELECT DISTINCT " & fields4QUPROJECTS & " FROM QU_donators INNER JOIN QU_projects ON QU_donators.CO_p_projects = QU_projects.ID WHERE QU_projects.LO_confirmed=True AND ((IN_raccolto+IN_mezzi_propri)/IN_cifra*100)>=100 AND QU_donators.ID=" & Session("logged_donator")
	If mode=2 Then 
	    SQL1="SELECT TX_favorites FROM QU_donators WHERE len(TX_favorites)>1 AND QU_donators.ID=" & Session("logged_donator")
	    Set rec1=connection.execute(SQL1)
		If rec1.eof Then 
		    Response.write "<p style=""color:#292f3a"">" & str_no_favorites & "</p>"
		    Response.end
		Else
		    favorites=Split(rec1("TX_favorites"),",")
			For y=1 To ubound(favorites)-1
			    adSql=adSql & " OR QU_projects.ID=" & favorites(y)
			Next
		    adSql=Mid(adSql,5)
		    SQL="SELECT DISTINCT " & fields4QUPROJECTS & " FROM QU_projects WHERE LO_confirmed=True AND (" & adSql & ")"
		End if
	End if
End if

'VB Query complessiva eseguita se non loggato 
'select 0 as ID,'06.11.2017' as DT_termine,AT_snapshot as AT_banner,null as AT_post_img,null as AT_main_img,'#292f3a' as TA_color,TA_video_title as TA_nome,TX_video_subtitle as TA_nome_1,'' as TA_emotional,'' as category,0 as CO_p_category,'' as TE_abstract,0 as fondi_raccolti,0 as IN_cifra,0 as LO_realizzato,0 as LO_aperto,1 as LO_video_embed,TX_video_embed,switch(lo_video_position=0,0,lo_video_position<>0,Rnd(-10000000*TimeValue(Now())*[id])) as randomId from _config_video where LO_disabilitato<>-1 
'union (SELECT top 4 QU_projects.ID,QU_projects.DT_termine,QU_projects.AT_banner,QU_projects.AT_post_img,QU_projects.AT_main_img,QU_projects.TA_color,QU_projects.TA_nome,QU_projects.TA_nome_1,QU_projects.TA_emotional,QU_projects.category,QU_projects.CO_p_category,QU_projects.TE_abstract,QU_projects.fondi_raccolti,QU_projects.IN_cifra,QU_projects.LO_realizzato,QU_projects.LO_aperto,QU_projects.LO_video_embed,QU_projects.TX_video_embed,Rnd(-10000000*TimeValue(Now())*[QU_projects.id]) as randomId FROM QU_projects WHERE len(AT_banner)>0 AND LO_deleted=False AND LO_in_evidenza=True AND LO_confirmed=True and co_p_area=1) 
'union (SELECT top 4 QU_projects.ID,QU_projects.DT_termine,QU_projects.AT_banner,QU_projects.AT_post_img,QU_projects.AT_main_img,QU_projects.TA_color,QU_projects.TA_nome,QU_projects.TA_nome_1,QU_projects.TA_emotional,QU_projects.category,QU_projects.CO_p_category,QU_projects.TE_abstract,QU_projects.fondi_raccolti,QU_projects.IN_cifra,QU_projects.LO_realizzato,QU_projects.LO_aperto,QU_projects.LO_video_embed,QU_projects.TX_video_embed,Rnd(-10000000*TimeValue(Now())*[QU_projects.id]) as randomId FROM QU_projects WHERE len(AT_banner)>0 AND LO_deleted=False AND LO_in_evidenza=True AND LO_confirmed=True and co_p_area=2) 
'union (SELECT top 4 QU_projects.ID,QU_projects.DT_termine,QU_projects.AT_banner,QU_projects.AT_post_img,QU_projects.AT_main_img,QU_projects.TA_color,QU_projects.TA_nome,QU_projects.TA_nome_1,QU_projects.TA_emotional,QU_projects.category,QU_projects.CO_p_category,QU_projects.TE_abstract,QU_projects.fondi_raccolti,QU_projects.IN_cifra,QU_projects.LO_realizzato,QU_projects.LO_aperto,QU_projects.LO_video_embed,QU_projects.TX_video_embed,Rnd(-10000000*TimeValue(Now())*[QU_projects.id]) as randomId FROM QU_projects WHERE len(AT_banner)>0 AND LO_deleted=False AND LO_in_evidenza=True AND LO_confirmed=True and co_p_area=3) 
'union (SELECT top 4 QU_projects.ID,QU_projects.DT_termine,QU_projects.AT_banner,QU_projects.AT_post_img,QU_projects.AT_main_img,QU_projects.TA_color,QU_projects.TA_nome,QU_projects.TA_nome_1,QU_projects.TA_emotional,QU_projects.category,QU_projects.CO_p_category,QU_projects.TE_abstract,QU_projects.fondi_raccolti,QU_projects.IN_cifra,QU_projects.LO_realizzato,QU_projects.LO_aperto,QU_projects.LO_video_embed,QU_projects.TX_video_embed,Rnd(-10000000*TimeValue(Now())*[QU_projects.id]) as randomId FROM QU_projects WHERE len(AT_banner)>0 AND LO_deleted=False AND LO_in_evidenza=True AND LO_confirmed=True and co_p_area=4) 
'ORDER BY randomId,DT_termine ASC
Set rec=connection.execute(SQL & orderString)

maxnum=7
''' IB aumento progetti home BEGIN
'If modeHome=1 Then maxnum=11
If modeHome=1 Then maxnum=15
''' IB aumento progetti home END


If rec.eof Then
	msgWrite="<p style=""color:#292f3a"">" & str_no_projects_category & "</p>"
    If modeHome=0 Then
        If mode=0 Then msgWrite="<p style=""color:#292f3a"">" & str_no_promises & "</p>"
        If mode=1 Then msgWrite="<p style=""color:#292f3a"">" & str_nofound2 & "</p>"
        If mode=2 Then msgWrite="<p style=""color:#292f3a"">" & str_no_favorites & "</p>"
    End if
    Response.write msgWrite
else
	For x=0 To maxnum
        If rec.eof Then exit for
           
        pRef=rec("ID")
	    termine=rec("DT_termine")
	    imgb=rec("AT_banner")
	    imgb1=rec("AT_post_img")
	    imgb0=rec("AT_main_img")
	    color=rec("TA_color")
	    pTitle=rec("TA_nome")
        'IB 170322 aggiunta subtitle
        pSubtitle = rec("TA_nome_1")
	    pEmotion=rec("TA_emotional")
	    pCat=rec("category")
	    refCat=rec("CO_p_category")
	    pText=rec("TE_abstract")
	    pTot=rec("fondi_raccolti")
	    pObj=rec("IN_cifra")
	    realizzato=rec("LO_realizzato")
	    aperto=rec("LO_aperto")
        isVideoEmbed = rec("LO_video_embed")
        pVideo = rec("TX_video_embed")
    wobj=str_obiettivo
        'Controlli sui fields estratti
        ishomevideo = ""
        if isNullOrEmpty(pcat) then ishomevideo = " overvideo"
   
        If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")
        If Len(pSubtitle)>0 Then psubTitle=Replace(psubTitle,"#","'")
            
        pText = ConvertFromUTF8(pText)
        If modeHome=0 Then imgb=imgb0

        addVideo = ""
        if isVideoEmbed then
            If Len(pVideo)>0 Then
			    If InStr(pVideo,"<iframe ") Then
				    pVideo=Replace(pVideo,Chr(34) & Chr(34),Chr(34))
				    pVideoGet=getVideoSrc(pVideo)
			    Else 
				    pVideoGet=pVideo
			    End If
				
			    If Len(pVideoGet)>0 Then 
                     if ishomevideo<>"" then
                        addVideo = "<span style='position:absolute;top:450px;left:55px;width:260px;height:60px;'>" & StringFormat("<img id='imgVideoHome' class='vImg' style='position:relative;width: 100%;height:100%;' src='../images/bottone_video_empty.png' rel='{0}' onclick='videoOpen(this)' </img>", Array(pVideoGet)) & "<p style='font-family:Helvetica;font-size:18px;margin-left:130px;position:absolute;top:-14px;cursor:pointer;' onclick='videoOpen(this.previousElementSibling)'>" & str_guarda_il_video & "</p></span>"
                     else
                        addVideo = StringFormat("<img class='vImg' src='../images/bottone_video.png' rel='{0}' onclick='videoOpen(this)'/>", Array(pVideoGet))
                     end if
                end if
            end if
        end if
        
	    p100=false
	    If pTot>=pObj and pTot<>0 Then p100=True

	    If realizzato Then If Len(imgb1)>0 Then imgb=imgb1	   
		
	    diffdays=dateDiff("d",Now(),termine)*-1

	    SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_projects=" & pRef & ")"
	    Set rec1=connection.execute(SQL)
	    num_subscribers=rec1("subscribers")

	    If modeHome=0 Then 
		    TotDonato=0
		    SQL="SELECT SUM(IN_promessa) As TotDonato FROM associa_registeredusers_projects WHERE CO_registeredusers=" & Session("logged_donator") & " AND CO_p_projects=" & pRef
		    Set rec1=connection.execute(SQL)
		    If Not rec1.eof Then TotDonato=rec1("TotDonato")
	    End if

        divCifre=""

	    sperc=0
        if pObj<>0 then 
            sperc=CInt(pTot/pObj*100)
            pObjw=setCifra(pObj)
            pObtw=setCifra(pTot)
            divCifre="<div class=""cifre""><div><span class=""cifre"">" & str_funds & ":</span><span class=""cifre dCifre"">" & pObtw & "</span></div><div><span class=""cifre"">" & wobj & _
                        ":</span><span class=""cifre dCifre"">" & pObjw & "</span></div>"
        end if
           
	    If Len(imgb)>0 Then 
		    If modeHome=0 Then imgb="/" & imgscript & "?path=" & imgb & "$600"
		    If modeHome=1 Then imgb="/" & imgscript & "?path=" & imgb & "$1280"
	    Else
		    imgb="/images/vuoto.gif"
	    End If

        pText=ClearHTMLTags(pText,0)
        If Len(pText)>0 Then pText=Trim(pText)
        lenabs=320-Len(pTitle)
        If Len(pText)>lenabs Then pText=truncateTxt(pText,lenabs)

        pLink=linkMaker(pTitle)
        'wobj=str_obiettivo
        If modeHome=0 Then 
            pText=""
            pObt=sperc & "%"
            pObj=num_subscribers&"&nbsp;&nbsp;&nbsp;"
            wobj=str_obiettivo
        End if

        divDonate=""
        ico_donation="ico_donate.png"
        bgi_donation=" style=""background-image: url(/images/" & Replace(color,"#","") & ".png);background-size:62% 70%"""
        adi_donation=""

        If modeHome=1 Then 
	        If realizzato then
		        pCat=str_realizzato
		        ico_donation="ico_realizzato_home.png"
		        bgi_donation=""
	        ElseIf p100 Then 
                If refCat<>0 then
                    adi_donation="<img class=""img100"" src=""/images/ico_100_" & refCat & ".png"" alt=""""/>"
                end if
		        If aperto=False Then ico_donation="ico_winprogress.png"
	        End If
        End if

        nomec=pCat
        If Len(nomec)>0 Then 
            nomec=Replace(nomec,"Sosteniamo",str_sosteniamo)
            nomec=Replace(nomec,"Doniamo",str_doniamo)
            nomec=Replace(nomec,"Finanziamo",str_finanziamo)
        end if
        pCat=nomec

        plink1="/?progetti/" & pRef & "/" & pLink
        plink2="/?progetti/" & pRef & "/" & pLink & "/donate/"

        If realizzato Then plink2="/?progetti/"&pRef&"/"&pLink&"/news/"

        colortext = "white"

        if Len(pCat)>0 then  divDonate="<div class=""donate"" style=""color:" & colortext & """ onclick=""document.location='" & pLink2 & "'""><img src=""/images/" & ico_donation & """" & bgi_donation & _
            "/><br/>" & pCat & "<br/></div>"
            
        'debugmsg=modeHome
        if debugmsg<>"" then
                Response.write "<div rel=""p"" class=""main"" style=""background-image:url(" & imgb & ")"" alt=""" & imgb & """><div class=""over"&ishomevideo&""" style=""background:" & color & _
            """></div><div class=""textcont""><div class=""overtext"" onclick=""document.location='" & plink1 &  "'""><p>" & ConvertFromUTF8(debugmsg) & "</p></div>"
        else
            divTitle="<div class=""titcont""><p><b>" & ConvertFromUTF8(pTitle) & "</b><br/><b>" & ConvertFromUTF8(pSubtitle) & "</b></p></div>"
            'VB 21/11/2017 se sta passando il videohome cambio il layout della sezione titolo
            if Len(ishomevideo)>0 then
                videoDivTitle="<div id=""videoTitle"" style=""color:white;position:absolute;left:120px;top:250px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;max-width:750px;word-wrap:break-word""><p style=""font-family:Helvetica;font-size:24px;""><b>" & ConvertFromUTF8(pTitle) & "</b></p><p style=""font-family:Helvetica;font-size:18px;"">" & ConvertFromUTF8(pSubtitle) & "</p></div>"
                divTitle=""
            else
                videoDivTitle=""
            end if

            Response.write "<div rel=""p"" class=""main"" style=""background-image:url(" & imgb & ")"" alt=""" & imgb & """><div class=""over" & ishomevideo & """ style=""background:" & color & _
            """></div><div class=""textcont"">" & adi_donation & videoDivTitle & "<span class=""video"">" & addVideo & "</span><div class=""overtext"" onclick=""document.location='" & plink1 & _
            "'"">" & divDonate & divTitle & "<p class=""overAbstract"">" & pText & "</p>" & divCifre

            'Add promessa in header user logged
	        If modeHome=0 And TotDonato>0 Then Response.write "<div><span class=""cifre"">" & str_promessa & ":</span><span class=""cifre dCifre"">" & setCifra(TotDonato) & "</span></div>"
	        'Add termine in header home
	        If load=0 AND modeHome=1 And diffdays<0 Then Response.write "<div><span class=""cifre"">" & diffdays*-1 & " " & str_cf_daysto & "</span></div>"
        end if
	        
	    response.Write "</div></div></div></div>"
	    rec.movenext
    Next
End If%>
<%connection.close%>