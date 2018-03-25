<!--#INCLUDE VIRTUAL="./INCS/load_connection.asp"--><%
Dim strFilePath, strFileSize, strFileName

nome=request("name")
if len(request("nome"))>0 then nome=request("nome")
if len(request("file"))>0 then nome=request("file")
if len(request("load"))>0 then nome=request("load")
if len(request("titolo"))>0 then oggetto=request("titolo")

SQL="SELECT TA_titolo FROM fails WHERE TA_nome='"&nome&"'"
set rec=connection.execute(SQL)
if not rec.eof then
oggetto=rec("TA_titolo")
end if

connection.close

If Len(nome)>0 Then
nome=Replace(nome,"\","")
End If


strFilePath=filespath&nome
strFilePath1=imagespath&nome

'Response.write strFilePath
'Response.End

Set fs=Server.CreateObject("Scripting.FileSystemObject")

If (fs.FileExists(strFilePath))=false Then
	  If (fs.FileExists(strFilePath1))=true Then 
		strFilePath=strFilePath1
		Else
	  Response.Write("<HTML><TITLE>FILE NOT FOUND</TITLE></head><BODY><center><b>SORRY</b><br><br>The requested file was not found on sever<br><br><a href=javascript:history.back();>GO BACK</a></center></body></html>")
response.end
End If
End If
set fs=nothing



nome=LCase(nome)
est=right(nome,3)
If InStr(nome,".")>0 Then est=Mid(nome,InstrRev(nome,".")+1)


videoextensions=" flv , wmv , .rm , ram , .rv , mov , .qt , mp3 , mp4 , mp2 , mpa , mpe , mpeg , mpg , mpv2 "

IF Instr(videoextensions, est)<>0 THEN
response.redirect("/videoEmbed.asp?"&nome)
response.end
END IF


if len(oggetto)>0 then
oggetto=Replace(oggetto, CHR(32)&CHR(32)&CHR(32), "")
oggetto=Replace(oggetto, CHR(32)&CHR(32), "")
oggetto=Replace(oggetto, CHR(32), "_")
oggetto=Replace(oggetto, CHR(39), "")
oggetto=linkMaker(oggetto)
end if
strFileName = oggetto&"_"&Day(Now())&Month(Now())&Year(Now())&"-"&Hour(Now())&Minute(Now())
strFileName=Replace(strFileName,",","")
strFileName=Replace(strFileName,".","")

strFileName = strFileName &"." & est

attmode=request("attmode")%><!--#INCLUDE VIRTUAL="./INCS/load_filestream.asp"-->