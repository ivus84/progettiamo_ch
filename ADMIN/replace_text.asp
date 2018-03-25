<%
if Len(testo)>0 then

testo = Replace(testo, CHR(34)&CHR(34), CHR(34))
testo=replace(testo,"&quot;",CHR(34))
testo = Replace(testo, "&amp;", "&")
testo=replace(testo,"../../img.asp","../img.asp")
testo=replace(testo,CHR(34)&"img.asp",CHR(34)&"../img.asp")
testo=replace(testo,"href="&CHR(34)&"www.","href="&CHR(34)&"http://www.")
testo=replace(testo,"[if"," ")
testo=replace(testo,"[endif"," ")

end if
%>