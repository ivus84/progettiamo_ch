<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<% 
SQL ="CREATE TABLE [_config_video] ( [ID] COUNTER NOT NULL, [TA_video_title] TEXT(255), [TX_video_subtitle] TEXT(255), [LO_video_position] BIT NOT NULL DEFAULT 0, [AT_snapshot] TEXT(255), [TX_video_embed] LONGTEXT );"
set recordset=connection.execute(SQL)

SQL="CREATE UNIQUE INDEX [PrimaryKey] ON [_config_video] (ID ASC) WITH PRIMARY DISALLOW NULL;"
set recordset=connection.execute(SQL)

%>