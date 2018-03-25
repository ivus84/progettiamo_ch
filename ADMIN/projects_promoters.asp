<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->

<%

load=request("load")
mode=request("mode")

SQL="SELECT * FROM p_projects WHERE ID="&load
If Session("adm_area")>0 Then SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_p_area="&Session("adm_area")
Set rec=connection.execute(SQL)
If rec.eof Then
Response.End
End If

nomep=rec("TA_nome")
pLink=linkMaker(nomep)
If mode="xls" Then
ContentType = "application/vnd.ms-excel"
'Response.Charset = "UTF-8"
Response.AddHeader "Content-Disposition", "attachment; filename=sostenitori_"&pLink&"_"&Day(Now())&Month(Now())&Year(Now())&".xls"
Response.ContentType = ContentType
End if
%>
<html>
<head>
<style>
body {font-family:arial; font-size:12px;text-align:left;background:#efefef;}
td {font-size:12px;background:#fff;white-space:nowrap; padding:3px;}

.curr
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[$CHF-1407\]\\ \#\,\#\#0\.00";
	text-align:right;
	background:white;
	mso-pattern:auto none;
	
	}

</style>
</head>

<body>
<%If Len(mode)=0 Then%>
<p>Lista sostenitori <b><%=nomep%></b></p>

<%End if%>
<table>
<tr>
<td><b>Ente/Societ&agrave;</b></td>
<td><b>Nome</b></td>
<td><b>Cognome</b></td>
<td><b>Fr.</b></td>
<td><b>Email</b></td>
<td><b>Tel.</b></td>
<td><b>Cap</b></td>
<td><b>Luogo</b></td>
<td><b>Indirizzo</b></td>
<td><b>Data</b></td>
</tr>
<%
SQL="SELECT DISTINCT ID FROM (SELECT ID FROM QU_projects_promises WHERE CO_p_projects="&load&" ORDER BY DT_data)"
Set rec1=connection.execute(SQL)
Do While Not rec1.eof
refu=rec1("ID")


SQL="SELECT SUM(IN_promessa) as promesso,MAX(DT_data) as lastdata FROM QU_projects_promises WHERE CO_p_projects="&load&" AND ID="&refu
Set rec=connection.execute(SQL)
promesso=rec("promesso")
lastdata=rec("lastdata")

SQL="SELECT * FROM registeredusers WHERE ID="&refu
Set rec=connection.execute(SQL)

If Not rec.eof Then
usrN=rec("TA_nome")
usrC=rec("TA_cognome")
usrE=rec("TA_ente")
usrEm=rec("TA_email")
usrEm1=rec("TA_email_new")
usrCap=rec("TA_cap")
usrAd=rec("TA_indirizzo")
usrLoc=rec("TA_citta")
usrTel=rec("TA_telefono")
lastdata=datevalue(lastdata)

	usrEm = EnDeCrypt(usrEm, npass, 2)
	usrTel = EnDeCrypt(usrTel, npass, 2)

If Len(usrEm)=0 Then usrEm=usrEm1
If Len(usrEm)=0 Or isnull(usrEm) Then 
usrEm="disabilitato"
Else
usrEm="<a href=""mailto:"&usrEm&""">mail</a>"
End if
%>
<tr>
<td><%=usrE%></td>
<td><%=usrN%></td>
<td><%=usrC%></td>
<td class="curr"><%=promesso%></td>
<td><%=usrEm%></td>
<td><%=usrTel%></td>
<td><%=usrCap%></td>
<td><%=usrLoc%></td>
<td><%=usrAd%></td>
<td><%=lastdata%></td>
</tr>

<%

End If


rec1.movenext
loop

%>
</table>
<%If Len(mode)=0 Then%>
<br/><br/>
<!--<input type="button" onclick="document.location='projects_promoters.asp?load=<%=load%>&mode=xls'" value="Vecchio SCARICA EXCEL"/>-->
<input type="button" onclick="document.location='ProjectPromotersExcelDownload.aspx?load=<%=load%>&mode=xls'" value="SCARICA EXCEL"/>
<input type="button" onclick="document.location='projects_promises.asp?load=<%=load%>'" value="GESTIONE PROMESSE"/>
<input type="button" onclick="window.print()" value="STAMPA"/>
<%End if%>

</body></html>
<%connection.close%>