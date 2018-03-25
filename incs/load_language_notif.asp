<%
getlangnotif="it"
If Len(Session("logged_donator"))>0 Then

SQL="SELECT TA_lang_notif FROM registeredusers WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)
    if not rec.eof then 
getlangnotif=rec("TA_lang_notif")
    end if
end if

	If getlangnotif="it" then
	%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_it.asp"-->
	<%elseif getlangnotif="fr" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_fr.asp"-->
	<%elseif getlangnotif="de" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_de.asp"-->
	<%elseif getlangnotif="en" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_en.asp"-->
	<%elseif getlangnotif="di" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche.asp"-->
    <%else%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche.asp"-->
	<%End if%>