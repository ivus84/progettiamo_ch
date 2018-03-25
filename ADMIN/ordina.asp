<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
nobg=True
sezio=request("sezio")

%>

<p class="titolo" style="padding:10px; margin:-60px 0px 0px 0px; font-weight:bold">Definisci l'ordine delle pagine</p>
<p class="testoadm"  style="padding:0px 10px; margin:5px 0px">Drag & move to the new position</p>

<ol id="ordPages" title="<%=sezio%>">
<%


SQL="SELECT ID, IN_ordine,newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE LO_deleted=False AND CO_oggetti="&sezio&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
'If sezio="5" Then SQL="SELECT ID, IN_ordine,newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE LO_deleted=False AND CO_oggetti="&sezio&" ORDER BY Year(newsection.DT_data) DESC, newsection.IN_ordine ASC"

set recordset=connection.execute(SQL)

i=0
do while not recordset.eof
i=i+1
recordset.movenext
loop
recordset.movefirst

n=0
do while not recordset.eof
nome=recordset("TA_nome")
pos=recordset("IN_ordine")
ref=recordset("ID")
If color1="#fff" Then
color1="#e7e7e7"
Else
color1="#fff"
End if

%>
<li class="testoadm" style="background:<%=color1%>" id="p_<%=ref%>"><input type="hidden" name="ref<%=n%>" value="<%=ref%>"/><%=pos%>.&nbsp;<b><%=nome%></b></li>
<%
n=n+1

SQL="UPDATE oggetti SET IN_ordine="&n&" WHERE ID="&ref
set record1=connection.execute(SQL)


recordset.movenext
loop
%>
</ul>
