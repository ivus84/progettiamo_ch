<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%


ref=request("ref")
pubb=request("pubb")
campo=request("campo")

if len(campo)=0 then
campo="LO_pubblica"&Session("reflang")
end if

if Len(pubb)<4 then
pubb="False"
end if

if pubb="False" then
pubb="True"
elseif pubb="True" then
pubb="False"
else
pubb="False"
end if


SQL="UPDATE oggetti SET "&campo&"="&pubb&" WHERE ID="&ref
SET recordset=connection.execute(SQL)

''response.redirect("main.asp?viewmode=edit_page.asp")

connection.close


%>
