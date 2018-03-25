<div id="footer">
	
	<div class="footer_container">
	<p><%=str_sponsor%><span style="margin-left:62px"><%=str_sponsor1%></span></p>
	<div class="sponsors">
<%

SQL="SELECT * from sponsors WHERE len(AT_logo)>3 AND LO_pubblica=True AND LO_partner=False ORDER BY IN_ordine, TA_nome"
Set recSponsoren=Connection.execute(SQL)
iPageSize = 150
sSQLStatement = SQL

Set recSponsoren = Server.CreateObject("ADODB.Recordset")

recSponsoren.Open sSQLStatement, Connection, adOpenStatic, adLockReadOnly
TotSp=recSponsoren.RecordCount



If TotSp>0 then

Do While Not recSponsoren.eof
urlS=recSponsoren("TA_link")
nameS=recSponsoren("TA_nome")
titS=recSponsoren("TA_titolo")
imgS=recSponsoren("AT_logo")
If isnull(urlS) Or Len(urlS)=0 Then urlS="javascript:void(0)"
Response.write "<div><a href="""&urlS&""" target=""_blank""><img src=""/images/vuoto.gif"" style=""background-image:url(/"&imgscript&"?path="&imgS&"$316)"" alt="""&nameS&""" title="""&nameS&"""/></a></div>"
recSponsoren.movenext
loop


End if%>
       
</div>
</div>

<div class="footer_container">
   
<p><%=str_progetto_condiviso%></p>

	<div class="sponsors">
<%

SQL="SELECT * from sponsors WHERE len(AT_logo)>3 AND LO_homepage AND LO_pubblica AND LO_partner ORDER BY IN_ordine, TA_nome"
Set recSponsoren=Connection.execute(SQL)
iPageSize = 150
sSQLStatement = SQL

Set recSponsoren = Server.CreateObject("ADODB.Recordset")

recSponsoren.Open sSQLStatement, Connection, adOpenStatic, adLockReadOnly
TotSp=recSponsoren.RecordCount



If TotSp>0 then

Do While Not recSponsoren.eof
urlS=recSponsoren("TA_link")
nameS=recSponsoren("TA_nome")
titS=recSponsoren("TA_titolo")
imgS=recSponsoren("AT_logo")
If isnull(urlS) Or Len(urlS)=0 Then urlS="javascript:void(0)"
Response.write "<div><a href="""&urlS&""" target=""_blank""><img src=""/images/vuoto.gif"" class=""prt"" style=""background-image:url(/"&imgscript&"?path="&imgS&"$316)"" alt="""&nameS&""" title="""&nameS&"""/></a></div>"
recSponsoren.movenext
loop

Response.write "<div><a href=""/?2228/partner""><img src=""/images/ico_plus.png"" class=""prt"" style="" background-image:url(/images/vuoto.gif)"" alt=""tutti i partner"" title=""tutti i partner""/></a></div>"


End if%>


</div>
</div>

	<div class="footer_container">
	<div class="sponsors">

		<div class="btm">
		<a href="/newsletter/" class="btn" style="clear:both"><%=str_ricevi_newsletter%></a>
		<p style="float:left; clear:left;">&copy; 2014 Progettiamo.ch | All rights reserved</p>
		<ul class="bmenu"><%=bmmenu%></ul>
		</div>

	<%if ishomepage then%>
	<div class="fb-like fbl" data-href="https://www.facebook.com/pages/Progettiamoch/1416183075301590" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div>
	<%End if%>


	</div>
	</div>

</div>