<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
load=request("load")
edref=request("edref")

If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
If Not rec.eof Then

title=request("title")
cifra=request("cifra")
cifra1=request("cifra1")
desc=request("desc")

if Len(title)>0 Then title=Replace(title,"'","''")
if Len(desc)>0 Then desc=Replace(desc,"'","''")
if Len(cifra)>0 Then cifra=Replace(cifra,"'","''")
if Len(cifra1)>0 Then cifra1=Replace(cifra1,"'","''")

If isnumeric(cifra)=False Then cifra=0
If isnumeric(cifra1)=False Then cifra1="Null"

If Len(edref)=0 then
SQL="INSERT INTO p_benefits (CO_p_projects,IN_value,IN_value_a,TA_nome,TX_testo) VALUES ("&load&","&cifra&","&cifra1&",'"&title&"','"&desc&"')"
Else
SQL="UPDATE p_benefits SET IN_value="&cifra&",IN_value_a="&cifra1&",TA_nome='"&title&"',TX_testo='"&desc&"' WHERE CO_p_projects="&load&" AND ID="&edref

End If

Set rec=connection.execute(SQL)


End if

End if
connection.close%>