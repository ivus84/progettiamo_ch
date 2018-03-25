<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
cptch=request("cptch")
TA_email=request("email")

If cptch<>Session("checkcaptcha") Then
Response.write "CODE"
Response.End
End If

If Len(TA_email)>5 Then

SQL="SELECT * FROM address WHERE TA_email='"&TA_email&"'"
Set rec=connection.execute(SQL)

If rec.eof Then
Response.write "NOEXIST"
Response.End
End if



SQL="DELETE FROM address WHERE TA_email='"&TA_email&"'"
Set rec=connection.execute(SQL)

enabled=True
if enabled=True then

Email = TA_email

Set Mail = Server.CreateObject("Persits.MailSender")
		Mail.Host = "localhost"
		Mail.From = Email
		Mail.FromName = Email
		Mail.AddAddress  "newsletter-unsubscribe@progettiamo.ch", ""
		Mail.Subject = ""
		Mail.Body = ""
		Mail.IsHTML = False
		Mail.Send
Set Mail = Nothing

Set Mail = Server.CreateObject("Persits.MailSender")
		Mail.Host = mailhost
		Mail.Port = 587
		Mail.From = sendmailer
		Mail.AddAddress  Email, ""
		Mail.Subject = "progettiamo.ch - Disiscrizione dalla newsletter"
		Mail.Body = "Il vostro indirizzo &egrave; stato eliminato dalla nostra newsletter<br/><br/>Grazie e a presto<br/>il team di progettiamo.ch"
		Mail.IsHTML = True
		Mail.Username = sendmailer
		Mail.Password = sendpassword
		Mail.Send
Set Mail = Nothing



End If

Response.write "OK"
End if

connection.close
%>