
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche.asp"-->
<!--#INCLUDE VIRTUAL="./incs/load_language_notif.asp"-->
<%
'response.CodePage = 65001

load=request("load")
valget=request("val")
If Len(Session("donazione_" & load & "_" & Session("logged_donator")))=0 Then Session("donazione_" & load & "_" & Session("logged_donator"))=0

	If Len(Session("logged_donator"))>0 Then

		SQL="SELECT COUNT(ID) as totdaydonation FROM associa_registeredusers_projects WHERE CO_registeredusers=" & Session("logged_donator") & " AND CO_p_projects=" & load & " AND DateDiff('d',DT_data,Now())=0"
		Set rec1=connection.execute(SQL)
		
		totdaydonation=rec1("totdaydonation")

		If totdaydonation<2 then

		    Session("project_wanted")=""
		    Session("chf_wanted")=""

		    valget=CDbl(valget)

		    SQL="SELECT TA_email as donatorEmail FROM registeredusers WHERE ID=" & Session("logged_donator")
		    Set rec=connection.execute(SQL)
			If Not rec.eof Then
			    donatorEmail=rec("donatorEmail")
			    donatorEmail = EnDeCrypt(donatorEmail, npass, 2)


			    SQL="SELECT TA_nome as projectname, TA_email_ref AS mailarea FROM QU_projects WHERE ID="&load
			    Set rec=connection.execute(SQL)

				If Not rec.eof Then


				    response.CodePage = 65001
				    projectname=request("projectname")
				    If Len(projectname)>0 Then projectname=Replace(projectname,"#","'")


	    			mailarea=rec("mailarea")
		            projectname=mailString(projectname)

                    HTML=str_txt_notifica_body&chr(10) & str_notifica_senddonate & chr(10) & str_txt_notifica_body_end
                    HTML=replace(HTML,"#project_name#",projectname)
                    HTML=replace(HTML,"#donation_value#",valget)
                    HTML=replace(HTML,"#mail_area#",mailarea)
                    mailsubject=str_subject_senddonate

					If Not mailSendDisabled Then
    					sendTo=donatorEmail
					%>
					<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
					<%
					End if

    				SQL="INSERT INTO associa_registeredusers_projects (IN_promessa,CO_p_projects,CO_registeredusers,TA_user_ip) VALUES (" & valget & "," & load & "," & Session("logged_donator") & ",'" & Request.ServerVariables("REMOTE_ADDR")&"')"
	    			Set rec=connection.execute(SQL)

		    		SQL="SELECT SUM(IN_promessa) as raccolto FROM associa_registeredusers_projects WHERE CO_p_projects="&load
			    	Set rec=connection.execute(SQL)
				    raccolto=rec("raccolto")

    				SQL="UPDATE p_projects set IN_raccolto=" & raccolto & " WHERE ID=" & load
	    			Set rec=connection.execute(SQL)

	    			Session("donazione_" & load & "_" & Session("logged_donator"))=Session("donazione_" & load & "_" & Session("logged_donator"))+1

		    		Response.write "DONE"
			    	Session("project_wanted")=""
				    Session("chf_wanted")=0
				    Session("donazione_"&load&"_"&Session("logged_donator"))=valget
				End if
			End if
	End if
Else
Session("project_wanted")=load
Session("chf_wanted")=valget
Response.write "LOGIN"
End if

connection.close%>