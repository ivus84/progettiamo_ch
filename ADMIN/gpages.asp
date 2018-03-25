<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
load=request("load")

If Len(load)>0 then
load=Split(load,",")

For x=1 To UBound(load)-1

SQL="Select TA_nome FROM oggetti WHERE ID="&load(x)
Set rec=connection.execute(SQL)

response.write "<img src=""./images/delete1.gif"" onclick=""delCr("&load(x)&");"" style=""cursor:pointer; float:left""/>&nbsp;"&rec("TA_nome")&"<br/>"

Next

End if
connection.close

%>