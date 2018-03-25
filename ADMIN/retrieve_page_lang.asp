<%
oggi=Month(Now())&"/"&Day(Now())&"/"&Year(Now())

SQL="INSERT INTO oggetti ("
SQL2="VALUES ("

SQL1="SELECT * FROM lingue WHERE LO_attiva=True ORDER BY IN_valore ASC"
set record=connection.execute(SQL1)
do while not record.eof
nomel=record("TA_abbreviato")
nomel1=record("TA_pag")
vall=record("IN_valore2")

if vall<>0 then
vall="_"&vall
end if

SQL=SQL&"TA_nome"&vall&","
SQL2=SQL2&"'"&nomel1&" "&UCase(nomel)&"',"
record.movenext
loop

SQL=SQL&"DT_data) "&SQL2&"#"&oggi&"#)"
'response.write SQL
'response.end
set recordset=connection.execute(SQL)
%>