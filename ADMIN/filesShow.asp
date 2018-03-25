<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
ref=Session("ref")
SQL="SELECT COUNT(ID) as allegati from associa_ogg_files where CO_lingue="&Session("lang")&" AND CO_oggetti="&ref
set recordset=connection.execute(SQL)
''response.write SQL

allegati=recordset("allegati")

SQL1="SELECT fails.TA_nome, fails.TA_titolo,fails.TA_grandezza, fails.ID, associa_ogg_files.IN_ordine,associa_ogg_files.ID as refass FROM fails INNER JOIN (oggetti INNER JOIN associa_ogg_files ON oggetti.ID = associa_ogg_files.CO_oggetti) ON fails.ID = associa_ogg_files.CO_fails WHERE associa_ogg_files.CO_lingue="&Session("lang")&" AND associa_ogg_files.CO_oggetti="&ref&" ORDER BY associa_ogg_files.IN_ordine ASC, fails.ID DESC"
set recordset1=connection.execute(SQL1)
%>
<b>File allegati: </b><%=allegati%>
<br/>Drag &amp; move elements to change the order
<ol id="listFiles">

<%

ii=1
do while not recordset1.eof
idfile=recordset1("ID")
refass=recordset1("refass")
TA_nome=recordset1("TA_nome")
TA_titolo=recordset1("TA_titolo")
TA_grandezza=recordset1("TA_grandezza")
IN_ordine=recordset1("IN_ordine")


if len(in_ordine)=0 OR isnull(in_ordine)=true Then 
SQL="UPDATE associa_ogg_files SET IN_ordine="&ii&" WHERE ID="&refass
Set rec=connection.execute(SQL)
in_ordine=ii
SQL="SELECT * FROM associa_ogg_files WHERE CO_oggetti="&ref&" AND ID<>"&refass&" AND IN_ordine>="&ii
Set rec=connection.execute(SQL)
Do while Not rec.eof
refass1=rec("ID")
ordine=rec("IN_ordine")
SQL="UPDATE associa_ogg_files SET IN_ordine="&(ordine+1)&" WHERE ID="&refass1
Set rec1=connection.execute(SQL)

rec.movenext
loop
End if


if len(TA_titolo)>0 then
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"   "," ")
TA_titolo=Replace(TA_titolo,"  "," ")
end if

grande=""
if Len(TA_grandezza)>0 then
grande=Replace(TA_grandezza," ","")

if Len(grande)>0 then 
if isnumeric(grande) and grande>500 then
grande=round(grande/1000,1)
grande=grande&" MB"
else
grande=grande&" KB"
end if
end if
end if

fExt=instr(TA_nome,"http:")
if instr(TA_nome,"http://")>0 then 
fExt="Emb"
else
if instr(TA_nome,".")>0 then fExt=mid(TA_nome,instrrev(TA_nome,".")+1)
end if%>

<li id="f_<%=idfile%>">
<div style="float:left;width:20px;height:12px; margin:2px 2px 0 2px;padding:2px;color:#fff;background:#999; border-radius:5px;text-align:center; font-size:9px"><%=UCASE(fExt)%></div>
<input type="text" name="titolo" onchange="changeField('TA_titolo',$(this).val(),<%=idfile%>);" maxlength="255" class="formtext" value="<%=TA_titolo%>" title="<%=TA_titolo%>" style="float:left;width:135px;margin:1px 2px"/>
<a href="javascript:delFile('vars=fails,<%=idfile%>,associa_ogg_files,CO_oggetti,<%=ref%>,TA_nome,filesShow.asp');" ALT="del"><img src="images/delete1.gif" border="0"></a>&nbsp;
<%if grande<>"0 KB" then%>
<a href="../download.asp?nome=<%=TA_nome%>" style="color:#00a0e3"><img src="images/downl.gif" border="0" alt="download"/></a>
<%=grande%>
<%end if%>
</li>
<%ii=ii+1
recordset1.movenext
loop
connection.close
%></ol>
