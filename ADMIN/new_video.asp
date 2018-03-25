<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
refogg=request("refogg")
title=request("title")
if len(title)>0 then title=replace(title,"'","´")
SQL="INSERT INTO videos (TA_nome"&Session("reflang")&",CO_oggetti) VALUES ('Nuovo Video "&title&"',"&refogg&")"
set rec=connection.execute(SQL)

response.redirect("edit_page.asp?viewmode=video")
response.end

connection.close
%>


