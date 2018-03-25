<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="/incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_header.asp"-->
<%
load=request("load")

SQL="SELECT newsection.DT_data, newsection.TA_linkto, newsection.CO_oggetti,newsection.TA_nome"&Session("reflang")&" AS TA_nome,newsection.sopra"&Session("reflang")&" AS namesection,newsection.TX_keywords"&Session("reflang")&" AS TX_keywords,newsection.TX_testo"&Session("reflang")&" AS TX_testo, newsection.TX_embed, newsection.isrosa, newsection.AT_image FROM newsection WHERE LO_deleted=False AND ID="&load
If Session("log45"&numproject)<>"req895620schilzej" Then SQL=SQL &" AND LO_pubblica"&Session("reflang")&"=True"

set recordset1=connection.execute(SQL)


if not recordset1.eof Then
titolo=recordset1("TA_nome")
testo=recordset1("TX_testo")
embd=recordset1("TX_embed")
getImg=recordset1("AT_image")
isrosa=recordset1("isrosa")
actionFile="getPartita"
pw=600
If isrosa Then embd=""
If Len(embd)>5 Then
getScheda=""
getImg=""

embd=getVideoFrame(embd)
testo=embd

End if

If isrosa Then 
actionfile="getPlayer"



	If Len(titolo)>0 And InStr(titolo," ") Then
	formatN=Split(titolo," ")
	gtnumber=formatN(0)
	If Len(gtnumber)>0 Then
	If isnumeric(gtnumber) Then 
	addnum="<div>"&gtnumber&"</div>"
	titolo=Replace(titolo,gtnumber&" ","")
	End if
	End if
	End if


imgAd="/images/vuoto.gif"
If Len(getImg)>0 Then imgAd = imgscript&"?path="&getImg&"$400"
If Len(titolo)>0 Then titolo=Replace(titolo,"&#45;","<br/>")
adclasImg="imgScheda"
If (Len(getScheda)=0 Or isnull(getScheda)) And (Len(testo)=0 Or isnull(testo)) Then adclasImg="imgSchedaV"

	adTxt="<div class="""&adclasImg&""" style=""float:left;""><img src="""&imgAd&"""/>"& addnum &"<span>"& titolo &"</span></div>"
	titolo=""
	gdate=""
	If Len(getScheda)>0 Then testo="caricando dati ..."

If (Len(getScheda)=0 Or isnull(getScheda)) And (Len(testo)=0 Or isnull(testo)) Then pw=300

Else

	titolo="<div class=""titPage""><span>"&titolo&"</span></div>"
gdate=formatData(recordset1("DT_data"),2)

End if


If Len(testo)>1000 Then pw=555
Response.codepage=65001
%>
<body class="fancyPage" style="width:<%=pw%>px; max-width:<%=pw%>px">
<%=titolo%>
<div style="width:95%">
<%If Len(testo)>0 then%><div class="gtTxt"><%=testo%></div><%End if%>
</div>
<script type="text/javascript">
$(document).ready(function() {
setTimeout(function() {
$('.fancybox-close', parent.document).css('display','none');
$('.fancybox-close', parent.document).addClass('fancybox-close-alt');
$('.fancybox-close-alt', parent.document).removeClass('fancybox-close');
$('.fancybox-close-alt', parent.document).css('display','inline');
},300)
})
</script>
</body>
</html>
<%
End If
connection.close%>