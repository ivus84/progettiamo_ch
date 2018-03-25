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
	
advimg="NOIMG"
		If Len(vembed)>0 Then 
		vembedo=vembed
		vSrc=getVideoSrc(vembed)
		vembed=Replace(vembedo,"'","''")
		advimg="<img class=""vImg"" src=""/images/vuoto.gif"" rel="""&vsrc&""" style=""width:130px; height:85px; border:solid 1px; float:right; cursor:pointer; margin:-85px 153px 0px 0px; background-position:center center; background-size:auto 100%; background-repeat:no-repeat;""/>"
		End if

	SQL="UPDATE p_projects set TX_video_embed='"&vembed&"' WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
	Set rec=connection.execute(SQL)

	response.write advimg
		
	End if

End if
connection.close%>