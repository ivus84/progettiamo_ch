<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<% 

SQL="ALTER TABLE [registeredusers] ADD COLUMN [TA_lang_notif] TEXT(4) WITH COMPRESSION;"
set recordset=connection.execute(SQL)
SQL="CREATE TABLE [friends] ([ID] AUTOINCREMENT,[p_name] TEXT(255) WITH COMPRESSION,[ta_title] TEXT(255) WITH COMPRESSION,[IN_ordine] LONG,	[LO_pubblica] BIT NOT NULL DEFAULT 0,[AT_Main_img] TEXT(255) WITH COMPRESSION,[TA_Color] TEXT(255) WITH COMPRESSION,[fixed] BIT NOT NULL DEFAULT 0,	[dt_data] DATETIME,	[co_p_area] LONG,CONSTRAINT [PrimaryKey] PRIMARY KEY ([ID]));"
'ALTER TABLE [friends] ALLOW ZERO LENGTH [p_name];ALTER TABLE [friends] ALLOW ZERO LENGTH [ta_title];ALTER TABLE [friends] ALLOW ZERO LENGTH [AT_Main_img];ALTER TABLE [friends] ALLOW ZERO LENGTH [TA_Color];ALTER TABLE [friends] FORMAT [LO_pubblica] SET ""True/False"";ALTER TABLE [friends] FORMAT [fixed] SET ""True/False"";"
set recordset=connection.execute(SQL)
SQL="CREATE TABLE [p_shorturls] ([ID] AUTOINCREMENT,[ID_Progetto] LONG,	[url_Original] TEXT(255) WITH COMPRESSION,	CONSTRAINT [PrimaryKey] PRIMARY KEY ([ID]));"
'ALTER TABLE [p_shorturls] ALLOW ZERO LENGTH [url_Original];"
'response.Write SQL 
set recordset=connection.execute(SQL)

 %>