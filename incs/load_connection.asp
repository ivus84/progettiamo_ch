<!--#INCLUDE VIRTUAL="./config/dbconfig.asp"-->
<%

if len(request.querystring)>0 then
actQueryString=request.querystring
if len(request.querystring)>2 then gLang=Mid(request.querystring,len(request.querystring)-3)
langs="/it/,/de/,/en/,/fr/,/ti/"
	if instr(langs, gLang)>0 then
		if glang="/it/" then langval=0
		if glang="/en/" then langval=1
		if glang="/de/" then langval=2
		if glang="/fr/" then langval=3
		if glang="/ti/" then langval=4
		Session("lang")=langval
		Session("langref")=mid(gLang,2,2)
		if len(actQueryString)>2 then actQueryString=Mid(actQueryString,1,len(actQueryString)-3)
	end if
end if

if IsNull(Session("lang")) then Session("lang")=0
if session(lang) = "" then session("lang") = 0
'response.write "SessionnLang"&Session("lang")
Session("reflang")=""
if Session("lang")>0 Then Session("reflang")="_"&Session("lang")

Set Connection=Server.CreateObject("ADODB.Connection")
Connection.Open "PROVIDER=Microsoft.Jet.OLEDB.4.0;" & "Data Source=" & dbpath & ";"
%>
<!--#INCLUDE VIRTUAL="./incs/load_numproject.asp"-->