<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->


<%

nome=request("nome")
titolo=request("titolo")
fixed=request("fixedH")
image=request("image")

nome=Replace(nome, "'", "´")
titolo=Replace(titolo, "'", "´")


SQL="INSERT INTO friends (p_name,TA_title,fixed,at_main_img,lo_pubblica,ta_color,dt_data,co_p_area) VALUES ('" & nome & "','" & titolo & "'," & fixed & ",'" & image & "',True,'#ffffff',date()," & session("adm_area") & ")"



set record1=connection.execute(SQL)

SQL="SELECT MAX(ID) as utente from friends"
set record1=connection.execute(SQL)
utente=record1("utente")
connection.close%>