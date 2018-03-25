<div style="float:left;clear:left; width:580px;font-size:12px;background:#fff;padding:3px 0px;"><b>Progetto </b>
<div style="float:right; width:40px; text-align:right; padding-right:10px"><b>Chf</b></div>
<div style="float:right; width:50px; padding-right:5px"><b>Status</b></div> 
</div>
<%
xx=0
While xx<10
xx=xx+1
If Not rectop.eof Then
namep=rectop("TA_nome")
If Len(namep)>0 Then namep=Replace(namep,"#","'")

refp=rectop("ID")
color=rectop("TA_color")
viewed=rectop("IN_viewed")
raccolto=rectop("IN_raccolto")
rating=rectop("rating")
status=rectop("status")
If isnull(viewed) Then viewed=0
If isnull(rating) Then rating=0
SQL="SELECT COUNT(ID) as promises from QU_projects_promises WHERE CO_p_projects="&refp
Set rectop1=connection.execute(SQL)
promises=rectop1("promises")
performance=0
If viewed>0 And promises>0 Then performance=Round(promises/viewed*100,0)&"%"
If Len(namep)>45 Then namep=Mid(namep,1,45)

%>
<div style="float:left;clear:left; width:580px;font-size:12px;border-bottom:solid 1px #9ba1b3;padding:2px 0px;text-transform:lowercase"><div style="float:left; width:10px; height:10px; border-radius:10px; background: <%=color%>; margin:2px 10px 2px 0px;"></div>
<%=namep%> 
<div style="float:right; width:40px;text-align:right; padding-right:10px;">&nbsp;<b><%=raccolto%></b></div>
<div style="float:right; width:30px;text-align:right; padding-right:20px;">&nbsp;<b><%=status%>&#37;</b></div>
</div>

<%
rectop.movenext
End if

Wend
%>
<p>*Performance = percentuale di promesse per visitatori</p>