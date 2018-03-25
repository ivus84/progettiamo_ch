<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<% 
pubblica = request("pubblica")
if (pubblica = "false" ) 
    pubblica = false
else
    pubblica = true
end if
SQL="update [_config_main] set LO_pubblica = "&pubblica&";"
set recordset=connection.execute(SQL)


 %>