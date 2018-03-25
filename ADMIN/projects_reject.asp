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
txtreject=request("txtreject")

SQL="SELECT * FROM p_projects WHERE ID="&load
If Session("adm_area")>0 Then SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_p_area="&Session("adm_area")
Set rec=connection.execute(SQL)
If rec.eof Then
Response.End
End If
nomep=rec("TA_nome")
if Len(conferma)>0 then

if Len(load)>0 then
If Len(txtreject)>0 Then txtreject=Replace(txtreject,"'","''")

SQL="UPDATE p_projects SET LO_toconfirmed=False,LO_complete=False,LO_rejected=True,TX_reject_reason='"&txtreject&"' WHERE ID="&load
Set rec=connection.execute(SQL)

SQL="SELECT * FROM QU_projects WHERE ID="&load
Set rec=connection.execute(SQL)


pName=rec("TA_nome")
pText=rec("TE_abstract")
pCat=rec("area")
pCifra=rec("IN_cifra")
pMezzipropri=rec("IN_mezzi_propri")
pMail=rec("TA_email")
refP=rec("ID")
txtreject=rec("TX_reject_reason")
mailarea=rec("TA_email_ref")
pMail = EnDeCrypt(pMail, npass, 2)

If Len(pName)>0 Then pName=Replace(pName,"#","'")

pName=AlterCharset(pName,"windows-1252", "UTF-8")
pText=AlterCharset(pText,"windows-1252", "UTF-8")

pName=mailString(pName)

Response.codepage = 65001


txt_project="<p>Progetto:<br/><b>"&pName&"</b><br/>"&pText&"<br/><br/>ERS di riferimento: "&pCat&"<br/>Ammontare complessivo progetto Fr. "&pCifra&"</p>"

HTML=str_txt_notifica_body&chr(10) & str_notifica_rejectproject &chr(10)& str_txt_notifica_body_end
HTML=replace(HTML,"#txt_project#",txt_project)
HTML=replace(HTML,"#txt_reject#",txtreject)
HTML=replace(HTML,"#mail_area#",mailarea)

mailsubject=str_subject_rejectproject



If Not mailSendDisabled Then
sendto=pMail
%>
<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
<%
End if


%>
<script>
alert("progetto non convalidato")
setTimeout(function() {
parent.document.location='projects.asp?ssid=' + Math.floor((Math.random()*111111)+1);
},500)

</script>
<%
end if

else
%>
<html>
<head>
</head>
<body style="font-family:arial; font-size:14px;" bgcolor="#efefef"><center>
<br><br><br><br>
<form action="projects_reject.asp" method="post">
<input type="hidden" name="load" value="<%=load%>"/>
<input type="hidden" name="conferma" value="True"/>
<center>
Non convalidare l'apertura del progetto<br/><b><%=nomep%></b>?
<br/><br/>
Motivazione da comunicare al promotore:<br/><br/>
<textarea name="txtreject" style="width:300px; height:150px; text-align:left;padding:10px; font-family:arial"></textarea><br/><br/>
<input type="button" value="ANNULLA" onclick="document.location='blank1.asp'"/>
<input type="submit" value="CONFERMA"/>
</form>
</body></html>
<%end If
connection.close%>