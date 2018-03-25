<%
''Set RecordSet = Server.CreateObject("ADODB.Recordset")
''recordset.PageSize = iPageSize
''recordset.CacheSize = iPageSize
''RecordSet.Fields.Append "TA_nome", adVarChar, 255, 255
''RecordSet.Fields.Append "DT_data", adDate, 7
''RecordSet.Open

  ''Set fso = CreateObject("Scripting.FileSystemObject")
    ''Set apri = fso.GetFolder(imagespath)
       ''For Each file In apri.Files
            ''fname=file.name
			''datecreated=file.DateLastModified
''If InStr(fname,"vuoto.")=0 AND InStr(fname,".ico")=0 AND InStr(fname,"videoThumb_")=0 then
''RecordSet.AddNew
''RecordSet.Fields("TA_nome").Value = fname
''RecordSet.Fields("DT_data").Value = Day(datecreated)&"/"&Month(datecreated)&"/"&Year(datecreated)
''RecordSet.Update
''End if
				''Next


''Set fso=Nothing
''''If Not recordset.eof then
''RecordSet.sort = "DT_data " & " DESC"
''RecordSet.MoveFirst
''End If

SQL="SELECT ID, immagini.TA_nome as TA_nome,1 as mode FROM immagini Union SELECT ID, oggetti.AT_image as TA_nome, 2 as mode from oggetti WHERE LEN(AT_image)>0 ORDER BY mode ASC, ID DESC"
Set recordset = Server.CreateObject("ADODB.Recordset")
RecordSet.PageSize = iPageSize
RecordSet.CacheSize = iPageSize

recordset.Open SQL, Connection, adOpenStatic, adLockReadOnly


nofound="Nessuna immagine trovata"

sPageURL = Request.ServerVariables ("SCRIPT_NAME")
iCurrentPage = Request("Page")
If iCurrentPage = "" Or Len(iCurrentPage)=0 Then iCurrentPage = 1


if recordset.eof then
response.write "<p class=""testoadm"">"&nofound&"</p>"
else

recordset.AbsolutePage = iCurrentPage
Totale=recordset.RecordCount

found="<div class=""testoadm"" style=""font-size:11px"">"&totale&" Images, page "&iCurrentPage&" of "&recordset.PageCount&" > "

addwrite=""


addUrlSearch=""
addStyleLink=" style=""font-size:12px;"""

addnav=""
totpages=recordset.PageCount

startCount=iCurrentPage
maxcountP=startCount+4

If maxcountP>totpages Then maxcountP=totpages

If startcount<5 Then 
startCount=1
maxcountP=startCount+4
ElseIf startcount>=5 And (maxcountP-startCount)>=4 then
maxcountP=startcount+2
startcount=startcount-2
ElseIf startcount>=5 And (maxcountP-startCount)<4 Then
startCount=maxcountP-4
maxcountP=startCount+4
End If

If maxcountP>totpages Then maxcountP=totpages

If startCount > 1 Then 	addnav = addnav & "<a href=""" & sPageURL & "?Page=" & startCount-1 &"&search="&search&""" style=""background:transparent"">...</a>&nbsp;"

	For i = startCount To maxcountP
	If i = CInt(iCurrentPage) Then
	addnav = addnav & "" & i & "&nbsp;"
	Else
addnav = addnav &  "<a href=""" & sPageURL & "?Page=" & i &"&search="&search&""" >" & i & "</a>&nbsp;"
	End If
	Next

If maxcountP < totPages Then 	addnav = addnav &  "... <a href=""" & sPageURL & "?Page=" & totPages &"&search="&search&""" >" & totPages & "</a>&nbsp;"


addnav = addnav & ""

response.write found&addnav&"</div>"


end if



addscript=""
if request("mode")="uploaded" then
if not recordset.eof then addscript="setTimeout(""chooseImage('"&recordset("TA_nome")&"');"",1200);"
end if%>

<%
ii=0
perrow=5
intCurrentRecord = 1


do While intCurrentRecord <= iPageSize
if not recordset.eof then
tWidth=55
ii=ii+1
TA_nome=recordset("TA_nome")
TA_nome=Replace(TA_nome," ","")
if ii=1 then firstID=ID

%>
<div class="loadImage" style="height:<%=tWidth%>px;width:<%=tWidth%>px; background-image: url(../<%=imgscript%>?path=<%=TA_nome%>$<%=tWidth*2%>)" onclick="javascript:chooseImage('<%=TA_nome%>');"></div>
<%
''if InStr((intCurrentRecord/perrow),".")=False AND InStr((intCurrentRecord/perrow),",")=False then response.write"</tr><tr>"
recordset.movenext
end if
intCurrentRecord=intCurrentRecord+1
loop
%>
