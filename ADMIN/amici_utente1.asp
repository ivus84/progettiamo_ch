<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<!-- #include VIRTUAL = "./admin/clsSHA-1.asp" -->

<%

nome=request("nome")
titolo=request("titolo")
fixed=request("fixedH")
image=request("image")
enabled=request("enabledH")
ref1=request("ref1")
'response.write fixed & " " enabled & " " & image
'response.end

nome=Replace(nome, "'", "´")
titolo=Replace(titolo, "'", "´")


SQL="UPDATE friends set p_name='" & nome & "',ta_title='" & titolo & "',lo_pubblica=" & enabled & ",fixed=" & fixed & ",at_main_img='" & image & "' WHERE ID=" & ref1
set record1=connection.execute(SQL)

connection.close%>