<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche.asp"-->
<!--#INCLUDE VIRTUAL="./incs/load_language_notif.asp"-->
<%

Const adTypeBinary = 1
Const adTypeText = 2

load=request("load")
conferma=request("conferma")
mode=request("mode")

SQL="SELECT * FROM p_projects WHERE ID="&load
If mode="updates" Then SQL="SELECT * FROM p_description WHERE ID="&load

If Session("adm_area")>0 AND Len(mode)=0 Then SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_p_area="&Session("adm_area")
Set rec=connection.execute(SQL)
If rec.eof Then
Response.End
End If
nomep=rec("TA_nome")
If mode="updates" Then
refproject = rec("CO_p_projects")
Else
refproject = load
End If

if Len(conferma)>0 then
p_category=request("p_category")
if Len(load)>0 then
SQL="UPDATE p_projects SET LO_confirmed=True,LO_toconfirmed=False,LO_aperto=True,CO_p_Category="&p_category&",DT_apertura=Now() WHERE ID="&load
If mode="updates" Then SQL="UPDATE p_description SET LO_confirmed=True WHERE ID="&load

Set rec=connection.execute(SQL)

dFile="projects.asp"


SQL="SELECT * FROM QU_projects WHERE ID="&refproject
	Set rec=connection.execute(SQL)

	pName=rec("TA_nome")
	pText=rec("TE_abstract")
	pCat=rec("category")
	pErs=rec("area")

pName=AlterCharset(pName,"windows-1252", "UTF-8")
pText=AlterCharset(pText,"windows-1252", "UTF-8")


	pCifra=rec("IN_cifra")
	pMezzipropri=rec("IN_mezzi_propri")
	pMail=rec("TA_email")
	refP=rec("ID")
	plink=linkMaker(pName)
			If Len(pName)>0 Then pName=Replace(pName,"#","'")

		pMail = EnDeCrypt(pMail, npass, 2)
pName=mailString(pName)

If mode="updates" Then 
dFile="projects_updates.asp"


pScheda=site_mainurl&"?progetti/"&refP&"/"&plink	
HTML=str_txt_notifica_body&chr(10) & str_notifica_approve_news_project &chr(10)& str_txt_notifica_body_end
HTML=replace(HTML,"#project_name#",pName)
HTML=replace(HTML,"#project_link#",pScheda)
	
	mailsubject=str_subject_approve_news_project

'mailSendDisabled=True

Else
	txt_project="<p>Progetto:<br/><b>"&pName&"</b><br/>"&pText&"<br/><br/>ERS di riferimento: "&pErs&"<br/><br/>Categoria: "&pCat&"<br/><br/>Ammontare complessivo progetto Fr. "&pCifra&"</p>"
	
	pScheda=site_mainurl&"?progetti/"&refP&"/"&plink	
	
	HTML=str_txt_notifica_body&chr(10) & str_notifica_approve_project &chr(10)& str_txt_notifica_body_end
	HTML=replace(HTML,"#txt_project#",txt_project)
	HTML=replace(HTML,"#project_link#",pScheda)
	mailsubject=str_subject_approve_project

	End if

	Response.codepage = 65001

	If Not mailSendDisabled Then
	sendto=pMail
	%>
	<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
	<%
	End if


%>

<%If mode="updates" Then%>
<b>Aggiornamento approvato</b><br/>
<iframe style="width:200px;height:111px;border:0px;overflow:hidden; opacity:1; filter:alpha(opacity=0);display:none;" src="/actions/set_notifica.asp?load=<%=refproject%>&amp;val=updates"></iframe>

<%Else%>
<b>Progetto convalidato</b><br/>

<script>
setTimeout(function() {
document.location='projects_project.asp?load=<%=refproject%>&ssid=' + Math.floor((Math.random()*111111)+1);
},2000)
</script>

<%End if%>

<%
end if

Else
dW="Confermare l'apertura del progetto"
If mode="updates" Then 
dW="Confermare la pubblicazione"
nomep="dell'aggiornamento"
End if
%>
<html>
<head>
<script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script> 
</head>
<body style="font-family:arial; font-size:14px;" bgcolor="#efefef"><center>
<br><br><br><br>
<center>
<br/><%=dW%><br/><b><%=nomep%></b>?<br/><br/>
<form method="post" action="projects_confirm.asp">
<input type="hidden" name="load" value="<%=load%>"/>
<input type="hidden" name="mode" value="<%=mode%>"/>
<input type="hidden" name="conferma" value="True"/>

<%If mode<>"updates" Then%>
<br/>Categoria:<br/>
<select name="p_category" style="width:290px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" onchange="$('.confirmB').fadeIn()"><option value="">...</option>
<%SQL="SELECT * FROM p_category"
Set rec=connection.execute(SQL)
Do While not rec.eof
refA=rec("ID")
addsl=""
If refA&""=pCat&"" then addsl=" selected=""selected"""
Response.write "<option value="""&refA&""""&addsl&">"&rec("TA_nome")&"</option>"
rec.movenext
loop%>
</select><br/><br/>
<input type="button" value="ANNULLA" onclick="document.location='projects_project.asp?load=<%=refproject%>'"/>
<input type="submit" value="CONFERMA" class="confirmB" style="display:none"/>

<%else%>
<input type="button" value="ANNULLA" onclick="document.location='blank1.asp'"/>
<input type="submit" value="CONFERMA" class="confirmB"/>
<%End if%>
</form>
</body></html>
<%end If
connection.close%>