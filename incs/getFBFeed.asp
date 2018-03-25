<%
response.charset="UTF-8"
response.codepage=65001
strURL="https://graph.facebook.com/1416183075301590/feed?access_token=617308955017050|HM3lXqscPl2E0px9FAdBJ9qk01I&limit=50"


If Len(Session("fbfeed"))=0 Then
Set objXMLHTTP = Server.CreateObject("Msxml2.ServerXMLHTTP")
objXMLHTTP.Open "GET", strURL , false
'objXMLHTTP.Send()
'xml=""&objXMLHTTP.responseText
xml ="[]"
Set objXMLHTTP = Nothing

xml=Mid(xml,InStr(xml,"["))
xml=Mid(xml,1,InStrRev(xml,"]"))
Session("fbfeed") = xml
End if

xml = Session("fbfeed")

Response.Buffer = true
Response.clear

Response.ContentType="application/json"
response.Charset="UTF-8"

response.write (request("jsoncallback")&"("&xml&")")
%>