<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
''ON ERROR RESUME NEXT

titletop="Statistiche progetti"
'titletop=titletop&" "&Session("name_areap")


nobg=True

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<p class="titolo"> <%=titletop%></p>
<p style="padding:8px 0px;margin:0px;font-size:12px; line-height:18px;">Filtra per area <select name="parea" onchange="document.location='projects_stats.asp?parea='+$(this).val()">
<option value="0">Tutte</option>
<%
areavieW=request("parea")
If Len(areavieW)=0 Or areavieW="0" Then areavieW=0
areavieW=CInt(areavieW)

If Session("adm_area")>0 And areavieW>0 And areavieW<>Session("adm_area") Then areavieW=0


SQL="SELECT * FROM p_area"
If Session("adm_area")>0 Then SQL=SQL&" WHERE ID="&Session("adm_area")
SQL=SQL&" ORDER BY IN_ordine"
Set rec=connection.execute(SQL)
Do While Not rec.eof
ref=rec("ID")
area=rec("TA_nome")
adsl=""
If ref=areavieW Then adsl=" selected=""selected"""
Response.write "<option value="""&ref&""""&adsl&">"&area&"</option>"
rec.movenext
Loop
%>
</select>
</p>

<%

SQL1="SELECT COUNT(ID) as totpr FROM QU_projects WHERE LO_realizzato=True"
If areavieW>0 Then 
SQL1=SQL1&" AND CO_p_area="&areavieW
End If
set rec1=connection.execute(SQL1)
totpr=rec1("totpr")

SQL1="SELECT COUNT(ID) as totp, SUM(IN_raccolto) as totraccolto FROM QU_projects WHERE LO_confirmed=True AND LO_deleted<>True AND ID>0 "
If areavieW>0 Then 
SQL1=SQL1&" AND CO_p_area="&areavieW
End If

set rec1=connection.execute(SQL1)
totp=rec1("totp")

If totp=0 Then
Response.write "<p>Nessun progetto trovato</p>"
Response.end
End if

totraccolto=rec1("totraccolto")

If isnull(totraccolto) Then totraccolto=0

SQL1="SELECT SUM(IN_promessa) as totraccolto_mese FROM (SELECT DateDiff(""d"",[DT_data],Now()) as daydone,IN_promessa FROM QU_projects_promises"
If areavieW>0 Then 
SQL1=SQL1&" WHERE CO_p_area="&areavieW
End If
SQL1=SQL1&") WHERE daydone<=30"

set rec1=connection.execute(SQL1)
totraccolto_mese=rec1("totraccolto_mese")
If isnull(totraccolto_mese) Then totraccolto_mese=0

SQL1="SELECT SUM(IN_promessa) as totraccolto_mese_prev FROM (SELECT DateDiff(""d"",[DT_data],Now()) as daydone,IN_promessa FROM QU_projects_promises"
If areavieW>0 Then 
SQL1=SQL1&" WHERE CO_p_area="&areavieW
End If
SQL1=SQL1&") WHERE daydone>30 and daydone<=60"

set rec1=connection.execute(SQL1)
totraccolto_mese_prev=rec1("totraccolto_mese_prev")
If isnull(totraccolto_mese_prev) Then totraccolto_mese_prev=0


If totraccolto_mese>0 Then 
trendMonth=Round((totraccolto_mese-totraccolto_mese_prev)*100/totraccolto_mese,1)
If trendMonth>0 Then trendMonth="+"&trendMonth
trendMonth=trendMonth&"%"
End if


SQL1="SELECT SUM(IN_promessa) as totraccolto_week FROM (SELECT DateDiff(""d"",[DT_data],Now()) as daydone,IN_promessa FROM QU_projects_promises"
If areavieW>0 Then 
SQL1=SQL1&" WHERE CO_p_area="&areavieW
End If
SQL1=SQL1&") WHERE daydone<=7"

set rec1=connection.execute(SQL1)
totraccolto_week=rec1("totraccolto_week")
If isnull(totraccolto_week) Then totraccolto_week=0

SQL1="SELECT SUM(IN_promessa) as totraccolto_week1 FROM (SELECT DateDiff(""d"",[DT_data],Now()) as daydone,IN_promessa FROM QU_projects_promises"
If areavieW>0 Then 
SQL1=SQL1&" WHERE CO_p_area="&areavieW
End If
SQL1=SQL1&") WHERE daydone>7 AND daydone<=15"

set rec1=connection.execute(SQL1)
totraccolto_prevweek1=rec1("totraccolto_week1")
If isnull(totraccolto_prevweek1) Then totraccolto_prevweek1=0

If totraccolto_week>0 Then 
trendWeek=Round((totraccolto_week-totraccolto_prevweek1)*100/totraccolto_week,1)
If trendweek>0 Then trendWeek="+"&trendWeek
trendWeek=trendWeek&"%"
End if

SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises)"
If areavieW>0 Then SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_area="&areavieW&")"



Set rec1=connection.execute(SQL)
tot_subscribers=rec1("subscribers")

SQL="SELECT AVG(IN_promessa) as mediapromessa FROM QU_projects_promises"
If areavieW>0 Then SQL=SQL&" WHERE CO_p_area="&areavieW

Set rec1=connection.execute(SQL)
mediapromessa=rec1("mediapromessa")

mediapromessa_single=0
numsubstainer=0
SQL="SELECT DISTINCT ID FROM QU_projects_promises"
If areavieW>0 Then SQL=SQL&" WHERE CO_p_area="&areavieW
Set rec1=connection.execute(SQL)

'Do While Not rec1.eof 
'numsubstainer=numsubstainer+1
'SQL="SELECT AVG(IN_promessa) as totpromessa FROM QU_projects_promises WHERE ID="&rec1("ID")
'If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW

'Set rec2=connection.execute(SQL)
'mediapromessa_single=mediapromessa_single + rec2("totpromessa")
'Response.write numsubstainer&". "&rec2("totpromessa")&"<br/>"
'rec1.movenext
'loop
'Response.write mediapromessa_single
If totraccolto>0 And tot_subscribers>0  Then mediapromessa_single=totraccolto/tot_subscribers


SQL="SELECT DISTINCT SUM(IN_raccolto) as totarea1 FROM QU_projects WHERE LO_confirmed=True AND CO_p_category=1"
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
Set recarea=connection.execute(SQL)
totarea1=recarea("totarea1")

SQL="SELECT DISTINCT SUM(IN_raccolto) as totarea2 FROM QU_projects WHERE LO_confirmed=True AND CO_p_category=2"
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
Set recarea=connection.execute(SQL)
totarea2=recarea("totarea2")

SQL="SELECT DISTINCT SUM(IN_raccolto) as totarea3 FROM QU_projects WHERE LO_confirmed=True AND CO_p_category=3"
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
Set recarea=connection.execute(SQL)
totarea3=recarea("totarea3")


SQL="SELECT COUNT(*) as conta_100 FROM (SELECT ((IN_raccolto+IN_mezzi_propri)/IN_cifra*100) as perc_project FROM QU_projects WHERE LO_confirmed=True"
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
SQL=SQL&") WHERE perc_project>=100"
Set rec_perc=connection.execute(SQL)
conta_100=rec_perc("conta_100")


SQL="SELECT COUNT(*) as conta_75 FROM (SELECT ((IN_raccolto+IN_mezzi_propri)/IN_cifra*100) as perc_project FROM QU_projects WHERE LO_confirmed=True"
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
SQL=SQL&") WHERE perc_project>=75 AND perc_project<100"
Set rec_perc=connection.execute(SQL)
conta_75=rec_perc("conta_75")

SQL="SELECT COUNT(*) as conta_50 FROM (SELECT ((IN_raccolto+IN_mezzi_propri)/IN_cifra*100) as perc_project FROM QU_projects WHERE LO_confirmed=True"
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
SQL=SQL&") WHERE perc_project>=50 AND perc_project<75"
Set rec_perc=connection.execute(SQL)
conta_50=rec_perc("conta_50")

SQL="SELECT COUNT(*) as conta_25 FROM (SELECT ((IN_raccolto+IN_mezzi_propri)/IN_cifra*100) as perc_project FROM QU_projects WHERE LO_confirmed=True"
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
SQL=SQL&") WHERE perc_project>=25 AND perc_project<50"
Set rec_perc=connection.execute(SQL)
conta_25=rec_perc("conta_25")

SQL="SELECT COUNT(*) as conta_m25 FROM (SELECT ((IN_raccolto+IN_mezzi_propri)/IN_cifra*100) as perc_project FROM QU_projects WHERE LO_confirmed=True"
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
SQL=SQL&") WHERE perc_project<25"
Set rec_perc=connection.execute(SQL)
conta_m25=rec_perc("conta_m25")


If isnull(totarea1) Then totarea1=0
If isnull(totarea2) Then totarea2=0
If isnull(totarea3) Then totarea3=0
If totraccolto>0 then
doug1=Round(totarea1/totraccolto*100,1)
doug2=Round(totarea2/totraccolto*100,1)
doug3=Round(totarea3/totraccolto*100,1)
End if
If Len(doug1)>0 Then doug1=Replace(doug1,",",".")
If Len(doug2)>0 Then doug2=Replace(doug2,",",".")
If Len(doug3)>0 Then doug3=Replace(doug3,",",".")

doug100=Round(conta_100/totp*100,1)
doug75=Round(conta_75/totp*100,1)
doug50=Round(conta_50/totp*100,1)
doug25=Round(conta_25/totp*100,1)
dougm25=Round(conta_m25/totp*100,1)

If Len(doug100)>0 Then doug100=Replace(doug100,",",".")
If Len(doug75)>0 Then doug75=Replace(doug75,",",".")
If Len(doug50)>0 Then doug50=Replace(doug50,",",".")
If Len(doug25)>0 Then doug25=Replace(doug25,",",".")
If Len(dougm25)>0 Then dougm25=Replace(dougm25,",",".")

mediaproject=0
If isnull(totp)=False Then mediaproject=Round(totraccolto/totp)

If isnull(mediapromessa)=False Then mediapromessa=Round(mediapromessa,1)

%>
<p style="padding:8px 0px;margin:0px;font-size:12px; line-height:18px;"><b><%=totp%></b> progetti<br/><b><%=totpr%></b> realizzati<br/><b><%=tot_subscribers%></b> sostenitori<br/><br/></p>
<div style="float:left;clear:left; width:400px;font-size:12px;">Raccolti in totale: <div style="float:right; width:120px;">Fr. <b><%=totraccolto%></b></div></div>
<div style="float:left;clear:left; width:400px;font-size:12px;">Media per progetto: <div style="float:right; width:120px;">Fr. <b><%=mediaproject%></b></div></div>
<div style="float:left;clear:left; width:400px;font-size:12px;">Ultimo mese: <div style="float:right; width:120px;">Fr. <b><%=totraccolto_mese%></b> (<%=trendMonth%>)</div></div>
<div style="float:left;clear:left; width:400px;font-size:12px;">Ultima settimana <div style="float:right; width:120px;">Fr. <b><%=totraccolto_week%></b> (<%=trendWeek%>)</div></div>
<div style="float:left;clear:left;"><p></p></div>
<div style="float:left;clear:left; width:400px;font-size:12px;">Media singola promessa di finanziamento: <div style="float:right; width:120px;">Fr. <b><%=mediapromessa%></b></div></div>
<div style="float:left;clear:left; width:400px;font-size:12px;">Promessa media per sostenitore:  <div style="float:right; width:120px;">Fr. <b><%=Round(mediapromessa_single,1)%></b></div></div>
<div style="float:left;clear:left;"><p></p></div>
<div style="float:left;clear:left; width:400px;font-size:12px;"><b>Finanziamenti raccolti per area</b></div>
<%If Len(totarea1)>0 Then%><div style="float:left;clear:left; width:400px;font-size:12px;color:#f0af10"><b>Sosteniamo</b>:  <div style="float:right; width:120px;color:#333">Fr. <b><%=Round(totarea1,1)%></b> (<%=doug1%>%)</div></div><%End if%>
<%If Len(totarea2)>0 Then%><div style="float:left;clear:left; width:400px;font-size:12px;color:#e43d46"><b>Doniamo</b>  <div style="float:right; width:120px;color:#333">Fr. <b><%=Round(totarea2,1)%></b> (<%=doug2%>%)</div></div><%End if%>
<%If Len(totarea3)>0 Then%><div style="float:left;clear:left; width:400px;font-size:12px;color:#1eb0be"><b>Finanziamo</b>  <div style="float:right; width:120px;color:#333">Fr. <b><%=Round(totarea3,1)%></b> (<%=doug3%>%)</div></div><%End if%>
<div style="float:right; margin-top:-55px;margin-right:110px;"><canvas id="canvas" width="96" height="96"></canvas></div>

<div style="float:left;clear:left;margin:10px 0px"><p></p></div>
<div style="float:left;clear:left; width:400px;font-size:12px;"><b>Status progetti</b></div>
<div style="float:left;clear:left; width:400px;font-size:12px;"><div style="float:left; width:10px; height:10px; border-radius:10px; background:#05b558; margin:2px 10px 2px 0px;"></div>>= 100%  <div style="float:right; width:120px;"><b><%=conta_100%></b> (<%=doug100%>%)</div></div>
<div style="float:left;clear:left; width:400px;font-size:12px;"><div style="float:left; width:10px; height:10px; border-radius:10px; background: #98de4d; margin:2px 10px 2px 0px;"></div>>= 75%  <div style="float:right; width:120px;"><b><%=conta_75%></b> (<%=doug75%>%)</div></div>
<div style="float:left;clear:left; width:400px;font-size:12px;"><div style="float:left; width:10px; height:10px; border-radius:10px; background: #f0af10; margin:2px 10px 2px 0px;"></div>>= 50%  <div style="float:right; width:120px;"><b><%=conta_50%></b> (<%=doug50%>%)</div></div>
<div style="float:left;clear:left; width:400px;font-size:12px;"><div style="float:left; width:10px; height:10px; border-radius:10px; background: #e43d46; margin:2px 10px 2px 0px;"></div>>= 25%  <div style="float:right; width:120px;"><b><%=conta_25%></b> (<%=doug25%>%)</div></div>
<div style="float:left;clear:left; width:400px;font-size:12px;"><div style="float:left; width:10px; height:10px; border-radius:10px; background: #9ba1b3; margin:2px 10px 2px 0px;"></div>< 25%  <div style="float:right; width:120px;"><b><%=conta_m25%></b> (<%=dougm25%>%)</div></div>
<div style="float:right; margin-top:-65px;margin-right:110px;"><canvas id="canvas1" width="96" height="96"></canvas></div>


<%
Set recloc =CreateObject("ADODB.RecordSet")
recloc.Fields.Append "TA_cap", adVarChar, 200
recloc.Fields.Append "TA_citta", adVarChar, 200
recloc.Fields.Append "IN_raccolto", adInteger
recloc.Open


SQL="SELECT DISTINCT QU_projects_promises.TA_cap AS cap FROM QU_projects_promises WHERE CO_p_projects>0"
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW

Set recL=connection.execute(SQL)

numgroups=0
Session("c_00")=0

For x=5 To 9
Session("c_6"&x)=0
Next

Do while Not recL.eof
TA_cap=recL("cap")
'TA_citta=recL("TA_citta")
SQL="SELECT SUM(QU_projects_promises.IN_promessa) as promessaL FROM QU_projects_promises WHERE TA_cap='"&TA_cap&"'"
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW

Set recL1=connection.execute(SQL)
promessaL=recL1("promessaL")

'If TA_cap="6900" Then SQL="SELECT SUM(QU_projects_promises.IN_promessa) as promessaL FROM QU_projects_promises WHERE TA_citta='Lugano' AND Mid(TA_cap,1,3)='690'"
adCap=TA_cap
If Len(adCap)>0 And isnumeric(adCap) then
If Mid(TA_cap,1,2)="65" Then 
adCap="65"
TA_cap=CInt(TA_cap)

	If TA_cap>=6571 And TA_cap<=6582 Then
	adCap="66"
	elseIf TA_cap>=6594 And TA_cap<=6598 Then
	adCap="66"
	Else
	adCap="65"
	End If
	
elseIf Mid(TA_cap,1,2)="66" Then 
adCap="66"
ElseIf Mid(TA_cap,1,2)="69" Then 
adCap="69"
elseIf Mid(TA_cap,1,2)="67" Then 
adCap="65"
elseif Mid(TA_cap,1,2)="68" Then 
TA_cap=CInt(TA_cap)
	If TA_cap>=6800 And TA_cap<=6815 Then
	adCap="69"
	Else
	adCap="68"
	End if
Else
adCap="00"
End If
Else
adCap="00"
End if

'If Len(adCap)=2 Then
Session("c_"&adCap)=Session("c_"&adCap)+promessaL
promessaL=Session("c_"&adCap)
'End if

recloc.AddNew
recloc.Fields("TA_cap").Value = adCap
recloc.Fields("TA_citta").Value = TA_citta
recloc.Fields("IN_raccolto").Value = promessaL
recloc.Update

recL.movenext
loop

recloc.sort = "IN_raccolto " & " DESC"
If Not recloc.eof Then recloc.MoveFirst

%>
<div style="float:left;clear:left;margin:10px 0px"><p></p></div>
<div style="float:left;clear:left; width:400px;font-size:12px;"><b>Provenienza finanziamenti</b></div>
<%
xx=0
totprov=0
adWrites=","
Do While Not recloc.eof

loc1=recloc("TA_cap")
adLoc="Altro (Fuori cantone)"
If loc1="65" Then adloc="Bellinzonese"
If loc1="66" Then adloc="Locarnese"
If loc1="67" Then adloc="Leventinese"
If loc1="68" Then adloc="Mendrisiotto"
If loc1="69" Then adloc="Luganese"

If InStr(adWrites,","&loc1&",")=0 then
xx=xx+1

conta_loc_1=recloc("IN_raccolto")
totprov=totprov+conta_loc_1
doug_loc_1=Round(conta_loc_1/totraccolto*100,1)

adWrites=adWrites&loc1&","

%>
<div style="float:left;clear:left; width:400px;font-size:12px;"><%=adloc%><div style="float:right; width:120px;">Fr. <b><%=conta_loc_1%></b> (<%=doug_loc_1%>%)</div></div>

<%
End if

recloc.movenext
Loop
If totprov<totraccolto Then
diffprov=totraccolto-totprov
doug_loc_alt=Round(diffprov/totraccolto*100,1)
%>
<div style="float:left;clear:left; width:400px;font-size:12px;">Altro<div style="float:right; width:120px;">Fr. <b><%=diffprov%></b> (<%=doug_loc_alt%>%)</div></div>
<%
End if
%>

<%
Set recloc =CreateObject("ADODB.RecordSet")
recloc.Fields.Append "TA_fascia", adVarChar, 200
recloc.Fields.Append "IN_raccolto", adInteger
recloc.Open

fascie="18-24,25-34,35-44,45-54,55-64,65-110"
fascie=Split(fascie,",")

For zz=0 To UBound(fascie)
fascia=fascie(zz)
anniget=Split(fascia,"-")

SQL="SELECT SUM(QU_projects_promises.IN_promessa) as promessaL FROM QU_projects_promises INNER JOIN registeredusers ON QU_projects_promises.CO_registeredusers=registeredusers.ID WHERE DateDiff('yyyy',registeredusers.DT_data_nascita,Now())>="&anniget(0)&" AND DateDiff('yyyy',registeredusers.DT_data_nascita,Now())<="&anniget(1)
If areavieW>0 Then SQL=SQL&" AND QU_projects_promises.CO_p_area="&areavieW

Set recL1=connection.execute(SQL)
promessaL=recL1("promessaL")
If isnull(promessaL) Then promessaL=0
recloc.AddNew
recloc.Fields("TA_fascia").Value = fascia
recloc.Fields("IN_raccolto").Value = promessaL
recloc.Update
Next

recloc.sort = "IN_raccolto " & " DESC"
If Not recloc.eof Then 
recloc.MoveFirst

%>
<div style="float:left;clear:left;margin:10px 0px"><p></p></div>
<div style="float:left;clear:left; width:400px;font-size:12px;"><b>Finanziamenti per fascia d'età finanziatori</b></div>
<%
xx=0
totprov=0
adWrites=","
Do While Not recloc.eof

loc1=recloc("TA_fascia")
xx=xx+1

conta_loc_1=recloc("IN_raccolto")
totprov=totprov+conta_loc_1
If totraccolto>0 Then doug_loc_1=Round(conta_loc_1/totraccolto*100,1)
If loc1="65-110" Then loc1="> 64"
adWrites=adWrites&loc1&","

%>
<div style="float:left;clear:left; width:400px;font-size:12px;"><%=loc1%><div style="float:right; width:120px;">Fr. <b><%=conta_loc_1%></b> (<%=doug_loc_1%>%)</div></div>

<%

recloc.movenext
Loop
If totprov<totraccolto Then
diffprov=totraccolto-totprov
doug_loc_alt=Round(diffprov/totraccolto*100,1)
%>
<div style="float:left;clear:left; width:400px;font-size:12px;">Non definito<div style="float:right; width:120px;">Fr. <b><%=diffprov%></b> (<%=doug_loc_alt%>%)</div></div>
<%
End If
End if
%>


<div style="float:left;clear:left;margin:5px 0px"><p></p></div>

<div style="float:left;clear:left;margin:5px 0px; width:580px;"><p style="font-size:12px"><b>Promesse : migliori 10</b> <a href="projects_stats.asp?vTemap=all&parea=<%=areavieW%>">in corso</a> - <a href="projects_stats.asp?vTemap=30&parea=<%=areavieW%>">ultimo mese</a> - <a href="projects_stats.asp?vTemap=7&parea=<%=areavieW%>">ultimi 7 giorni</a></p>
<%
Dim rectop
Set rectop =CreateObject("ADODB.RecordSet")
rectop.Fields.Append "TA_nome", adVarChar, 200
rectop.Fields.Append "TA_color", adVarChar, 200
rectop.Fields.Append "ID", adInteger
rectop.Fields.Append "IN_viewed", adInteger
rectop.Fields.Append "IN_raccolto", adInteger
rectop.Fields.Append "rating", adInteger
rectop.Fields.Append "status", adInteger
rectop.Open

vTemap=request("vTemap")
If Len(vTemap)>0 Then session("viewlastW")=vTemap
If Len(session("viewlastW"))=0 Then session("viewlastW")="all"

If session("viewlastW")="7" Then addTemp=" AND DateDiff(""d"",[DT_data],Now())<=7"
If session("viewlastW")="30" Then addTemp=" AND DateDiff(""d"",[DT_data],Now())<=30"
If session("viewlastW")="all" Then addTemp=""

SQL="SELECT DISTINCT CO_p_projects FROM QU_projects_promises WHERE CO_p_projects>0"&addTemp
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW

Set rec1=connection.execute(SQL)
Do While Not rec1.eof 
refp=rec1("CO_p_projects")

SQL="SELECT SUM(IN_promessa) as promesso FROM QU_projects_promises WHERE CO_p_projects>0"&addTemp&" AND CO_p_projects="&refp
Set rec2=connection.execute(SQL)
IN_promessa=rec2("promesso")

SQL="SELECT *,Round(IN_rated/IN_votes) as rating, Round((IN_raccolto+IN_mezzi_propri)/IN_cifra*100) as status FROM QU_projects WHERE LO_aperto=True AND LO_confirmed=True AND ID="&refp
Set rec2=connection.execute(SQL)
If Not rec2.eof Then
TA_nome=rec2("TA_nome")
TA_color=rec2("TA_color")
IN_viewed=rec2("IN_viewed")
status=rec2("status")
rating=rec2("rating")

rectop.AddNew
rectop.Fields("ID").Value = refp
rectop.Fields("TA_nome").Value = TA_nome
rectop.Fields("TA_color").Value = TA_color
rectop.Fields("IN_raccolto").Value = IN_promessa
rectop.Fields("IN_viewed").Value = IN_viewed
rectop.Fields("status").Value = status
rectop.Fields("rating").Value = rating
rectop.Update
End If

rec1.movenext
Loop


If Not rectop.eof Then
rectop.sort = "IN_raccolto " & " DESC"
rectop.MoveFirst
End if
%>

<!--#INCLUDE VIRTUAL="./ADMIN/projects_stat1.asp"-->

</div>



<div style="float:left;clear:left;margin:5px 0px; width:580px;"><p style="font-size:12px"><b>In scadenza </p>
<%
SQL="SELECT QU_projects.*, Round(IN_rated/IN_votes) as rating, Round((IN_raccolto+IN_mezzi_propri)/IN_cifra*100) as status FROM QU_projects WHERE DateDiff('d',DT_termine,Now())<=0 AND IN_viewed>0 AND LO_confirmed=True "
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
SQL=SQL&" ORDER BY DT_termine ASC"
Set rectop=connection.execute(SQL)

gtMode=0
modeview="temp"
%>

<!--#INCLUDE VIRTUAL="./ADMIN/projects_stat.asp"-->

</div>

<div style="float:left;clear:left;margin:5px 0px; width:580px;"><p style="font-size:12px"><b>I più visitati</b> (in corso)</p>
<%
SQL="SELECT QU_projects.*, Round(IN_rated/IN_votes) as rating, Round((IN_raccolto+IN_mezzi_propri)/IN_cifra*100) as status FROM QU_projects WHERE DateDiff('d',DT_termine,Now())<=0 AND IN_viewed>0 AND LO_confirmed=True "
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
SQL=SQL&" ORDER BY IN_viewed DESC"
Set rectop=connection.execute(SQL)

gtMode=0
modeview="normal"
%>

<!--#INCLUDE VIRTUAL="./ADMIN/projects_stat.asp"-->

</div>



<div style="float:left;clear:left;margin:5px 0px; width:580px;"><p style="font-size:12px"><b>I più votati</b> (in corso)</p>

<%
SQL="SELECT QU_projects.*, Round(IN_rated/IN_votes) as rating, Round((IN_raccolto+IN_mezzi_propri)/IN_cifra*100) as status FROM QU_projects WHERE DateDiff('d',DT_termine,Now())<=0 AND IN_viewed>0 AND LO_confirmed=True "
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
SQL=SQL&" ORDER BY IN_votes DESC"
Set rectop=connection.execute(SQL)
%>

<!--#INCLUDE VIRTUAL="./ADMIN/projects_stat.asp"-->

</div>

<div style="float:left;clear:left;margin:5px 0px; width:580px;"><p style="font-size:12px"><b>I più visitati</b> (tutti)</p>
<%
SQL="SELECT QU_projects.*, Round(IN_rated/IN_votes) as rating, Round((IN_raccolto+IN_mezzi_propri)/IN_cifra*100) as status FROM QU_projects WHERE IN_viewed>0 AND LO_confirmed=True "
If areavieW>0 Then SQL=SQL&" AND CO_p_area="&areavieW
SQL=SQL&" ORDER BY IN_viewed DESC"
Set rectop=connection.execute(SQL)
%>

<!--#INCLUDE VIRTUAL="./ADMIN/projects_stat.asp"-->

</div>

<input type="button" value="Stampa statistiche" onclick="self.print()" style="position:absolute; right:10px; top:10px"/>
<input type="button" value="Dati sostenitori" onclick="document.location='projects_promoters_extract.asp'" style="position:absolute; right:150px; top:10px"/>

<script src="/js/Chart.min.js"></script>
<script>
$(document).ready(function() {
var optionsDoug = { percentageInnerCutout : 1, segmentStrokeWidth : 1, segmentShowStroke : true };
var doughnutData = [ {	value: <%=doug1%>, color:"#f0af10" },{	value: <%=doug2%>, color:"#e43d46" },	{value: <%=doug3%>, color:"#1eb0be"	}];
var myDoughnut = new Chart(document.getElementById("canvas").getContext("2d")).Doughnut(doughnutData,optionsDoug);

var optionsDoug1 = { percentageInnerCutout : 1, segmentStrokeWidth : 1, segmentShowStroke : true };
var doughnutData1 = [ {	value: <%=doug100%>, color:"#05b558" },{	value: <%=doug75%>, color:"#98de4d" },	{value: <%=doug50%>, color:"#f0af10"	},	{value: <%=doug25%>, color:"#e43d46"	} ,	{value: <%=dougm25%>, color:"#9ba1b3"	}];
var myDoughnut1 = new Chart(document.getElementById("canvas1").getContext("2d")).Doughnut(doughnutData1,optionsDoug1);
})


</script>
</body>
</html>
<%
connection.close
response.End%>