<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
function replSpec(vStringa)

If Len(vStringa)>0 Then
set regEx = New RegExp 
		regEx.IgnoreCase = True
		regEx.Global = True
		regEx.Pattern = "<[^>]*>"
		'vStringa = regEx.Replace(vStringa, "")
vStringa = Replace(vStringa, Chr(34),"\""")
vStringa = Replace(vStringa, "<p>","")
vStringa = Replace(vStringa, "</p>","")

y=1
While y<31
vStringa = Replace(vStringa, Chr(y),"")
y=y+1
Wend
End If

replSpec=vStringa
end Function

SQL="SELECT * FROM testimonianze WHERE LO_pubblica=True ORDER BY IN_ordine"
Set rec=connection.execute(SQL)

Do While Not rec.eof 
item_name=rec("TA_nome")
item_message=rec("TE_testo")
item_message=replSpec(item_message)
'item_message=ClearHTMLTags(item_message,0)


adRes=adRes&"{""testimonial"": { ""name"":"""&item_name&""",""message"":"""&item_message&"""}},"


rec.movenext
Loop
connection.close

If Len(adRes)>0 Then
adRes=Mid(adRes,1,Len(adRes)-1)
adRes="["&adRes&"]"

End If

Response.Buffer = true
Response.clear
response.codepage=65001


Response.ContentType="application/json"
response.Charset="UTF-8"

response.write (request("jsoncallback")&"("&adRes&")")

%>