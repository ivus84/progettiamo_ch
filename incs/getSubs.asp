<!--#INCLUDE VIRTUAL="/incs/load_connection.asp"-->
<%

     Response.CharSet = "ISO-8859-1"
Response.CodePage = 28591
load=request("load")

addlinkd=""
SQL="SELECT ID, DT_data, AT_image,TX_embed, newsection.TA_nome"&Session("reflang")&" as TA_nome,newsection.TA_linkto"&Session("reflang")&" as TA_linkto, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE ID<>0 AND isnews=False AND LO_hidemainmenu=False AND (newsection.CO_oggetti="&load&") AND LO_deleted=False ORDER BY newsection.IN_ordine ASC, newsection.TA_nome"&Session("reflang")&" ASC, newsection.DT_data DESC"
if Session("log45"&numproject)<>"req895620schilzej" THEN SQL=Replace(SQL,"WHERE","WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND")

Set record=connection.execute(SQL)

	If Not record.eof then
	Do While Not record.eof

		ref=record("ID")
		nome=record("TA_nome")
        'nome = ConvertFromUTF8(nome)
   ' nome = mailString(nome)
		glink=record("TA_linkto")
	
	If Len(glink)=0 Then glink=nome

	nomelink=linkMaker(glink)
	nomelink="?"&ref&"/"&nomelink
	addlinkd=addlinkd&ref&"|"&convertfromutf8(glink)&"|"&nomelink&"$"
    

	record.movenext
	Loop
	
	If Len(addlinkd)>1 Then addlinkd=Mid(addlinkd,1,Len(addlinkd)-1)
	Response.write load&"#"&addlinkd

	End if
	connection.close

%>