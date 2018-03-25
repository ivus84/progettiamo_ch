<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
tabella=request("tabella")
ref=request("ref")
refi=request("refi")

SQL="UPDATE "&tabella&" set LO_pubblica"&Session("reflang")&"=True WHERE ID="&ref
set record=connection.execute(SQL)

response.redirect("main.asp?refi="&refi)

%>