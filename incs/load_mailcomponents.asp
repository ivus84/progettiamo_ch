<%


    'mailsubject = "=?UTF-8?B?"&base64_encode(mailsubject)&"?="
    'mailsubject = "=?UTF-8?B?"&mailsubject&"?="
    mailsubject = ConvertFromUTF8(mailsubject)
    mailsubject = HTMLDecode(mailsubject)
    if fromname = "" then fromname = sendmailer
if component="Persits.Mail" then
Set Mail = Server.CreateObject("Persits.MailSender")
Mail.Host = mailhost
Mail.Port = 587
Mail.From = sendmailer
    
Mail.FromName = fromname
Mail.Username  = sendmailer
Mail.Password  = sendpassword
Mail.AddAddress  sendto
if len(sendtobcc)>0 then Mail.AddBcc sendtobcc
Mail.Subject = mailsubject
Mail.CharSet = "UTF-8"
Mail.ContentTransferEncoding = "Quoted-Printable"
Mail.IsHTML = True
Mail.Body = HTML
Mail.Send
Set Mail = Nothing

elseif component="CdoSys" then
%>
<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" NAME="CDO for Windows 2000 Library" -->
<%
Set objMessage = CreateObject("CDO.Message")
Set objConfig = CreateObject("CDO.Configuration")
objConfig.Fields(cdoSendUsingMethod) = cdoSendUsingPort
objConfig.Fields(cdoSMTPServer) = mailhost
objConfig.Fields(cdoSMTPServerPort) = 587
objConfig.Fields(cdoSMTPConnectionTimeout) = 60
objConfig.Fields(cdoSMTPauthenticate) = cdoBasic
objConfig.Fields(cdoSendUserName) = sendmailer
objConfig.Fields(cdoSendPassword) = sendpassword
objConfig.Fields.Update
Set objMessage.Configuration = objConfig
objMessage.BodyPart.Charset = "utf-8"


objMessage.To = sendto
if len(sendtobcc)>0 then objMessage.Bcc = sendtobcc
    
objMessage.From = fromname & "<"&sendmailer&">"
objMessage.ReplyTo = sendmailer
objMessage.Subject = mailsubject
objMessage.HtmlBody = HTML
    if href <> "" then
        with objMessage 
        .HtmlBody = ""
        .CreateMHTMLBody(href)
        .MimeFormatted = True
        end with 
    end if 
objMessage.HTMLBodyPart.Charset = "utf-8"
objMessage.Send
Set objMessage = Nothing
Set objConfig = Nothing
end if
%>