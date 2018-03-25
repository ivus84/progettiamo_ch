<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
load=request("load")
edref=request("edref")
ptype=request("ptype")
fname=request("fname")
fdime=request("fdim")
embd=request("embd")

If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
If Not rec.eof Then

title=request("title")
desc=request("desc")

if Len(title)>0 Then title=Replace(title,"'","''")
if Len(desc)>0 Then desc=Replace(desc,"'","''")
if Len(embd)>0 Then embd=Replace(embd,"'","''")

if Len(title)=0 Then title="Senza titolo"

If Len(edref)=0 then

SQL="SELECT MAX(IN_ordine) AS maxord FROM p_description  WHERE CO_p_projects="&load&" AND TA_type='"&ptype&"'"
Set rec1=connection.execute(SQL)
If Not rec1.eof Then maxord=rec1("maxord")
If isnull(maxord) Then 
maxord=1
Else
maxord=maxord+1

End If


SQL="INSERT INTO p_description (CO_p_projects,TA_type,TA_nome,TX_testo,IN_ordine) VALUES ("&load&",'"&ptype&"','"&title&"','"&desc&"',"&maxord&")"
if ptype="download" Then SQL="INSERT INTO p_description (CO_p_projects,TA_type,TA_nome,TX_testo,AT_file,IN_dim_file,IN_ordine) VALUES ("&load&",'"&ptype&"','"&title&"','"&desc&"','"&fname&"',"&fdime&","&maxord&")"
if ptype="about" Then SQL="INSERT INTO p_description (CO_p_projects,TA_type,TA_nome,TX_testo,AT_file,IN_ordine) VALUES ("&load&",'"&ptype&"','"&title&"','"&desc&"','"&fname&"',"&maxord&")"
if ptype="video" Then SQL="INSERT INTO p_description (CO_p_projects,TA_type,TA_nome,TX_testo,TX_embed,IN_ordine) VALUES ("&load&",'"&ptype&"','"&title&"','"&desc&"','"&embd&"',"&maxord&")"
Else
SQL="UPDATE p_description SET TA_nome='"&title&"',TX_testo='"&desc&"',TX_embed='"&embd&"' WHERE CO_p_projects="&load&" AND ID="&edref
if ptype="download" AND Len(fname)>0 Then SQL="UPDATE p_description SET TA_nome='"&title&"',TX_testo='"&desc&"',AT_file='"&fname&"',IN_dim_file="&fdime&" WHERE CO_p_projects="&load&" AND ID="&edref
if ptype="about" AND Len(fname)>0 Then SQL="UPDATE p_description SET TA_nome='"&title&"',TX_testo='"&desc&"',AT_file='"&fname&"' WHERE CO_p_projects="&load&" AND ID="&edref
if ptype="download" AND Len(fname)=0 Then SQL="UPDATE p_description SET TA_nome='"&title&"',TX_testo='"&desc&"' WHERE CO_p_projects="&load&" AND ID="&edref
End If

Set rec=connection.execute(SQL)


End if

End if
connection.close%>