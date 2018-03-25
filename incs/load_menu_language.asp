

<%

if Session("allow_languages"&numproject)=True then
SQL="SELECT * FROM lingue WHERE LO_attiva=True AND LO_pubblica=True ORDER BY IN_ordine DESC"

Set RecordSet = Server.CreateObject("ADODB.Recordset")
RecordSet.Open SQL, Connection, adOpenStatic, adLockReadOnly


if Not recordset.eof then
Totale=RecordSet.RecordCount

If totale>1 then
%>
<form style="" id="project_search">
<span style=" ">
<input class="sstring" name="<%=str_ricerca%>" value="<%=str_ricerca%>" onfocus="setString()"/>
<input type="submit" class="ssubmit" value=""/>

</span>
</form>
<div id="language_menu">

<%
hn=0

If Len(Session("lang"))>0 then
SQL="SELECT * FROM lingue WHERE LO_attiva=True AND LO_pubblica=True AND IN_valore="&Session("lang")

Set RecordSet1 = connection.execute(SQL)
	If Not RecordSet1.eof Then 
	nomeact=recordset1("TA_nome")
    nomeact = ConvertFromUTF8(nomeact)
		addlang = "<div style=""display:inline;""><a class=""langActive"" href=""javascript:void(0)""><img src=""/images/ico_languages.png"" alt=""""/>"&nomeact&"</a></div>"
	End if
End If

addlang = addlang & "<div class=""navLang"" onmouseover=""clearTimeout(hideMenL)"">"

actref = addUrlOG
checkl=Right(actref,4)
if instr(langs, checkl)>0 Then actref=Mid(actref,1,Len(actref)-4)


do while not recordset.eof

hn=hn+1
nomela=LCase(recordset("TA_abbreviato"))
nomela1=recordset("TA_nome")
vall=recordset("IN_valore")

If Len(actref)=0 Then actref="?"
nlink=actref&"/"&nomela&"/"

adclass=""
If vall=Session("lang") Then adclass=" class=""active"""
adVal=""
If vall>0 Then adVal="_"&vall

	If isnumeric(refid) And Len(refid)>0 Then
	SQL="SELECT TA_nome"&adVal&" as vallT FROM oggetti WHERE LO_pubblica"&adVal&"=True AND ID="&refid
	Set recL=connection.execute(SQL)

		If Not recL.eof Then 
		lanT=recL("vallT")
		nomelink=linkMaker(lanT)
		nlink="/?"&refid&"/"&nomelink&"/"&nomela&"/"
		End If
		
	SQL="SELECT TA_nome FROM p_projects WHERE ID="&refid
	Set recL=connection.execute(SQL)
		If Not recL.eof Then 
		lanT=recL("TA_nome")
		nomelink=linkMaker(lanT)
		nlink="/?"&refid&"/"&nomelink&"/"&nomela&"/"
		End If


	End if


addlang=addlang&"<div onmouseover=""clearTimeout(hideMenL)"" onclick=""document.location='"&nlink&"'"""&adclass&">"&ConvertFromUTF8(nomela1)&"</div>"
'End if
recordset.movenext
Loop
recordset.close
addlang=addlang&"</div></div>"
%>
<%End If%>
<%End If%>
<%End If%>

