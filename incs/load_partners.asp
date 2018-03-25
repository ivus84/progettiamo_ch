<%If InStr(testo,"$_partners_$") Or InStr(testo,"$_sponsors_$") Then
addprtnrs="<div class=""sponsors"">"

SQL="SELECT * from sponsors WHERE len(AT_logo)>3 AND LO_pubblica=True AND LO_partner=true ORDER BY IN_ordine, TA_nome"
If InStr(testo,"$_sponsors_$") Then 
SQL="SELECT * from sponsors WHERE len(AT_logo)>3 AND LO_pubblica=True AND LO_partner=false ORDER BY IN_ordine, TA_nome"
addprtnrs="<div class=""sponsors main_sponsors"">"
End if

Set recSponsoren=Connection.execute(SQL)
iPageSize = 150
sSQLStatement = SQL

Set recSponsoren = Server.CreateObject("ADODB.Recordset")

recSponsoren.Open sSQLStatement, Connection, adOpenStatic, adLockReadOnly

Do While Not recSponsoren.eof
urlS=recSponsoren("TA_link")
nameS=recSponsoren("TA_nome")
titS=recSponsoren("TA_titolo")
titS1=recSponsoren("TA_sotto_titolo")
imgS=recSponsoren("AT_logo")
If isnull(urlS) Or Len(urlS)=0 Then urlS="javascript:void(0)"
If len(titS1)>0 Then titS1=Replace(titS1,"-","<br />")
If InStr(testo,"$_partners_$") Then titS1="<br/>"&titS1
addprtnrs=addprtnrs& "<div><a href="""&urlS&""" target=""_blank""><img src=""/images/vuoto.gif"" class=""prt"" style=""background-image:url(/"&imgscript&"?path="&imgS&"$316)"" alt="""&nameS&""" title="""&nameS&"""/></a><br/><a href="""&urlS&""" target=""_blank""><strong>"&nameS&"</strong>"&titS1&"</a></div>"
recSponsoren.movenext
loop


addprtnrs=addprtnrs&" <br style=""clear: both;"" /></div>"
End If

testo=Replace(testo,"$_partners_$",addprtnrs)
testo=Replace(testo,"$_sponsors_$",addprtnrs)
%>