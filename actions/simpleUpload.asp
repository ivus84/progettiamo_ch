<!-- #include VIRTUAL="./admin/aspUpload.asp" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
connection.close
server.scriptTimeout=3600

npref=Replace(Request.ServerVariables("HTTP_HOST"),".","")

npref=Replace(npref,"www","")
npref=Replace(npref,":","")
npref=Replace(npref,"lavb","")
npref=Replace(npref,"localhost","progettiamo.ch")
npref=Replace(npref,"test.","")

Dim uploadsDirVar
Dim Upload, fileName, fileSize, ks, i, fileKey

Set Upload = New FreeASPUpload
    
Upload.ReadForm()

nameprefix=Upload.Form("nameprefix")
operationType=Upload.Form("operationType")

uploadsDirVar = imagespath

Upload.Save(uploadsDirVar)
if operationType="insert" then
    response.redirect "../admin/amici.asp"
elseif operationType="update" then
    response.write "<script>window.parent.parent.location.reload(false);</script>"
end if
%>