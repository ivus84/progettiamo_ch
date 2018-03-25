<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

load=request("load")
conferma=request("conferma")
DT_termine=request("DT_termine")

SQL="SELECT * FROM p_projects WHERE ID="&load
If Session("adm_area")>0 Then SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_p_area="&Session("adm_area")
Set rec=connection.execute(SQL)
If rec.eof Then
Response.End
End If
nomep=rec("TA_nome")
valore=rec("DT_termine")
giorno=Day(valore)
mese=Month(valore)
anno=Year(valore)
valore=mese&"/"&giorno&"/"&anno

today=Now()
giorno1=Day(today)
mese1=Month(today)
anno1=Year(today)
oggi=mese1&"/"&giorno1&"/"&anno1



if Len(conferma)>0 And Len(load)>0 Then

If Len(DT_termine)>0 Then
giorno2=Day(DT_termine)
mese2=Month(DT_termine)
anno2=Year(DT_termine)
newterm=mese2&"/"&giorno2&"/"&anno2
'newterm=DT_termine
End if

	If dateDiff("d",newterm,Now())<1 then


	SQL="UPDATE p_projects SET LO_aperto=True, DT_termine=#"&DT_termine&"# WHERE ID="&load
	Set rec=connection.execute(SQL)


	%>
	<script>
	alert("progetto prorogato")
	setTimeout(function() {
	parent.document.location='projects.asp?ssid=' + Math.floor((Math.random()*111111)+1);
	},1000)

	</script>
	<%
	Else
	%>
	<script>
	alert("Definire una data futura per la proroga")
	document.location='projects_proroga.asp?load=<%=load%>&ssid=' + Math.floor((Math.random()*111111)+1);

	</script>
	<%

	end if

else
%>
<html>
<head>
<link rel="stylesheet" href="/css/ui-lightness/jquery-ui-1.8.18.custom.css" type="text/css"/>
<script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script> 
<script type="text/javascript" src="/js/jquery-ui-1.8.18.custom.min.js"></script>
<script type="text/javascript" src="/js/jquery.ui.datepicker-it.js"></script>
</head>
<body style="font-family:arial; font-size:14px;" bgcolor="#efefef"><center>
<br><br><br><br>
<form action="projects_proroga.asp" method="post">
<input type="hidden" name="load" value="<%=load%>"/>
<input type="hidden" name="conferma" value="True"/>
<center>
Prorogare il termine di raccolta fondi del progetto<br/><b><%=nomep%></b>?
<br/><br/>
Inserire data<br/>
<input type="text" name="DT_termine" value="<%=valore%>" class="dtPicker" style="width:80px" onfocus="$(this).blur()"/><br/>
<input type="button" value="ANNULLA" onclick="document.location='blank1.asp'"/>
<input type="submit" value="CONFERMA"/>
</form>

<script language="javascript" type="text/javascript">
var maxlevs=3;
var loadedStructure="";
$(document).ready(function() {
$( ".dtPicker" ).datepicker();
})
</script>

</body></html>
<%end If
connection.close%>