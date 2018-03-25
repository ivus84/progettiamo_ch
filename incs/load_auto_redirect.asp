<%

if Len(request("modeview"))=0 AND disableredirect=False then
if (len(pretext)=0 OR Isnull(pretext)) AND Session("autoredirect"&numproject)=True then


If isnewsarchive Then 
SQL="SELECT refcontainer FROM checknews"
Set rec=connection.execute(SQL)
session("ArchiveNews")=refid
refid=rec("refcontainer")
session("ModeNews")="Archivio"
Else
session("ModeNews")=""

End if
  
SQL="SELECT ID,TA_nome"&Session("reflang")&" as TA_nome FROM newsection WHERE newsection.CO_oggetti="&refid&" AND newsection.LO_pubblica"&Session("reflang")&"=True AND LO_deleted=False"
If news_set Or isnewsarchive Then 
If isnewsarchive Then SQL=SQL&" AND DateDiff('d',DT_data,Now())>30"
SQL=SQL&" ORDER BY newsection.DT_data DESC"
else
SQL=SQL&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC, newsection.DT_data DESC"
End if

Set recordn1 = Server.CreateObject("ADODB.Recordset")

recordn1.Open SQL, Connection, adOpenStatic, adLockReadOnly

tot=recordn1.RecordCount

if tot>0 then
refn=recordn1("ID")
nome=recordn1("TA_nome")

nomelink=linkMaker(nome)
response.redirect("?"&refn&"/"&nomelink)

end if
end if
end if
%>