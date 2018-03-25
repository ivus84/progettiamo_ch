<%
load=request("load")
lev=request("lev")

If Len(Session("openedStructure"))>0 Then

mchange=Session("openedStructure")
	set regEx = New RegExp
	regEx.IgnoreCase = true
	regEx.Global = true
	regEx.Pattern = ","&load&"#"&lev&","
	mchange = regEx.Replace(mchange, ",")
	set regEx=nothing

	set regEx2 = New RegExp
	regEx2.IgnoreCase = true
	regEx2.Global = true
	regEx2.Pattern = ",#,"
	mchange = regEx2.Replace(mchange, ",")
	set regEx2=nothing

	set regEx1 = New RegExp
	regEx1.IgnoreCase = true
	regEx1.Global = true
	regEx1.Pattern = ",,"
	mchange = regEx1.Replace(mchange, ",")
	set regEx1=nothing

	
Session("openedStructure")=mchange
response.write Session("openedStructure")

End If
%>
