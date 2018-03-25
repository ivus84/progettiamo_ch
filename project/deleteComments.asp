<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
load=request("load")


If Len(Session("logged_donator"))=0 Then 
Response.write"NOTLOGGED"
Response.End
End if

SQL="SELECT QU_comments.* FROM QU_comments INNER JOIN QU_projects ON QU_comments.refproject=QU_projects.ID WHERE QU_projects.CO_registeredusers="&Session("logged_donator")&" AND QU_comments.ID="&load
Set rec=connection.execute(SQL)


If Not rec.eof Then

SQL="DELETE * FROM p_comments WHERE ID="&load
Set rec=connection.execute(SQL)

SQL="DELETE * FROM p_comments WHERE CO_p_comments="&load
Set rec=connection.execute(SQL)
Response.write"OK"

end if

connection.close%>