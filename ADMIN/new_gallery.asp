<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
refogg=request("refogg")
title=request("title")
if len(title)>0 then title=replace(title,"'","´")
SQL="INSERT INTO galleries (TA_nome"&Session("reflang")&") VALUES ('PhotoGallery "&title&"')"
set rec=connection.execute(SQL)
SQL="SELECT MAX(ID) as ref from galleries"
set rec=connection.execute(SQL)
ref=rec("ref")

SQL="INSERT INTO associa_ogg_galleries (CO_oggetti,CO_galleries) VALUES ("&refogg&","&ref&")"
set rec=connection.execute(SQL)

response.redirect("main.asp?viewmode=edit_page.asp&viewmode1=gallery")
response.end

connection.close
%>


