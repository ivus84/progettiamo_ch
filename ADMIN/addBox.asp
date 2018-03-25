<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

load=request("load")
gBox=request("gBox")
mode=request("mode")


if mode="1" then

SQL="SELECT * FROM associa_ogg_boxes WHERE CO_boxes="&gBox&" AND CO_oggetti="&load
Set rec=connection.execute(SQL)

If rec.eof then
SQL="INSERT INTO associa_ogg_boxes (CO_boxes,CO_oggetti) VALUES ("&gBox&","&load&")"
Set rec=connection.execute(SQL)
End If
End If

if mode="0" then

SQL="DELETE FROM associa_ogg_boxes WHERE CO_boxes="&gBox&" AND CO_oggetti="&load
Set rec=connection.execute(SQL)

End If

%>