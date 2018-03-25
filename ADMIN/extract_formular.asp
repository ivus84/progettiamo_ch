<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
if request("mode")="xls" then
ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition", "attachment; filename=formular_"&Session("refform")&".xls"
Response.Charset = "UTF-8"
Response.ContentType = ContentType
%>
<html>
<head>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head><body>
<%Else
nobg=True
%><!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<%end if


ref=request("ref")
formular=request("formular")

if len(ref)>0 then Session("refform")=ref
if len(formular)>0 then Session("refformular")=formular
ref=Session("refform")
formular=Session("refformular")

response.CodePage = 1252
SQL="SELECT * FROM formulari WHERE ID="&formular
set rec=connection.execute(SQL)

do while not rec.eof
nomef=rec("TA_nome")
inidatadef=rec("TX_datadef")

rec.movenext
loop

if request("mode")<>"xls" then
%>
<div style="float:right">
<input type="BUTTON" value="X CHIUDI" id="mybt1" class="testoadm" onclick="closeThis();">
</div>

<br/></font>
<br/><img src="./images/xls.gif" align="absmiddle"/> <a href="extract_formular.asp?mode=xls">download Excel</a><br/><br/>
<%end if%>
<table width=100% border=0 cellpadding=2 cellspacing=1>
<tr bgcolor="#999999">
<%
datadef=Split(Mid(inidatadef,1,len(inidatadef)-1),"#")
n=1
for x=LBound(datadef) to UBound(datadef)
field_n=datadef(x)
field_def=Split(field_n,"|")

response.write "<td class=testoadm><b>"&field_def(0)&"</b></td>"

n=n+1
next
%><td class=testoadm><b>Data</b></td>
</tr><%

SQL="SELECT formulari_dati.* FROM formulari_dati WHERE CO_formulari="&formular&" AND CO_oggetti="&ref&" ORDER BY DT_data DESC"
set rec=connection.execute(SQL)
''response.CodePage = 65001

do while not rec.eof
if col1="FFFFFF" then
col1="EFEFEF"
else
col1="FFFFFF"
end if
%>
<tr bgcolor="#<%=col1%>">
<%
refdata=rec("ID")
datauser=rec("TX_data")
date1=rec("DT_data")

datadef=Split(datauser,"|")
n=1


for x=LBound(datadef) to UBound(datadef)
datawrite=datadef(x)

datawrite=Mid(datawrite,Instr(datawrite,"=")+1,len(datawrite))
if len(datawrite)>0 then
datawrite=Replace(datawrite,"ë","&euml;")
datawrite=Replace(datawrite,"ö","&ouml;")
datawrite=Replace(datawrite,"ü","&uuml;")
datawrite=Replace(datawrite,"ä","&auml;")
datawrite=Replace(datawrite,"ï","&iuml;")
datawrite=Replace(datawrite,"Ë","&Euml;")
datawrite=Replace(datawrite,"Ö","&Ouml;")
datawrite=Replace(datawrite,"Ü","&Uuml;")
datawrite=Replace(datawrite,"Ä","&Auml;")
datawrite=Replace(datawrite,"Ï","&Iuml;")
end if
response.write "<td class=testoadm>"&datawrite&"</td>"
n=n+1
next
%>
<td class=testoadm><%=Day(date1)%>.<%=Month(date1)%>.<%=Year(date1)%></b></td>
<%if request("mode")<>"xls" then%>
<td class=testoadm><a href="del.asp?tabella=formulari_dati&pagina=<%=refdata%>&da=extract_formular"><img src="./images/delete1.gif" border="0"></a></td><%end if%>
</tr><%
rec.movenext
loop%>
</table>

<%if request("mode")<>"xls" then%>
<script language="javascript" type="text/javascript">
redimThis();
</script>
<%End if%>