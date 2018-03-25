<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
''ON ERROR RESUME NEXT

titletop="Gestione progetto"

load=request("load")
SQL="SELECT * FROM QU_projects WHERE ID="&load
If Session("adm_area")>0 Then 
SQL1=SQL1&" AND CO_p_area="&Session("adm_area")
End If

set rec=connection.execute(SQL)
If rec.eof Then
Response.End
End if

nobg=True

pCat=rec("refCat")
pCatName=rec("category")
pColor=rec("TA_color")
pImg=rec("AT_main_img")
aperto=rec("LO_aperto")
realizzato=rec("LO_realizzato")
deleted=rec("LO_deleted")
		imgb1=rec("AT_banner")
		pImg=rec("AT_main_img")
		
		'If Len(pImg)=0 OR isnull(pImg) Then pImg=imgb1
		imgb2=rec("AT_post_img")

If isnull(pColor) Then pColor="#9ba1b3"
If isnull(pCat) Then pCat=0

pTitle=rec("TA_nome")
If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")
plink=linkMaker(pTitle)
    ptitle = convertfromutf8(ptitle)
confirmed=rec("LO_confirmed")

toconfirmed=rec("LO_toconfirmed")

puser=rec("CO_registeredusers")

If Len(puser)>0 Then
SQL="SELECT * from registeredusers WHERE LO_projects=True AND LO_enabled=True AND ID="&puser
Set rec1=connection.execute(SQL)
if Not rec1.eof then

addinfo="<p style=""font-size:13px; margin-bottom:0px; width:200px""><b>Promotore</b><br/>"&rec1("TA_ente")&"<br/>"&rec1("TA_nome")&"&nbsp;"&rec1("TA_cognome")&"<br/><br/>"
fb=rec1("TA_facebook")
If Len(fb)>0 Then addinfo=addinfo&"<a href="""&fb&""" target=""_blank""><img src=""/images/img_fb.png""></a>&nbsp;&nbsp;"

tw=rec1("TA_twitter")
If Len(tw)>0 Then addinfo=addinfo&"<a href="""&tw&""" target=""_blank""><img src=""/images/img_tw.png""></a>&nbsp;&nbsp;"

lk=rec1("TA_linkedin")
If Len(lk)>0 Then addinfo=addinfo&"<a href="""&lk&""" target=""_blank""><img src=""/images/img_lk.png""></a>&nbsp;&nbsp;"

addinfo=addinfo&"</p>"

End If
End if

		luogo=rec("TA_luogo")
		nazione=rec("TA_nazione")
		pText=rec("TE_abstract")
		pObj=rec("IN_cifra")

		cifraObiettivo=pObj
		cifraObiettivo=setCifra(cifraObiettivo)

		pPropri=rec("IN_mezzi_propri")
		pObt=rec("IN_raccolto")
		promesse=pObt
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
		sperc=0
		sperc1=0
		
		If pObj>0 Then sperc=Round(pObt/pObj*100,1)
		If pObj>0 Then sperc1=Round(pPropri/pObj*100,1)
		totLevel = sperc+sperc1
		totLevel = Replace(totLevel,",",".")
		sperc=Replace(sperc,",",".")
		sperc1=Replace(sperc1,",",".")

		svotes=0
		pObt=pObt+pPropri
		mCol="#00b450" 
		If pObj>0 Then wManca="obiettivo raggiunto<br/>sostienici ancora!"
		If pMancante<0 Then 
		mCol="#e20613"
		wManca="mancano ancora"
		pMancante=setCifra(pMancante*-1)
		Else
		If pMancante>0 Then pMancante="+"&setCifra(pMancante)
		
		End if
		If (voti>0) Then svotes=round(rated/voti,1)

		subCategories=rec("CR_p_subcategory")
diffdays=dateDiff("d",Now(),termine)
diffdaysReal=dateDiff("d",Now(),termine)*-1
diffmonths=dateDiff("m",Now(),termine)
wdiff="giorni"
wdays=diffdays
If diffdays>60 Then 
wdiff="mesi"
'wdays=diffmonths
wdays=Round(diffdays/30)
End if

If diffdays<0 Then 
wdays=0
End if

SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_projects="&load&")"
Set rec1=connection.execute(SQL)
num_subscribers=rec1("subscribers")
ptext = ConvertFromUTF8(ptext)
Response.CharSet = "ISO-8859-1"
Response.CodePage = 28591
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<p class="titolo"> <%=titletop%> - <%=pTitle%></p>
<div style="position:absolute; right:10px; top:20px">
<img src="/images/vuoto.gif" style="float:left; background: url(/<%=imgscript%>?path=<%=pImg%>$400) center center no-repeat; width:100px; height:100px; background-size:100% auto"/>
<img src="/images/vuoto.gif" style="float:left; margin-left:10px; background: url(/<%=imgscript%>?path=<%=imgb1%>$800) center center no-repeat; width:293px; height:100px; background-size:100% auto"/>
</div>
<p class="titolo" style="color:<%=pColor%>"><%=pCatName%></p>
<%=addinfo%>
<p style="font-size:13px; margin-bottom:0px"><%=luogo%>,&nbsp;<%=nazione%></p>
<p style="font-size:13px; margin-bottom:0px"><%=pText%></p>
<p style="font-size:13px; margin-bottom:0px">
Termine: <b><%=termine%></b><br/>
Status: <b><%=totLevel%></b>%<br/>
Cifra obiettivo: <b><%=cifraObiettivo%></b><br/>
Mezzi propri: <b><%=setCifra(pPropri)%></b><br/>
Raccolto: <b><%=promesse%></b><br/>
Mancante: <b><%=pMancante%></b><br/>
<br/>



<%

'GIULIO: rimossa if not deleted per far apparire le schede cancellate come quelle scadute
'If Not deleted then
    If Not confirmed And toconfirmed then%>
        <span style="color:#ff0000">In attesa di conferma</span>
    <%ElseIf Not confirmed And Not toconfirmed then%>
        <span style="color:#ff0000">In preparazione</span>
    <%else%>
        
        <%If deleted then %>
            <p><span style="color:#ff0000; font-size:14px;">Progetto annullato</span></p>
            <!--GIULIO: Aggiunto pulsante per riattivare il progetto-->
            <input class="btn12" type="button" style="float:left; width:158px; margin:4px 4px; " onclick="document.location = 'projects_undo_delete.asp?load=<%=load%>';" value="RIAPRI RACCOLTA FONDI"/>
        <%End if %>

        <b><%=wdays%>&nbsp;<%=wdiff%></b> al termine della raccolta fondi<br/>
        Visite: <b><%=visite%></b><br/>
        Rating: <b><%=svotes%></b> (<%=voti%> voti)<br/>
        <%If realizzato then%>
            <br/><span style="color:#ff0000">PROGETTO REALIZZATO</span>
        <%ElseIf diffdaysReal>0 then%>
            <br/><span style="color:#ff0000">CROWDFUNDING SCADUTO</span>

        <%End if%>
    <%End if%>
    </p>
    <p>
	    <input class="btn12" type="button" style="float: left; width:90px;margin:4px 4px; " onclick="window.open('/?progetti/<%=load%>/<%=plink%>','edit-project')" value="APRI SCHEDA"/>
    
    <%If num_subscribers>0 then%>
	    <input class="btn12" type="button" style="float: left; width:105px;margin:4px 4px; " onclick="document.location='projects_promoters.asp?load=<%=load%>'" value="<%=num_subscribers%> Sostenitori"/>
    <%ElseIf confirmed And diffdaysReal<=0 AND Not realizzato then%>
	    <input class="btn12" type="button" style="float: left; width:130px;margin:4px 4px; " onclick="document.location='projects_disable.asp?load=<%=load%>'" value="annulla convalida"/>
    <%End if%>

    <%If Not deleted then%>
    <input class="btn12" type="button" style="float: left; width:120px; margin:4px 8px 0px 0px;" onclick="window.open('projects_edit.asp?load=<%=load%>','edit-project')" value="MODIFICA SCHEDA"/>
    <%End if%>



    <%If Not confirmed then%>
	    <%If toconfirmed then%>
	    <input class="btn12" type="button" style="float:left; width:80px;margin:4px 4px; " onclick="document.location='projects_confirm.asp?load=<%=load%>';" value="CONVALIDA"/>
	    <input class="btn12" type="button" style="float:left; width:113px;margin:4px 4px; " onclick="document.location='projects_reject.asp?load=<%=load%>';" value="non convalidare"/>
	    <%End IF%>
    <%Else%>
	
	    <%If Not realizzato then%>
	    <input class="btn12" type="button" style="float:left; width:73px;margin:4px 4px; " onclick="document.location='projects_proroga.asp?load=<%=load%>';" value="PROROGA"/>
	    <%End if%>

	    <%If totlevel>99.9 And Not realizzato Then 
	    'Response.write diffdaysReal
	    %>
		    <%If diffdaysReal>=0 Then
			    SQL="SELECT * FROM notifiche WHERE CO_p_projects="&load&" AND TA_notifica_type='confirmed'"
			    Set rec1=connection.execute(SQL)
				    if rec1.eof Then
				    %> <input class="btn12" type="button" style="float:left; width:128px;margin:4px 4px; " onclick="document.location='projects_confirm100.asp?load=<%=load%>';" value="INVIA CONFERMA 100%"/>
				    <%
				    Else
				
				    End if%>
		    <%End if%>
	    <input class="btn12" type="button" style="float:left; width:88px;margin:4px 4px; " onclick="document.location='projects_finished.asp?load=<%=load%>';" value="REALIZZATO"/>
	    <%End if%>
	
        <%If diffdaysReal>0 And (totLevel)<100 And Not realizzato then%>
	        <input class="btn12" type="button" style="float:left; width:158px; margin:4px 4px; " onclick="document.location='projects_delete.asp?load=<%=load%>';" value="ARCHIVIA RACCOLTA FONDI"/>
	    <%End if%>
	    <input class="btn12" type="button" style="float:left; width:98px;margin:4px 4px; " onclick="document.location='projects_addnews.asp?load=<%=load%>';" value="AGGIUNGI NEWS"/>
    <%End if%>
    </p>
    <iframe id="edNews1" scrolling="auto" src="edit.asp?tabella=p_projects&pagina=<%=load%>" style="position:relative; width:100%; height:450px;border:solid 0px"></iframe>
    <%If realizzato then%>
        <iframe style="width:1px;height:1px;border:0px;overflow:hidden; opacity:0; filter:alpha(opacity=0); display:none;" src="/actions/set_notifica.asp?load=<%=load%>&amp;val=finished"></iframe>
    <%End if%>

<%
    'GIULIO: rimossa if not deleted per far apparire le schede cancellate come quelle scadute
    'else%>




<%
    'GIULIO: rimossa if not deleted per far apparire le schede cancellate come quelle scadute
    'End if%>

</body>
</html>
<%
connection.close
response.End%>