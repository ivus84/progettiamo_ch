<div class="pContainer" style="margin-bottom:60px; clear:both">
	<div class="pText" style="min-height:140px; ">
	<h1 class="titolo" style="background: #292f3a; padding:10px 0px"><span style="padding:10px"><%=str_miei_progetti%></span></h1>
	<div class="myprojectsList">
	<%

If Session("islogged"&numproject)="hdzufzztKJ89ei" And  Session("projects_promoter")=True Then
SQL="SELECT * FROM QU_projects WHERE CO_registeredusers="&Session("logged_donator")&" ORDER BY LO_confirmed DESC, DT_apertura DESC"
Set rec=connection.execute(SQL)

If rec.eof Then
Response.write "<p style=""padding:10px; "">Non hai ancora inserito nessun progetto<br/><br/>&gt; <a href=""/actions/project_add.asp"" style=""color:#9ba1b3;"">Aggiungi un progetto</a></p>"
End if
Do while Not rec.eof
		imgb1=rec("AT_banner")
		imgb=rec("AT_main_img")
		If Len(imgb)=0 OR isnull(imgb) Then imgb=imgb1
realizzato=rec("LO_realizzato")
titolo=rec("TA_nome")
category=rec("category")
colore=rec("TA_color")
luogo=rec("TA_luogo")
nazione=rec("TA_nazione")
aperto=rec("LO_aperto")
realizzato=rec("LO_realizzato")
rated=rec("IN_rated")
votes=rec("IN_votes")
confirmed=rec("LO_confirmed")
toconfirmed=rec("LO_toconfirmed")
rejected=rec("LO_rejected")
deleted=rec("LO_deleted")
txrejected=rec("TX_reject_reason")
complete=rec("LO_complete")
viewed=rec("IN_viewed")
favorites=rec("IN_favorite")
termine=rec("DT_termine")
refProject=rec("ID")
cifra=rec("IN_cifra")
mezzi=rec("IN_mezzi_propri")
raccolto=rec("IN_raccolto")
raccolto=raccolto+mezzi

pText=rec("TE_abstract")
If isnull(colore) Then colore="#9ba1b3"
diffdays=dateDiff("d",Now(),termine)*-1


		If Len(imgb)>0 Then 
		imgb="/"&imgscript&"?path="&imgb&"$460"
		Else
		imgb="/images/thumb_picture1.png"
		End If

If Len(pText)>0 Then pText="<br/>"&ClearHTMLTags(pText,0)
If Len(pText)>100 Then pText=truncateTxt(pText,100)&" ..."

status=""
If cifra>0 Then status=Round(raccolto/cifra*100,0)&"%<br/>"

addVotes=""
rating=0
If votes>0 Then rating=Round(rated/votes,1)
svotes=rating
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


If Len(termine)>0 Then termine= datevalue(termine)

promised=setCifra(raccolto)
obiettivo=setCifra(cifra)

SQL="SELECT COUNT(ID) as updates FROM p_description WHERE TA_type='update' AND LO_confirmed=True AND CO_p_projects="&refProject
Set rec1=connection.execute(SQL)
updates=rec1("updates")

SQL="SELECT COUNT(ID) as comments FROM QU_comments WHERE refproject="&refProject
Set rec1=connection.execute(SQL)
comments=rec1("comments")

plink=linkMaker(titolo)


editLink="/?progetti/"&refProject&"/"&plink
If deleted Then editLink="#"
	%>
<div class="p_list"> <div class="bg" style="background:<%=colore%>"></div><div class="pic" data-href="<%=imgb%>" onclick="document.location='<%=editLink%>'" style="background-color:<%=colore%>; background-image:url(/images/thumb_picture1.png);"></div>

<div class="text" onclick="document.location='<%=editLink%>'">

<p style="width:90%; height:90px; overflow:hidden"><b><%=titolo%></b><br/><%=luogo%>&nbsp;<%=nazione%></p>

<p style="margin:10px 0px">
<strong>Cifra obiettivo:</strong> <span style="padding-left:3px">Fr. <%=obiettivo%></span> <br/>
<strong>Cifra raccolta:</strong> <span style="padding-left:10px">Fr. <%=promised%></span><br/>
Visitatori: <span style="padding-left:51px"><%=viewed%></span><br/><br/>
<%
If realizzato Then 
Response.write "realizzato"
	If Not aperto Then Response.write " - chiuso"
else
If Not confirmed Then
	If Not toconfirmed And Not deleted Then 
	If complete Then Response.write "da inviare per approvazione"
	If Not complete And Not rejected Then Response.write "scheda da completare"
		If rejected Then 
If Len(txrejected)>0 Then txrejected=Replace(txrejected,"'","\'")
		Response.write "Pubblicazione <strong>non convalidata</strong>"
		If Len(txrejected)>0 Then Response.write "<br/><span onmouseover=""viewReason('"&txrejected&"',$(this))"" style=""text-decoration:underline"">leggi motivazione</span>"
		End if
	Else
	If Not deleted Then Response.write "in attesa di approvazione"
	If deleted Then Response.write "crowdfunding annullato"
	End If
else
	If aperto Then Response.write "aperto"
	If Not aperto Then Response.write "chiuso"
End If
End If
%>

</p>

</div>
<div class="boxes" style="background:<%=colore%>">

<div class="box" style="background-image:url(/images/ico_rating.png); background-position:center 6px; padding-top:5px; line-height:13px;">
<%=addVotes%>
</div>

<div class="box">
<span style="float:left;width:100%;font-size:14px; margin-top:-1px;"><%
If aperto Or Not confirmed Then 
diffdays=diffdays*-1
If diffdays>0 then
If diffdays<=60 Then Response.write "<b>"&diffdays&"</b><br/>giorni"
If diffdays>60 Then Response.write "<b>"&CInt(diffdays/30)&"</b><br/>mesi"
End if
End if
%></span>
</div>

<div class="box">
<span style="line-height:31px; font-size:14px"><b><%=status%></b></span>
</div>

<div class="box" style="color:#fff; overflow:hidden; background-image: url(/images/favorite_on.png); background-repeat:no-repeat; background-position: 6px 6px">
<span style="line-height:31px; font-size:12px; color:<%=colore%>; font-weight:bold"><%=favorites%></span>
</div>
<div class="box">
<img class="dn" src="/images/ico_donate_small.png" style="opacity:0.5; cursor:default; margin-top:-3px"/>
</div>

<div class="box" style="clear:left; width: 230px; margin-left:-1px; margin-top:-3px; background:#9ba1b3;font-size:14px; color:#fff">
<%If (aperto OR confirmed) Then%>
<span class="myp" style="width:110px; border-right:solid 1px #fff">
<a href="javascript:void(0)"  onclick="document.location='/?progetti/<%=refProject%>/<%=plink%>/addnews/'">Gestire News (<%=updates%>)</a></span>
<span class="myp" style="width:98px;"><a class="vote" href="/getCommentsEdit.asp?load=<%=refProject%>&amp;pname=<%=titolo%>">Commenti (<%=comments%>)</a></span>
</span>
<%End if%>

<%If Not confirmed Then%>
<%If Not toconfirmed Then%>

<span class="myp" style="width:105px; border-right:solid 1px #fff"><a href="javascript:void(0)" onclick="if(confirm('Eliminare il progetto?')) document.location='/actions/project_del.asp?load=<%=refproject%>'">Elimina</a></span>
<%If Not deleted Then%>
<span class="myp" style="width:103px;"><a href="javascript:void(0)" onclick="document.location='<%=editLink%>'">Modifica</a></span>
<%End if%>

<%Else
If Not deleted  then%>
<span class="myp" style="width:100%"><a style="color:#2a2e39">In attesa di approvazione</a></span>
<%End if%>
<%End if%>
<%End if%>
</div>

</div>


</div>


<%
rec.movenext
loop
%>
	<p style="clear:left; margin:20px 10px; font-size:14px;">&gt; <a href="/download/progettiamo_guida_promotori_web.pdf" target="_blank" style="color:#9ba1b3; font-size:14px;">Scarica la guida all'inserimento dei progetti</a> (pdf, 230 KB)</p>

</div>
<%
Else
If Session("islogged"&numproject)<>"hdzufzztKJ89ei" Then Response.redirect(pagelog)
End if%>

</div></div>