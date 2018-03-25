<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%


ref=request("ref")
pubb=request("pubb")



if Len(pubb)<4 then
pubb="False"
end if

if pubb="False" then
pubb="True"
elseif pubb="True" then
pubb="False"
end if


SQL="UPDATE lingue SET LO_attiva="&pubb&" WHERE ID="&ref
response.write SQL
'response.end

SET recordset=connection.execute(SQL)






                          response.redirect("languages.asp")

connection.close


%>
