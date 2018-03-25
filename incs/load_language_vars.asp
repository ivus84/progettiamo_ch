<%
getlangtxts="it"
If Len(Session("langref"))>0 Then getlangtxts=Session("langref")

	If getlangtxts="it" then
	%>
	<!--#INCLUDE VIRTUAL="/config/txts_it.asp"-->
	<%elseif getlangtxts="fr" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_fr.asp"-->
	<%elseif getlangtxts="de" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_de.asp"-->
	<%elseif getlangtxts="en" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_en.asp"-->
	<%elseif getlangtxts="di" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_ti.asp"-->
	<%End if%>