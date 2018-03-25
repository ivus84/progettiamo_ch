<%
Set RecordSet = Server.CreateObject("ADODB.Recordset")
ipageSize=50
recordset.PageSize = iPageSize
recordset.CacheSize = iPageSize
RecordSet.Fields.Append "TA_nome", adVarChar, 255, 255
RecordSet.Fields.Append "DT_data", adDate, 7
RecordSet.Open



  Set fso = CreateObject("Scripting.FileSystemObject")
    Set apri = fso.GetFolder(filespath)
       For Each file In apri.Files
            fname=file.name
			datecreated=file.DateLastModified

If InStr(fname,"vuoto.")=0 AND InStr(fname,".ico")=0 then
RecordSet.AddNew
RecordSet.Fields("TA_nome").Value = fname
RecordSet.Fields("DT_data").Value = Day(datecreated)&"/"&Month(datecreated)&"/"&Year(datecreated)
RecordSet.Update
End if
				Next
Set fso=nothing
RecordSet.sort = "DT_data " & " DESC"
RecordSet.MoveFirst

nofound="Nessuna immagine trovata"

sPageURL = Request.ServerVariables ("SCRIPT_NAME")
iCurrentPage = Request("Page")
If iCurrentPage = "" Or Len(iCurrentPage)=0 Then iCurrentPage = 1


if recordset.eof then
response.write "<p class=""testoadm"">"&nofound&"</p>"
else

recordset.AbsolutePage = iCurrentPage
Totale=recordset.RecordCount

found="<p class=""testoadm"" style=""font-size:12px"">"&totale&" Images, page "&iCurrentPage&" of "&recordset.PageCount&"<img src=images/vuoto.gif border=0 align=absbottom width=""8""/>"

addwrite=""


addUrlSearch=""
addStyleLink=" style=""font-size:12px;"""

if recordset.PageCount>1 then
addwrite=addwrite&found

		if CInt(iCurrentPage) > 1 then
		iii=CInt(iCurrentPage)-1
		addwrite=addwrite&"<a href=""" & sPageURL & "?Page=" & iii &addUrlSearch&""""&addStyleLink&"><<</a><img src=images/vuoto.gif border=0 align=absbottom width=""8""/>"
		else
		addwrite=addwrite&"<img src=images/vuoto.gif border=0 align=absbottom>"
		end if
addwrite=addwrite&"[&nbsp;"
		For i = 1 to recordset.PageCount
		If i = CInt(iCurrentPage) Then
		addwrite=addwrite&"" & i & "&nbsp;"
		Else
		addwrite=addwrite&"<a href=""" & sPageURL & "?Page=" & i &addUrlSearch&""""&addStyleLink&">" & i & "</a>&nbsp;"
		End If
		Next
addwrite=addwrite&"&nbsp;]"

		if CInt(iCurrentPage) < recordset.PageCount then
		ii=CInt(iCurrentPage)+1
		addwrite=addwrite&"<img src=images/vuoto.gif border=0 align=absbottom width=""8""/><a href=""" & sPageURL & "?Page=" & ii &addUrlSearch&""""&addStyleLink&">>></a>"
		end if

addwrite=addwrite&"</p>"

response.write addwrite
end if

end if



addscript=""
if request("mode")="uploaded" then
if not recordset.eof then addscript="setTimeout(""chooseImage('"&recordset("TA_nome")&"');"",1200);"
end if%>

<table width="100%" border="0" cellpadding="2" cellspacing="1"><tr>
<%
ii=0
perrow=5
intCurrentRecord = 1


do While intCurrentRecord <= iPageSize
if not recordset.eof then
tWidth=65
TA_nome=recordset("TA_nome")
TA_nome=Replace(TA_nome," ","")
SQL="SELECT ID FROM fails WHERE TA_nome='"&TA_nome&"' UNION SELECT ID FROM fails_prodotti WHERE TA_nome='"&TA_nome&"' UNION SELECT ID FROM oggetti WHERE Instr(TX_testo,'"&TA_nome&"')>0"
Set rec=Connection.execute(SQL)
If rec.eof Then  
ii=ii+1
%>
<td valign=middle align=center><div style="Position:relative;left:0px; top:0px; height:<%=tWidth%>px;width:<%=tWidth%>px; overflow:hidden;border:solid 1px #bababa; vertical-align:middle;background-color:#ffffff"><table style="height:<%=tWidth%>px;width:<%=tWidth%>px;" border="0" cellpadding="0" cellspacing="0"><tr><td valign="middle">
<%=TA_nome%><br/>
<a href="delImg.asp?path=<%=TA_nome%>&da=files.asp"><img src="./images/delete1.gif" border="0" align="bottom"/></a>
</td></tr></table></div>
</td>
<%
End If
if ii=perrow then 
response.write"</tr><tr>"
ii=0
end if
recordset.movenext
end if
intCurrentRecord=intCurrentRecord+1
loop
%>
</tr></table>