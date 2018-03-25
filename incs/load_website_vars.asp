<%
    
SQL="SELECT * FROM oggetti WHERE LO_pubblica"&Session("reflang")&"=False AND Len(TA_duedate)>0"
	Set recD=connection.execute(SQL)
	Do While Not recD.eof
	refDate=recD("TA_duedate")
	refPage=recD("ID")
	If isdate(refDate) Then
	diffdate=DateDiff("n",CDate(refdate),Now())
	If diffdate>=0 Then
	SQL="UPDATE oggetti SET LO_pubblica"&Session("reflang")&"=True, TA_duedate='' WHERE ID="&refPage
	Set recD1=connection.execute(SQL)
	End if
	End if
	recD.movenext
	loop


	SQL="SELECT * FROM QU_config"
	set recordset=connection.execute(SQL)

	LO_pubbl=recordset("LO_pubblica")

		if not recordset.eof Then

		LO_pubbl=recordset("LO_pubblica")
		if LO_pubbl=true then Session("online"&numproject)="ok1"

		
		Session("autoredirect"&numproject)=recordset("LO_auto_redirect")
		Session("newssection"&numproject)=recordset("LO_news_section")
		Session("viewsubmenulist"&numproject)=recordset("LO_submenu_onpage")
		Session("viewsubmenulisthide1stlevel"&numproject)=True
		Session("basedir")=recordset("TA_basedir")
		Session("basedir1")=recordset("TA_basedir1")
		Session("nomeprogetto")=ConvertFromUTF8(recordset("TA_nomeprogetto"))

		Session("favicon")=recordset("AT_favicon")
		Session("homebanner")=recordset("AT_logo")
        'link banner
        session("linkbanner") = recordset("CO_oggetti")
        'link banner
		Session("descriptiondsm3x")=recordset("TX_website_description")
		Session("headerscript")=recordset("TX_website_abstract")
		Session("keywordsdsm3x")=recordset("TX_website_keywords")
		'Session("descriptiondsm3x")=Replace(Session("descriptiondsm3x"),"&nbsp;&nbsp;"," ")
		
		If Len(Session("headerscript"))>0 Then Session("headerscript")=Replace(Session("abstractdsm3x"),"&nbsp;&nbsp;"," ")
		Session("nomeprogetto")=Replace(Session("nomeprogetto"),"&nbsp;"," ")
		
			If Len(Session("keywordsdsm3x"))>0 Then 
			Session("keywordsdsm3x")=Replace(Session("keywordsdsm3x"),"&nbsp;&nbsp;"," ")
			Session("keywordsdsm3x")=Replace(Session("keywordsdsm3x"),"<br />",CHR(10))
			Session("keywordsdsm3x")=Trim(Session("keywordsdsm3x"))
			End if
		end If

		set recordset=Nothing

	Session("browser")=Request.ServerVariables("HTTP_USER_AGENT")
	Session("proddir")=Session("basedir")
	if right(Session("proddir"),1)<>"/" then Session("proddir")=Session("proddir")&"/"
	if len(Session("langref"))=0 then Session("langref")="it"

if len(Session("headerscript"))>0 then 
scriptTxt=Session("headerscript")
scriptTxt=Replace(scriptTxt,Chr(34)&Chr(34),Chr(34))
scriptTxt=Replace(scriptTxt,"&#39;","'")
scriptTxt=Replace(scriptTxt,"<br />",Chr(10))
Session("headerscript") = scriptTxt
end if

%>