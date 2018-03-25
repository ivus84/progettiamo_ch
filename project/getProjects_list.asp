<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_language_vars.asp"-->
<%
'response.write "<script>alert('load')</script>"
'Response.CodePage  = 65001
load=request("load")
mode=request("mode")
area=request("area")

'VB: se 0 vuol dire che non ho trovato risultati per quella ricerca (nuova implementazione) ed eseguo la ricerca per tutte le aree
if Len(area)>0 then 
    if area=0 then area=""
else
    area=""
end if

'Response.charset="utf-8"
if load ="" then load = "0" 

'response.write "mode:" & mode & " area:" & area & " load:" & load
'response.end

If Len(mode)>0 And mode<>"tag" Then 
    load=CInt(load)
    If mode="category" And load>0 Then Session("p_category")=load
    If mode="category" And load=0 Then Session("p_category")=""
    If mode="area" then
        if load>0 Then 
            Session("p_area")=load
        else
            Session("p_area")=""
        end if
    end if

    colorc="#9ba1b3"
    If mode="type" Then
        'VB: Anche per mode=type tengo in considerazione l'area. Prima era assegnato a ""
   
	    Session("p_area")=area
	    Session("p_category")=""
	    Session("p_tag")=""

	    If load>0 Then 
		    SQL="SELECT * FROM p_category WHERE ID="&load
		    Set rec=connection.execute(SQL)
		    colorc=rec("TA_color")
	    End if
    End If

 
    'Se mode="area" allora la pagina proviene dopo la selezione dell'area dalla combo, e in load ho l'id dell'area
    'Il mode="type" indica la query per tipo, ovvero "Sosteniamo" "Doniamo" o "Finanziamo"
    'Il mode="tag" indica una ricerca e in load c'è il testo da ricercare
	If mode="area" Or mode="type" Then
        'response.write "<script>alert('sono nel primo if')</script>"
	    SQL1="SELECT COUNT(ID) as num, sum(IN_raccolto) as fondi FROM QU_projects WHERE (LO_aperto=True OR LO_realizzato=True OR fondi_raccolti>=IN_cifra)"
	    SQL2="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE (LO_aperto=True OR LO_realizzato=True OR fondi_raccolti>=IN_cifra))"
	    SQL3="SELECT SUM(IN_viewed) as num_visits FROM QU_projects WHERE (LO_aperto=True OR LO_realizzato=True OR fondi_raccolti>=IN_cifra)"

        'VB:Modifica per risoluzione problema numero progetti=0; il numero di progetti totali me lo porto sempre
        '--------------------
        SQL_TOT_PROJECTS="SELECT COUNT(ID) as num, sum(IN_raccolto) as fondi FROM QU_projects WHERE (LO_aperto=True OR LO_realizzato=True OR (fondi_raccolti>=IN_cifra AND LO_confirmed))"
        Set rec1=connection.execute(SQL_TOT_PROJECTS)
        tot_projects=rec1("num")
        '-------------------------
	    If mode="type" Then
	        SQL1=SQL1& " AND CO_p_category=" & load
	        SQL2=Replace(SQL2, "WHERE","WHERE CO_p_category=" & load & " AND")
	        SQL3=SQL3& " AND CO_p_category="&load
	        SQL1=Replace(SQL1, " OR LO_realizzato=True OR fondi_raccolti>=IN_cifra","")
	        SQL2=Replace(SQL2, " OR LO_realizzato=True OR fondi_raccolti>=IN_cifra","")
	        SQL3=Replace(SQL3, " OR LO_realizzato=True OR fondi_raccolti>=IN_cifra","")
		    'CARICA CONTEGGI REALIZZATI
		    If load=0 Then
		        SQL1="SELECT COUNT(ID) as num, sum(IN_raccolto) as fondi FROM QU_projects WHERE LO_aperto=False AND LO_confirmed AND LO_deleted=False AND (LO_realizzato=True OR fondi_raccolti>=IN_cifra)"
		        SQL2="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE LO_aperto=False AND LO_confirmed AND LO_deleted=False AND (LO_realizzato=True OR fondi_raccolti>=IN_cifra))"
		        SQL3="SELECT SUM(IN_viewed) as num_visits FROM QU_projects WHERE LO_aperto=False AND LO_confirmed AND LO_deleted=False AND (LO_realizzato=True OR fondi_raccolti>=IN_cifra)"
		    End if
            'VB:tengo in considerazione l'area anche quando faccio il load per tipo progetto
            'response.write "<script>alert('prima di area')</script>"
            if Len(area)>0 then
                'response.write "<script>alert('area non è vuoto')</script>"
                if area>0 then sql1 = sql1 & " and co_p_area=" & area
            end if
            Set rec1=connection.execute(SQL1)
            tot_projects=rec1("num")
	    End If
	  
        num_projects=0
        searchForArea=false
	    If mode="area" And load>0 Then
	        SQL1=SQL1& " AND CO_p_area=" & load
	        SQL2=Replace(SQL2, "WHERE","WHERE CO_p_area="& load &" AND")
	        SQL3=SQL3& " AND CO_p_area=" & load
	    'ElseIf mode="area" And load=0 Then
	        'SQL1="SELECT COUNT(ID) as num, sum(IN_raccolto) as fondi FROM QU_projects WHERE (LO_aperto=True OR LO_realizzato=True OR (fondi_raccolti>=IN_cifra AND LO_confirmed))"
            Set rec1=connection.execute(SQL1)
            num_projects=rec1("num")
            searchForArea=true
        else 
            num_projects=tot_projects
	    End If

	    num_fondi=rec1("fondi")
	    If isnull(num_fondi) Then num_fondi=0
	    num_fondi=setCifra(num_fondi)

	    Set rec2=connection.execute(SQL2)
        num_subscribers=rec2("subscribers")

	    Set rec3=connection.execute(SQL3)
	    num_visits=rec3("num_visits")

        'VB:Visualizza le intestazioni delle 4 colonne per tipi di progetto ("Sosteniamo - Doniamo etc")
        'Forzo num_project a 0 per la visualizzazione delle nuova lable
        'num_projects=0
        Response.write"<div class=""catInfo"" style=""color:"&colorc&""">"
        'VB:Commentata perchè Alessandro chiede il banner nei progetti
        'If searchForArea Then           
        '    if num_projects>0 then
        '        Response.write"<div>"&str_tot_projects&" <div style=""color:"&colorc&"""><img src=""/images/vuoto.gif"" style=""background-color:"&colorc&";margin-left:15px; background-image: url(/images/ico_presenti.png)"" alt=""""/><span>"& num_projects &"</span></div></div>"
        '    else
        '        displayLabel=Replace(str_no_projects_found,"/cod_zona/",str_no_projects_found_append)
        '        SQL="SELECT TA_nome from p_area where id=" & session("p_area")
        '        Set rec1=connection.execute(SQL)
        '        nome_area=rec1("ta_nome")
        '        displayLabel=Replace(str_no_projects_found,"/cod_zona/",nome_area)
        '        Response.write"<div>" & displayLabel & "<div style=""color:"&colorc&"""><img src=""/images/vuoto.gif"" style=""background-color:"&colorc&";margin-left:15px; background-image: url(/images/ico_presenti.png)"" alt=""""/><span>"& num_projects &"</span></div></div>"  
        '    end if           
        'else
        '    Response.write"<div>"&str_tot_projects&" <div style=""color:"&colorc&"""><img src=""/images/vuoto.gif"" style=""background-color:"&colorc&";margin-left:15px; background-image: url(/images/ico_presenti.png)"" alt=""""/><span>"& tot_projects &"</span></div></div>"
        'End If
        Response.write"<div>"&str_tot_projects&" <div style=""color:"&colorc&"""><img src=""/images/vuoto.gif"" style=""background-color:"&colorc&";margin-left:15px; background-image: url(/images/ico_presenti.png)"" alt=""""/><span>"& num_projects &"</span></div></div>"
        Response.write"<div>"&str_tot_visits&"<div style=""color:"&colorc&"""><img src=""/images/vuoto.gif"" style=""background-color:"&colorc&"; background-image: url(/images/ico_sostenitori.png)"" alt=""""/><span>"& num_visits &"</span></div></div>"
        Response.write"<div>"&str_supporters&"<div style=""color:"&colorc&"""><img src=""/images/vuoto.gif"" style=""background-color:"&colorc&";width:46px; height:54px; margin-top:-24px; background-image: url(/images/ico_finanziatori.png)"" alt=""""/><span>"& num_subscribers &"</span></div></div>"
        Response.write"<div>"&str_funds&" Fr.<div style=""color:"&colorc&"""><img src=""/images/vuoto.gif"" style=""background-color:"&colorc&"; background-image: url(/images/ico_fondi.png)"" alt=""""/><span>"& num_fondi &"</span></div></div>"
        Response.write"</div>"
    End If
End If

'response.write "mode:" & mode & " area:" & area & " load:" & load
'response.end

SQL="SELECT * FROM QU_projects WHERE LO_confirmed=True"

If mode="tag" And Len(load)>0 Then
    addnofound="<br/><br/>Ricerca tag: <b>"&load&"</b>"
    load=Trim(load)
    load=Replace(load,"'","''")
    load=Replace(load,Chr(34),"")
    If Len(load)>0 then
	    If InStr(load," ")=0 then
	        SQL=SQL&" AND (instr(TX_keywords,'," & load  &",')>0 OR instr(TE_abstract,'" & load & "') OR instr(TA_nome,'" & load & "')>0)"
		   Else
	        gtload=Split(load," ")
	        adSql=" AND (instr(TX_keywords,',"&load&",')>0"
	        For x=0 To Ubound(gtload)
		        adSql=adSql&" OR instr(TX_keywords,',"&gtload(x)&",')>0 OR instr(TE_abstract,'" & gtload(x) & "') OR instr(TA_nome,'"&gtload(x)&"')>0"
	        Next
	        adSql=adSql&")"
	        SQL=SQL&adSql
	    End If
    End If
End if

If Len(Session("p_category"))>0 Then SQL=SQL & " AND instr(CR_p_subcategory,'," & Session("p_category") & ",')"
If Len(Session("p_area"))>0 Then 
    SQL=SQL& " AND CO_p_area="&Session("p_area")
    SQL1="SELECT TA_nome FROM p_area WHERE ID="&Session("p_area")
    Set rec1=connection.execute(SQL1)
    If Not rec1.eof Then
        addnofound=addnofound&"<br/><br/>Area: <b>"&rec1("TA_nome")&"</b>"
    End if
End if

'response.write "mode:" & mode & " area:" & area & " load:" & load
'response.end

If mode="type" Then 
    If load>0 Then SQL=SQL & " AND CO_p_category="& load &" AND (LO_aperto=True)"
    If load=0 Then SQL=SQL & " AND LO_aperto=False AND (LO_realizzato=True OR fondi_raccolti>=IN_cifra)"
    'if len(area)>0 and area<>0 then sql=sql & " and co_p_area=" & area
End If

SQL=SQL&" ORDER BY LO_aperto ASC, DT_apertura DESC"
Set rec=connection.execute(SQL)

If rec.eof Then
    If mode="type" or mode="area" Then 
        displayLabel=Replace(str_no_projects_found,"/cod_zona/",str_no_projects_found_append)
        if area = "" then area = 0
        SQL="SELECT TA_nome from p_area where id=" & area
        Set rec1=connection.execute(SQL)
        if not rec1.EOF then
        nome_area=rec1("ta_nome")
        displayLabel=Replace(str_no_projects_found,"/cod_zona/",nome_area)
        'Response.write "<script>alert('" & area & "')</script>"
        response.write "<script>showNoProjectModal('" & displayLabel & "'," & load & ",'" & str_tutte_aree & "')</script>"
        end if 
    else
        Response.write "<div class=""p_list"" style=""width:400px""><p style=""padding:10%"">"&str_nofound1 & addnofound&"</p></div>"
    end if
    
else
    
    Response.write "<div class=""scrollProjects"">"
	Do While Not rec.eof
		If Not rec.eof Then
		    imgb1=rec("AT_banner")
		    imgb=rec("AT_main_img")
		    If Len(imgb)=0 OR isnull(imgb) Then imgb=imgb1

		    imgb2=rec("AT_post_img")

		    color=rec("TA_color")
		    luogo=rec("TA_luogo")
		    nazione=rec("TA_nazione")
		    refProject=rec("ID")
		    pTitle=ConvertFromUTF8(rec("TA_nome"))
            fblink = rec("TX_fblink")
            shorturl = stringformat("{0}{1}.aspx", array(site_mainurl,rec("ID")))
            
		    If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")
            pSubtitle = rec("TA_nome_1")
            
            If Len(pSubTitle)>0 Then 
                pSubtitle=Replace(pSubTitle,"#","'")
                pSubtitle = ConvertFromUTF8(pSubtitle)
            end if
		    pCat=rec("category")
		    pText=rec("TE_abstract")
            pText = ConvertFromUTF8(pText)
		    pObj=rec("IN_cifra")
		    pObt=rec("IN_raccolto")
		    pMezzi=rec("IN_mezzi_propri")
		    pRef=rec("ID")
		    inizio=rec("DT_apertura")
		    termine=rec("DT_termine")
		    rated=rec("IN_rated")
		    voti=rec("IN_votes")
		    realizzato=rec("LO_realizzato")
		    pcat=rec("CO_p_category")
		    dedu=rec("LO_deducibile")
            bonus = rec("LO_bonus")
            bonus_text = rec("TX_testo_bonus")
            bonus_text = HTMLDecode(bonus_text)
            bonus_text = ConvertFromUTF8(bonus_text)
            bonus_img = rec("AT_sponsor")

            If realizzato Then
	            If Len(imgb2)>0 Then imgb=imgb2
            End if
		    closed=false
		    sperc=CInt((pObt+pMezzi)/pObj*100)
		    svotes=0
		    If (voti>0) Then svotes=round(rated/voti,1)
		        pLink=linkMaker(pTitle)
                'fbLink = pLink
                ' se link presente nel campo fblink allora usa questo altrimenti usa link breve 
                if isnull(fblink) then fblink = shorturl
		        If Len(imgb)>0 Then 
		            imgb="/"&imgscript&"?path="&imgb&"$600"
		        Else
		            imgb="/images/thumb_picture1.png"
		        End If

                addDiff=""
                addDonate=""
                addVotes=""
                diffdays=dateDiff("d",Now(),termine)*-1
                diffdaystart=dateDiff("d",inizio,Now())

                closed=False

                If diffdays>=1 Then closed=True

                addDonate="<img class=""dn"" src=""/images/ico_donate_small.png"" style=""opacity:0.5; cursor:default;""/>"
                If Not closed Then addDonate="<img class=""dn"" src=""/images/ico_donate_small.png"" onclick=""document.location='/?progetti/"&refProject&"/"&pLink&"/donate/'""/>"

                If svotes>0 Then
                    y=1
	                While y<=svotes
	                    adst=""
	                    If y=4 Then adst=" style=""margin-left:3px; margin-right:-1"""
	                    addVotes=addVotes&"<img src=""/images/rt.png"" class=""rt"""&adst&"/>"
	                    y=y+1
	                Wend
	                If y<=5 Then
		                While y<=5
		                    addVotes=addVotes&"<img src=""/images/rtn.png"" class=""rt""/>"
		                    y=y+1
		                Wend
	                End if
                End If
                'IB sostituzione rating con pulsante FB con contatore condivisioni
'addVotes = ""

                status="current"
                statusview=str_cf_current

                If diffdays>=-30 And diffdays<0 Then 
                    status="time"
                    statusview=(diffdays*-1)&" "&str_cf_daysto
                End If

                If diffdaystart<20 Then 
                    status="start"
                    statusview=str_cf_started
                End If

                If closed Then 
                    status="closed"
                    statusview=str_cf_finished
                End If

                If sperc>=100 Then 
                    status="done"
                    statusview=str_cf_done
                    closed=false
                End If

                If realizzato Then 
                    status="realised"
                    statusview=str_cf_realized
                    closed=false
                End if

                icoLove="/images/ico_love_on.png"
                If Len(Session("logged_donator"))>0 then
                    If InStr(Session("p_favorites"),","&refproject&",")=0 OR isnull(Session("p_favorites")) Then icoLove="/images/ico_love.png"
                Else
                    icoLove="/images/ico_love.png"
                End if


		        If Not closed Then

		        addlocation=luogo
		        If nazione<>"Svizzera" Then addlocation=addlocation&", "&nazione

                If Len(pText)>0 then
	                pText=Trim(pText)
	                If Len(pText)>0 Then pText=Replace(pText,"</a>","")

	                set regEx = New RegExp
	                regEx.IgnoreCase = True
	                regEx.Global = True
	                regEx.Pattern = "<a[^>]*>"
	                If Len(pText)>0 Then pText= regEx.Replace(pText, "")
	                set regEx=Nothing
                    
	                maxlength=260
                    'IB 170321 - Modifiche layout
	                'If Len(pText)>maxlength Then pText=truncateTxt(pText,maxlength)&" ..."
                    'IB 170321 - Modifiche layout
                End if
            'IB 170318 - riduci testo 
            maxTitleLength = 45
            maxSubtitleLength = 80
            
            if Len(pTitle)> maxTitleLength then pTitle = truncateTxt2(pTitle, maxTitleLength)
            if len(pSubtitle)> maxSubtitleLength then pSubtitle = truncatetxt(psubtitle, maxSubtitlelength)
            if len(psubtitle)>0 then
                psubtitle = "<p class=""subtitle"">" & psubtitle & "</p>"
            end if
            'IB 170318 - riduci testo 
            addOverico=""
            addDedu_ico=""
            addBonus_ico = ""
            If dedu Then addDedu_ico="<img src=""/images/ico_ded_"&pcat&".png"" class=""dedu tooltip"" title="""&str_deducibile&"""/>"
            if bonus then addBonus_ico ="<img src=""/images/ico_bonus.png"" class='bonus tooltip' title ='<div style=""margin-bottom:5px;"">"&bonus_text&"</div><img src=""/"&imgscript&"?path="&bonus_img&"$166""/>'/>"
   response.write  "<div class='tooltip_templates'><span id='tt"&refProject&"'><b>"&bonus_text&"</b><img src=""/"&imgscript&"?path="&bonus_img&"$600""/></span></div>"
    
            If realizzato Then plink=plink&"/news/"
            If realizzato Then addOverico="<img class=""overIco"" src=""/images/ico_ribbon"&pcat&".png"" alt="""&str_realizzato&""" title="""&str_realizzato&"""/>"
            If sperc>=100 And Not realizzato Then addOverico="<img class=""overIco ico_100"" src=""/images/ico_100_"&pcat&".png"" alt="""&str_obiettivo_raggiunto&""" title="""&str_obiettivo_raggiunto&"""/>"
    	        Response.write "<div class=""p_list"" id=""p_"&refProject&""" rel="""&pLink&"""><div class=""bg"" style=""background:"& color &"""></div><div class=""pic"" data-href="""& imgb &""" style=""background-color:"& colore &"; background-image:url(/images/thumb_picture1.png);"">"&addOverico&addDedu_ico&addBonus_ico&"</div><div class=""text""><p style=""height: 57px; overflow: hidden;""><b>"&pTitle&"</b></p>"&pSubtitle&"<p><span class=""location"">"& ConvertFromUTF8(addlocation) &"</span></p><p class=""descx""><span>"&pText&"</span></p>"

' INIZIO modifica CM 20161116
        response.write "</div>"
        response.write "<div class=""fb_div"">"
    response.write "<div class=""fb-like"" data-href="""&fbLink&"/"" data-layout=""button_count"" data-action=""like"" data-show-faces=""true"" data-share=""false""></div>"
    response.write "</div>"

' END Modifica CM 20161116 		        
    Response.write "<div class=""boxes"" style=""background:"&color&""">"

                   ' IB sostituzione rating con pulsante facebook
			    Response.write "<div class=""box"" style=""background-image:url(/images/ico_rating.png); background-position:center 6px; padding-top:5px; line-height:13px; "">"&addVotes&"</div>"
               'Test IB/CM utiizzo FB-like
                'Response.write "<div class=""fb-like box"" data-href=""/?progetti/"&refProject&"/"&pLink&"/"" data-layout=""box_count"" data-action=""like"" data-show-faces=""true"" data-share=""false""></div>"
                'Response.write "<div id=""facebook"" class=""sharrre fb"" style="""" slink=""/?progetti/"&refProject&"/"&pLink&"/"" link="""&site_mainurl&"?progetti/"&refProject&"/"&pLink&"/'"" prj=""list""><a class=""box"" href=""#""><div class=""share""><span></span></div></a>"&addVotes&"</div>"
' IB sostituzione rating con pulsante facebook

     'response.write "<div class=""box"" style=""background-color:#3b5998; height:34px;"" >"
    'response.write "<span class=""fb"" style=""background:url(/images/fb_icon_150x150.png);background-size: 27px 29px;    background-position: 8px 3px; background-repeat: no-repeat;margin-top:-8px;margin-left: 0px;""></span></div>"

			    Response.write "<div class=""box"" style=""padding:0px; height:84px""><img src=""/images/ico_"&status&".png"" style=""width:45px;"" alt="""&statusview&""" title="""&statusview&"""/></div>"
'			    Response.write "<div class=""box"" style=""padding:0px; height:84px; margin-top:-10px""><img src=""/images/ico_"&status&".png"" alt="""&statusview&""" title="""&statusview&"""/></div>"
			    Response.write "<div class=""box""><b>"&sperc&"</b><sup style=""font-size:12px; padding-top:8px;"">&#37;</sup></div>"
'			    Response.write "<div class=""box""><b>"&sperc&"</b><sup style=""font-size:12px;"">&#37;</sup></div>"
			    Response.write "<div class=""box""><img src="""&icoLove&"""/></div>"
			    Response.write "<div class=""box"">"&addDonate&"</div>"

		        'Response.write "</div>"
		        Response.write "</div>"
		    End if
		End if
	rec.movenext
   
    Loop
    Response.write "</div>"
    response.write "<script>(function(d, s, id) { var js, fjs = d.getElementsByTagName(s)[0]; if (d.getElementById(id)) return; js = d.createElement(s); js.id = id;  js.src = '//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.8'; fjs.parentNode.insertBefore(js, fjs);}(document, 'script', 'facebook-jssdk')); try { FB.XFBML.parse(document.getElementById('homeProjects')); } catch (e) { console.log(e) }</script>"
End if
		%>
<%connection.close%>