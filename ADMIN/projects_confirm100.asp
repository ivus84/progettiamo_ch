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
termine=rec("DT_termine")
SQL="SELECT * FROM notifiche WHERE CO_p_projects="&load&" AND TA_notifica_type='confirmed'"
Set rec1=connection.execute(SQL)
			
If Not rec1.eof Then
response.write "<p>Conferma 100% già inviata ai sostenitori</p>"
Response.end
End if

SQL="SELECT * FROM QU_projects WHERE ID="&load
Set rec=connection.execute(SQL)

pName=rec("TA_nome")

if Len(conferma)>0 then
if Len(load)>0 then

dFile="projects.asp"




%>
<html>
<head>
<script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
</head>
<body style="font-family:arial; font-size:14px;" bgcolor="#efefef">
<center>
<p id="nota">Invio notifica in corso... prego attendere</p>
<iframe style="width:1px;height:1px;border:0px;overflow:hidden; opacity:0; filter:alpha(opacity=0);display:none;" src="/actions/set_notifica.asp?load=<%=load%>&amp;val=confirmed"></iframe>
</center>
</body>
</html>
<%
end if

Else
dW="Confermare l'invio della notifica 100% raggiunto per il progetto<br/><b>"&pName&"</b>?<br/><br/>La notifica è da inviare a conclusione della campagna di crowdfunding (scadenza termine)"
If DateDiff("d",termine,Now())<0 Then dW=dW&"<br/><br/><b>ATTENZIONE</b><br/><br/>mancano ancora <b>"&DateDiff("d",termine,Now())*-1&" giorni</b> alla scadenza della raccolta fondi"
%>
<html>
<head>
</head>
<body style="font-family:arial; font-size:14px;" bgcolor="#efefef"><center>
<br><br><br><br>
<center>
<br/><%=dW%><br/><br/>
<br/><br/>
<input type="button" value="ANNULLA" onclick="document.location='projects_project.asp?load=<%=load%>'"/>
<input type="button" value="CONFERMA" onclick="document.location='projects_confirm100.asp?load=<%=load%>&mode=<%=mode%>&conferma=True';"/>
</body></html>
<%end If
connection.close%>