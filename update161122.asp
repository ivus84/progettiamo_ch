<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<% 

SQL="Update [p_projects] set [IN_mailShareCount] = 0;"
set recordset=connection.execute(SQL)

 %>