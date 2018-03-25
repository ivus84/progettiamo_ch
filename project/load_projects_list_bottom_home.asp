<%
iCurrentPage = 1
sSQLStatement = SQL

Set RecordSet = Server.CreateObject("ADODB.Recordset")
RecordSet.PageSize = iPageSize
RecordSet.CacheSize = iPageSize
RecordSet.Open sSQLStatement, Connection, adOpenStatic, adLockReadOnly

intCurrentRecord = 1
addsid=","
do While intCurrentRecord <= iPageSize

if not recordset.eof then

pcolor=RecordSet("TA_color")
pname=RecordSet("TA_nome")
    pname = ConvertFromUTF8(pname)
If mode="ultimi" Then pdata=datevalue(RecordSet("DT_apertura"))
If mode="termine" Then pdata=datevalue(RecordSet("DT_termine"))
refProjectlist=RecordSet("ID")

addsid=addsid&refProjectlist&","
pluogo=RecordSet("TA_luogo")
pnazione=RecordSet("TA_nazione")
pimg=RecordSet("AT_main_img")
ncolor=HEXCOL2RGB(pcolor)
rated=RecordSet("IN_rated")
voti=RecordSet("IN_votes")
		pObj=RecordSet("IN_cifra")
		pObt=RecordSet("IN_raccolto")
		pMezzi=RecordSet("IN_mezzi_propri")
		inizio=RecordSet("DT_apertura")
		termine=RecordSet("DT_termine")
		realizzato=RecordSet("LO_realizzato")

sperclist=CInt((pObt+pMezzi)/pObj*100)

addDiff=""
addDonate=""
addVotes=""
diffdays=dateDiff("d",Now(),termine)*-1
diffdaystart=dateDiff("d",inizio,Now())

closed=False

If diffdays>=1 Then closed=True



If Len(pname)>0 Then pname=Replace(pname,"#","'")
pLink=linkMaker(pname)

addbimg=""
If Len(pimg)>4 Then addbimg="<div class=""bbg"" style=""background-color:"&pcolor&""" ></div><img class=""bnews"" src=""/images/vuoto.gif"" style=""background-color:"&pcolor&"; background-image:url(/"&imgscript&"?path="&pimg&"$600)"" alt="""" />"

svotes=0
If (voti>0) Then svotes=round(rated/voti,1)
addVotes=""
If svotes>0 Then
y=1
	While y<=svotes
	adst=""
	If y=4 Then adst=" style=""margin-left:7px; margin-right:-1;"""
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

If sperclist>=100 Then 
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
		If InStr(Session("p_favorites"),","&refProjectlist&",")=0 OR isnull(Session("p_favorites")) Then icoLove="/images/ico_love.png"
		Else
		icoLove="/images/ico_love.png"
	End if

	addDonate="<img class=""dn"" src=""/images/ico_donate_small.png"" style=""opacity:0.5; cursor:default;""/>"
	If Not closed Then addDonate="<img class=""dn"" src=""/images/ico_donate_small.png"" onclick=""document.location='/?progetti/"&refProjectlist&"/"&pLink&"/donate/'""/>"

	If mode="donation" Then
		pdata=RecordSet("data_promessa")
		promessa=RecordSet("promessa")
		promessa=setCifra(promessa)
		pdata="</span><span style=""font-size:12px; padding-top:1px"">"&datevalue(pdata)&" - "&Mid(timevalue(pdata),1,InStrRev(timevalue(pdata),":")-1)


		pdata=pdata&"</span><span style=""float:right;margin-right:12px;"">Fr. "&promessa
	End if

	ico_small="ico_cal1.png"
	If mode="donation" Then ico_small="ico_donate_small_1.png"
	If mode="termine" Then ico_small="ico_time_1.png"


Response.write "<div class=""lproject"" style=""background-color:"&pcolor&""">"
Response.write "<div class=""nContent"" onclick=""document.location='/?progetti/"&refProjectlist&"/"&pLink&"/'"" ><p style=""margin-top:50px""><span>"&pname&"</span><br/>"&pluogo&", "&pnazione&"</p></div>"
Response.write addbimg&"<div><img src=""/images/"&ico_small&""" alt=""""/><span>"&pdata&"</span></div>"
Response.write "<div class=""boxes"" style=""background:"&pcolor&""">"
' IB sostituzione rating con pulsante facebook
			Response.write "<div class=""box"" style=""background-image: url(/images/ico_rating.png); background-position: center 6px; padding: 7px 0px 0px 4px; line-height:13px; "">"&addVotes&"</div>"
			
            'Response.write "<div id=""facebook"" class=""sharrre fb"" style="""" slink=""/?progetti/"&refProjectlist&"/"&pLink&"/"" link="""&site_mainurl&"?progetti/"&refProjectlist&"/"&pLink&"/'""><a class=""box"" href=""#""><div class=""share""><span></span></div></a>"&addVotes&"</div>"






           Response.write "<div class=""box"" style=""height:84px; padding:0px;""><img src=""/images/ico_"&status&".png"" style=""width:45px;"" alt="""&statusview&""" title="""&statusview&"""/></div>"
            Response.write "<div class=""box"" style=""width:44px""><b>"&sperclist&"</b><sup style=""font-size:12px; padding-top:8px;"">&#37;</sup></div>"
			Response.write "<div class=""box""><img src="""&icoLove&"""/></div>"
			Response.write "<div class=""box"">"&addDonate&"</div>"
		Response.write "</div>"
        ' IB sostituzione rating con pulsante facebook
        Response.write "</div>"

RecordSet.movenext
End If
intCurrentRecord=intCurrentRecord+1
    
loop


%>
