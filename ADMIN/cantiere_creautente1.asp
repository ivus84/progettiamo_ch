<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<!-- #include VIRTUAL = "./admin/clsSHA-1.asp" -->


<%

nome=request("nome")
ref=request("ref")
lettura=request("lettura")
lang=request("lang")

cognome=request("cognome")
email=request("email")
tel=request("tel")
tipo=request("tipo")

tel1=request("tel1")
fax=request("fax")
societa=request("societa")
provincia=request("provincia")
login=request("login")
pass=request("pass")
avvisi=request("avvisi")
amm=request("amm1")

if Len(pass)=0 then
response.write"La password non è stata inserita..."
response.write"<br><<a href='javascript:history.back()'>Indietro</a>"
response.end
end if

if Len(nome)<2 OR Len(cognome)<2 OR Len(email)<6 OR InStr(email, "@")=0 OR InStr(email, ".")=0 then
response.write"I campi NOME, COGNOME e EMAIL sono obbligatori e l'EMAIL deve contenere un indirizzo valido"
response.write"<br><<a href='javascript:history.back()'>Indietro</a>"
response.end
end if


if Len(tel)=0 then
tel=" "
end if

pwd0=pass&numproject

Dim ObjSHA1

Set ObjSHA1 = New clsSHA1
pass = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing

nome=Replace(nome, "'", "´")
login=Replace(login, "'", "")

cognome=Replace(cognome, "'", "´")
tel=Replace(tel, "'", "")
email=Replace(email, "'", "")
tel1=Replace(tel1, "'", "")
fax=Replace(fax, "'", "")
societa=Replace(societa, "'", "")

SQL="SELECT * FROM utenticantieri WHERE TA_login='"&login&"' OR TA_email='"&email&"'"
set record1=connection.execute(SQL)



if not record1.eof then
response.write"Il LOGIN e l'indirizzo EMAIL inserito è gi&agrave esistente;, occorre sceglierne un altro"
response.write"<br><<a href='javascript:history.back()'>Indietro</a>"
response.end
end if

if len(ref)>0 then
SQL1="SELECT CO_utenticantieri as uteresp FROM cantieri WHERE ID="&ref
set record2=connection.execute(SQL1)

uteresp=record2("uteresp")
else
uteresp=0
end if

SQL="INSERT INTO utenticantieri (TA_nome,TA_cognome,TA_login,TA_password,TA_email,TA_tel,TA_tel1,TA_fax,TA_societa,IN_tipoutente,CO_provincie1,LO_avvisi,CO_utenticantieri,LO_attivo,LO_amministrazione,TA_admin_language) VALUES ('"&nome&"','"&cognome&"','"&login&"','"&pass&"','"&email&"','"&tel&"','"&tel1&"','"&fax&"','"&societa&"',"&tipo&",1,"&avvisi&","&uteresp&",True,True,'"&lang&"')"

set record1=connection.execute(SQL)

SQL="SELECT MAX(ID) as utente from utenticantieri"
set record1=connection.execute(SQL)
utente=record1("utente")

if len(ref)>0 then
SQL1="INSERT INTO associa_cantieri_utenticantieri (CO_cantieri,CO_utenticantieri,LO_scrittura) values ("&ref&","&utente&","&lettura&")"
set record1=connection.execute(SQL1)
end if

response.redirect("utenti.asp?page="&utente)
connection.close%>