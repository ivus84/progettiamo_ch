<!--#INCLUDE VIRTUAL="./INCS/load_connection.asp"-->
<%
getquery=request.querystring

If InStr(getquery,"/") Then
getquery=Split(getquery,"/")

f_title=getquery(0)
f_name=getquery(1)

strFilePath=projectspath & f_name



Set fs=Server.CreateObject("Scripting.FileSystemObject")

If (fs.FileExists(strFilePath))=false Then
'Response.write strFilePath
Response.Write("<HTML><TITLE>FILE NOT FOUND</TITLE></head><BODY style=""font-family:arial""><center><b>SPIACENTI</b><br><br>Il file richiesto non &egrave; stato trovato<br/><br/><a href=javascript:history.back();>&lt; INDIETRO</a></center></body></html>")
response.end
End If
set fs=nothing

f_name=LCase(f_name)
est=right(f_name,3)
If InStr(f_name,".")>0 Then est=Mid(f_name,InstrRev(f_name,".")+1)

strFileName = f_title&"_"&Day(Now())&Month(Now())&Year(Now())&"-"&Hour(Now())&Minute(Now())
strFileName = strFileName &"." & est

attmode=request("attmode")%>
<!--#INCLUDE VIRTUAL="./INCS/load_filestream.asp"-->
<%

End if

%>