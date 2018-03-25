	<!--#INCLUDE VIRTUAL="./config/dbconfig.asp"-->
<%

Set Connection=Server.CreateObject("ADODB.Connection")
Connection.Open "PROVIDER=MSDASQL.1;" & "Driver={Microsoft Access Driver (*.mdb)};" & "DBQ=" & dbpath & ";"


%>
<!--#INCLUDE VIRTUAL="./incs/load_numproject.asp"-->
<%
npass=Mid(numproject,1,7)
npass="prgttmc"

if Session("log45"&numproject)<>"req895620schilzej" then
response.redirect("logout.asp")
response.end
end if


langedit=Session("adminlanguageactive")

%>