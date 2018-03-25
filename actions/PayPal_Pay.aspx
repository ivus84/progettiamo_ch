<%@ Page Language="VB" %>
<%@ Import Namespace="System.Net" %>
<script runat="server">

dim site_mainurl as string 
'Client ID
'ATqgWde26gpJCQXJRWgPEf6_3rTuE24GsJBnC8p3VHu1La7pioS7cTHpDi1ziSCPJstk6eBKt9qfv884
Const CLIENT_ID = "ATqgWde26gpJCQXJRWgPfEf6_3rTuE24GsJBnC8p3VHu1La7pioS7cTHpDi1ziSCPJstk6eBKt9qfv884"
'Secret
'EKCC3bRvFNnkAfn8jDaTFfX8OnW7kAZGpCX7axqO9Z4P2PH_wWa4WCPVDaGnH9Si8GRbAo4rbbRTh1Dq
const CLIENT_SECRET = "EKCC3bRvFNnkAfn8jDaTFfX8OnW7kAZGpCX7axqO9Z4P2PH_wWa4WCPVDaGnH9Si8GRbAo4rbbRTh1Dq"
dim RETURN_URL as string
dim CANCEL_URL as string 
Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
    site_mainurl="http://" & Request.ServerVariables("HTTP_HOST") & "/"
    RETURN_URL = site_mainurl & "paypal_return.asp"
    CANCEL_URL = site_mainurl & "paypal_cancel.asp"
    dim auth_token = GetAuthToken()
    dim redirect_url = ""
    'redirect_url=  MakePaymentRequest(10.0, "CHF", "test",auth_token)
if redirect_url <> "" then
    response.redirect(redirect_url)
else
    response.write ("Errore Richiesta")
end if
end sub
Function GetAuthToken()
GetAuthToken = ""

dim data  As New NameValueCollection
data.add ( "grant_type","client_credentials")
'Set http = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
dim http = new WebClient
with http
    '.open "POST", "https://api.sandbox.paypal.com/v1/oauth2/token", False
    '.setRequestHeader "Accept-Language", "it_IT"
    .Headers.Add("Accept-Language", "it_IT")
    '.setRequestHeader "Accept", "application/json"
    .Headers.Add("Accept", "application/json")
    '.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    .Headers.Add("Content-Type", "application/x-www-form-urlencoded")
    '.setRequestHeader "Authorization", "Basic " & base64_encode(CLIENT_ID & ":" & CLIENT_SECRET) 
    .Headers.Add("Authorization", "Basic " & Convert.ToBase64String(Encoding.Unicode.GetBytes(CLIENT_ID & ":" & CLIENT_SECRET)))
    '.send data
    System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls
    response.write (.uploadvalues("https://api.sandbox.paypal.com/v1/oauth2/token",data))
    
    'response.write .responseText
    'dim Info : set Info = JSON.parse(.responseText)
    
    'GetAuthToken = Info.access_token
end with

http = nothing
End Function




Function MakePaymentRequest(amount, curr, description, auth_token)
<%--    dim data
    dim payer: set payer=JSON.parse ("{}")
    dim transactions(1)
    dim transaction : set transaction = JSON.parse ("{}")
    dim amt : set amt = JSON.parse ("{}")
    dim redirect_urls : redirect_urls = JSON.parse ("{}")

    Set http = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
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

    http = nothing--%>
end Function

</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
