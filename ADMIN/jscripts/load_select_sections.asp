<%
response.AddHeader "PRAGMA", "CACHE" 
response.contentType="text/plain"

ref=request("ref")
maxlevels=request("maxlevels")
mode=request("mode")


If Len(session("listad"&ref&maxlevels&mode))=0 Or datediff("n",session("listadtime"),Now())>1 Then

%>
	<!--#INCLUDE VIRTUAL="./config/dbconfig.asp"-->
<%
function reptext(testo)
if len(testo)>0 then
testo=replace(testo,"&#45;","-")
testo=replace(testo,"&#40;","(")
testo=replace(testo,"&#41;",")")
testo=replace(testo,"&#39;","'")
testo=replace(testo,",","")
end if
reptext=testo
end function

Set Connection=Server.CreateObject("ADODB.Connection")
Connection.Open "PROVIDER=Microsoft.Jet.OLEDB.4.0;" & "Data Source=" & dbpath & ";"


maxlevels=5
if len(ref)=0 then ref=0
if isloadedselect<>True then
SQL00="SELECT * FROM limita_contenuti WHERE CO_utenticantieri="&Session("IDuser")
set recordset00=connection.execute(SQL00)
if recordset00.eof then
SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica, newsection.LO_networking as scelti,newsection.LO_news,newsection.LO_menu2 FROM newsection WHERE ID<>"&ref&" AND LO_deleted=False AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
else
SQL="SELECT DISTINCT newsection.ID AS ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica, newsection.LO_networking as scelti,newsection.LO_news,newsection.LO_menu2 FROM limita_contenuti INNER JOIN newsection ON limita_contenuti.CO_oggetti = newsection.ID WHERE newsection.LO_deleted=False AND limita_contenuti.CO_utenticantieri="&Session("IDuser")
end if

if mode="unpublished" then SQL=Replace(SQL," newsection.LO_pubblica"&Session("reflang")&"=True AND","") 
set recordset5=connection.execute(SQL)
end if


col1="EFEFEF"

do while not recordset5.eof
IDr=recordset5("ID")
nome=recordset5("TA_nome")
    nome = convertfromutf8( nome )
LO_news=recordset5("LO_news")
LO_menu2=recordset5("LO_menu2")
scelti=recordset5("scelti")
if IsNull(nome)=True then nome="No name"
nome=ClearHTMLTags(nome, 0)
nome=reptext(nome)

addList=addlist& IDr&","&nome&",0#"

	if maxlevels>1 And LO_news=False And LO_menu2=False AND scelti=False then

SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica, newsection.LO_news AS news,newsection.LO_networking as scelti,newsection.LO_menu2 FROM newsection WHERE ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
If LO_news=True Then   SQL=Replace(SQL,"ORDER BY","ORDER BY newsection.DT_data DESC, ")
if mode="unpublished" then SQL=Replace(SQL,"newsection.LO_pubblica"&Session("reflang")&"=True AND","") 
set recordset6=connection.execute(SQL)

do while not recordset6.eof
IDr1=recordset6("ID")
nome=recordset6("TA_nome")
if IsNull(nome)=True then nome="No name"
nome=ClearHTMLTags(nome, 0)
nome=reptext(nome)
news=recordset6("news")
LO_menu2=recordset6("LO_menu2")
scelti=recordset6("scelti")

addList=addlist& IDr1&","&nome&",1#"


if maxlevels>2 And news=False And LO_menu2=False AND scelti=False then

	SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr1&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
	if mode="unpublished" then SQL=Replace(SQL," newsection.LO_pubblica"&Session("reflang")&"=True AND","") 
set recordset7=connection.execute(SQL)

	do while not recordset7.eof
	IDr2=recordset7("ID")
	nome=recordset7("TA_nome")
	if IsNull(nome)=True then nome="No name"
	nome=ClearHTMLTags(nome, 0)
	nome=reptext(nome)

addList=addlist& IDr2&","&nome&",2#"

if maxlevels>3 then
SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr2&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
			if mode="unpublished" then SQL=Replace(SQL," newsection.LO_pubblica"&Session("reflang")&"=True AND","") 
set recordset8=connection.execute(SQL)

		do while not recordset8.eof
		IDr3=recordset8("ID")
		nome=recordset8("TA_nome")
		if IsNull(nome)=True then nome="No name"
		nome=ClearHTMLTags(nome, 0)
		nome=reptext(nome)

addList= addlist & IDr3&","&nome&",3#"

			if maxlevels>4 then
			SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr3&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
				if mode="unpublished" then SQL=Replace(SQL," newsection.LO_pubblica"&Session("reflang")&"=True AND","") 
set recordset9=connection.execute(SQL)

			do while not recordset9.eof
			IDr4=recordset9("ID")
			nome=recordset9("TA_nome")
			if IsNull(nome)=True then nome="No name"
			nome=ClearHTMLTags(nome, 0)
			nome=reptext(nome)

addList = addlist & IDr4&","&nome&",4#"


			recordset9.movenext
			loop
			end if

		recordset8.movenext
		loop
		end if
	recordset7.movenext
	loop
	end if
recordset6.movenext
loop
end if
recordset5.movenext
loop
recordset5.movefirst
isloadedselect=True

addList=mid(addList,1,len(addList)-1)
session("listad"&ref&maxlevels&mode)=addList
session("listadtime")=now()
End If

response.write session("listad"&ref&maxlevels&mode)
%>