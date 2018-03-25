<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
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
Response.codepage = 1252
ContentType = "application/vnd.ms-excel"
Response.Charset = "UTF-8"
Response.AddHeader "Content-Disposition", "attachment; filename=promesse_"&pLink&"_"&Day(Now())&Month(Now())&Year(Now())&".xls"
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
<p>Lista promesse <b><%=nomep%></b></p>

<%End if%>
<table>
<tr>
<td><b>Ente/Società</b></td>
<td><b>Nome</b></td>
<td><b>Cognome</b></td>
<td><b>Email</b></td>
<td><b>Fr.</b></td>
<td><b>Data</b></td>
<%If Len(mode)=0 Then%>
<td><b>Elimina</b></td>
<%End if%>
</tr>
<%

SQL="SELECT ID, refass, IN_promessa as promesso,DT_data as lastdata FROM QU_projects_promises WHERE CO_p_projects="&load&" ORDER BY DT_data DESC"
Set rec1=connection.execute(SQL)
Do While Not rec1.eof
refu=rec1("ID")

promesso=rec1("promesso")
lastdata=rec1("lastdata")
refass=rec1("refass")

SQL="SELECT * FROM registeredusers WHERE ID="&refu
Set rec=connection.execute(SQL)

If Not rec.eof Then
usrN=rec("TA_nome")
usrC=rec("TA_cognome")
usrE=rec("TA_ente")
usrEm=rec("TA_email")
usrEm1=rec("TA_email_new")
usrEm = EnDeCrypt(usrEm, npass, 2)

If Len(usrEm)=0 Then usrEm=usrEm1
If Len(usrEm)=0 Or isnull(usrEm) Then 
usrEm="disabilitato"
End if

%>
<tr>
<td><%=usrE%></td>
<td><%=usrN%></td>
<td><%=usrC%></td>
<td><%=usrEm%></td>
<td class="curr"><%=promesso%></td>
<td><%=lastdata%></td>
<%If Len(mode)=0 Then%>
<td><input type="button" value="del" onclick="document.location='del.asp?tabella=associa_registeredusers_projects&pagina=<%=refass%>&da=projects_promises&load=<%=load%>'"/></td>
<%End if%>
</tr>

<%

End If


rec1.movenext
loop

%>
</table>
<%If Len(mode)=0 Then%>
<br/><br/>
<input type="button" onclick="document.location='projects_promises.asp?load=<%=load%>&mode=xls'" value="SCARICA EXCEL"/>
<input type="button" onclick="document.location='projects_promoters.asp?load=<%=load%>'" value="LISTA SOSTENITORI"/>
<input type="button" onclick="window.print()" value="STAMPA" />
<%End if%>

</body></html>
<%connection.close%>