<%
Set objHttp = Server.CreateObject("WinHTTP.WinHTTPRequest.5.1")
objHttp.open "GET", "https://howsmyssl.com/a/check", False
objHttp.Send
Response.Write objHttp.responseText
Set objHttp = Nothing
%>