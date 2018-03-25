<%
	SQL="SELECT * FROM p_benefits WHERE CO_p_projects="&refProject&" ORDER BY IN_value ASC"
	Set rec1=connection.execute(SQL)
If Not rec1.eof Then Response.write "<p style=""margin-top:28px;padding-top:10px; border-top: solid 1px #292f3a;"" class=""notrans"">"&str_benefits_sostenitori&"</p>"

	Do While Not rec1.eof 
nB=rec1("TA_nome")
tB=rec1("TX_testo")
    nb = convertfromutf8(nb)
vB=rec1("IN_value")
vB1=rec1("IN_value_a")
wV=vB
wV=setCifra(wV)
wV1=""
If Len(vB1)>0 And vB1>0 then
wV1=vB1
wV1=" "&str_a_fr&" "&setCifra(wV1)
End if
%><input type="hidden" onfocus="this.blur()" class="fDonate" value="da <%=wV%><%=wV1%> Fr." rel="<%=vB%>" style=""/>
<p style="clear:both;width:99% margin:20px 0px 0px 0px; font-size:18px; line-height:18px;" class="tit"><%=nB%></p>
<p style="clear:both;width:99% margin:-10px 0px 0px 0px" class="notrans"><b><%=str_da_fr%>&nbsp;<%=wV%><%=wV1%>  </b></p>
<%=tB%>
<p style="clear:both;width:99% margin:0px 0px 20px 0px" class="notrans">&nbsp;</p><%

	rec1.movenext
	Loop
	%>