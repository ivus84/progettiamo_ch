<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->


<%

ref=request("ref")
sel0=request("sel0")
sel1=request("sel1")
sel2=request("sel2")
conferma=request("conferma")
da=request("da")


if Len(conferma)>0 then



SQL0="DELETE FROM oggetti WHERE ID="&ref
set recordset0=connection.execute(SQL0)


SQL="SELECT * FROM associa_ogg_files WHERE CO_oggetti="&ref
set recordset=connection.execute(SQL)
if not recordset.eof then
SQL2="DELETE FROM associa_ogg_files WHERE CO_oggetti="&ref
set recordset2=connection.execute(SQL2)
end if



if len(da)=0 then
goto1="main.asp"
else
goto1=da&".asp"
end if

response.redirect(goto1&"?sel1="&sel1&"&sel2="&sel2&"&sel0="&sel0)


else
%>
<body style="font-family:verdana" bgcolor=#d4d0c8><center>
<br><br><br><br>
<center>
Are you sure to delete this section?<br><br>
<input type=button value="CANCEL" onclick="javascript:history.back();""> <input type=button value="CONFIRM" onclick="document.location='delobject.asp?ref=<%=ref%>&sel1=<%=sel1%>&sel2=<%=sel2%>&sel0=<%=sel0%>&conferma=True&da=<%=da%>';">
<%end if%>
