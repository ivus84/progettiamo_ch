<%
    ''SET CONTENT TYPE
    if est="doc" OR est="rtf" Or est="docx" then
    cnt="application/msword"
    elseif est="jpg" OR est="epg" then
    cnt="image/jpeg"
    elseif est="gif" then
    cnt="image/gif"
    elseif est="xls" OR est="xlc" OR est="xlm" OR est="xlt" OR est="xlw" then
    cnt="application/vnd.ms-excel"
    elseif est="pps" OR est="ppt" OR est="pot" then
    cnt="application/vnd.ms-powerpoint"
    elseif est="pdf" OR est="zip" then
    cnt="application/"&est
    elseif est="html" OR est="htm" OR est="txt" then
    cnt="text/html"
    elseif est="asf" OR est="asr" OR est="asx" then
    cnt="video/x-ms-asf"
    else
    cnt="application/unknown"
    end if

        fn = strFileName
        FPath = strFilePath



 Set fs=Server.CreateObject("Scripting.FileSystemObject")
    Set f=fs.GetFile(FPath)

    Set adoStream = CreateObject("ADODB.Stream")
    dataSize = f.size


If Len(attmode)=0 Then attmode="attachment"
    Set adoStream = CreateObject("ADODB.Stream")
    adoStream.Open()
    adoStream.Type = 1
    adoStream.LoadFromFile(FPath)
    Response.Buffer = true
    Response.clear
    Response.ContentType = cnt
    Response.AddHeader "Content-Length", dataSize
    Response.AddHeader "Content-Disposition", attmode&"; filename=" & fn

    Response.flush
    While not adoStream.eos
    If Not Response.IsClientConnected Then Response.End()
    Response.BinaryWrite adoStream.Read(1024 * 4)
    Response.flush
    Wend

Response.End%>