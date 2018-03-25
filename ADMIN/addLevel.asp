<%
load=request("load")
lev=request("lev")

If Len(Session("openedStructure"))>0 Then

	set regEx2 = New RegExp
	regEx2.IgnoreCase = True
	regEx2.Global = True
	regEx2.Pattern = ",#,"
	mchange = regEx2.Replace(mchange, ",")
	set regEx2=Nothing
	
	set regEx1 = New RegExp
	regEx1.IgnoreCase = True
	regEx1.Global = True
	regEx1.Pattern = ",,"
	mchange = regEx1.Replace(mchange, ",")
	set regEx1=Nothing

If InStr(Session("openedStructure"), ","&load&"#"&lev&",")=0 Then Session("openedStructure") = Session("openedStructure") & ","&load&"#"&lev&","

response.write Session("openedStructure")
End if
%>