<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche.asp"-->
<!--#INCLUDE VIRTUAL="./incs/common_functions.asp"-->
<%
'response.CodePage = 65001

    'response.Write "nuovo file"
load=request("load")
valget=request("val")
allowedlevels=",50,75,90,100,deleted,finished,updates,confirmed,termine,1week,1month,lastmonth,"
If InStr(allowedlevels,","&valget&",") Then

SQL="SELECT * FROM notifiche WHERE CO_p_projects="&load&" AND TA_notifica_type='"&valget&"'"
If valget="updates" Then
SQL="SELECT * FROM notifiche WHERE CO_p_projects="&load&" AND DateDiff('d',DT_data,Now())=0 AND TA_notifica_type='"&valget&"'"
End if

Set rec1=connection.execute(SQL)
		
If rec1.eof Then
SQL="SELECT * FROM QU_projects WHERE ID="&load
Set rec = connection.execute(SQL)


	If Not rec.eof Then

	aperto=rec("LO_aperto")
	confirmed=rec("LO_confirmed")
		If confirmed Then

		SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_projects="&load&")"
		Set rec2=connection.execute(SQL)
		num_subscribers=rec2("subscribers")


		pTitle=rec("TA_nome")
		If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")

		plink=linkMaker(pTitle)
		luogo=rec("TA_luogo")
		nazione=rec("TA_nazione")
		pText=rec("TE_abstract")
promoterName=rec("usrN")&" "&rec("usrC")
pTitle=AlterCharset(pTitle,"windows-1252", "UTF-8")
pText=AlterCharset(pText,"windows-1252", "UTF-8")

		pObj=rec("IN_cifra")
		pPropri=rec("IN_mezzi_propri")
		pObt=rec("IN_raccolto")
		pMancante=(pObj-pObt-pPropri)
		totChf=rec("fondi_raccolti")
		termine=rec("DT_termine")
		categoria=rec("category")
		totVisits=rec("IN_viewed")
		daysToGo=datediff("d",Now(),termine)

		sperc=0
		sperc1=0
		If pObj>0 Then sperc=Round(pObt/pObj*100,1)
		If pObj>0 Then sperc1=Round(pPropri/pObj*100,1)
		totLevel = sperc+sperc1
		percToGo=100-totLevel
		totLevel = Replace(totLevel,",",".")
		sperc=Replace(sperc,",",".")
		sperc1=Replace(sperc1,",",".")


		pTitle=mailString(pTitle)

		valueWrite=totLevel

mailArea=rec("TA_email_ref")

pMail=rec("TA_email")
pMail = EnDeCrypt(pMail, npass, 2)
'IB: invio mail in lingua
    pLangMail = rec("TA_lang_notif")
    if pLangMail = "" then pLangMail = "it"
		sendto_Mails="|"&pMail&":"&pLangMail
		If Len(mailArea)>0 Then sendto_Mails=sendto_Mails&"|"&mailArea&":it"

		'carica indirizzi donatori
		If valget="100" Or valget="termine" Then 
			sendto_Mails="|"&mailArea
		ElseIf valget="1week" Or valget="1month" Or valget="lastmonth" Then 
			sendto_Mails="|"&pMail
		else
				SQL="SELECT DISTINCT registeredusers.TA_email, registeredusers.TA_lang_notif, registeredusers.LO_enabled, registeredusers.LO_notifica_50, registeredusers.LO_notifica_75, registeredusers.LO_notifica_90, registeredusers.LO_notifica_100, registeredusers.LO_notifica_deleted, registeredusers.LO_notifica_finished, registeredusers.LO_notifica_updates, registeredusers.LO_notifica_favorites, registeredusers.TX_favorites FROM QU_projects_promises INNER JOIN registeredusers ON QU_projects_promises.CO_registeredusers = registeredusers.ID WHERE QU_projects_promises.CO_p_projects="&load&" AND registeredusers.LO_no_notifica=False AND registeredusers.LO_notifica_"&valget&"=True"
				
				If valget="confirmed" Or valget="deleted" Then
						SQL="SELECT DISTINCT registeredusers.TA_email, registeredusers.TA_lang_notif, registeredusers.LO_enabled, registeredusers.LO_notifica_50, registeredusers.LO_notifica_75, registeredusers.LO_notifica_90, registeredusers.LO_notifica_100, registeredusers.LO_notifica_deleted, registeredusers.LO_notifica_finished, registeredusers.LO_notifica_updates, registeredusers.LO_notifica_favorites, registeredusers.TX_favorites FROM QU_projects_promises INNER JOIN registeredusers ON QU_projects_promises.CO_registeredusers = registeredusers.ID WHERE QU_projects_promises.CO_p_projects="&load
				End If
				
				Set recsend=connection.execute(SQL)
				
				If recsend.eof Then 
				Response.End
				End If
				
				Do While Not recsend.eof
					donatorEmail=recsend("TA_email")
					donatorEmail = EnDeCrypt(donatorEmail, npass, 2)
                    'IB 160825- gestione notifiche in lingua 
                    donatorEmail = donatorEmail&":"&recsend("TA_lang_notif")
                    
					sendto_Mails=sendto_Mails&"|"&donatorEmail 
				recsend.movenext
				loop

				'carica indirizzi progetti preferiti
				SQL="SELECT DISTINCT registeredusers.TA_email,registeredusers.TA_lang_notif, registeredusers.LO_enabled, registeredusers.LO_notifica_50, registeredusers.LO_notifica_75, registeredusers.LO_notifica_90, registeredusers.LO_notifica_100, registeredusers.LO_notifica_deleted, registeredusers.LO_notifica_finished, registeredusers.LO_notifica_updates, registeredusers.LO_notifica_favorites, registeredusers.TX_favorites FROM registeredusers WHERE instr(TX_favorites,',"&load&",') AND registeredusers.LO_no_notifica=False AND registeredusers.LO_enabled=True AND registeredusers.LO_notifica_"&valget&"=True AND registeredusers.LO_notifica_favorites=True"
				
				If valget="confirmed" Or valget="deleted" Then
				SQL="SELECT DISTINCT registeredusers.TA_email,registeredusers.TA_lang_notif, registeredusers.LO_enabled, registeredusers.LO_notifica_50, registeredusers.LO_notifica_75, registeredusers.LO_notifica_90, registeredusers.LO_notifica_100, registeredusers.LO_notifica_deleted, registeredusers.LO_notifica_finished, registeredusers.LO_notifica_updates, registeredusers.LO_notifica_favorites, registeredusers.TX_favorites FROM registeredusers WHERE instr(TX_favorites,',"&load&",') AND registeredusers.LO_no_notifica=False AND registeredusers.LO_enabled=True AND registeredusers.LO_notifica_favorites=True"
				End if

				
				Set recsend=connection.execute(SQL)

				Do While Not recsend.eof
					donatorEmail=recsend("TA_email")
					donatorEmail = EnDeCrypt(donatorEmail, npass, 2)
                    'IB 160825- gestione notifiche in lingua 
                    donatorEmail = donatorEmail&":"&recsend("TA_lang_notif")

					If InStr(sendto_Mails,donatorEmail)=False Then sendto_Mails=sendto_Mails&"|"&donatorEmail
				recsend.movenext
				loop
		End if


		If Len(sendto_Mails)>1 Then

	If Not mailSendDisabled Then
    'response.Write "sendto_Mails: "&sendto_Mails
	'sendto_Mails=Split(sendto_Mails,"|")
    sendto_MailsSplit=Split(sendto_Mails,"|")
        'For  x in sendto_Mails
		For each x in sendto_MailsSplit 
        'On Error Resume Next
		    'IB 160825: gestione notifiche in lingua
            'sendto=sendto_Mails(x)
            'response.write "x: "&x
            if x <> "" then
                mail_lang = Split(x,":")
   
                sendto = mail_lang(0)
                'response.write "sendto: " &sendto
                lang = "it"
                if UBound(mail_lang) > 0 then

                    lang = mail_lang(1)
                    if lang ="" then lang = "it"
                end if
                'response.Write "lang:" &lang
                setLangNotif(lang)
    

    
If isnumeric(valget) Or valget="confirmed" Then addMessagge = str_notifica_status_target

If isnumeric(valget) AND valueWrite<100 Then 
addMessagge=addMessagge&str_notifica_status_mancano
addMessagge=replace(addMessagge,"#donation_value#", setCifra(pMancante))
end if

If isnumeric(valget) AND valueWrite>=100 Then addMessagge=str_notifica_status_raggiunto

If valget="confirmed" Then addMessagge=str_notifica_status_done

If valget="termine" AND valueWrite>=100 Then addMessagge= str_notifica_status_raggiunto_done

If valget="termine" AND valueWrite<100 Then addMessagge= str_notifica_status_scaduto

If valget="deleted" Then addMessagge= str_notifica_status_closed

If valget="finished" Then addMessagge= str_notifica_status_realized

If valget="updates" Then addMessagge= str_notifica_status_news

If valget="1week" Then addMessagge= str_txtmail_week
If valget="1month" Then addMessagge = str_txtmail_month
If valget="lastmonth" Then addMessagge = str_txtmail_onemonth


pScheda=site_mainurl&"?progetti/"&load&"/"&plink&"/"
If valget<>"deleted" Then addMessagge=addMessagge & str_notifica_status_link


addMessagge=replace(addMessagge,"#project_name#", pTitle)
addMessagge=replace(addMessagge,"#status_write#", valueWrite)
addMessagge=replace(addMessagge,"#project_link#",pScheda)
addMessagge=replace(addMessagge,"#promoter_name#", promoterName)
addMessagge=replace(addMessagge,"#tot_chf#", totChf)
addMessagge=replace(addMessagge,"#tot_visits#", totVisits)
addMessagge=replace(addMessagge,"#daystogo#", daysToGo)
addMessagge=replace(addMessagge,"#percent_togo#", percToGo)
addMessagge=replace(addMessagge,"#tot_target#", pObj)
addMessagge=replace(addMessagge,"#tot_donators#", num_subscribers)

response.CodePage = 65001

salutomail=str_notifica_saluto
If valget="100" Or valget="termine" Or valget="1week" Or valget="1month" Or valget="lastmonth" Then salutomail=""

footermail= str_notifica_nota & "<p>"&now()&"</p>"
If valget="100" Or valget="termine" Or valget="1week" Or valget="1month" Or valget="lastmonth" Then footermail=""

str_txt_notifica_body_end=footermail & str_txt_notifica_body_end

HTML=str_txt_notifica_body&chr(10) &salutomail&"<p>"&Chr(10) & addMessagge &Chr(10)&"</p>"



HTML=HTML & chr(10)& str_txt_notifica_body_end

mailsubject=str_subject_notifica_default
If valget="deleted" Then mailsubject=str_subject_notifica_pdeleted
If valget="confirmed" Then mailsubject=str_subject_notifica_pdone
If valget="finished" Then mailsubject=str_subject_notifica_prealized
If valget="1week" Then mailsubject=str_subject_week
If valget="1month" Then mailsubject=str_subject_month
If valget="lastmonth" Then mailsubject=str_subject_onemonth

mailsubject=replace(mailsubject,"#project_name#",pTitle)	
	
'response.write "beforemail"


%>
<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
<%

'                response.write "aftermail"
            'If Err.Number <> 0 Then
            ' Error Occurred / Trap it
            'On Error Goto 0 ' But don't let other errors hide!
            ' Code to cope with the error here
            'End If
            'On Error Goto 0
            end if
		Next

	End if

		HTML=Replace(HTML,"'","''")
		SQL="INSERT INTO notifiche (CO_p_projects,TA_notifica_type,TE_testo) VALUES ("&load&",'"&valget&"','"&HTML&"')"
		Set rec1=connection.execute(SQL)


If valget="deleted" Then 
SQL="DELETE FROM associa_registeredusers_projects WHERE CO_p_projects="&load
Set rec=connection.execute(SQL)

SQL="UPDATE p_projects SET LO_aperto=False, LO_Confirmed=False WHERE ID="&load
Set rec=connection.execute(SQL)

End if

		'Response.write HTML
%>
<html>
<head>
    <script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
</head>
<body>
    <script>
$(document).ready(function() {
if ($('#nota', parent.document).size()>0)
{
$('#nota', parent.document).html('Notifica inviata')
}
});
    </script>
</body>
</html>
<%

		End if

		End if

		End if
	End if
End if


connection.close%>