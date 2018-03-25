<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

ref=request("ref")

SQL="SELECT TA_nome,TX_testo,LO_pubblica from oggetti WHERE ID="&ref
set rec=connection.execute(SQL)
pubblica=rec("LO_pubblica")
pubb="False"
if pubblica=True then pubb="True"
SQL="UPDATE oggetti set TA_nome"&Session("reflang")&"='"&rec("TA_nome")&"',TX_testo"&Session("reflang")&"='"&rec("TX_testo")&"',LO_pubblica"&Session("reflang")&"="&pubb&" WHERE ID="&ref
''response.write SQL
''response.end
set rec=connection.execute(SQL)

response.redirect("main.asp")
response.end
connection.close%>