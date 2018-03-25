<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->


<%

ref=request("ref")
ogg=request("ogg")
gall=request("formular")
da="list"


SQL="INSERT INTO associa_ogg_formulari (CO_oggetti,CO_formulari) VALUES("&ogg&","&gall&")"
set record=connection.execute(SQL)

response.redirect("./"&da&".asp")


%>
