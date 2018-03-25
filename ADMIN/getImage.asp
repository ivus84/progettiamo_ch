
<%
filename=request("filename")
response.buffer = true
'create a stream object
Dim objStream
Set objStream = Server.CreateObject("ADODB.Stream")


 objStream.Type = 1
 objStream.Open
 objStream.LoadFromFile filename
 Response.ContentType = "image/JPEG"
 Response.AddHeader "content-disposition", "inline;filename=image.jpg"
 Response.BinaryWrite objStream.Read

'clean up..
objStream.Close
Set objStream = Nothing
%>