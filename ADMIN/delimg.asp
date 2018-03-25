<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
ON ERROR RESUME NEXT
path=request("path")
conferma=request("conferma")
da=request("da")

if Len(conferma)>0 then

dim fs
Set fs=Server.CreateObject("Scripting.FileSystemObject")

uploadsDirVar=imagespath&path

if fs.FileExists(uploadsDirVar) then fs.DeleteFile(uploadsDirVar)
uploadsDirVar=filespath&path
if fs.FileExists(uploadsDirVar) then fs.DeleteFile(uploadsDirVar)

SQL="DELETE * FROM immagini WHERE TA_nome='"&path&"'"
Set rec=connection.execute(SQL)
response.redirect("./"&da)
else
%>
<script language="Javascript" src="./main_lang/langedit_<%=Session("adminlanguageactive")%>.js"></script>
<body style="font-family:verdana" bgcolor="#efefef"><center>
<br><br><br><br>
<center>
<script>document.write(txt64a);</script>
<br><br>
<input type=button id="mybt1" value="CANCEL" onclick="javascript:history.back();"> <input id="mybt2" type=button value="CONFIRM" onclick="document.location='delimg.asp?conferma=True&path=<%=path%>&da=<%=da%>';">

<script>
document.getElementById("mybt1").value=txt62;
document.getElementById("mybt2").value=txt65;
</script>

<%end if%>
