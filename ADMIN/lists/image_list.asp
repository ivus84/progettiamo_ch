<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<%

Response.Expires = 0
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
response.contenttype="text/javascript"

addimages=""

'SQL="SELECT * FROM immagini ORDER BY ID DESC"
'set recordset=connection.execute(SQL)

'do while not recordset.eof
'ID=recordset("ID")
'TA_nome=recordset("TA_nome")
'TA_nome=Replace(TA_nome," ","")

'addimages=addimages&"[""- "&TA_nome&""",""../img.asp?width=200&path="&TA_nome&"""],"&CHR(10)

'recordset.movenext
'loop
connection.close
%>
var tinyMCEImageList = new Array(
	// Name, URL
	<%=addimages%>["", ""]
);
