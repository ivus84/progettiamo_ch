<%nobg=True%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<%
load=request("load")
if Len(load)>0 Then
load=Replace(load,"'","&#39;")

SQL="SELECT ID, TA_nome"&Session("reflang")&" as TA_nome, DT_data, LO_pubblica"&Session("reflang")&" as pubblica, TA_linkto FROM oggetti WHERE LO_deleted=False AND (Instr(TA_nome"&Session("reflang")&",'"&load&"') OR Instr(TX_testo"&Session("reflang")&",'"&load&"') OR Instr(TA_linkto,'"&load&"')) ORDER BY TA_nome"&Session("reflang")
Set rec=connection.execute(SQL)

If rec.eof Then
Response.write "<p style=""margin:3%; font-size:14px"">No pages found for search <b>"&load&"</b></p>"
Else
Response.write "<p style=""margin:10px 2%; font-size:14px"">Search results for <b>"&load&"</b></p>"
End If

Do While Not rec.eof
ref=rec("ID")
nome=rec("TA_nome")
nome1=rec("TA_linkto")
data=rec("DT_data")
pubblica=rec("pubblica")
pubblico="published"
If pubblica=False Then pubblico="not published"
If Len(nome1)>0 Then nome=nome&" - " &nome1
%>
<div class="testoadm" style="float:left; clear:both; border-bottom:solid 1px #ddd; padding:10px 2%; width:96%; font-size:12px; cursor:pointer" onclick="parent.openEdit('edit_page.asp?ref=<%=ref%>'); setTimeout('parent.$.fancybox.close();',200)">
<b><%=nome%></b> 
<span style="float:right; margin-left:10px"><%=data%></span>
<span style="float:right"><%=pubblico%></span>
</div>
<%
rec.movenext
Loop
End if
%>
</body>
</html>