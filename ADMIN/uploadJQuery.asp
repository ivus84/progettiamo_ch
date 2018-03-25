<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
connection.close
server.scriptTimeout=3600

npref=Replace(Request.ServerVariables("HTTP_HOST"),".","")
npref=Replace(npref,"www","")
npref=Replace(npref,"preview","")
npref=Replace(npref,":","")
npref=Replace(npref,"distanze","")
npref=Replace(npref,"localhost","lcal")

nameprefix=npref&Day(Now())&Month(Now())&Right(Year(Now()),2)&Hour(Now())&Minute(Now())&Second(Now())
%>

<!-- #include VIRTUAL="./admin/aspUpload.asp" -->
<%
Dim uploadsDirVar
Dim Upload, fileName, fileSize, ks, i, fileKey

    Set Upload = New FreeASPUpload
    
Upload.ReadForm()
tabdest=Upload.Form("tabdest")
uploadsDirVar = imagespath

If tabdest="fails" Then uploadsDirVar = filespath
If tabdest="fails_prodotti" Then uploadsDirVar = filespath
If tabdest="AT_file" Then uploadsDirVar = filespath
If tabdest="AT_image" Then uploadsDirVar = imagespath

Upload.Save(uploadsDirVar)

    SaveFiles = ""
    ks = Upload.UploadedFiles.keys
 	totfiles=""
   
    if (UBound(ks) <> -1) then

	totfile=0
		
		for each fileKey in Upload.UploadedFiles.keys
			totfile=totfile+1
			
			origName=Upload.UploadedFiles(fileKey).FileName		
			
		ext="."&Right(origName,3)
		If InStr(origName,".")>0 Then ext=Mid(origName,InstrRev(origName,"."))

			gSize=Upload.UploadedFiles(fileKey).Length

			totfiles=totfiles & nameprefix&"_"&totfile & ext&"#"& gSize&"#"&origName&"|"
		next

totfiles=mid(totfiles,1,len(totfiles)-1)
totfiles=split(totfiles,"|")
getResults=""

for x=0 to UBound(totfiles)
getFile=split(totfiles(x),"#")
getResults=getResults&"{""name"":"""&getFile(2)&""", ""size"":"&getFile(1)&",""url"":"""&getFile(0)&""",""thumbnail_url"":"""",""delete_url"":"""",""delete_type"":""DELETE""},"
Next

getResults=Mid(getResults,1,Len(getResults)-1)
getResults="["&getResults&"]"

Response.Buffer = true
Response.clear
Response.codepage=1252
''Response.ContentType="application/json"
Response.ContentType="text/plain"
response.Charset="UTF-8"

response.write getResults

end if
	

%>