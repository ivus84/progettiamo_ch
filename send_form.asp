<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
response.CodePage = 65001

formref=request("CO_formulari")
refid=request("CO_oggetti")
gCaptcha=request("cptch")
inidatadef=request("TX_datadef")

'if len(Session("sentForm"&formref))>0 then
'oblig="Formulario già inviato"
'oblig_1="Form already sent"
'oblig_2="Formular bereits gesendet"
'oblig_3="formulaire déjà envoyée"
'oblig=eval("oblig"&session("reflang"))
'response.write "SUCCESS#"&oblig
'response.end
'end if


SQL="SELECT formulari.*, associa_ogg_formulari.TA_send_email,associa_ogg_formulari.TA_mail_subject from formulari INNER JOIN associa_ogg_formulari ON associa_ogg_formulari.CO_formulari=formulari.ID WHERE associa_ogg_formulari.CO_oggetti="&refid&" AND formulari.ID="&formref
set rec=connection.execute(SQL)

if not rec.eof Then
Session("titlepage_form")
postSend=rec("TX_message_after_send")

send_email=rec("TA_send_email")
send_subject=rec("TA_mail_subject")
if len(send_email)=0 OR isnull(send_email)=True then send_email=sendmaildefault

Session("message_after_form")=rec("TX_message_after_send")
datadef=Split(Mid(inidatadef,1,len(inidatadef)-1),"#")
iscomplete=1
allval=""


for x=LBound(datadef) to UBound(datadef)

valuser=""
field_n=datadef(x)

field_def=Split(field_n,"|")

fieldname=field_def(0)
fieldmand=field_def(2)

valuser=request("formfield_"&x)

if fieldmand="True" AND len(valuser)=0 then iscomplete="0"

if len(valuser)>0 then valuser=Replace(valuser,"'","&#39;")
allval=allval&fieldname&"="

allval=allval&valuser&"|"


n=n+1
next

if iscomplete=1 then
allval=Mid(allval,1,len(allval)-1)
SQL="INSERT INTO formulari_dati (CO_formulari,CO_oggetti,TX_data,DT_data) VALUES ("&formref&","&refid&",'"&allval&"',#"&Month(Now())&"/"&Day(Now())&"/"&Year(Now())&"#)"
set rec1=connection.execute(SQL)

if len(send_email)>0 then
sendto=send_email
mailsubject=send_subject

if len(mailsubject)=0 OR isnull(mailsubject)=True then mailsubject="progettiamo.ch - "&rec("TA_nome")

testo=Split(allval,"|")
HTML=""

for x=LBound(testo) to UBound(testo)

writex=testo(x)
writex0=Mid(writex,1,instr(writex,"=")-1)
HTML=HTML&writex0&": "

writex1=Mid(writex,instr(writex,"=")+1,len(writex))
HTML=HTML&writex1&"<br/>"

If writex0="Area geografica" Then send_email=writex1
next

sendto=send_email

response.CodePage = 65001

HTML="<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd""><html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""it"" lang=""it""><head><meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" /></head><body style=""font-family:arial""><p>Formulario di contatto da <b>progettiamo.ch</b><br/><br/>"&HTML&"</p><p>Messaggio inviato il "&now()&" da indirizzo ip: "&Request.ServerVariables ("REMOTE_ADDR")&"</p></body></html>"



if Not mailSendDisabled then%>
<!--#INCLUDE FILE="./incs/load_mailcomponents.asp"-->
<%
end if
Session("sentForm"&formref)="sentMsg"
end if

response.CodePage = 1252
response.write "SUCCESS#"&postSend
response.end
else

oblig="Si prega di riempire tutti i campi obbligatori"
oblig_1="Please check Mandatory* fields"
oblig_2="Bitte überprüfen Obligatorische Felder"
oblig_3="S'il vous plaît vérifiez les champs obligatoires"
oblig=eval("oblig"&session("reflang"))

response.write oblig

response.end
end if

end if%>


