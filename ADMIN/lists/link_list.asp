<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<%

Response.Expires = 0
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
response.contenttype="text/javascript"

addlinks=""
maxlevels=4

if len(ref)=0 then ref=0

SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica, newsection.LO_contact_page as scelti FROM newsection WHERE ID<>"&ref&" AND LO_deleted=False AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordset5=connection.execute(SQL)

do while not recordset5.eof
IDr=recordset5("ID")
nome=recordset5("TA_nome")
scelti=False


nomelink=linkMaker(nome)

nome=Replace(nome,"&#45;","")
nome=Replace(nome,Chr(34),"")

addlinks=addlinks&"["""&cata&nome&""",""/?"&IDr&"/"&nomelink&"""],"&CHR(10)

if limittosections<>True AND scelti<>True then

SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica, newsection.LO_news AS news FROM newsection WHERE ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordset6=connection.execute(SQL)

do while not recordset6.eof
IDr1=recordset6("ID")
nome=recordset6("TA_nome")
news=recordset6("news")
nomelink=linkMaker(nome)
nome=Replace(nome,"&#45;","")
nome=Replace(nome,Chr(34),"")
addlinks=addlinks&"[""- "&cata&nome&""",""/?"&IDr1&"/"&nomelink&"""],"&CHR(10)

if maxlevels>2 and news<>true and scelti<>true then

SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr1&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordset7=connection.execute(SQL)
do while not recordset7.eof
IDr2=recordset7("ID")
nome=recordset7("TA_nome")

nomelink=linkMaker(nome)
nome=Replace(nome,"&#45;","")
nome=Replace(nome,Chr(34),"")

addlinks=addlinks&"[""-- "&cata&nome&""",""/?"&IDr2&"/"&nomelink&"""],"&CHR(10)

if maxlevels>3 then
SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr2&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordset8=connection.execute(SQL)

do while not recordset8.eof
IDr3=recordset8("ID")
nome=recordset8("TA_nome")
nomelink=linkMaker(nome)
nome=Replace(nome,"&#45;","")
nome=Replace(nome,Chr(34),"")

addlinks=addlinks&"[""---"&cata&nome&""",""/?"&IDr3&"/"&nomelink&"""],"&CHR(10)

if maxlevels>4 then
SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr3&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordset9=connection.execute(SQL)

do while not recordset9.eof
IDr4=recordset9("ID")
nome=recordset9("TA_nome")

nomelink=linkMaker(nome)

nome=Replace(nome,"&#45;","")
nome=Replace(nome,Chr(34),"")
addlinks=addlinks&"[""---- "&cata&nome&""",""/?"&IDr4&"/"&nomelink&"""],"&CHR(10)
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


addfiles=""

SQL9="SELECT * FROM fails ORDER BY TA_titolo,ID,TA_nome DESC"
set recordset9=connection.execute(SQL9)

do while not recordset9.eof
ID=recordset9("ID")
titl=recordset9("TA_titolo")
If IsNull(titl)=False Then titr=Replace(recordset9("TA_titolo")," ","")

if Len(titr)=0 Or IsNull(titr) then
TA_titolo="Senza nome"
else
TA_titolo=Mid(recordset9("TA_titolo"), 1, 35)
end if

TA_nome=recordset9("TA_nome")

TA_titolo=TA_titolo&" "&Right(TA_nome,3)
TA_titolo=Replace(TA_titolo,"&#45;","")
TA_titolo=Replace(TA_titolo,Chr(34),"")
TA_titolo=Replace(TA_titolo,"   ","")
addfiles=addfiles&"[""F> "&TA_titolo&""",""../download.asp?nome="&TA_nome&"""],"&CHR(10)

recordset9.movenext
Loop

addprojects=""

SQL9="SELECT * FROM QU_projects WHERE LO_confirmed AND (LO_aperto OR fondi_raccolti>=IN_cifra) ORDER BY TA_nome ASC"
set recordset9=connection.execute(SQL9)

do while not recordset9.eof
ID=recordset9("ID")
titl=recordset9("TA_nome")
If IsNull(titl)=False Then titl=Replace(titl,"'","")
If IsNull(titl)=False Then titl=Replace(titl,"#"," ")
linkp=linkmaker(titl)

addprojects=addprojects&"[""P> "&titl&""",""../?progetti/"&ID&"/"&linkp&"""],"&CHR(10)

recordset9.movenext
Loop
connection.close


adding=addlinks&"[""FILES"", """"],"&CHR(10)&addfiles&CHR(10)&addprojects

adding=Mid(adding,1,Len(adding)-2)
%>

var tinyMCELinkList = new Array(
	// Name, URL
	<%=adding%>

);
