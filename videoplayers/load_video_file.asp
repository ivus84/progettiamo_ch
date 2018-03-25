<!--#INCLUDE VIRTUAL="./INCS/load_connection.asp"-->
<%
ON ERROR RESUME NEXT
Server.ScriptTimeOut = 660
Dim strFilePath, strFileSize, strFileName
nome=request("nome")

strFilePath = filespath & nome

Set fs=Server.CreateObject("Scripting.FileSystemObject")

nome=LCase(nome)
est=right(nome,3)

cnt="audio/mp3"

Response.Clear


Response.Buffer = False

Server.ScriptTimeout = 30000

    Response.ContentType = cnt
    fn = strFileName
    FPath = strFilePath
    Response.AddHeader "Content-Disposition", "inline; filename=" & fn

    Set adoStream = CreateObject("ADODB.Stream")
    chunk = 2048
    adoStream.Open()
    adoStream.Type = 1
    adoStream.LoadFromFile(FPath)

    iSz = adoStream.Size

    Response.AddHeader "Content-Length", iSz

    For i = 1 To iSz \ chunk
        If Not Response.IsClientConnected Then Exit For
        Response.BinaryWrite adoStream.Read(chunk)
    Next

    If iSz Mod chunk > 0 Then
        If Response.IsClientConnected Then
            Response.BinaryWrite adoStream.Read(iSz Mod chunk)
        End If
    End If

    adoStream.Close
    Set adoStream = Nothing

    Response.End

%>
