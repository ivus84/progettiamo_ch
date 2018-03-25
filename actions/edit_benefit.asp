<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
function replSpec(vStringa)

If Len(vStringa)>0 Then

vStringa = Replace(vStringa, Chr(34),"\""")

y=1
While y<31
vStringa = Replace(vStringa, Chr(y),"")
y=y+1
Wend

End If

replSpec=vStringa
end Function


load=request("load")
refb=request("refb")
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
	If Not rec.eof Then
	
	SQL="SELECT * FROM p_benefits WHERE CO_p_projects="&load&" AND ID="&refb
	Set rec=connection.execute(SQL)

	tit=rec("TA_nome")
	texto=rec("TX_testo")
	IN_value=rec("IN_value")
	IN_value_a=rec("IN_value_a")
texto=replSpec(texto)
tit=replSpec(tit)

Response.ContentType="application/json"
response.Charset="UTF-8"
getResults="{ ""title"":"""&tit&""",""text"":"""&texto&""",""val1"":"""&IN_value&""",""val2"":"""&IN_value_a&"""}"
response.write getResults
		
	End if

End if
connection.close%>