<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<img src=images/editor.gif  border=0 align=right><%

loadg=request("loadg")
totalfield=CInt(request("totalfield"))

h=0

do while h<totalfield

ref=request("ref"&h)
ord=request("ord"&h)

SQL="UPDATE associa_galleries_immagini set IN_ordine="&ord&" WHERE ID="&ref
set recordset=connection.execute(SQL)

set recordset=nothing

h=h+1
loop

connection.close
response.redirect("edit_galleries.asp?refgallery="&loadg)
response.end


%>



