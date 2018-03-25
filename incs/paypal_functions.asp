<% 'Paypal Common Functions%>
<!--#INCLUDE VIRTUAL="/config/dbconfig.asp"-->
<!--#include virtual="/incs/json2.asp"-->

<%
'Credenziali https://www.sandbox.paypal.com
'ivo.barone-facilitator@gmail.com/ivus1984
'ivo.barone-buyer@gmail.com/ivus1984

'Client ID
'ATqgWde26gpJCQXJRWgPEf6_3rTuE24GsJBnC8p3VHu1La7pioS7cTHpDi1ziSCPJstk6eBKt9qfv884
Const CLIENT_ID = "ATqgWde26gpJCQXJRWgPEf6_3rTuE24GsJBnC8p3VHu1La7pioS7cTHpDi1ziSCPJstk6eBKt9qfv884"
'Secret
'EKCC3bRvFNnkAfn8jDaTFfX8OnW7kAZGpCX7axqO9Z4P2PH_wWa4WCPVDaGnH9Si8GRbAo4rbbRTh1Dq
const CLIENT_SECRET = "EKCC3bRvFNnkAfn8jDaTFfX8OnW7kAZGpCX7axqO9Z4P2PH_wWa4WCPVDaGnH9Si8GRbAo4rbbRTh1Dq"
RETURN_URL = site_mainurl & "paypal_return.asp"
CANCEL_URL = site_mainurl & "paypal_cancel.asp"


'access_token = GetAccessToken(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI, AUTHORIZATION_CODE)
auth_token = GetAuthToken()
redirect_url=  MakePaymentRequest(10.0, "CHF", "test",auth_token)
if redirect_url <> "" then
    response.redirect(redirect_url)
else
    response.write "Errore Richiesta"
end if


Function GetAuthToken()
GetAuthToken = ""
'curl -v https://api.sandbox.paypal.com/v1/oauth2/token \
'  -H "Accept: application/json" \
'  -H "Accept-Language: it_IT" \
'  -u "client_id:secret" \
'  -d "grant_type=client_credentials"
dim data
data = "grant_type=client_credentials"
'Set http = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
set http = Server.CreateObject("WinHTTP.WinHTTPRequest.5.1")
dim SXH_OPTION_SELECT_CLIENT_SSL_CERT : SXH_OPTION_SELECT_CLIENT_SSL_CERT = 3
http.option(SXH_OPTION_SELECT_CLIENT_SSL_CERT)= "LOCAL_MACHINE\C:\inetpub\wwwroot\progettiamo_ch\cert_key_pem.txt"
'http.option(9) = 2720
with http
    .open "POST", "https://api.sandbox.paypal.com/v1/oauth2/token", False
    .setRequestHeader "Accept-Language", "it_IT"
    .setRequestHeader "Accept", "application/json"
    .setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    .setRequestHeader "Authorization", "Basic " & base64_encode(CLIENT_ID & ":" & CLIENT_SECRET) 
    .send data
    response.write .responseText
    dim Info : set Info = JSON.parse(.responseText)
    
    GetAuthToken = Info.access_token
end with

http = nothing
End Function




Function MakePaymentRequest(amount, curr, description, auth_token)
    dim data
    dim payer: set payer=JSON.parse ("{}")
    dim transactions(1)
    dim transaction : set transaction = JSON.parse ("{}")
    dim amt : set amt = JSON.parse ("{}")
    dim redirect_urls : redirect_urls = JSON.parse ("{}")

    'Set http = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
        set http = Server.CreateObject("WinHttp.WinHttpRequest.5.1")
        http.option (9) = 2720
    with http
        .open "POST", "https://api.sandbox.paypal.com/v1/payments/payment", False
        .setRequestHeader "Content-Type", "application/json"
        .setRequestHeader "Authorization", "Bearer " & auth_token
        set data = JSON.parse ("{}")
        data.set "intent" , "sale"
        payer.set "payment_method", "paypal"
        redirect_urls.set "return_url",RETURN_URL
        redirect_urls.set "cancel_url",CANCEL_URL
        amt.set "total", amount
        amt.set "currency", curr
        transaction.set "amount", amount
        transaction.set "description" , description
        set transactions(0) = transaction
        data.set "payer", payer
        data.set "redirect_urls",redirect_urls
        data.set "transactions", transactions
        .send data
        response.write .responseText
        dim Info : set Info = JSON.parse(.responseText)
        if Info.state ="created" then
        for each lnk in Info.links
            if lnk.rel = "approval_url" then
                MakePaymentRequest = lnk.href
            end if
        next
        end if
        
    end with

    http = nothing
end Function
 %>