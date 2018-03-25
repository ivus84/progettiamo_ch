<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./admin/load_reptext.asp"-->
<%
''ON ERROR RESUME NEXT
tabella=request("tabella")
if len(Tabella)>0 then Session("tabella")=tabella
tabella=Session("tabella")

wList=315

titletop="Gestione "&tabella

if tabella="p_subcategory" Then titletop="Gestione Tags"


if tabella="formulari" then
wList=400
if langedit="en" then titletop="Edit Forms"
if langedit="de" then titletop="Admin Anmeldungen"
if langedit="it" then titletop="Gestione Formulari"
end if

if tabella="commenti" Then titletop="Gestione Commenti"

vedicampo_="TA_nome"
if tabella="resellers" then vedicampo_="TA_nazione"
if tabella="commenti" then 
'disablecreate="True"
vedicampo_="reford"
End if


%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->


<div id="content_page">

<p class="titolo"><%=titletop%></p>
<%
if len(disablecreate)=0 then
%>
<input type="button" class="titolo" style="position:relative;float:left;  left:0px; top:10px; width:200px;margin-bottom:20px" value="Crea nuovo" id="mybt1" onclick="document.location='insert1.asp?TA_nome=%20NEW&tabella=<%=tabella%>&da=list';">
<%end if%>
<%
If tabella="registeredusers" Then
searchString=request("searchString")
wsearc="cerca..."
If Len(searchString)>0 Then wsearc=searchString
%>
<input type="button" class="titolo" style="position:relative;float:left;  margin-left:10px; top:10px; width:140px;margin-bottom:20px" value="Abilitati" id="mybt1" onclick="document.location='list.asp?tabella=<%=tabella%>&mode=enabled';">
<input type="button" class="titolo" style="position:relative;float:left;  margin-left:10px; top:10px; width:140px;margin-bottom:20px" value="Non abilitati" id="mybt1" onclick="document.location='list.asp?tabella=<%=tabella%>&mode=disabled';">

<form action="list.asp" method="post" style="margin:0px; float:left; position:relative; margin-left:20px; top:10px;margin-bottom:20px;">
<input class="titolo" name="searchString" style="width:120px;" value="<%=wsearc%>" onfocus="$(this).val('')"/>
<input type="hidden" name="mode" value="<%=request("mode")%>" />
</form>
<%End if%>

<%
SQL="SELECT * FROM "&tabella&" order by TA_nome ASC"

if tabella="newsletter_address" then SQL="SELECT * FROM "&tabella&" order by TA_cognome"
if tabella="suppliers" then SQL="SELECT * FROM "&tabella&" order by IN_ordine ASC"
if tabella="resellers" then SQL="SELECT * FROM "&tabella&" order by TA_nazione,TA_regione ASC"
if tabella="commenti" then SQL="SELECT commenti.*, 'COMMENTO#'&ID AS reford FROM commenti ORDER by commenti.DT_data DESC,commenti.ID DESC"
if tabella="registeredusers" then 
SQL="SELECT "&tabella&".* FROM "&tabella&" WHERE LO_enabled=True AND LO_deleted=False AND LO_projects=False ORDER BY TA_cognome"

If Len(searchString)>0 Then
searchString=Replace(searchString,"'","&#39;")
SQL="SELECT * FROM "&tabella&" WHERE LO_enabled=True AND LO_deleted=False AND LO_projects=False AND (Instr(TA_cognome,'"&searchString&"') OR Instr(TA_nome,'"&searchString&"') OR Instr(TA_ente,'"&searchString&"')) order by TA_cognome"
End if

If request("mode")="disabled" Then SQL=Replace(SQL,"LO_enabled=True AND LO_deleted=False","LO_enabled=False")

End If


If tabella="sponsors" And limiteduser Then
SQL="SELECT sponsors.*, retrievepath.ID2 FROM sponsors LEFT JOIN retrievepath ON sponsors.CO_oggetti = retrievepath.ID WHERE retrievepath.ID2="&limitedsection&" OR sponsors.CO_oggetti=0 OR isnull(sponsors.CO_oggetti) order by sponsors.TA_nome ASC"
End if

Session("sqlList")=SQL

sPageURL = "list.asp"
iCurrentPage = Request("Page")
If iCurrentPage = "" Or Len(iCurrentPage)=0 Then iCurrentPage = 1
iPageSize = 20
sSQLStatement = SQL

Set RecordSet = Server.CreateObject("ADODB.Recordset")
RecordSet.PageSize = iPageSize
RecordSet.CacheSize = iPageSize
RecordSet.Open sSQLStatement, Connection, adOpenStatic, adLockReadOnly

if recordset.eof then
response.write nofound
else
RecordSet.AbsolutePage = iCurrentPage
Totale=RecordSet.RecordCount

''response.write "<tr><td class=""testoadm"" align=""center"">"
found_it=""&totale&" risultati, pagina "&iCurrentPage&" di "&RecordSet.PageCount
found_en=""&totale&" records, page "&iCurrentPage&" of "&RecordSet.PageCount
found_de=totale&" gefundenen Seiten, Seite "&iCurrentPage&" von "&RecordSet.PageCount
found=Eval("found_"&langedit)

response.write "<div style=""position:relative;margin-bottom:10px;clear:both"">"&found&" - "

stringadd="stringsearch="&stringsearch&"&mode="&request("mode")

if RecordSet.PageCount>1 then
	if CInt(iCurrentPage) > 1 then
	iii=CInt(iCurrentPage)-1
	Response.Write "<a href=""" & sPageURL & "?Page=" & iii &"&"&stringadd&""" class=linkint style=""font-size:14px"">&lt;&lt; </a>"
	else
	Response.Write "<img src=images/vuoto.gif border=0 align=absbottom>"
	end if
response.write "[&nbsp;"
	For i = 1 to RecordSet.PageCount
	If i = CInt(iCurrentPage) Then
	Response.Write "<b>" & i & "</b>&nbsp;"
	Else
	Response.Write "<a href=""" & sPageURL & "?Page=" & i &"&"&stringadd&""" class=linkint>" & i & "</a>&nbsp;"
	End If
	Next
response.write "&nbsp;]"

	if CInt(iCurrentPage) < RecordSet.PageCount then
	ii=CInt(iCurrentPage)+1
	Response.Write "<a href=""" & sPageURL & "?Page=" & ii &"&"&stringadd&""" class=linkint style=""font-size:14px""> &gt;&gt;</a>"
	end if

end if
response.write "</div>"
end if

hnr=0



connection.close
%>
<div id="listGet" style="width:280px; border:solid 1px #e2e2e2; box-shadow: 2px -2px 3px #e2e2e2">
</div>

</div>
<form name="form1" action="list.asp?tabella=<%=tabella%>" method="post"></form>

<script type="text/javascript">
var loadedStructure="";
var maxlevs=3;

$(document).ready(function() {
<%=adScript%>
GetList();

});


function GetList() {
	$.ajax({
  url: "list_get.asp?getPage=<%=iCurrentPage%>&tabella=<%=tabella%>&psize=<%=iPageSize%>",
  context: document.body,
  success: function(msg){
gtmsg=msg.substring(0,msg.indexOf('#$#'));
gtscrpt=msg.substring(msg.indexOf('#$#')+3);
$('#listGet').html(gtmsg)
if (gtscrpt.length>0) eval(gtscrpt)
}});
}
</script>
</body>
</html>
