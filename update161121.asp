<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<% 

SQL="ALTER TABLE [p_projects] ADD COLUMN [IN_mailShareCount] NUMBER;"
set recordset=connection.execute(SQL)
SQL="ALTER TABLE [p_projects] ADD COLUMN [LO_bonus] BIT;"
set recordset=connection.execute(SQL)
SQL="ALTER TABLE [p_projects] ADD COLUMN [TX_testo_bonus] TEXT(255) WITH COMPRESSION;"
set recordset=connection.execute(SQL)
SQL="ALTER TABLE [p_projects] ADD COLUMN [AT_sponsor] TEXT(255) WITH COMPRESSION;"
set recordset=connection.execute(SQL)
    SQL="CREATE TABLE [MailShares] ([ID] AUTOINCREMENT,[ID_Progetto] LONG,	[Message] TEXT(255) WITH COMPRESSION,	[Sender] TEXT(255) WITH COMPRESSION,	[Receiver] TEXT(255) WITH COMPRESSION	CONSTRAINT [PrimaryKey] PRIMARY KEY ([ID]));"
 %>