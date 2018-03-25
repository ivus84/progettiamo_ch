<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
cptch=request("cptch")
TA_nome=request("nome")
TA_cognome=request("cognome")
TA_email=request("email")

If cptch<>Session("checkcaptcha") Then
Response.write "CODE"
Response.End
End If

If Len(TA_nome)>0 AND Len(TA_cognome)>0 And Len(TA_email)>5 Then
TA_nome=Replace(TA_nome,"'","''")
TA_cognome=Replace(TA_cognome,"'","''")

SQL="SELECT * FROM address WHERE TA_email='"&TA_email&"'"
Set rec=connection.execute(SQL)

If Not rec.eof Then
Response.write "EXIST"
Response.End

End if



SQL="INSERT INTO address (TA_nome,TA_cognome,TA_email,TA_ip) VALUES ('"&TA_nome&"','"&TA_cognome&"','"&TA_email&"','"&Request.ServerVariables("REMOTE_ADDR")&"')"
Set rec=connection.execute(SQL)
Response.write "OK"

enabled=True
if enabled=True then

Set Mail = Server.CreateObject("Persits.MailSender")
		Mail.Host = "localhost"
		Mail.From = TA_email
		Mail.FromName = TA_email
		Mail.AddAddress  "newsletter-subscribe@progettiamo.ch", ""
		Mail.Subject = ""
		Mail.Body = ""
		Mail.IsHTML = False
		Mail.Send
Set Mail = Nothing

Set Mail = Server.CreateObject("Persits.MailSender")
		Mail.Host = mailhost
		Mail.Port = 587
		Mail.From = sendmailer
		Mail.AddAddress  TA_email, ""
		Mail.Subject = "progettiamo.ch - Iscrizione alla newsletter"
		Mail.Body = "Il vostro indirizzo &egrave; stato aggiunto alla nostra newsletter<br/><br/>Grazie e a presto<br/>il team di progettiamo.ch"
		Mail.IsHTML = True
		Mail.Username = sendmailer
		Mail.Password = sendpassword
		Mail.Send
Set Mail = Nothing
End if


End if

connection.close
%>