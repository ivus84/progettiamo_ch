<%function RepText(strHTML)
		dim strTagLess
		strTagless = strHTML
if len(strTagless)>0 then
		strTagless=Replace(strTagless,"´","'")
		strTagless=Replace(strTagless,"’","'")
		strTagless=Replace(strTagless,"“","&quot;")
		strTagless=Replace(strTagless,"”","&quot;")
		strTagless=Replace(strTagless,"à","&agrave;")
		strTagless=Replace(strTagless,"è","&egrave;")
		strTagless=Replace(strTagless,"ù","&ugrave;")
		strTagless=Replace(strTagless,"ú","&uacute;")
		strTagless=Replace(strTagless,"ì","&igrave;")
		strTagless=Replace(strTagless,"í","&iacute;")
		strTagless=Replace(strTagless,"ò","&ograve;")
		strTagless=Replace(strTagless,"ó","&oacute;")
		strTagless=Replace(strTagless,"é","&eacute;")
		strTagless=Replace(strTagless,"á","&aacute;")
		strTagless=Replace(strTagless,"ü","&uuml;")
		strTagless=Replace(strTagless,"ä","&auml;")
		strTagless=Replace(strTagless,"ö","&ouml;")
		strTagless=Replace(strTagless,"ê","&ecirc;")
		strTagless=Replace(strTagless,"û","&ucirc;")
		strTagless=Replace(strTagless,"î","&icirc;")
		strTagless=Replace(strTagless,"ô","&ocirc;")
		strTagless=Replace(strTagless,"ç","&ccedil;")
		strTagless=Replace(strTagless,"Ü","&Uuml;")
		strTagless=Replace(strTagless,"Ù","&Ugrave;")
		strTagless=Replace(strTagless,"°","&ordm;")
	end if
RepText = strTagLess
end function
%>