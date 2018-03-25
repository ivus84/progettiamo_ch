<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->

<%

load=request("load")

SQL="INSERT INTO p_description (TA_nome,TA_type,CO_p_projects) VALUES ('','update',"&load&")"
Set rec=connection.execute(SQL)

SQL="SELECT MAX(ID) as refpu FROM p_description WHERE CO_p_projects="&load
Set rec=connection.execute(SQL)

refpu=rec("refpu")
Response.redirect("edit.asp?tabella=p_description&pagina="&refpu)
connection.close%>