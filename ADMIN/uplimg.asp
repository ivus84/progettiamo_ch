<%
ref=request("file")
pag=request("pagina")
tabb=request("tabella")
campo=request("campo")

if Len(ref)=0 then
ref=Day(Now())&Month(Now())&Year(Now())&Hour(Now())&Minute(Now())&Second(Now())&".ext"
end if

nobg=True
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<script language="Javascript" src="./main_lang/langedit_<%=Session("adminlanguageactive")%>.js"></script>

<form name="form1" action="makeUpload_or.asp" method="POST" EncType="multipart/form-data">
<input type="hidden" name="table" value="<%=tabb%>"/>
<input type="hidden" name="fieldF" value="<%=campo%>"/>
<input type="hidden" name="connectTable" value=""/>
<input type="hidden" name="addFields" value=""/>
<input type="hidden" name="modeupl" value="update,<%=pag%>"/>
<input type="hidden" name="returnurl" value="confirmUpload.asp"/>

<p class="titolo">Carica File</p>
<p class=testoadm>
<script>document.write(txt61);</script>&nbsp;
<input type="file" name="File1" style="width:150px" class=testoadm>
<input type="button" value="CANCEL" id="mybt1" class=testoadm onclick="doClose();">
<input type="submit" value="UPLOAD" id="mybt2" class=testoadm>
</form>


<script type="text/javascript">

redimThis();

function doClose() {
if (parent.document.getElementById("editing_page"))
 {
closeThis();
  return;
}
self.close();
}

document.getElementById("mybt1").value=txt62;
document.getElementById("mybt2").value=txt63;
</script>




