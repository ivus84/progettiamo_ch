<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
''ON ERROR RESUME NEXT
load=request("load")


SQL="SELECT * FROM QU_projects WHERE ID="&load
If Session("adm_area")>0 Then 
SQL1=SQL1&" AND CO_p_area="&Session("adm_area")
End If

set rec=connection.execute(SQL)
If rec.eof Then
Response.End
End if

pTitle=rec("TA_nome")
plink=linkMaker(pTitle)
puser=rec("CO_registeredusers")

Session("logged_donator")=puser
Session("islogged"&numproject)="hdzufzztKJ89ei"
'Session("logged_name")=gname&" "&rec("TA_cognome")
'Session("logged_ente")=rec("TA_ente")
'Session("logged_name_short")=sname&"."&rec("TA_cognome")
'Session("p_favorites")=rec("TX_favorites")
Session("projects_promoter")=True


Response.redirect("/?edit-project/"&load&"/"&plink)


connection.close
%>