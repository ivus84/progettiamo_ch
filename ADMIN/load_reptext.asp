<%function RepText(strHTML)
		dim strTagLess
		strTagless = strHTML
if len(strTagless)>0 then
		strTagless=Replace(strTagless,"�","'")
		strTagless=Replace(strTagless,"�","'")
		strTagless=Replace(strTagless,"�","&quot;")
		strTagless=Replace(strTagless,"�","&quot;")
		strTagless=Replace(strTagless,"�","&agrave;")
		strTagless=Replace(strTagless,"�","&egrave;")
		strTagless=Replace(strTagless,"�","&ugrave;")
		strTagless=Replace(strTagless,"�","&uacute;")
		strTagless=Replace(strTagless,"�","&igrave;")
		strTagless=Replace(strTagless,"�","&iacute;")
		strTagless=Replace(strTagless,"�","&ograve;")
		strTagless=Replace(strTagless,"�","&oacute;")
		strTagless=Replace(strTagless,"�","&eacute;")
		strTagless=Replace(strTagless,"�","&aacute;")
		strTagless=Replace(strTagless,"�","&uuml;")
		strTagless=Replace(strTagless,"�","&auml;")
		strTagless=Replace(strTagless,"�","&ouml;")
		strTagless=Replace(strTagless,"�","&ecirc;")
		strTagless=Replace(strTagless,"�","&ucirc;")
		strTagless=Replace(strTagless,"�","&icirc;")
		strTagless=Replace(strTagless,"�","&ocirc;")
		strTagless=Replace(strTagless,"�","&ccedil;")
		strTagless=Replace(strTagless,"�","&Uuml;")
		strTagless=Replace(strTagless,"�","&Ugrave;")
		strTagless=Replace(strTagless,"�","&ordm;")
	end if
RepText = strTagLess
end function
%>