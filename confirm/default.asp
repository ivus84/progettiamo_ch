<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_language_vars.asp"-->
<!--#INCLUDE VIRTUAL="/incs/common_functions.asp"-->
<%
getcode=request.querystring
If Len(getcode)>0 Then 

SQL="SELECT * FROM registeredusers WHERE LO_enabled=False AND TA_confcode='"&getcode&"'"
Set rec=connection.execute(SQL)

'Response.write SQL
	If rec.eof Then
	Response.write"<html><body style=""margin:10%;font-family:arial""><p><b>progettiamo.ch</b><br/><br/>"&str_confirm_email_error&"</p></body></html>"
	Response.end
	End if

loggingWant=rec("TA_logging_donation")
gname=rec("TA_nome")
sname=""
If Len(gname)>0 Then sname=Mid(gname,1,1)
Session("logged_donator")=rec("ID")
Session("islogged"&numproject)="hdzufzztKJ89ei"
Session("logged_name")=gname&" "&rec("TA_cognome")
Session("logged_name_short")=sname&"."&rec("TA_cognome")
Session("p_favorites")=rec("TX_favorites")
Session("projects_promoter")=rec("LO_projects")
Session("promoter_last_login")=rec("DT_last_login")



SQL="UPDATE registeredusers SET LO_enabled=True,DT_last_login=Now() WHERE ID="&rec("ID")
Set rec=connection.execute(SQL)
gotopage=site_mainurl
loggingWanted=loggingWant
If Len(loggingWant)>1 Then
    loggingWant=Split(loggingWant,"#")
    projectGo=loggingWant(0)
    projectVal=loggingWant(1)
    SQL="SELECT * from p_projects WHERE ID="&projectGo
    Set rec=connection.execute(SQL)
    If Not rec.eof Then
        proj_name = rec("TA_nome")
        nomeprogetto=linkMaker(proj_name)
        proj_main = gotopage&"?progetti/"&projectGo&"/"&nomeprogetto
        gotopage=gotopage&"?progetti/"&projectGo&"/"&nomeprogetto&"/donate/"
        Session("project_wanted")=projectGo
        Session("chf_wanted")=projectVal

    End if
End if

	Response.write "<html><body style=""margin:10%;font-family:arial""><p><b>progettiamo.ch</b><br/><br/>"&str_confrim_email_1&"<br/><br/>"
	If Len(loggingWanted)>1 Then 
	'response.write setDonation(projectGo,projectVal, proj_name)
    %>
    <script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
    $.ajax({
      type: "POST",
      url: "/setDonation.asp?load=<%=projectGo %>&val=<%=projectVal %>&projectname=<%=proj_name %>&ssid="+Math.floor((Math.random()*111111)+1),
      timeout: 6000,
      success    : function(msg) {
      
      }
     });

    
    
    </script>
    
    
    <%
    ''' IB 160916 
    'Response.write str_confrim_email_2& " <a href="""&gotopage&""" style=""color:#ff0000; text-transform:uppercase"">"&str_confrim_next_page&"</a>"
	Response.write str_confrim_email_3& " <a href="""&proj_main&""" style=""color:#ff0000; text-transform:uppercase"">"&str_continua&"</a>" 
    Else
	Response.write "<a href="""&gotopage&""" style=""color:#ff0000"">"&str_continua_su&" progettiamo.ch</a>"
	End if
	'Response.write "</p><script type=""text/javascript"">setTimeout(function() {document.location='"&gotopage&"'},15000)</script></body></html>"
	Response.end

End if
connection.close%>