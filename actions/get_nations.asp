<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%
Response.write"<option value="""">...</option>"


SQL="SELECT * FROM nazioni ORDER BY IN_ordine, TA_nome"
Set rec=connection.execute(SQL)

Do While Not rec.eof
    
    Response.write"<option value='"&rec("ID")&"' country_code='"&rec("TA_country_code")&"'>"&ConvertFromUTF8(rec("TA_nome"))&"</option>"&Chr(10)
    rec.movenext
Loop

connection.close%>