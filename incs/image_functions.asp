<%
    Function getImage(strImageUrl)

  ' Set objHttp = CreateObject("Microsoft.XMLHTTP")
  ' Set objHttp = CreateObject("MSXML2.ServerXMLHTTP")
  Set objHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
  ' Set Http = CreateObject("WinHttp.WinHttpRequest")
  objHttp.Open "GET", strImageUrl, False
  objHttp.Send
            
  getImage = objHttp.ResponseBody

End Function
 

function saveImage(ByteArray, strImageName)

  Const adTypeBinary = 1
  Const adSaveCreateOverWrite = 2
  Const adSaveCreateNotExist = 1
  fileprefix = request.ServerVariables("HTTP_HOST")
    fileprefix=Replace(fileprefix, "www","")
    fileprefix=Replace(fileprefix,":","")
    fileprefix=Replace(fileprefix,"localhost","")
    fileprefix=Replace(fileprefix,"test.","")
    fileprefix=Replace(fileprefix,"lavb.","")
    y = year(now)
    m = month(now)
    d = day(now)
    min = minute(now)
    h = hour(now)
    s = second(now)

    fileprefix=fileprefix & y & m & d & h & min & s

    percorso = Server.MapPath("./")

    percorso = left(percorso,InStrRev(percorso,"\"))
    percorso = left(percorso,InStrRev(percorso,"\"))
    percorso = left(percorso,InStrRev(percorso,"\"))
    percorso = percorso & "\database\"
    addpath = "projects\"
    percorso = projectspath
    newname =  fileprefix & "_" & "0" & strImageName 
                  


    ext="."&Right(strImageName,3)
    If InStr(strImageName,".")>0 Then ext=Mid(strImageName,InstrRev(strImageName,"."))


    Set objBinaryStream = CreateObject("ADODB.Stream")
    objBinaryStream.Type = adTypeBinary
            
    objBinaryStream.Open
    objBinaryStream.Write ByteArray 
    objBinaryStream.SaveToFile percorso & newname, adSaveCreateOverWrite

    saveImage = newname

end function

function getAndSaveImage( url, strImageName ) 
    getAndSaveImage = saveImage (getImage(url), strImageName)
end function
%>