<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<% 

 SQL1 ="ALTER TABLE _config_video add LO_disabilitato BIT"
 Set rec1=connection.execute(SQL1)

%>