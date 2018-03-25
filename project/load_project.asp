<%
'Response.CodePage  = 65001
refProject=load
SQL="SELECT * FROM QU_projects WHERE ID="&refProject
Set rec=connection.execute(SQL)

If Not rec.eof Then
    pCat=rec("refCat")
    pCatName=rec("category")
    pTitle=ConvertFromUTF8(rec("TA_nome"))
    If Len(ptitle)>0 Then pTitle=Replace(pTitle,"#","'")
'IB 170322 aggiunta subtitle
pSubtitle = ConvertFromUTF8(rec("TA_nome_1"))
If Len(pSubtitle)>0 Then psubTitle=Replace(psubTitle,"#","'")
'IB 170322 aggiunta subtitle
pColor=rec("TA_color")
pImg=rec("AT_main_img")
aperto=rec("LO_aperto")
imgb1=rec("AT_banner")
confirmed=rec("LO_confirmed")
toconfirmed=rec("LO_toconfirmed")
puser=rec("CO_registeredusers")
dedu=rec("LO_deducibile")
pShareCount = rec("IN_mailShareCount")
     if not isnumeric(psharecount) then 
        SQL = "select count (ID) as coun from MailShares where p_project =  "&refproject
        set rec2 = connection.execute(SQL)
        if not rec2.eof then 
            count = rec2("coun")
            SQL="UPDATE p_projects set IN_mailShareCount = " &count &" where id = "&refproject
            Set rec2=connection.execute(SQL)
            psharecount = count
        else
            psharecount = 0
        end if
    end if
bonus = rec("LO_bonus")
bonus_text = rec("TX_testo_bonus")
bonus_text = HTMLDecode (bonus_text)
bonus_text = ConvertFromUTF8(bonus_text)
bonus_img = rec("AT_sponsor")
pImg=rec("AT_main_img")
If Len(pImg)=0 OR isnull(pImg) Then pImg=imgb1
imgb2=rec("AT_post_img")
If Len(imgb2)>0 Then pImg=imgb2

If isnull(pColor) Then pColor="#9ba1b3"
If isnull(pCat) Then pCat=0

If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")

plink=linkMaker(pTitle)
fblink = rec("TX_fblink")
    fblink = ConvertFromUTF8(fblink) 

	If confirmed=False AND puser<>Session("logged_donator")  Then
	If Not Session("log45"&numproject)="req895620schilzej" Then Response.End
	End If



	If Len(puser)>0 Then
	SQL="SELECT * from registeredusers WHERE LO_projects=True AND LO_enabled=True AND ID="&puser
	Set rec1=connection.execute(SQL)
		if Not rec1.eof then

		wPromo=rec1("TA_ente")
		If Len(wPromo)=0 Then wPromo=rec1("TA_nome")&"&nbsp;"&rec1("TA_cognome")
        '''fix nome promotore
            wPromo = ConvertFromUTF8(wPromo)
        '''fix nome promotore
		addinfo="<p style=""margin-bottom:0px"" class=""notrans""><b>"&str_promotore&"</b><br/>"&wPromo&"<br/><br/>"
		fb=rec1("TA_facebook")
		If Len(fb)>0 Then addinfo=addinfo&"<a href="""&fb&""" target=""_blank""><img src=""/images/img_fb.png""></a>&nbsp;&nbsp;"

		tw=rec1("TA_twitter")
		If Len(tw)>0 Then addinfo=addinfo&"<a href="""&tw&""" target=""_blank""><img src=""/images/img_tw.png""></a>&nbsp;&nbsp;"

		lk=rec1("TA_linkedin")
		If Len(lk)>0 Then addinfo=addinfo&"<a href="""&lk&""" target=""_blank""><img src=""/images/img_lk.png""></a>&nbsp;&nbsp;"

		addinfo=addinfo&"</p>"

		End If
	End if

	If confirmed=False AND toconfirmed=False And puser=Session("logged_donator") AND Session("log45"&numproject)<>"req895620schilzej" And Len(Session("logged_donator"))>0 Then
		If InStr(complex,"/preview-project")=0 then
			Response.redirect("/?edit-project/"&refProject&"/"&plink)
		End if
	End If


		luogo=ConvertFromUTF8(rec("TA_luogo"))
		nazione=rec("TA_nazione")
		pText=rec("TE_abstract")
		pVideo=rec("TX_video_embed")
		pRef=rec("ID")
		termine=rec("DT_termine")
		rated=rec("IN_rated")
		visite=rec("IN_viewed")
		voti=rec("IN_votes")
		minimo=rec("IN_cifra_minima")
		minvalue=minimo
		free_donate=rec("LO_free_donate")
		closed=rec("LO_realizzato")
		relatedProjects=rec("CR_p_projects")
        TRwidget=rec("TX_widget")
        If InStr(TRwidget,"/timerepublik.com")=0 Then TRwidget=""
		pObj=rec("IN_cifra")
		pObt=rec("IN_raccolto")
		pPropri=rec("IN_mezzi_propri")
		
		totLevel_chf = rec("fondi_raccolti")
		totLevel_chf_write = Replace(totLevel_chf,",",".")

		cifraObiettivo=pObj
		cifraObiettivo=setCifra(cifraObiettivo)

		pMancante=(pObj-totLevel_chf)*-1
		cifra_manca=pMancante

		sperc=0
		sperc1=0
		If pObj>0 Then sperc=Round(pObt/pObj*100,1)
		If pObj>0 Then sperc1=Round(pPropri/pObj*100,1)
		
		tot_percent=sperc+sperc1

		svotes=0
		
		mCol="#00b450" 
		If pObj>0 Then wManca=str_obiettivo_raggiunto&"<br/>"&str_sostienici_ancora&"!"
		
			If pMancante<0 Then 
				mCol="#e20613"
				wManca=str_mancano_ancora
				pMancante=setCifra(pMancante*-1)
			Else
				If pMancante>0 Then pMancante="+"&setCifra(pMancante)
			End if
			
		If (voti>0) Then svotes=round(rated/voti,1)

		diffdays=dateDiff("d",Now(),termine)
		diffmonths=dateDiff("m",Now(),termine)
		wdiff=str_giorni
		wdays=diffdays

		If diffdays>60 Then 
		wdiff=str_mesi
		wdays=Round(diffdays/30)
		End if

		If diffdays<0 Then 
			wdays=0
			If pObj>0 Then wManca=str_obiettivo_raggiunto&"!"
		End if

		If aperto And diffdays<0 Then
			SQL="UPDATE p_projects SET LO_aperto=False WHERE ID="&refProject
			Set rec1=connection.execute(SQL)
			aperto=false
		End if

	addimg="/images/thumb_picture.png"
	If Len(pImg)>0 Then addimg=imgscript&"?path="&pImg&"$400"

		If Len(Session("updproject"&refProject))=0 And confirmed And Len(Session("log45"&numproject))=0 Then
			visite=visite+1

			SQL="UPDATE p_projects SET IN_viewed="&visite&" WHERE ID="&refProject
			If Len(Session("logged_donator"))>0 And  puser=Session("logged_donator") Then SQL="SELECT IN_viewed FROM p_projects WHERE ID="&refProject

			Set rec1=connection.execute(SQL)
			
			Session("updproject"&refProject)=visite
		
		End If

			notifica_send=0
			If aperto And tot_percent>0 And confirmed Then 
			
				If tot_percent>49.9 And tot_percent<75 Then checklevelSend=50
				If tot_percent>74.9 And tot_percent<90 Then checklevelSend=75
				If tot_percent>89.9 And tot_percent<100 Then checklevelSend=90
				If cifra_manca>=0 Then checklevelSend=100
				If diffdays<=0 Then checklevelSend="termine"

				SQL="SELECT * FROM notifiche WHERE CO_p_projects="&refProject&" AND TA_notifica_type='"&checklevelSend&"'"
				Set rec1=connection.execute(SQL)
			
				If rec1.eof Then notifica_send = checklevelSend
			End if


		SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_projects="&refProject&")"

		Set rec1=connection.execute(SQL)
	 
    num_subscribers=rec1("subscribers")

		SQL="SELECT COUNT(ID) as newscount FROM p_description WHERE TA_type='update' AND LO_confirmed=True AND CO_p_projects="&refProject
		If Len(Session("logged_donator"))=0 Then SQL="SELECT  COUNT(ID) as newscount FROM p_description WHERE TA_type='update' AND DateDiff('d',DT_data,Now())<=7 AND LO_confirmed=True AND CO_p_projects="&refProject
		Set rec1=connection.execute(SQL)
		newscount=rec1("newscount")

		If newscount>0 Then
			newscount="<div class=""newscount"" style=""color:#fff"">"&newscount&"</div>"
			If Len(Session("logged_donator"))=0 Then newscount="<div class=""newscount"" style=""color:#fff""><b>!</b></div>"
		Else
			newscount=""
		End if


		If Len(pCatName)>0 Then pCatName=Replace(pCatName,"Sosteniamo",str_sosteniamo)
		If Len(pCatName)>0 Then pCatName=Replace(pCatName,"Doniamo",str_doniamo)
		If Len(pCatName)>0 Then pCatName=Replace(pCatName,"Finanziamo",str_finanziamo)

addDedu_ico=""
addBonus_ico  =""
If dedu Then addDedu_ico="<img src=""/images/ico_ded_"&pcat&".png"" class=""dedup"" title="""&str_deducibile&"""/>"
    if bonus then addBonus_ico = "<img src=""/images/ico_bonus.png"" class='bonus tooltip' title='<div >"&bonus_text&"</div><img src=""/"&imgscript&"?path="&bonus_img&"$166""/>'/>"
%>
<div id="maincolor"><%=pColor%></div>
<div id="maincat"><%=pCat%></div>
<input id="edRef" type="hidden" value="<%=refproject%>" />


<div class="pContainer">
    
    <div id="mailForm" style="background-color:#ffffff; display:none; text-align:left" title="Progettiamo.ch">
        <div class="logo" >
            <img src="/images/progettiamo_logo_trans.png" />
        </div>
        <p class="validateTips"></p>
        <form id="ajaxForm" action="/actions/mailer.php">
            <input type="hidden" name="proj" value="<%=refProject %>" />
            <fieldset>
        <div style="float:left; clear:left; width:100%;text-align:left;padding-top: 15px;">
            <span class="header">A:<span class="text">&nbsp;(email)</span></span><span style="display: block;
    overflow: hidden;
    padding: 0 5px"><input type="email" class="value" name ="email" id="email" style=" width:100%" required/></span>
        </div>
        <div style="float:left; clear:left; width:100%;text-align:left">
            <label class="header" style="">da:<span class="text">&nbsp;(nome)</span></label><span style="display: block;
    overflow: hidden;
    padding: 0 5px"><input type="text" class="value" name ="name" id="name" style=" width:100%" required/></span>
        </div>
        <div style="float:left; clear:left; width:100%;padding-top: 15px;">
            <span class="header">messaggio:</span>
        </div>
        <div style="float:left; clear:left; width:100%; padding-bottom:0px; margin-bottom:5px; border: 1px solid black;">
<textarea name="txtmessaggio" style="float:left; clear:left; padding: 0px; margin: 0px; border: 0px;width:100%;"></textarea>

        </div>
        <div class="boxProject" style="float: left; text-align: left;border: 1px solid #efefef; padding: 0px; margin:0px">
            <img style="width: 160px; height: 160px; float: left;" runat="server" id="imgSharePrj"/>
            <div class="title">
                <span ID="imgShareTitle"  ></span></div>
            <div class="abstract" id="imgShareDescription"></div>
            <div class="site"><a id="imgShareUrlLink" style="color: #000000;text-transform: uppercase;" href=""></a></div>
        </div>
        <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
                </fieldset>
</form>
    </div>
    
    <div class="pText">
        <div class="pButton a<%=pCat%>">
            <img src="/images/p_1.png" longdesc="/images/p_1.png" rel="/images/p_1<%=pCat%>.png" /><br />
            <%=str_il_progetto%></div>
        <div class="pButton a<%=pCat%>">
            <img src="/images/p_2.png" longdesc="/images/p_2.png" rel="/images/p_2<%=pCat%>.png" /><br />
            <%=str_chi_siamo%></div>
        <div class="pButton a<%=pCat%>">
            <img src="/images/p_3.png" longdesc="/images/p_3.png" rel="/images/p_3<%=pCat%>.png" /><br />
            <%=str_media%></div>
        <div class="pButton a<%=pCat%>">
            <img src="/images/p_4.png" longdesc="/images/p_4.png" rel="/images/p_4<%=pCat%>.png" /><br />
            <%=str_downloads%></div>
        <%If Not closed And aperto then%>
        <div class="pButton fin">
            <img src="/images/p_5.png" longdesc="/images/p_5.png" rel="/images/p_51.png" /><br />
            <%=str_finanzia%></div>
        <%else%>
        <div class="pButton a<%=pCat%>">
            <img src="/images/p_7.png" longdesc="/images/p_7.png" rel="/images/p_7<%=pCat%>.png" /><br />
            <%=str_benefit%></div>
        <%End if%>
        <div class="pButton a<%=pCat%>"><%=newscount%><img src="/images/p_6.png" longdesc="/images/p_6.png" rel="/images/p_6<%=pCat%>.png" /><br />
            <%=str_news%></div>

        <div style="clear: both"></div>

        <div class="pLeft">
            <img src="/images/vuoto.gif" alt="<%=pTitle%>" style="background-image: url(<%=addimg%>)" />
            <%If InStr(Session("p_favorites"),","&refproject&",")>0 then%>
            <div style="background: <%=pColor%> url(/images/favorite_p.png) center center no-repeat; width: 45px; height: 42px; right: 1px; top: 117px; position: absolute; overflow: hidden"></div>
            <%End if%>
            <%=addDedu_ico%>
            <%=addBonus_ico%>
        </div>
        <% response.write  "<div class='tooltip_templates'><span id='tt"&refProject&"'><b>"&bonus_text&"</b><img src=""/"&imgscript&"?path="&bonus_img&"$600""/></span></div>"%>
        <div class="pCenter">
            <div class="pInfo">
                <img src="/images/vuoto.gif" alt="<%=pTitle%>" style="background-image: url(<%=addimg%>)" />
                <h1 style="color: <%=pColor%>"><%=pTitle%></h1>
                <h1 class="subtitle" style="color: <%=pColor%>"><%=pSubtitle%></h1>
                <h2 style="color: <%=pColor%>"><%=luogo%>, <%=nazione%></h2>
                <h3 style="color: <%=pColor%>"><%=str_categoria%>: <%=pCatName%></h3>
            </div>

            <div class="pDesc">
                <%
				
			'PROJECT MAIN DESCRIPTION
				If Len(pVideo)>0 Then
					If InStr(pVideo,"<iframe ")Then
					pVideo=Replace(pVideo,Chr(34)&Chr(34),Chr(34))
					pVideoGet=getVideoSrc(pVideo)
					Else 
					pVideoGet=pVideo
					End If
				
					If Len(pVideoGet)>0 Then Response.write "<p style=""text-align:left;"" class=""tit notrans"">"&str_video_presentazione&"</p><p class=""embedVideo notrans""><iframe src="""&pVideoGet&""" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></p>"

				End if
                    
				addanchor=""
				SQL="SELECT * FROM p_description WHERE TA_type='description' AND CO_p_projects="&refProject&" ORDER BY IN_ordine ASC, ID ASC"
				Set rec1=connection.execute(SQL)
				If rec1.eof Then Response.write "<p class=""notrans"">"&str_no_description&"</p><p>&nbsp;</p>"
				
                Do While Not rec1.eof
				    dName=rec1("TA_nome")
				    dContent=rec1("TX_testo")
				    refD=rec1("ID")
				    Response.write "<a name=""d_"&refD&"""></a><p class=""tit"">"&ConvertFromUTF8(dName)&"</p>"&Chr(10)&" "&dContent&" <p>&nbsp;</p>"
				    addanchor=addanchor&"<a id=""d_"&refD&""" href=""javascript:toAnchor('d_"&refD&"')"">"&ConvertFromUTF8(dName)&"</a>"
				    rec1.movenext
			loop

                   %>
                <div class="anchor"><%=addanchor%></div>
            </div>

            <div class="pDesc">
                <%
				'PROJECT ABOUT
                %>

                <%=addinfo%>
                <%
                     
			addanchor=""
			SQL="SELECT * FROM p_description WHERE TA_type='about' AND CO_p_projects="&refProject&" ORDER BY IN_ordine ASC, ID ASC"
			Set rec1=connection.execute(SQL)
			If rec1.eof Then Response.write "<p class=""notrans"">"&str_no_element&"</p><p>&nbsp;</p>"
			Do While Not rec1.eof
			    dName=rec1("TA_nome")
			    dContent=rec1("TX_testo")
			    dImage=rec1("AT_file")
			    refD=rec1("ID")

                dname  =ConvertFromUTF8(dname)
                dcontent = ConvertFromUTF8(dcontent)

			    advimg=""
			    If Len(dImage)>0 Then 	advimg="<img class=""aImg"" src=""/images/vuoto.gif"" style=""position:relative;  float:left; width:180px; height:177px; background-color:#f3f3f3; margin:0px 22px 8px 0px; background-image:url(/"&imgscript&"?path="&dImage&"$300); background-size:auto 100%; -webkit-background-size:auto 100%; background-repeat:no-repeat;background-position:center center;""/>"

			    Response.write "<a name=""d_"&refD&"""></a><p style=""clear:left;"" class=""tit"">"&dName&"</p>"&Chr(10)&advimg&" "&dContent&" <p style=""clear:left;"">&nbsp;</p>"

			    addanchor=addanchor&"<a id=""d_"&refD&""" href=""javascript:toAnchor('d_"&refD&"')"">"&dName&"</a>"
			    rec1.movenext
			loop%>
                <div class="anchor"><%=addanchor%></div>
            </div>

            <div class="pDesc" style="margin-left: -20px; padding-top: 25px; width: 100%">
                <%
			'PROJECT MEDIA
                   
			addanchor=""
			SQL="SELECT * FROM p_description WHERE (TA_type='video' OR TA_type='gallery') AND CO_p_projects="&refProject&" ORDER BY TA_type, IN_ordine"
			Set rec1=connection.execute(SQL)
				
				If rec1.eof Then Response.write "<p style=""padding-left:20px; margin-top:-6px;"">"&str_no_element&"</p><p>&nbsp;</p>"
				
				If Not rec1.eof Then addanchor="<span style=""float:left; clear:both; margin-bottom:30px"">"&str_seleziona_solo&":</span>"
				
				Do While Not rec1.eof
				dName=rec1("TA_nome")
				dContent=rec1("TX_testo")
				dEmbed=rec1("TX_embed")
				refD=rec1("ID")
				gtType=rec1("TA_type")
				advimg=""
				adcl=""
				adnum=""
				skipElement=False


					If gtType="video" Then 
					adcl="video"
					
						If Len(adancVid)=0 And Not skipElement Then 
						addanchor=addanchor&"<a href=""javascript:void(0)"" onclick=""javascript:filterMM('video',$(this))"">Video</a>"
						adancVid="true"
						End if


						vSrc=getVideoSrc(dEmbed)
						advimg="<img class=""vImg"" src=""/images/vuoto.gif"" rel="""&vsrc&"""/>"
						If Len(dEmbed)=0 Or isnull(dEmbed) Then advimg="<img src=""/images/thumb_video.png"" rel=""/images/thumb_video.png""/>"
					End if

					If gtType="gallery" Then 
					adcl="foto"
						If Len(adancFot)=0 Then 
						addanchor=addanchor&"<a href=""javascript:void(0)"" onclick=""javascript:filterMM('foto',$(this))"">Foto</a>"
						adancFot="true"
						End if

						SQL="SELECT * FROM p_pictures WHERE len(AT_file)>3 AND CO_p_description="&refD&" AND CO_p_projects="&refProject&" ORDER BY IN_ordine"
						Set rec2=connection.execute(SQL)
							If rec2.eof Then skipElement=True
							advimg=""
							nimg_g=0
							Do While Not rec2.eof
							nimg_g=nimg_g+1
							gimg="/"&imgscript&"?path="&rec2("AT_file")&"$500"
							advimg=advimg&"<a class=""gImg"" rel=""gallery_"&refD&""" href="""&gimg&""" longdesc="""&rec2("TA_nome")&"""><img src=""/images/vuoto.gif"" style=""background-image:url("& gimg &")""/></a>"
							rec2.movenext
							Loop
							If nimg_g>1 Then adnum="&nbsp;("&nimg_g&" foto)"
					End if

				If Not skipElement Then Response.write "<div class=""mm "&adcl&"""><a name=""d_"&refD&"""></a>"&advimg&"<span style=""float:right"">"&adnum&"</span><p class=""tit"">"&ConvertFromUTF8(dName)&"</p>"&Chr(10)&""&ConvertFromUTF8(dContent)&"</div>"
				rec1.movenext
				Loop
		
			If Len(adancVid)=0 OR Len(adancFot)=0 Then addanchor=""
                %>
                <div class="anchor"><%=addanchor%></div>
            </div>

            <div class="pDesc">
                <%
			'PROJECT DOWNLOAD

			SQL="SELECT * FROM p_description WHERE TA_type='download' AND len(AT_file)>3 AND IN_dim_file>0 AND CO_p_projects="&refProject&" ORDER BY IN_ordine ASC, ID ASC"
			Set rec1=connection.execute(SQL)
			
			If rec1.eof Then Response.write "<p class=""notrans"">"&str_no_element&"</p><p>&nbsp;</p>"
			Do While Not rec1.eof

			dName=rec1("TA_nome")
			dContent=rec1("TX_testo")
			atFile=rec1("AT_file")
			refD=rec1("ID")
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


			fLink=linkMaker(pTitle&" "&dName)

			ext=""
			If InStr(atFile,".") Then ext=UCase(Mid(atFile,InStrRev(atFile,".")+1))
			Response.write "<a name=""d_"&refD&"""></a><p class=""tit"">"&ConvertFromUTF8(dName)&"</p>"&Chr(10)&" "&dContent&" <p><a href=""/download/?"&fLink&"/"&atFile&"""><img src=""/images/ico_download.png"" alt=""Download"" style=""float:left; margin:-5px 10px 0px 0px;""/>("&ext&" " &grandezzaw&")</a></p><p>&nbsp;</p>"
			rec1.movenext
			loop%>
                <div class="anchor"></div>
            </div>

            <div class="pDesc">
                <%
			'PROJECT DONATE

			If closed then%>
                <p class="notrans"><%=str_realizzato_grazie%></p>
                <%if len(imgb2)>0 then%>
                <p class="notrans" style="display: none">
                    <img src="/images/vuoto.gif" style="background-image: url(<%=imgscript%>?path=<%=imgb2%>$600); background-repeat: no-repeat; width: 600px; height: 400px; background-size: 100% auto" alt="<%=str_cf_realized%>" /></p>
                <%End if%>
                <%else%>


                <%If diffdays<=-1 Then%>
                <p class="notrans"><%=str_scaduto_scheda%></p>
                <%ElseIf closed Then%>
                <p class="notrans"><b><%=str_cf_realized%></b>.<br />
                </p>
                <%Else%>
                <%If dedu then%><p><%=str_deducibile%></p>
                <%End if%>
                <!--#INCLUDE VIRTUAL="./project/load_form_donation.asp"-->
                <%End if%>
                <%End if%>
                <!--#INCLUDE VIRTUAL="./project/load_benefits.asp"-->
                <div class="anchor"></div>
            </div>

            <div class="pDesc">
                <%
			'PROJECT NEWS
                %>
                <%If confirmed=true AND puser=Session("logged_donator") Then%>
                <p style="margin: -14px 0px 40px 0px" class="notrans">
                    <input type="button" class="bt" value="aggiungi news" style="width: 150px" onclick="viewFormAdd(0)" /></p>
                <div class="myprojectsFrame" style="height: 420px; margin-bottom: 40px; width: 647px; display: none">
                    <iframe scrolling="0" style="min-width: 100% !important; min-height: 100% !important;" src="/actions/project_update.asp?load=<%=refproject%>" allowtransparency></iframe>
                </div>
                <%End if%>

                <%
			'NEWS SECTION
			addanchor=""
			SQL="SELECT * FROM p_description WHERE TA_type='update' AND LO_confirmed=True AND CO_p_projects="&refProject&" ORDER BY DT_data DESC"
			If puser=Session("logged_donator") Then	SQL="SELECT * FROM p_description WHERE TA_type='update' AND CO_p_projects="&refProject&" ORDER BY DT_data DESC"

			Set rec1=connection.execute(SQL)
			If rec1.eof Then Response.write "<p>"&str_no_news&"</p><p>&nbsp;</p>"

			Do While Not rec1.eof
			    dName=rec1("TA_nome")
			    dContent=rec1("TX_testo")
                    dcontent = HTMLDecodeSimple(dContent)
			    'dContent = HTMLDecode(dContent)
                'dContent = convertfromutf8(dContent)
			dTime=datevalue(rec1("DT_data"))
			newsconfirmed=rec1("LO_confirmed")
			dImg=rec1("AT_file")
			dEmbed=rec1("TX_embed")
			refD=rec1("ID")
			If Not newsconfirmed Then dContent="<p style=""color:#e43d46"" class=""notrans"">"&str_news_pending&"</p>"&dContent
			
			If Len(dimg)>0 Then dimg="<a class=""imgG"" data-href=""/"&imgscript&"?path="&dImg&"$700""><img class=""newsImg""  src=""/images/vuoto.gif"" style=""background-image:url(/"&imgscript&"?path="&dImg&"$500)""/></a>"
			
			advimg=""
			If Len(dEmbed)>3 Then
			vSrc=getVideoSrc(dEmbed)
			advimg="<img class=""vImg newsImg"" src=""/images/vuoto.gif"" rel="""&vsrc&""" style=""margin:0px !important;""/>"
			End If
			
			If Len(dContent)>0 Then dContent=Replace(dContent,Chr(34)&Chr(34),Chr(34))
			SQL="SELECT count(ID) as numcomments FROM p_comments WHERE LO_deleted=false AND CO_p_description="&refD
			Set rec2=connection.execute(SQL)
			numcomments=rec2("numcomments")

			Response.write "<div class=""blog""><a name=""d_"&refD&"""></a><p style=""margin-bottom:9px"" class=""tit"">"&ConvertFromUTF8(dName)&"</p><p style=""margin:0px;""><span><img src=""/images/ico_cal_blog.png"" style=""float:left; margin:0px 10px 0px 0px"" alt=""""/>"&dTime&"</span>"

			If numcomments>0 Then Response.write "<span><a href=""javascript:viewComments("&refD&","&refProject&")"">"&numcomments&"<img src=""/images/ico_comment_blog.png"" alt=""""/></a></span><span><a href=""javascript:viewComments("&refD&","&refProject&")"">"&str_visualizza_commenti&"</a></span>"
			If numcomments=0 Then Response.write "<span><a href=""javascript:viewComments("&refD&","&refProject&")"">"&str_add_commento&"</a></span>"

			Response.write "</p>"&Chr(10)
			If Len(dimg)>0 Or Len(advimg)>0 Then Response.write "<p style=""clear:both; width:100%; padding-top:10px; margin-bottom: 10px !important; height:180px;"">"& dimg & advimg &"</p>"
			Response.write "<p class=""newscontent"" style=""clear:left;margin-top:0px"">"& dContent&"</p>"

			If puser=Session("logged_donator") Then%>
                <div style="position: relative; z-index: 5; text-align: right; width: 100%; border-bottom: solid 1px #292f3a">
                    <img src="/images/ico_edit.png" style="cursor: pointer; width: 45px" onclick="editNews(<%=refD%>);" onmouseover="$(this).attr('src','/images/ico_edit_o.png')" onmouseout="$(this).attr('src','/images/ico_edit.png')" />
                    <img src="/images/ico_delete.png" style="cursor: pointer; width: 45px" onclick="javascript:delNews(<%=refD%>)" onmouseover="$(this).attr('src','/images/ico_delete_o.png')" onmouseout="$(this).attr('src','/images/ico_delete.png')" />
                </div>
                <%
			End if
			Response.write "</div>"
			rec1.movenext
			loop%>
                <div class="anchor"></div>
            </div>

        </div>

        <div class="pRight">
            <%
	graphicH=130
	If sperc1>0 Then graphicH=160
	tot_percent_write=tot_percent
	If Len(tot_percent_write)>0 Then tot_percent_write=Replace(tot_percent_write,",",".")
            %>
            <div style="height: <%=graphicH%>px;">
                status<br />
                <canvas id="canvas" width="106" height="106" style="background: url(/images/bg_doug.png) center 8px no-repeat"></canvas>
                <div class="viewPerc"><%=tot_percent_write%><sup style="font-size: 12px;">%</sup></div>
                <%If sperc1>0 then%>
                <div class="viewPerc1">
                    <span style="float: left; width: 10px; height: 10px; border-radius: 10px; background: #9ba1b3; margin: 2px 3px"></span><%=str_altri_finanziamenti%><br />
                    <span style="clear: left; float: left; width: 10px; height: 10px; border-radius: 10px; background: #292f3a; margin: 2px 3px"></span>progettiamo.ch
                </div>
                <%End if%>
            </div>
            <div style="border: 0px; color: #9ba1b3;"><%=str_cifra_obiettivo%><br />
                <span style="float: left; width: 100%; color: #9ba1b3; font-size: 22px; margin-top: 10px; white-space: nowrap"><%=cifraObiettivo%><sup style="font-size: 14px;">Fr.</sup></span></div>
            <div style="border: 0px; margin-top: -15px; margin-bottom: -5px;"><%=str_funds%><br />
                <span style="float: left; width: 100%; font-size: 28px; margin-top: 10px; white-space: nowrap"><%=setCifra(totLevel_chf_write)%><sup style="font-size: 14px;">Fr.</sup></span></div>
            <div class="sostieni" style="color: <%=mCol%>"><%=wManca%><br />
                <span style="float: left; width: 100%; font-size: 22px; margin-top: 10px;"><%=pMancante%><sup style="font-size: 12px;">Fr.</sup></span></div>
            <%If closed=False then%><div><%=wdiff%>&nbsp;<%=str_restanti_raccolta%>
                <div style="position: relative; margin-top: 5px; height: 47px; text-align: center; padding-top: 36px; width: 100%; background: url(/images/ico_cal.png) center top no-repeat; font-size: 28px;"><%=wdays%></div>
            </div>
            <%End if%>
            <div><%=str_visite_progetto%><br />
                <span class="sVisits">
                    <img src="/images/ico_visits.png" alt="" /><%=visite%></span></div>
            <div><%=str_finanziatori%><br />
                <span class="sVisits">
                    <img src="/images/ico_supporter.png" style="float: left" alt="" /><%=num_subscribers%></span></div>
            <div>
                <%=str_valutazione%><br />
                <div class="stars">
                    <img src="/images/vuoto.gif" style="float: left; height: 24px; width: <%=CInt(svotes*26)%>px; background: url(/images/stars_over.png) left -1px no-repeat; border: 0px;" />
                    <%If Len(Session("logged_donator"))>0 And closed=False And Session("logged_donator")<>puser then%>
                    <a style="width: 100%; height: 20px; position: absolute; left: 0px;" class="vote" alt="<%=UCase(str_vota)%>" title="<%=UCase(str_vota)%>" href="/project/voteProject.asp?load=<%=refproject%>"></a>
                    <%End if%>
                </div>
            </div>
            <%If Len(Session("logged_donator"))>0 And confirmed then%>
            <div>
                <%If InStr(Session("p_favorites"),","&refproject&",")=0 OR isnull(Session("p_favorites")) then%>
                <%=str_add_favorites%><br />
                <img src="/images/favorite.png" style="margin-top: 10px; cursor: pointer" alt="aggiungi ai preferiti" title="aggiungi ai preferiti" onclick="addtoFavorites(<%=refproject%>)" />
                <%else%>
                <%=str_tra_favorites%><br />
                <img src="/images/favorite_on.png" style="margin-top: 10px" alt="" />
                <%End if%>
            </div>
            <%End if%>

            <%If Len(TRwidget)>0 AND InStr(TRwidget,"<script>") Then
			TRwidget=Replace(TRwidget,Chr(34)&Chr(34),Chr(34))
			TRwidget=Replace(TRwidget,"''","'")
			Response.write "<div style=""min-height:130px; max-height:150px; margin-top:0px;""><p class=""notrans"" style=""margin:0px 0px 16px 0px;"">"&str_trepublick&"<br/><a class=""vote"" style=""font-weight:normal; color:#8a8fa4;"" href=""/getPageFooter.asp?load=2238"">"&str_trepublick1&"</a></p>"&TRwidget&"</div>"
			End if%>

            <%If  confirmed then%>
            <div style="height: 90px;">
                <%=str_condividi%><br />
                <div id="facebook" style="display:none"></div>
                <!--<div id="twitter"></div>-->
                <div class="sharrre grey" id="mail1">
                    <span class="box"></span><span class="count"><%=pShareCount %></span>
                </div>
                <div class="sharrre" id="googleplus">
                    <div class="box"></div>
                </div>
                <div class="sharrre" id="pinterest">
                    <div class="box"></div>
                </div>
                <div class="sharrre" id="eml" style="display:none"><div class="box"></div></div>



                <%
       relativePath = "/"
         applicationMetaPath = Request.ServerVariables("APPL_MD_PATH")
   instanceMetaPath = Request.ServerVariables("INSTANCE_META_PATH")
    rootPath = Mid(applicationMetaPath, Len(instanceMetaPath) + Len("/ROOT/"))
    ToRootedVirtual = rootPath + relativePath 

            shorturl = stringformat("{0}{1}.aspx", array(site_mainurl,refProject))
            
               if isnull(fblink) or isempty(fblink)  then 
                fblink = shorturl
               end if
                    
                %>
                <div id="urlshort" style="font-size: 9px"><%=shorturl %></div>
                
            </div>
            <div style="height: 90px;border-bottom:0px">

                <div class="fb-like"
                    data-href="<%=fblink%>/"
                    data-layout="box_count"
                    data-action="like"
                    data-size="large"
                    data-show-faces="true"
                    data-share="true">
                </div>
                
                <div id="form-messages"></div>
            </div>
            <%End if%>

            <%
	'LOAD HIDDEN SEND NOTIFY SYSTEM
	If Len(notifica_send)>0 Then%>
            <!--<iframe style="width:1px;height:1px;border:solid 0px;overflow:hidden; opacity:0; filter:alpha(opacity=0); display:none;" src="/actions/set_notifica.asp?load=<%=refproject%>&amp;val=<%=notifica_send%>"></iframe>-->
            <%End if%>
        </div>
    </div>

    <%
'CONTROLS FOR PROMOTER, BEFORE SEND TO APPROVE
If toconfirmed=False And confirmed=False AND puser=Session("logged_donator")  Then%>
    <div class="addbottom" style="width: 100%; position: relative; background: #fff; margin-top: -37px; text-align: right; margin-bottom: 37px; height: 42px;">
        <%If isnull(minimo)=False And minimo>=10 And pObj>0 And isnull(termine)=False then%><input type="button" class="bta" onclick="document.location = '/?edit-project/<%=refproject%>/<%=plink%>/avvio/'" value="<%=str_richiedi_approvazione%>" /><%End if%>
        <input type="button" class="bt" onclick="document.location = '/?edit-project/<%=refproject%>/<%=plink%>/edit/'" value="<%=UCase(str_modifica)%>" />
    </div>
    <%ElseIf puser=Session("logged_donator")  Then%>
    <div class="addbottom" style="width: 100%; position: relative; background: #fff; margin-top: -37px; text-align: right; margin-bottom: 37px; height: 42px;">
        <input type="button" class="bt" onclick="document.location = '/myprojects/'" value="<%=UCase(str_miei_progetti)%>" />
    </div>
    <%End if%>
</div>


<%
spercw=sperc
spercw1=sperc1

If spercw>0 And spercw<=1 Then spercw=1
If spercw1>0 And spercw1<=1 Then spercw1=1


If spercw>100 Then spercw=100
altvalue=100-spercw-spercw1
If altvalue<0 Then altvalue=0
altvalue=Round(altvalue,1)

altvalue=Replace(altvalue,",",".")
spercw=Replace(spercw,",",".")
spercw1=Replace(spercw1,",",".")


addscriptP=addscriptP&"loadPieChart("&spercw1&","&spercw&","&altvalue&"); $('.homeProjects').css('display','inline');"



	'LOAD RELATED PROJECTS
	If Len(relatedProjects)>1 And confirmed Then
	relatedProjects=Split(relatedProjects,",")
	SQLrelateds=""
		For y=1 To UBound(relatedProjects)-1
		SQLrelateds=SQLrelateds&"SELECT * FROM QU_projects WHERE ID="&relatedProjects(y)&" AND (LO_aperto OR fondi_raccolti>=IN_cifra) UNION "
		Next

		If Len(SQLrelateds)>0 Then 


		SQLrelateds=Mid(SQLrelateds,1,Len(SQLrelateds)-6)&" ORDER BY DT_termine ASC"
%>
<div class="homeNews lprojects">
    <div>
        <p><%=str_related_projects%></p>
        <div class="newsScroller">
            <%
					SQL=SQLrelateds
					mode="ultimi"
					iPageSize = 4

            %>
            <!--#INCLUDE VIRTUAL="./project/load_projects_list_bottom_home.asp"-->
        </div>
    </div>
</div>

<%
		End if
	End If

	firstDo=0

	If InStr(complex,"/donate/") Then firstDo=4
	If InStr(complex,"/addnews/") Or InStr(complex,"/news/") Then firstDo=5

%>
<a style="display: none" class="firstAction" href="javascript:$('div.pButton').eq(<%=firstDo%>).trigger('click')"></a>
<%End if%>
<div style="display:none"> charset
<% 

Call Response.Write(Response.Charset)
Call Response.Write(Response.CodePage)
%></div>