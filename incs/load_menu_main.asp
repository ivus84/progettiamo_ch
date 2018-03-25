
<%
SQL="SELECT ID, DT_data, newsection.TA_nome"&Session("reflang")&" as TA_nome,newsection.TA_linkto"&Session("reflang")&" as TA_linkto,LO_news,LO_networking,newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica,newsection.LO_contact_page, LO_homepage,LO_menu2, LO_commerce,LO_protected FROM newsection WHERE LO_homepage=false AND LO_hidemainmenu=False AND LO_deleted=False AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY IN_ordine"
if Session("log45"&numproject)<>"req895620schilzej" THEN SQL=Replace(SQL,"WHERE","WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND")
Set record1 = Server.CreateObject("ADODB.Recordset")
record1.Open SQL, Connection, adOpenStatic, adLockReadOnly
totsub=record1.RecordCount
%>
<div id="mainmenu_set">
<ul class="mainMenu"><li class="homeli"><img src="/images/ico_home.png" alt="homepage" onclick="document.location='/'" class="homeico"/></li><%
do While Not record1.eof
	hn1=hn1+1
	ref=record1("ID")
	nomelink=htmldecode(record1("TA_nome"))
	glink=record1("TA_linkto")
	ddata=record1("DT_data")
	hidesubm=record1("LO_contact_page")
	LO_protected=record1("LO_protected")
	news_subscribe=record1("LO_commerce")
	singleMenu=record1("LO_networking")
	LO_menu2=record1("LO_menu2")
    If Len(glink)=0 Then glink=nomelink
    nomelink=linkMaker(glink)

    refup=ref

    mlink="/"&ref&"/"&nomelink&"/"
    mlink="/?"&ref&"/"&nomelink
    mlinkorig=mlink

    addst=""
    If ref&""=session("pagina1") OR ref&""=isupsection&"" Then 
        addst=" innerCurrent"
        addscript=addscript&"makeSub("&ref&",1)"&Chr(10)
    End if
    If LO_menu2 Then
        bmmenu=bmmenu&" <li class=""elMen"&addst&""" id=""m_"&ref&"""><a href=""/getPageFooter.asp?load="&ref&""">"&glink&"</a></li>"&Chr(10)
    Else
        mmenu=mmenu&" <li class=""elMen"&addst&""" id=""m_"&ref&"""><a href="""&mlinkorig&""">"&ConvertFromUTF8(glink)&"</a></li>"&Chr(10)
    End If

    addst=""
    record1.movenext
Loop

Response.write mmenu
%></ul>
<%
search="Cerca"
search_1="Search"
search_2="Süche"
search_3="Rechercer"
search_4="Buscar"

search=Eval("search"&Session("reflang"))
If Len(stringSearch)>0 Then search=stringSearch
%>
</div>



