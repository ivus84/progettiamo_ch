<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<%

load=request("load")
conferma=request("conferma")
mode=request("mode")

SQL="SELECT * FROM p_projects WHERE ID="&load
If Session("adm_area")>0 AND Len(mode)=0 Then SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_p_area="&Session("adm_area")
Set rec=connection.execute(SQL)
If rec.eof Then
Response.End
End If

SQL="SELECT * FROM QU_projects WHERE ID="&load
Set rec=connection.execute(SQL)

pName=rec("TA_nome")

if Len(conferma)>0 then
if Len(load)>0 then

dFile="projects.asp"

SQL="UPDATE p_projects SET LO_realizzato=True WHERE ID="&load
Set rec=connection.execute(SQL)

Response.redirect("projects_project.asp?load="&load)

end if

Else
dW="Confermare la realizzazione del progetto"
%>
<html>
<head>
</head>
<body style="font-family:arial; font-size:14px;" bgcolor="#efefef"><center>
<br><br><br><br>
<center>
<br/><%=dW%><br/><b><%=pName%></b>?<br/><br/>
I finanziatori riceveranno notifica di realizzazione.
<br/><br/>
<input type="button" value="ANNULLA" onclick="document.location='blank1.asp'"/>
<input type="button" value="CONFERMA" onclick="document.location='projects_finished.asp?load=<%=load%>&mode=<%=mode%>&conferma=True';"/>
</body></html>
<%end If
connection.close%>