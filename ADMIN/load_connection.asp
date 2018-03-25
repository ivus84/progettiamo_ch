<!--#INCLUDE VIRTUAL="./config/dbconfig.asp"-->
<%
'Response.write"<p>Amministrazione contenuti chiusa temporaneamente per aggiornamenti.</p>"
'Response.end


Set Connection=Server.CreateObject("ADODB.Connection")
Connection.Open "PROVIDER=Microsoft.Jet.OLEDB.4.0;" & "Data Source=" & dbpath & ";"

%>
<!--#INCLUDE VIRTUAL="./incs/load_numproject.asp"-->
<%

if Session("log45"&numproject)<>"req895620schilzej" then
response.redirect("logout.asp")
response.end
end if

langedit=Session("adminlanguageactive")
max_level=2

%>