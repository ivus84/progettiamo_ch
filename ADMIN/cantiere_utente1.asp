<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<!-- #include VIRTUAL = "./admin/clsSHA-1.asp" -->

<%

nome=request("nome")
ref1=request("ref1")

cognome=request("cognome")
email=request("email")
tel=request("tel")
tel1=request("tel1")
fax=request("fax")
societa=request("societa")
provincia=request("provincia")
pass=request("pass")
tipo=request("tipo")
tipo=request("tipo")
amm1=request("amm1")
amm2=request("amm2")
amm3=request("amm3")
amm5=request("amm5")
amm6=request("amm6")
areac=request("areac")
avvisi=request("avvisi")
CO_p_area=request("CO_p_area")


cv=" "

if Len(areac)=0 OR IsNull(areac)=True Then areac=0



LO_consulenza=request("LO_consulenza")
LO_newsletter=request("LO_newsletter")
LO_utenti=request("LO_utenti")
LO_software=request("LO_software")
LO_cantieri=request("LO_cantieri")
LO_admusers=request("LO_admusers")
LO_iscrizioni=request("LO_iscrizioni")
LO_admanmeldung=request("LO_admanmeldung")
LO_admkontakt=request("LO_admkontakt")

if Len(amm1)>0 Then 
amm1="True"
Else
amm1="False"
End If

if Len(LO_iscrizioni)>0 Then 
LO_iscrizioni="True"
Else
LO_iscrizioni="False"
End If

if Len(LO_consulenza)>0 Then 
LO_consulenza="True"
Else
LO_consulenza="False"
End If

if Len(LO_newsletter)>0 Then 
LO_newsletter="True"
Else
LO_newsletter="False"
End If

if Len(LO_utenti)>0 Then 
LO_utenti="True"
Else
LO_utenti="False"
End If

if Len(LO_admusers)>0 Then 
LO_admusers="True"
Else
LO_admusers="False"
End If


if Len(LO_software)>0 Then 
LO_software="True"
Else
LO_software="False"
End If

if Len(LO_cantieri)>0 Then 
LO_cantieri="True"
Else
LO_cantieri="False"
End If

if Len(LO_admkontakt)>0 then
LO_admkontakt="True"
else
LO_admkontakt="False"
end if
if Len(LO_admanmeldung)>0 then
LO_admanmeldung="True"
else
LO_admanmeldung="False"
end if

if Len(amm2)>0 then
amm2="True"
else
amm2="False"
end if

if Len(amm3)>0 then
amm3="True"
else
amm3="False"
end if
if Len(amm5)>0 then
amm5="True"
else
amm5="False"
end if

if Len(amm6)>0 then
amm6="True"
else
amm6="False"
end if

if len(tel)=0 then
tel=" "
end if



if Len(nome)<2 OR Len(cognome)<2 OR Len(email)<6 OR InStr(email, "@")=0 OR InStr(email, ".")=0 then
response.write"I campi NOME, COGNOME e EMAIL sono obbligatori e l'EMAIL deve contenere un indirizzo valido"
response.write"<br><<a href='javascript:history.back()'>Indietro</a>"
response.end
end if

nome=Replace(nome, "'", "�")
cognome=Replace(cognome, "'", "�")
tel=Replace(tel, "'", "")
email=Replace(email, "'", "")
tel1=Replace(tel1, "'", "")
fax=Replace(fax, "'", "")
societa=Replace(societa, "'", "")


If Len(pass)<20 Then
pwd0=pass&numproject

Dim ObjSHA1

Set ObjSHA1 = New clsSHA1
pass = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing
'response.write pass
'response.end
End if

SQL="UPDATE utenticantieri set TX_cv='"&cv&"',CO_p_area="&CO_p_area&",LO_attivo="&amm3&",LO_amministrazione="&amm1&",LO_contenuti="&amm5&",LO_utenti="&LO_utenti&",LO_consulenza="&LO_consulenza&",LO_software="&LO_software&",LO_newsletter="&LO_newsletter&",LO_cantieri="&LO_cantieri&",TA_nome='"&nome&"',TA_email='"&email&"',TA_cognome='"&cognome&"',TA_password='"&pass&"',TA_tel='"&tel&"',TA_tel1='"&tel1&"',TA_fax='"&fax&"',TA_societa='"&societa&"',CO_provincie1="&provincia&",LO_avvisi="&avvisi&",LO_admusers="&LO_admusers&",LO_iscrizioni="&LO_iscrizioni&",LO_admanmeldung="&LO_admanmeldung&",LO_admkontakt="&LO_admkontakt&",IN_tipoutente="&tipo&" WHERE ID="&ref1
set record1=connection.execute(SQL)

if amm6="True" then
amm6=True
else
amm6=False
end if

if amm5="True" then
amm5=True
else
amm5=False
end if

Session("allow_utenti")=amm6
Session("allow_contenuti")=amm5

response.redirect("cantiere_utente.asp?ref1="&ref1)


connection.close%>