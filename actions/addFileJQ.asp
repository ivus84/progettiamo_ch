<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
If Len(Session("logged_donator"))>0 Then

tabadd=request("table")
fieldF=request("fieldF")
fieldVal=request("fieldVal")
fieldRef=request("fieldRef")


		If tabadd="registeredusers" Then SQL="UPDATE "&tabadd&" SET "&fieldF&"='"&fieldVal&"' WHERE ID="&Session("logged_donator")
		If tabadd="p_projects" Then SQL="UPDATE "&tabadd&" SET "&fieldF&"='"&fieldVal&"' WHERE ID="&fieldRef
		Response.write SQL
		set recordset=connection.execute(SQL)

End If

connection.close
%>
