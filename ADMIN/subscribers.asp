<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<%

sel0=1
sel1=21
sel2=request("sel2")
sel3=request("sel3")
sel4=request("sel4")
cercanome=request("cercanome")

if Len(sel0)=0 then
sel0=0
end if

if Len(sel1)=0 then
sel1=0
end if

if Len(sel2)=0 then
sel2=0
end if

if Len(sel3)=0 then
sel3=0
end if

if Len(sel4)=0 then
sel4=0
end if

Session("idcantedit")=0
Session("admpage")="utenti.asp"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<%
fleft=180%>
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
 <div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">

<script>document.write(txt7);</script> 

<table width=100% border=0 align=left cellpadding=0 cellspacing=0>
<tr>

<td class=testoadm align=left style="padding:20px">
<%

SQL="SELECT count(ID) as contau FROM registeredusers"
set record1=connection.execute(SQL)

contau=record1("contau")

%>
<%=contau%> <script>document.write(txt8);</script> <img src="./images/xls.gif" align="absmiddle"/> <a href="extract_excel.asp?table=registeredusers">download Excel</a> - <a href="insert1.asp?TA_nome=Nuovo&CO_nazioni=203&TA_email=%20Nuovo_Utente&tabella=registeredusers&da=subscribers"target="editing_page" onclick="setEditing();">Crea nuovo utente</a> - <%if contau>0 then%>
<input type="button" onclick="document.location='users_disable.asp?set1=false';" style="width:190px" class=testoadm value="Disable all users" id="mybt2"> <input type="button" onclick="document.location='users_disable.asp?set1=True';" style="width:190px" class=testoadm value="Enable all users" id="mybt3"><%end if%>
<script type="text/javascript">
if (document.getElementById("mybt2")) document.getElementById("mybt2").value=txt10;
if (document.getElementById("mybt3")) document.getElementById("mybt3").value=txt11;
</script>
<%if contau>0 then%>
<br><br>
<table width=750 border=0 cellspacing="1" bgcolor="#bdbdbd">
<tr bgcolor=#bdbdbd>
<td></td>
<td class=titolo><b><script>document.write(txt20c);</script> <script>document.write(txt20b);</script></b></td>
<td class=titolo><b><script>document.write(txt12);</script> </b></td>
<td class=titolo><b><script>document.write(txt13);</script></b></td>
<%if session("allow_mailing"&numproject)=True then%><td class=titolo><b>Newsletter</b><%end if%>
<!--<td class=titolo><b><script>document.write(txt14);</script></b>//-->
<%if session("allow_commerce"&numproject)=True then%><td class=titolo><b>E-Commerce</b><%end if%>
<%if session("allow_networking"&numproject)=True AND Session("adm_networking")=True then%><td class=titolo>Intern <b><script>document.write(txt15);</script></b></td>
<td class=titolo>Kunden <b><script>document.write(txt15);</script></b><%end if%>
</td></tr>
<%

SQL0="SELECT * FROM registeredusers ORDER BY LO_enabled DESC, TA_cognome ASC"
set record0=connection.execute(SQL0)

do while not record0.eof

ref=record0("ID")
nome=record0("TA_nome")
cognome=record0("TA_cognome")
email=LCase(record0("TA_email"))
pass=record0("LO_protected_pages")
enab=record0("LO_enabled")
list=record0("LO_newsletter")
comm=record0("LO_ecommerce")


if enab=True then
class1="macrosezione"
else
class1="teston"
end if



if colore="FFFFFF" then
colore="EFEFEF"
else
colore="FFFFFF"
end if
%>
<tr bgcolor=#<%=colore%>>
<td align="center"><a href="del.asp?pagina=<%=ref%>&tabella=registeredusers&da=subscribers"><img src="images/delete1.gif" border="0" align="absmiddle"/></a> <a href="edit.asp?pagina=<%=ref%>&tabella=registeredusers&da=subscribers" class="<%=class1%>" target="editing_page" onclick="setEditing();"><img src="images/edit.gif" border="0" align="absmiddle"/></a></td><td class="teston" nowrap><b><%=cognome%>&nbsp; <%=nome%></b></a></td>
<td class="teston"><%=email%></td>

<td class="teston" width="95"><%=enab%></td>
<%if session("allow_mailing"&numproject)=True then%><td class=teston width=95><%=list%></td><%end if%>
<!--<td class=teston width=95><%=pass%></td>//-->
<%if session("allow_commerce"&numproject)=True then%><td class=teston width=95><%=comm%></td><%end if%>
<%if session("allow_networking"&numproject)=True AND Session("adm_networking")=True then%><td class=teston>
<%
SQL="SELECT networking_groups.TA_nome, networking_users.LO_write_permission, networking_users.ID as refass FROM networking_users INNER JOIN networking_groups ON networking_users.CO_networking_groups = networking_groups.ID WHERE (((networking_users.CO_registeredusers)="&ref&")) AND networking_groups.CO_networking_grouptype=1"
set rec=connection.execute(SQL)
grp=""
do while not rec.eof
grp=grp&"<a href=del.asp?pagina="&rec("refass")&"&tabella=networking_users&da=subscribers><img src=./images/delete1.gif border=0 alt=""DELETE FROM GROUP"" align=absmiddle> "&rec("TA_nome")&"</a><br>"
rec.movenext
loop%>
<%=grp%></td>
<td class=teston>
<%
SQL="SELECT networking_groups.TA_nome, networking_users.LO_write_permission, networking_users.ID as refass FROM networking_users INNER JOIN networking_groups ON networking_users.CO_networking_groups = networking_groups.ID WHERE (((networking_users.CO_registeredusers)="&ref&")) AND networking_groups.CO_networking_grouptype=2"
set rec=connection.execute(SQL)
grp=""
do while not rec.eof
grp=grp&"<a href=del.asp?pagina="&rec("refass")&"&tabella=networking_users&da=subscribers><img src=./images/delete1.gif border=0 alt=""DELETE FROM GROUP"" align=absmiddle> "&rec("TA_nome")&"</a><br>"
rec.movenext
loop%>
<%=grp%></td>
<%end if%>

</tr>

<%
record0.movenext
loop
%></table>
<%end if%>



<br/><br/><!--
<b>Sezioni protette</b><br/><p class="testoadm"><%SQL="SELECT * FROM oggetti WHERE LO_protected=True"
set record=connection.execute(SQL)

do while not record.eof
nn=record("TA_nome")
response.write "- "&nn&"<br/>"


record.movenext
loop%>
//-->

</div>
</body>
</html>



