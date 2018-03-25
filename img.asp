	<!--#INCLUDE VIRTUAL="./config/dbconfig.asp"-->
<%
servername=Request.ServerVariables("HTTP_HOST")
refer=Request.ServerVariables("HTTP_REFERER")


If (Len(refer)=0 And InStr(refer,servername)=0) Then
If session("Group")<>"admin" Then
''response.End
End If
End if

width=request("width")
path=Request("path")

ext=LCase(Mid(path,InstrRev(path,".")+1))

cnt="image/"&ext
if ext="jpg" then cnt="image/jpeg"


strFilePath = imagespath&path

if ext="ico" then
 cnt="image/x-icon"
%>
<!--#INCLUDE VIRTUAL="./incs/load_imagestream.asp"-->
<%response.end
end if


if len(width)>0 then
response.redirect("./"&imgscript&"?path="&path&"$"&width)
response.end
else
response.redirect("./"&imgscript&"?path="&path&"$1280")
response.end
end if

response.end
%>