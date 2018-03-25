<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

load=request("load")
conferma=request("conferma")

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

SQL="UPDATE p_projects SET LO_toconfirmed=False,LO_confirmed=False,LO_rejected=False,LO_aperto=False,LO_in_evidenza=False WHERE ID="&load
Set rec=connection.execute(SQL)

SQL="SELECT * FROM QU_projects WHERE ID="&load
Set rec=connection.execute(SQL)

Response.codepage = 65001

pName=rec("TA_nome")
pText=rec("TE_abstract")
pCat=rec("area")
pCifra=rec("IN_cifra")
pMezzipropri=rec("IN_mezzi_propri")
pMail=rec("TA_email")
refP=rec("ID")
txtreject=rec("TX_reject_reason")




%>
<script>
alert("progetto non convalidato")
setTimeout(function() {
parent.document.location='projects.asp?ssid=' + Math.floor((Math.random()*111111)+1);
},2000)

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
<form action="projects_disable.asp" method="post">
<input type="hidden" name="load" value="<%=load%>"/>
<input type="hidden" name="conferma" value="True"/>
<center>
Annullare la convalida del progetto<br/><b><%=nomep%></b>?
<br/><br/>
<input type="button" value="ANNULLA" onclick="document.location='blank1.asp'"/>
<input type="submit" value="CONFERMA"/>
</form>
</body></html>
<%end If
connection.close%>