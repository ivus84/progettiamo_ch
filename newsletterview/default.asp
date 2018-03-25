<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
servername = site_mainurl
Response.codepage = 65001
Response.Charset = "utf-8"

load=request.querystring

If isnumeric(load) then
SQL="SELECT * FROM newsletter WHERE ID="&load

Set rec=Connection.execute(SQL)
If Not rec.eof then
nn=rec("ID")
titolo=rec("TA_nome")
testo=rec("TE_testo")
num=rec("IN_newsletter_numero")
addc=""


htmlsend=testo

End if
End if
response.write htmlsend
connection.close
%>