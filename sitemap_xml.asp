<%Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
Response.ContentType = "text/xml"
%><?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
in_levels=3

serv_name = Request.ServerVariables("http_host")
SQL="SELECT * FROM lingue WHERE LO_attiva=True AND LO_pubblica=True ORDER BY IN_ordine DESC"
set record=connection.execute(SQL)
Do While Not record.eof

reflang=record("IN_valore2")
langadd=record("TA_abbreviato")
If Len(reflang)>0 Then reflang="_"&reflang

SQL="SELECT ID,newsection.TA_nome"&reflang&" as nome,newsection.DT_data as data FROM newsection WHERE LO_contact_page=False AND LO_homepage=False AND LO_pubblica"&reflang&"=True AND LO_deleted=False AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&reflang&" ASC"
set recordset=connection.execute(SQL)

do while not recordset.eof

ID=recordset("ID")
datarev=recordset("data")
nome=recordset("nome")
nome=linkMaker(nome)
mm=month(datarev)
dd=day(datarev)
if mm<10 then mm="0"&mm
if dd<10 then dd="0"&dd
%>
<url>
    <loc>http://<%=serv_name%>/?<%=ID%>/<%=nome%></loc>
    <lastmod><%=year(datarev)%>-<%=mm%>-<%=dd%></lastmod>
    <changefreq>weekly</changefreq>
</url>
<%
SQL1="SELECT ID,newsection.TA_nome"&reflang&" as nome, newsection.DT_data as data  FROM newsection WHERE LO_pubblica"&reflang&"=True AND CO_oggetti="&ID&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&reflang&" ASC"
set recordset1=connection.execute(SQL1)

sss=0
do while not recordset1.eof
ID1=recordset1("ID")
datarev=recordset1("data")
nome=recordset1("nome")
if len(nome)>0 then nome=linkMaker(nome)
mm=month(datarev)
dd=day(datarev)
if mm<10 then mm="0"&mm
if dd<10 then dd="0"&dd
%>
<url>
    <loc>http://<%=serv_name%>/?<%=ID1%>/<%=nome%></loc>
    <lastmod><%=year(datarev)%>-<%=mm%>-<%=dd%></lastmod>
    <changefreq>weekly</changefreq>
</url>
<%

if len(pass1)=0 AND in_levels>2 then
SQL1="SELECT ID,newsection.TA_nome"&reflang&" as nome, newsection.DT_data as data, newsection.LO_pubblica"&reflang&" AS LO_pubblica FROM newsection WHERE LO_pubblica"&reflang&"=True AND CO_oggetti="&ID1&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&reflang&" ASC"
set recordset2=connection.execute(SQL1)

sss=0
do while not recordset2.eof
ID2=recordset2("ID")
nome=recordset2("nome")
if len(nome)>0 then nome=linkMaker(nome)
datarev=recordset2("data")
mm=month(datarev)
dd=day(datarev)
if mm<10 then mm="0"&mm
if dd<10 then dd="0"&dd
%>
<url>
    <loc>http://<%=serv_name%>/?<%=ID2%>/<%=nome%></loc>
    <lastmod><%=year(datarev)%>-<%=mm%>-<%=dd%></lastmod>
    <changefreq>weekly</changefreq>
</url>
<%

if in_levels>3 then
SQL1="SELECT ID,newsection.TA_nome"&reflang&" as nome,  newsection.DT_data as data, newsection.TA_nome"&reflang&" as TA_nome, newsection.LO_pubblica"&reflang&" AS LO_pubblica FROM newsection WHERE LO_pubblica"&reflang&"=True AND CO_oggetti="&ID2&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&reflang&" ASC"
set recordset3=connection.execute(SQL1)

sss=0
do while not recordset3.eof
ID3=recordset3("ID")
nome=recordset3("nome")
if len(nome)>0 then nome=linkMaker(nome)
datarev=recordset3("data")
mm=month(datarev)
dd=day(datarev)
if mm<10 then mm="0"&mm
if dd<10 then dd="0"&dd
%>
<url>
    <loc>http://<%=serv_name%>/?<%=ID3%>/<%=nome%></loc>
    <lastmod><%=year(datarev)%>-<%=mm%>-<%=dd%></lastmod>
    <changefreq>weekly</changefreq>
</url><%
recordset3.movenext
loop
end if
recordset2.movenext
loop
end if
recordset1.movenext
loop
recordset.movenext
Loop
record.movenext
loop

SQL="SELECT * FROM p_projects WHERE LO_confirmed AND LO_aperto AND dateDiff('d',Now(),DT_termine)>=0 ORDER BY DT_apertura DESC"
set record=connection.execute(SQL)


Do while Not record.eof
refitem=record("ID")
titolo=record("TA_nome")
gLink=linkmaker(titolo)

datarev=record("DT_apertura")
mm=month(datarev)
dd=day(datarev)
if mm<10 then mm="0"&mm
if dd<10 then dd="0"&dd


%>
<url>
    <loc>http://<%=serv_name%>/?progetti/<%=refitem%>/<%=gLink%></loc>
    <lastmod><%=year(datarev)%>-<%=mm%>-<%=dd%></lastmod>
    <changefreq>monthly</changefreq>
</url><%

record.movenext
loop
%>
</urlset>
<%connection.close
response.end%>
