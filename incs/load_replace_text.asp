<%
function replaceTesto(testo)
if Len(testo)>0 then
testo = Replace(testo, CHR(34)&CHR(34), CHR(34))
testo=replace(testo,"&quot;",CHR(34))
testo=replace(testo,"alt="&chr(34)&" ","alt="&chr(34)&chr(34)&" ")
testo=replace(testo,"border="&chr(34)&" ","border=""0"" ")
testo=replace(testo,"height="&chr(34)&" ","")
testo=replace(testo,"&lt;","<")
testo=replace(testo,"&gt;",">")
'testo=replace(testo,">&nbsp;<","><")
testo = Replace(testo, "&amp;", "&")
testo = Replace(testo, "baseline", "top")
testo=replace(testo,"&width","&amp;width")
testo=replace(testo,"&nome","&amp;nome")

testo = Replace(testo,Session("basedir"),"")
testo = Replace(testo,"&ID","&amp;ID")
testo=replace(testo,"../allegato.asp","allegato.asp")
testo=replace(testo,"allegato.asp?nome=","download.asp?name=")
testo=replace(testo,"admin/","")
testo=replace(testo,"pagina.asp","page.asp")
testo=replace(testo,"pagina=","load=")
testo=replace(testo,"../page.asp","page.asp")
testo=replace(testo,"immagine_res.asp","img.asp")
testo=replace(testo,"../load_image.aspx","/load_image.aspx")
testo=replace(testo,"../../img.asp","img.asp")
testo=replace(testo,"../img.asp","img.asp")
testo=replace(testo,"load_image.aspx",imgscript)
testo=replace(testo,"load_image.asp",imgscript)
testo=replace(testo,"href="&CHR(34)&"www.","href="&CHR(34)&"http://www.")
testo=replace(testo,"[if"," ")
testo=replace(testo,"[endif"," ")
testo=replace(testo,"�","&igrave;")
testo=replace(testo,"�","&agrave;")
testo=replace(testo,"�","&egrave;")
testo=replace(testo,"�","&eacute;")
testo=replace(testo,"�","&ugrave;")
testo=replace(testo,"�","&ocirc;")
testo=replace(testo,"�","&#39;")
testo=replace(testo,"�","&#39;")
testo=replace(testo,"<br>","<br/>")
testo=replace(testo,"<BR>","<br/>")
testo=replace(testo,"align=""absMiddle"" ","align=""middle"" ")

testo=replace(testo,"target="&CHR(34)&"_self"&CHR(34)&"","target="&CHR(34)&"_top"&CHR(34)&"")

set regEx = New RegExp
regEx.IgnoreCase = True
regEx.Global = True
regEx.Pattern = "&amp;nome=[^>]*"&chr(34)
testo= regEx.Replace(testo, CHR(34))
set regEx=nothing

testo=replace(testo,"<font size=","<font param=")
end if
replaceTesto=testo
end function
%>