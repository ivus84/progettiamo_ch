<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<%
Function convertHexColor(hexColor, opacity)
	If Len(hexColor)>5 And opacity>=0 And opacity<100 then
		hexColor=Replace(hexColor,"#","")

		redV=Mid(hexColor,1,2)
		greenV=Mid(hexColor,3,2)
		blueV=Mid(hexColor,5)

		red_RGB = CLng("&H" & redV) 
		green_RGB = CLng("&H" & greenV) 
		blue_RGB = CLng("&H" & blueV) 

		redVal = red_RGB + (256 - red_RGB) * (100-opacity) / 100
		greenVal = green_RGB + (256 - green_RGB) * (100-opacity) / 100
		blueVal = blue_RGB + (256 - blue_RGB) * (100-opacity) / 100

		convertedRed=Hex(CInt(redVal))
		convertedGreen=Hex(CInt(greenVal))
		convertedBlue=Hex(CInt(blueVal))

		convertHexColor=convertedRed & convertedGreen & convertedBlue
	Else
		convertHexColor=hexColor
	End If
end Function



servername = site_mainurl
'servername = "http://test.progettiamo.ch/"
'imgscript ="load_image.asp"
load=request("load")

SQL="SELECT * FROM newsletter WHERE ID="&load
Set rec=Connection.execute(SQL)

nn=rec("ID")
titolo=rec("TA_nome")
testo=rec("TE_testo")

sent=rec("LO_sent")
If Len(testo)>0 Then testo=Replace(testo,"../",servername)
If sent Then
Response.codepage = 65001
Response.Charset = "utf-8"

Response.write testo
%>
<div id="btns" style="position:absolute; z-index:999; left:0px; top:0px; width:100%;background:#EFEFEF; color:#000000; opacity:0.9; filter: alpha(opacity:90)">
Newsletter URL: <a href="<%=servername%>newsletterview/?<%=load%>" style="text-decoration:none"><%=servername%>newsletterview/?<%=load%></a><br/>
</div>
<%
Response.End
Else


num=rec("IN_newsletter_numero")
addc=""

html="<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.01 Transitional//EN"" ""http://www.w3.org/TR/html4/loose.dtd"">"&Chr(10)
html=html&"<html> <head><title></title><meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" /></head>"&Chr(10)
html=html&"<body style=""width:100%; margin:0px; border:0px; background-color:#ebecf0; font-family: Helvetica, Arial, sans-serif; text-align: center; font-size:14px; color:#000000;"">"&Chr(10)
html=html&"<table width=""600"" align=""center"" cellpadding=""0"" cellspacing=""0"" style=""position:relative; margin:0 auto; text-align:left;background:#9ba1b3;font-family: Helvetica, Arial, sans-serif;"">"&Chr(10)
'html=html&"<tr><td style=""height:20px; font-size:10px; padding:5px 0px;width:308px;background:#ebecf0;font-family: Helvetica, Arial, sans-serif;"">Newsletter di informazione sulla piattaforma<br/>di crowdfunding progettiamo.ch</td>"&Chr(10)
'html=html&"		<td style=""height:20px; font-size:10px; padding:5px 0px;background:#ebecf0;font-family: Helvetica, Arial, sans-serif;"">"&Chr(10)
'html=html&"		<a href="""&servername&"newsletterview/?"&load&""" style=""color:#000; text-decoration:none"">Se hai problemi nel visualizzare<br/>questa email clicca qui</a></td></tr>"&Chr(10)
'html=html&"			<tr><td colspan=""2"" style=""height:129px;""><img src="""&servername&"newsletter/images/int.png"" width=""600"" height=""129"" alt=""progettiamo.ch"" title=""progettiamo.ch ""/></td></tr>"&Chr(10)
html=html&"			<tr><td colspan=""2"" style=""width:599px;height:43px;text-align:right; color:#ffffff; font-size: 21px; padding:0px 15px;font-family: Helvetica, Arial, sans-serif;"">Newsletter n. "&num&"</td></tr>"&Chr(10)
html=html&" <tr><td colspan=""2"" style=""padding:15px; font-size:16px; line-height:22px; background:#fff; text-align:justify;font-family: Helvetica, Arial, sans-serif;"">"&Chr(10)
html=html& testo &Chr(10)

SQL="SELECT * FROM QU_projects WHERE LO_newsletter AND LO_confirmed AND LO_aperto ORDER BY DT_termine"
Set rec=Connection.execute(SQL)
If Not rec.eof Then
html=html&"<table cellpadding=""0"" cellspacing=""0"" border=""0"" width=""544"" align=""center""><tr>"
hn=0
Do While Not rec.eof
hn=hn+1
If hn=3 Then
html=html&"</tr><tr><td style=""height:20px"">&nbsp;</td></tr><tr>"
hn=1
End if
		imgb=rec("AT_main_img")
		'imgb=rec("AT_banner")
		pRef=rec("ID")
		color=rec("TA_color")
		pTitle=rec("TA_nome")
		pCat=rec("category")
		pText=rec("TE_abstract")
		pObj=rec("IN_cifra")
		If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")


		pObt=rec("IN_raccolto")
		pFin=rec("IN_mezzi_propri")

pObt=pObt+pFin
plink=linkmaker(pTitle)

pText=ClearHTMLTags(pText,0)
maxTextLen=300-Len(pTitle)
If Len(pText)>maxTextLen Then pText=truncateTxt(pText,maxTextLen)&" ..."


		pRef=rec("ID")
		termine=rec("DT_termine")
		diffdays=dateDiff("d",Now(),termine)

wDays=diffdays&" giorni alla chiusura"
If diffdays>60 Then
wmonth=Round(diffdays/30)
wDays=wmonth&" mesi alla chiusura"

End if

colorget=color
convertedColor=convertHexColor(colorget, 30)

html=html&"<td valign=""top"" width=""262""  style=""width:262px; padding-bottom:15px; height:400px; background:#"&convertedColor&"""><p style=""margin:0px; padding:0px; width:262px; height:190px; background:"&color&" url(" & servername & imgscript&"?path="&imgb&"$292) center top no-repeat;""><img src=""" & servername & imgscript&"?path="&imgb&"$262"" width=""262"" height=""190"" style=""opacity:0 ;-moz-opacity:0""/></p>"&Chr(10)
html=html&"<a style=""color:"&color&";text-decoration:none"" href="""&servername&"?progetti/"&pRef&"/"&pLink&""">"
html=html&"<p style=""font-family: Helvetica, Arial, sans-serif; margin:10px 15px 0px 15px; padding:0px; color:"&color&"""><b>"&pCat&"</b></p>"&Chr(10)
html=html&"<p style=""font-family: Helvetica, Arial, sans-serif; margin:5px 15px; padding:0px; text-align:left; color:#292d38; font-size:15px; line-height:18px;""><b>"&pTitle&"</b></p>"&Chr(10)
html=html&"<p style=""font-family: Helvetica, Arial, sans-serif; margin:5px 15px; padding:0px;text-align:left; color:#292d38; font-size:14px; line-height:17px; min-height:140px; max-height:140px; overflow:hidden; text-align:justify"">"&pText&"</p>"&Chr(10)
html=html&"<p style=""font-family: Helvetica, Arial, sans-serif; margin:30px 0px 0px 15px; padding:0px;color:#292d38; font-size:15px; line-height:18px;""><a style=""color:"&color&""" href="""&servername&"?progetti/"&pRef&"/"&pLink&""">Scheda del progetto</a><br/><br/>Cifra raccolta: Fr. "&setCifra(pObt)&"<br/>Obiettivo: Fr. "&setCifra(pObj)&"<br/>"&wDays&"</p></a>"&Chr(10)
If hn=1 Then html=html&"</td><td width=""20"" style=""width:20px"">&nbsp;</td>"
rec.movenext
Loop
html=html&"</tr></table>"&Chr(10)
End if

html=html&"<p style=""margin-top:50px;""><img src="""&servername&"newsletter/images/loghi_enti.png"" width=""571"" height=""58"" alt=""Enti Regionali per lo Sviluppo"" title=""Enti Regionali per lo Sviluppo""/></p>"&Chr(10)
html=html&"<p style=""text-align:center;margin:50px 0px"">Seguici su<br/>"&Chr(10)
html=html&"<a href=""https://www.facebook.com/pages/Progettiamoch/1416183075301590""><img src="""&servername&"newsletter/images/ico_f.png"" width=""39"" height=""42"" alt=""Seguici su Facebook"" title=""Seguici su Facebook"" border=""0"" style=""border-right:solid 1px #fff""/></a><a href=""https://twitter.com/Progettiamoch""><img src="""&servername&"newsletter/images/ico_t.png"" width=""39"" height=""42"" alt=""Seguici su Twitter"" title=""Seguici su Twitter"" border=""0""/></a></p>"&Chr(10)
html=html & "</td></tr>"&Chr(10)
'html=html & "	<tr><td colspan=""2"" style=""height:125px;background:#ebecf0"">"&Chr(10)
'html=html & "			<img src="""&servername&"newsletter/images/sponsors2.png"" width=""600"" height=""125"" alt=""sponsor: Banca Stato, un progetto condiviso da: DFE Cantone Ticino""/>"&Chr(10)
'html=html & "		</td></tr>"&Chr(10)
'html=html & "	<tr><td colspan=""2"" style=""height:216px; background:#292f3a; text-align:center; color:#fff; font-size:12px; padding:10px 0px;font-family: Helvetica, Arial, sans-serif;"" valign=""top"">"&Chr(10)
'html=html & "&copy; 2014 Progettiamo.ch | All rights reserved<br/><br/>"&Chr(10)
'html=html & "Ricevi questa email perché iscritto alla nostra mailing list.<br/><br/>"&Chr(10)
'html=html & "			<img src="""&servername&"newsletter/images/logo_small.png"" width=""52"" height=""51"" alt=""progettiamo.ch"" title=""progettiamo.ch""/><br/><br/>Progettiamo.ch<br/>Svizzera<br/><br/>"&Chr(10)
'html=html & "<a href="""&servername&"unsubscribe"" style=""color:#fff; text-decoration:none"">cancellati da questa lista</a></td></tr>"&Chr(10)
html=html & "</table>"&Chr(10)


htmlsend=html&"</body></html>"
previewhtml=html

response.write previewhtml
%>
<div id="btns" style="position:absolute; z-index:999; left:0px; top:0px; width:100%;background:#EFEFEF; color:#000000; opacity:0.9; filter: alpha(opacity:90)">
Newsletter URL: <a href="<%=servername%>newsletterview/?<%=load%>" style="text-decoration:none"><%=servername%>newsletterview/?<%=load%></a><br/>
<%If request("mode")="send" then%>
<form id="fSend" method="POST">
<input type="hidden" name="subject" value="Progettiamo.ch - Newsletter n.<%=num%> - <%=titolo%>"/>
<input type="hidden" name="mode" value="<%=mode%>"/>
<input type="hidden" name="load" value="<%=load%>"/>
<textarea name="htmlbody" style="visibility:hidden;width:1px; height:1px"><%=htmlsend%></textarea>
<br/><b>Salvare la newsletter</b> per l'invio<br/>o inserire un indirizzo per inviare come test <input type="text" name="test_email"/><br/><br/><input type="submit" value="TEST / SALVA"/><br/><br/>
</form>
<%
End if
%>
</div>
<%
End if
connection.close
%>
<script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
$('#fSend').submit(function(e) {
complete=1;
e.preventDefault();
totest=$('input[name="test_email"]').val();
if (totest.length>0) totest="Inviare test newsletter a "+totest+"?"
if (totest.length==0) totest="Salvare la newsletter?\nNon sarà più possibile modificare il contenuto"
if (confirm(totest))
{
$('#fSend').unbind('submit')
$('#fSend').submit(function() {return true; })
$('#fSend').attr('action','newsletter_send.asp')
$('#fSend').submit();

} else {
return
}

return false;
})
})

function confirmSend() {

}
</script>

</body>
</html>