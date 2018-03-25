<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
response.Charset="UTF-8"

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
	
	SQL="SELECT * FROM p_description WHERE CO_p_projects="&load&" AND ID="&refb
	Set rec=connection.execute(SQL)

	mode=rec("TA_type")
	fname=rec("AT_file")
	tit=rec("TA_nome")
	texto=rec("TX_testo")
	embed=rec("TX_embed")
tit=replSpec(tit)
texto=replSpec(texto)
embed=replSpec(embed)

Response.ContentType="application/json"
getResults="{ ""title"":"""&tit&""",""text"":"""&texto&""",""embed"":"""&embed&"""}"
response.write getResults
		
	End if

End if
connection.close%>