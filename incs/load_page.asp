
<!--#INCLUDE VIRTUAL="./incs/load_replace_text.asp"-->
<%
'Response.codepage = 65001

titolo=mainTitle
origTitle=mainTitle
testo=mainTxt
astracttx=mainAbstract
imgnews=mainImg
'imgnews=""
LO_homepage=ishome
If Len(testo)=0 Or isnull(testo) Then testo="<p>&nbsp;</p>"

dataev=mainData

yearProject=year(dataev)

if isnews=true then stTitle=DateValue(dataev)
testo=replaceTesto(testo)

addevents=""
titleclass="titolo"

	
	If Len(imgnews)>0 Then 
	imgnews="/"&imgscript&"?path="&imgnews&"$960"
	gtimg="/images/vuoto.gif"

	imgnews="<div class=""iContainer""><img class=""imgPage"" src="""&gtimg&""" style=""display:inline; background-image: url("&imgnews&")"&adst&""" alt=""""/><img class=""lineOver"" src=""/images/vuoto.gif"" alt=""""/></div>"
	titleclass=titleclass& " imgtitle"
	attachclass=" downimg"
	End if


SQL="SELECT fails.ID, fails.TA_titolo, fails.TA_nome,fails.TA_grandezza,associa_ogg_files.IN_ordine FROM fails INNER JOIN associa_ogg_files ON fails.ID = associa_ogg_files.CO_fails WHERE associa_ogg_files.CO_lingue="&Session("lang")&" AND associa_ogg_files.CO_oggetti="&refid&" ORDER BY associa_ogg_files.IN_ordine, fails.ID ASC"

Set recFiles=Connection.execute(SQL)
addattchsments=""

If Not recFiles.eof Then
	disableredirect=True
	%>
	<!--#INCLUDE VIRTUAL="./incs/load_downloads.asp"-->
	<%
	addattchsments="<div class=""attachments"& attachclass&"""><p class=""titolo"" style=""margin:0px"">Download</p>"&Chr(10)&addattchsments&Chr(10)&"</div>"
End if


If hidetitleonpage=True Then titleclass=titleclass& " notitle"


headAdd="<header>"&Chr(10)&Chr(10)&"<h1 class="""&titleclass&"""><span>"&ConvertFromUTF8(titolo)&"</span></h1></header>"&Chr(10)

testo=headAdd&"<div class=""normalPage"&adclass&""">"&Chr(10)&_
""& testo &"</div>"


firstPList="display:none"

Response.write imgnews


pclass=""
If Len(addattchsments)>0 Then pclass=" dContainer"

If InStr(testo,"$_form_$") Then
%><!--#INCLUDE VIRTUAL="./incs/load_forms.asp"-->
<%End if%>
<!--#INCLUDE VIRTUAL="./incs/load_partners.asp"-->

<div class="pContainer<%=pclass%>">
<%Response.write addattchsments%>
	<div class="pText">
			<section>
				<article>
				<%=testo%>
				</article>
			</section>

			<%if isnews=true then%>
			<nav>
			<div class="newsList"></div>
			</nav>
			<%end if%>


	

	</div>
</div>
<!--#INCLUDE VIRTUAL="./incs/load_auto_redirect.asp"-->