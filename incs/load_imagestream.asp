<%

    Set fs=Server.CreateObject("Scripting.FileSystemObject")
    Set f=fs.GetFile(strFilePath)

    Set adoStream = CreateObject("ADODB.Stream")
    dataSize = f.size

    adoStream.Open()
    adoStream.Type = 1
    adoStream.LoadFromFile(strFilePath)
    Response.Buffer = true
    Response.clear
    Response.ContentType = cnt
    Response.AddHeader "Content-Length", dataSize

    Response.flush
    While not adoStream.eos
    If Not Response.IsClientConnected Then Response.End()
    Response.BinaryWrite adoStream.Read(1024 * 4)
    Response.flush
    Wend



%>