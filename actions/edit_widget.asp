<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
response.Charset="UTF-8"

load=request("load")
vembed=request("vembed")
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
	If Not rec.eof Then
	
		If Len(vembed)>0 Then 
		vembedo=vembed
		vembed=Replace(vembedo,"'","''")
		advimg=vembed
		End if

	SQL="UPDATE p_projects set TX_widget='"&vembed&"' WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
	Set rec=connection.execute(SQL)

	response.write advimg
		
	End if

End if
connection.close%>