<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%
ref=request("ref")
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT TA_nome FROM p_projects WHERE ID="&ref&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
If Not rec.eof Then

myTextarea=request("myTextarea")
title=request("title")
subtitle = request("subtitle")
cifra=request("cifra")
mezzi=request("mezzi")
termine=request("termine")
keywords=request("keywords")
cat=request("cat")
area=request("area")
luogo=request("luogo")
nazione=request("nazione")
dedu=request("dedu")

if Len(title)>0 Then title=Replace(title,"'","#")
if Len(title)>0 Then title=Replace(title,Chr(34),"&quot;")
if Len(subtitle)>0 Then subtitle=Replace(subtitle,"'","#")
if Len(subtitle)>0 Then subtitle=Replace(subtitle,Chr(34),"&quot;")
if Len(luogo)>0 Then luogo=Replace(luogo,"'","''")
if Len(nazione)>0 Then nazione=Replace(nazione,"'","''")
if Len(keywords)>0 Then keywords=Replace(keywords,"'","''")
if Len(cifra)>0 Then cifra=Replace(cifra,"'","")
if Len(mezzi)>0 Then mezzi=Replace(mezzi,"'","")
If Not isnumeric(cifra) Then cifra=0
If Not isnumeric(mezzi) Then mezzi=0

If Len(termine)>0 And InStr(termine,".") Then 
termine=Replace(termine,".","/")
termine=Split(termine,"/")
newterm="#"&termine(1)&"/"&termine(0)&"/"&termine(2)&"#"

Else
newterm="DateAdd('m',6,Now())"
End if



If Len(myTextarea)>0 Then
myTextarea=Replace(myTextarea,"'","''")
myTextarea=Replace(myTextarea,"<p>","")
myTextarea=Replace(myTextarea,"</p>","<br/>")
myTextarea=Replace(myTextarea,"&nbsp;"," ")
myTextareaTot=myTextarea
myTextareaTot=ClearHTMLTags(myTextareaTot,0)
If Len(myTextareaTot) > 270 Then myTextarea=truncateTxt(myTextarea,270)
End If

SQL=StringFormat("UPDATE p_projects set TA_nome='"&title&"', TA_luogo='"&luogo&"',TA_nazione='"&nazione&"',IN_cifra="&cifra&",IN_mezzi_propri="&mezzi&",DT_termine="&newterm&",TX_keywords='"&keywords&"',TE_abstract='"&myTextarea&"',CO_p_category="&cat&",CO_p_area="&area&",LO_deducibile="&dedu&",TA_nome_1='{0}' WHERE ID="&ref&" AND CO_registeredusers="&Session("logged_donator"),array(subtitle))
Set rec=connection.execute(SQL)

End If

End if
connection.close%>