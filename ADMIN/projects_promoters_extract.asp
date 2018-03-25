<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"--><%

mode=request("mode")

SQL="SELECT * FROM QU_projects_promises"
Set rec=connection.execute(SQL)
If rec.eof Then
Response.End
End If

If mode="xls" Then
ContentType = "application/vnd.ms-excel"
Response.codepage = 65001
Response.charset = "UTF-8"

Response.AddHeader "Content-Disposition", "attachment; filename=sostenitori_tutti_"&Day(Now())&Month(Now())&Year(Now())&".xls"
Response.ContentType = ContentType
End if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns:x="urn:schemas-microsoft-com:office:excel">
	<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%If Len(mode)=0 Then%>
<script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script> 

<link rel="stylesheet" href="/css/ui-lightness/jquery-ui-1.8.18.custom.css" type="text/css"/>
<link rel="stylesheet" href="./admstyles.css" type="text/css"/>
<script type="text/javascript" src="/js/jquery-ui-1.8.18.custom.min.js"></script>
<script type="text/javascript" src="/js/jquery.ui.datepicker-it.js"></script>
<%End if%>
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

.dta
	{
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	background:white;
	mso-pattern:auto none;}

.num
	{
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:right;
	background:white;
	mso-pattern:auto none;}

</style>
</head>

<body>
<%
areavieW=request("parea")
dal=request("da")
al=request("al")

If Len(mode)=0 Then%>
<p class="titolo">Dati sostenitori</p>
<p>Filtra per:<br/> 
Area: 
<select name="parea" onchange="document.location='projects_promoters_extract.asp?parea='+$(this).val()">
<option value="0">Tutte</option>
<%

If Len(dal)>0 Then Session("daldata")=dal

If Len(al)>0 Then Session("aldata")=al


If Len(areavieW)=0 Or areavieW="0" Then areavieW=0
areavieW=CInt(areavieW)

'If Session("adm_area")>0 And areavieW>0 And areavieW<>Session("adm_area") Then areavieW=0


SQL="SELECT * FROM p_area"
SQL=SQL&" ORDER BY IN_ordine"
Set rec=connection.execute(SQL)
Do While Not rec.eof
ref=rec("ID")
area=rec("TA_nome")
adsl=""
If ref=areavieW Then adsl=" selected=""selected"""
Response.write "<option value="""&ref&""""&adsl&">"&area&"</option>"
rec.movenext
Loop    
%>
</select><br/><br/>
<span style="float:left">Dal:&nbsp;</span>
<%
valore=Session("daldata")

	If Len(valore)>0 Then
		giorno=Day(valore)
		mese=Month(valore)
		anno=Year(valore)
		'valore=mese&"/"&giorno&"/"&anno
		apply="<span class=""vDate"">"&mese&"."&giorno&"."&anno&"</span><input id=""from"" type=""text"" name=""dax"" value="""&valore&""" onfocus=""this.blur()"" class=""dtPicker"">"
			Else
		apply="<span class=""vDate""></span><input id=""from"" type=""text"" name=""dax"" value="""&now()&""" onfocus=""this.blur()"" class=""dtPicker"">"
	End If

Response.write apply

%>
<span style="float:left">Al:&nbsp;</span>
<%
valorea=Session("aldata")

	If Len(valorea)>0 Then
		giorno=Day(valorea)
		mese=Month(valorea)
		anno=Year(valorea)
		'valorea=mese&"/"&giorno&"/"&anno
		apply="<span class=""vDate"">- "&mese&"."&giorno&"."&anno&"</span><input id=""todate"" type=""text"" name=""dax"" value="""&valorea&""" onfocus=""this.blur()"" class=""dtPicker"">"
			Else
		apply="<span class=""vDate""></span><input id=""todate"" type=""text"" name=""dax"" value="""&now&""" onfocus=""this.blur()"" class=""dtPicker"">"
	End If

Response.write apply

%>

</p><br/><br/>

<input type="button" onclick="document.location='projects_promoters_extract.asp?mode=xls&parea=<%=areavieW%>'" value="SCARICA EXCEL"/>
<input type="button" onclick="window.print()" value="STAMPA"/>
<br/><br/>

<%End if%>
<table width="95%">
<tr>
<td><b>Categoria</b></td>
<td><b>Progetto</b></td>
<td><b>Area</b></td>
<td width="110"><b>Importo</b></td>
<td width="100"><b>Data</b></td>
<td><b>Cap</b></td>
<td><b>Domicilio</b></td>
</tr>
<%
SQL="SELECT QU_projects_promises.*, p_category.TA_nome as categoria, p_area.TA_nome AS area FROM (QU_projects_promises LEFT JOIN p_category ON QU_projects_promises.CO_p_category = p_category.ID) LEFT JOIN p_area ON QU_projects_promises.CO_p_area = p_area.ID WHERE QU_projects_promises.ID>0"

If areavieW>0 Then 
SQL=SQL&" AND QU_projects_promises.CO_p_area="&areavieW
End If

If Len(Session("daldata"))>0 Then
Session("daldata")=Replace(Session("daldata"),".","/")
SQL=SQL&" AND DateDiff('d',#"&Session("daldata")&"#,QU_projects_promises.DT_data)>=0"
End if


If Len(Session("aldata"))>0 Then
Session("aldata")=Replace(Session("aldata"),".","/")
SQL=SQL&" AND DateDiff('d',#"&Session("aldata")&"#,QU_projects_promises.DT_data)<=0"
End if

SQL=SQL&" ORDER BY QU_projects_promises.DT_data ASC"
'Response.write SQL
Set rec1=connection.execute(SQL)
Do While Not rec1.eof


promesso=rec1("IN_promessa")
lastdata=rec1("DT_data")
usrCap=rec1("TA_cap")
usrLoc=rec1("TA_citta")
progetto=rec1("TA_project")
categoria=rec1("categoria")
area=rec1("area")
lastdata=datevalue(lastdata)

%>
<tr>
<td><%=categoria%></td>
<td><div style="position:relative; height:20px; width:140px; overflow:hidden"><%=progetto%></div></td>
<td><div style="position:relative; height:20px; width:100px; overflow:hidden"><%=area%></div></td>
<td class="curr"><%=promesso%></td>
<td class="dta"><%=lastdata%></td>
<td class="num"><%=usrCap%></td>
<td><div style="position:relative; height:20px; width:100px; overflow:hidden"><%=usrLoc%></div></td>
</tr>

<%

rec1.movenext
loop

%>
</table>

<%If Len(mode)=0 Then%>
<script language="javascript" type="text/javascript">
$(document).ready(function() {

$( "#from" ).datepicker({
	dateFormat: "mm/dd/yy",
   onSelect: function(dateText, inst) { 
document.location="projects_promoters_extract.asp?parea=<%=areavieW%>&da="+dateText
}
});

$( "#todate" ).datepicker({
	dateFormat: "mm/dd/yy",
   onSelect: function(dateText, inst) { 
document.location="projects_promoters_extract.asp?parea=<%=areavieW%>&al="+dateText
}
});
});
</script>
<%End if%>

</body></html>
<%connection.close%>