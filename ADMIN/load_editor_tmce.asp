<%
if len(TX_testo)>0 then

TX_testo = Replace(TX_testo, CHR(34)&CHR(34), CHR(34))
TX_testo = Replace(TX_testo,"&#45;" , "-")

	for x=1 to 31
	chrF=Eval("CHR("&x&")")
	TX_testo = Replace(TX_testo, chrF,"")
	Next

testo=TX_testo
%>
<!--#INCLUDE VIRTUAL="./ADMIN/replace_text.asp"-->
<%
TX_testo=testo
end If

%>
<div id="Editor_tmce" style="display:none; z-Index:1000; position:absolute;left:0px; top:0px; background:transparent">
<div id="origText" style="display:none">
<%=TX_testo%>
</div>
</div>