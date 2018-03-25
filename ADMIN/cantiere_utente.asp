<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%nobg=True%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<p class="titolo">Gestione utenti amministrazione</p>

<%

ref=request("ref")
ref1=request("ref1")

SQL="SELECT * FROM utenticantieri WHERE ID="&request("ref1")
set record1=connection.execute(SQL)
If record1.eof Then%>
<script language="javascript" type="text/javascript">
$(document).ready(function() {
closeThis();
});
</script>
<%
Response.End
End if

nome=record1("TA_nome")
cognome=record1("TA_cognome")
email=record1("TA_email")
'email=email = EnDeCrypt(record1("TA_email"), npass, 1)
pass=record1("TA_password")
login=record1("TA_login")
tel=record1("TA_tel")
tel1=record1("TA_tel1")
tipo=record1("IN_tipoutente")
fax=record1("TA_fax")
societa=record1("TA_societa")
provincia=record1("CO_provincie1")
avvisi=record1("LO_avvisi")
amm1=record1("LO_amministrazione")
amm2=record1("LO_espertoconsulenza")
amm3=record1("LO_attivo")

if len(provincia)>0 then
provincia=CInt(provincia)
else
provincia=0
end if


%>

<form name="form1" action="cantiere_utente1.asp" method="POST">


<table width=100%>

<tr>
<td class=testoadm>Login:</td>
<td class=testoadm><b><%=login%></b></td><td class=testoadm rowspan=16 colspan=2 valign=top width=50%>

<tr>
<td class=testoadm><script>document.write(txt20a);</script>?</td>
<td class=testoadm>
<%if Len(amm3)=0 or amm3=False then
Sella=""
else
Sella=" CHECKED"
end if%>

<input type="checkbox" name="amm3" value="True" class=formtext2<%=sella%>>

</td></tr>
<tr>
<td class=testoadm><script>document.write(txt20b);</script>:</td>
<td class=testoadm><input type="text" name="nome" size=26 maxlength="100" value="<%=nome%>" class=formtext2></td></tr>
<tr>
<td class=testoadm><script>document.write(txt20c);</script>:</td>
<td class=testoadm><input type="text" name="cognome" size=26 maxlength="100" value="<%=cognome%>" class=formtext2></td></tr>
<tr>
<td class=testoadm>E-mail:</td>
<td class=testoadm><input type="text" name="email" size=26 maxlength="100" value="<%=email%>" class=formtext2></td></tr>
<tr>
<td class=testoadm><script>document.write(txt20d);</script>:</td>
<td class=testoadm><input type="password" name="pass" size=26 maxlength="15" value="<%=pass%>" class=formtext2></td></tr>
<input type="hidden" name="tipo" value="1">
<input type="hidden" name="provincia" value="1">


<input type="hidden" name="avvisi" value="True">

<tr>
<td class=testoadm valign=top></td>
<td class=testoadm>
<%'if Len(amm1)=0 or amm1=False then
'Sella=""
'else
Sella=" CHECKED"
'end if%>

<input type="hidden" name="amm1" value="True"> <%if sella=" CHECKED" then

amm1=record1("LO_contenuti")



LO_docs=record1("LO_admkontakt")
LO_galleries=record1("LO_consulenza")
LO_newsletter=record1("LO_newsletter")
LO_utenti=record1("LO_utenti")
LO_languages=record1("LO_software")
LO_cantieri=record1("LO_cantieri")
LO_admusers=record1("LO_admusers")
LO_iscrizioni=record1("LO_iscrizioni")
LO_admkontakt=record1("LO_admkontakt")
LO_admanmeldung=record1("LO_admanmeldung")
CO_p_area=record1("CO_p_area")

%>


<tr><td class=testoadm><script>document.write(txt20e);</script></td><td class=testoadm>
<%Sella=""
if LO_admusers=True then Sella=" CHECKED" end if%>
<input type="checkbox" name="LO_admusers" value="True" class=formtext2<%=sella%>></td></tr>


<%if Session("allow_subscribers"&numproject)=True then%>
<tr><td class=testoadm>Admin progetti</td><td class=testoadm>
<%Sella=""
if LO_utenti=True then Sella=" CHECKED" end if%>
<input type="checkbox" name="LO_utenti" value="True" class=formtext2<%=sella%>></td></tr>
<%else%>
<input type="hidden" name="LO_utenti" value="">
<%end if%>

<%if Session("allow_networking"&numproject)=True then%>
<tr><td class=testoadm><script>document.write(txt20g);</script></td><td class=testoadm>
<%Sella=""
if LO_iscrizioni=True then Sella=" CHECKED" end if%>
<input type="checkbox" name="LO_iscrizioni" value="True" class=formtext2<%=sella%>></td></tr>
<%else%>
<input type="hidden" name="LO_iscrizioni" value="">
<%end if%>

<tr><td class=testoadm>Admin utenti progetti</td><td class=testoadm>
<%Sella=""
if LO_newsletter=True then Sella=" CHECKED" end if%>
<input type="checkbox" name="LO_newsletter" value="True" class=formtext2<%=sella%>></td></tr>


<%if Session("allow_languages"&numproject)=True then%>
<tr><td class=testoadm><script>document.write(txt20h);</script></td><td class=testoadm>
<%Sella=""
if LO_languages=True then Sella=" CHECKED" end if%>
<input type="checkbox" name="LO_software" value="True" class=formtext2<%=sella%>></td></tr>
<%else%>
<input type="hidden" name="LO_software" value="">
<%end if%>

<%if Session("allow_config"&numproject)=True then%>
<tr><td class=testoadm><script>document.write(txt20i);</script></td><td class=testoadm>
<%Sella=""
if LO_cantieri=True then Sella=" CHECKED" end if%>
<input type="checkbox" name="LO_cantieri" value="True" class=formtext2<%=sella%>></td></tr>
<%else%>
<input type="hidden" name="LO_cantieri" value="">
<%end if%>

<tr><td class=testoadm>Amministratore Immagini</td><td class=testoadm>
<%Sella=""
if LO_galleries=True then Sella=" CHECKED" end if%>
<input type="checkbox" name="LO_consulenza" value="True" class=formtext2<%=sella%>></td></tr>

<%if Session("allow_attachments"&numproject)=True then%>
<tr><td class=testoadm>Amministratore Files</td><td class=testoadm>
<%Sella=""
if LO_docs=True then Sella=" CHECKED" end if%>
<input type="checkbox" name="LO_admkontakt" value="True" class=formtext2<%=sella%>></td></tr>
<%end if%>
<tr><td class="testoadm">Area</td>
<td class="testoadm">
<select name="CO_p_area"><option value="0">...</option>
<%SQL="SELECT * FROM p_area"
Set rec=connection.execute(SQL)
Do While Not rec.eof
refo=rec("ID")
recn=rec("TA_nome")
adds=""
If refo=CO_p_area Then adds=" selected=""selected"""
Response.write"<option value="""&refo&""""&adds&">"&recn&"</option>"
rec.movenext
loop%>
</select>

</td>
</tr>
<table width=400 border=0 align=left cellpadding=0 cellspacing=0 style="border:dotted 1px #bdbdbd">

<tr><td class="testo" width="500" valign="top" nowrap colspan="6">

<table border="0" width=500 align=center cellpadding=2>
<tr>
<td class="testoadm" colspan="3"><font class="testoadm"><b><script>document.write(txt20l);</script></b></font><br>
</td></tr>





<tr>
<td class=testoadm valign=top width=170><script>document.write(txt20m);</script></td>
<td class=testoadm>
<%if Len(amm1)=0 or amm1=False then
Sella=""
else
Sella=" CHECKED"
end if%>

<input type="checkbox" name="amm5" value="True" class=formtext2<%=sella%>><br>
<% if Sella=" CHECKED" then%>
 <select style="width:250px" class=formtext2 name="limita" onchange="document.form1.action='set_limite.asp';document.form1.submit();"><option value="" selected><script>document.write(txt20n);</script>:</option>
<%
SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE LO_deleted=False AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordset=connection.execute(SQL)
do while not recordset.eof
val=recordset("ID")

nome=recordset("TA_nome")



%><option style="background-color:#EFEFEF" value="<%=val%>">&raquo; <%=nome%></option>
<%
SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE LO_deleted=False AND CO_oggetti="&val&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordset1=connection.execute(SQL)
do while not recordset1.eof
val1=recordset1("ID")

nome1=recordset1("TA_nome")
%>
<option value="<%=val1%>">&raquo;&raquo; <%=nome1%></option><%
recordset1.movenext
loop

recordset.movenext
loop
%>

</select>

<%
SQL="SELECT oggetti.TA_nome"&Session("reflang")&" as TA_nome,oggetti.ID FROM oggetti INNER JOIN limita_contenuti on limita_contenuti.CO_oggetti=oggetti.ID WHERE limita_contenuti.CO_utenticantieri="&ref1
set recordset=connection.execute(SQL)
if recordset.eof then%><br><script>document.write(txt20o);</script><%else%><br><script>document.write(txt20n);</script>:<br><%end if
do while not recordset.eof
id=recordset("ID")
TA_nome=recordset("TA_nome")

%><b><%=ta_nome%></b> <a href="del_limita.asp?ref0=<%=id%>&ref1=<%=ref1%>"><img src=images/delete1.gif border=0></a><br>
<%recordset.movenext
loop
%>

<%if Session("allow_languages"&numproject)=True then%><br><br>
<select style="width:250px" class=formtext2 name="limita1" onchange="document.form1.action='set_limite_lingua.asp';document.form1.submit();"><option value="" selected><script>document.write(txt20p);</script>:</option>
<%
SQL="SELECT * FROM lingue WHERE LO_attiva=True ORDER BY IN_ordine ASC"
set recordset=connection.execute(SQL)
do while not recordset.eof
val=recordset("ID")
nome=recordset("TA_nome")



%>
<option style="background-color:#EFEFEF" value="<%=val%>">&raquo; <%=nome%></option>
<%
recordset.movenext
loop
%>

</select>
<%
SQL="SELECT lingue.TA_nome,lingue.ID FROM lingue INNER JOIN limita_lingue on limita_lingue.CO_lingue=lingue.ID WHERE limita_lingue.CO_utenticantieri="&ref1
set recordset=connection.execute(SQL)
if recordset.eof then%><br><script>document.write(txt20o);</script><%else%><br><script>document.write(txt20p);</script>:<br><%end if
do while not recordset.eof
id=recordset("ID")
TA_nome=recordset("TA_nome")

%><b><%=ta_nome%></b> <a href="del_limita.asp?tipo=lingue&ref0=<%=id%>&ref1=<%=ref1%>"><img src=images/delete1.gif border=0></a><br>
<%recordset.movenext
loop
%>


<%
end if
end if%>

<%end if%>

<input type="hidden" name="amm2" value="False" class=formtext2>
<input name="cv" type="hidden" value=" ">
</td></tr>
</table>

</td></tr>

<tr>
<td style="padding-left:20px">
<input type="hidden" value="<%=ref%>" name="ref">
<input type="hidden" value="<%=ref1%>" name="ref1">

</td></tr>


<tr>
<td class=testoadm>&nbsp;</td>
<td class=testoadm>&nbsp;</td></tr>
<tr>
</tr>



</table>
<div style="position:relative;clear:both; float:right;margin-top:-20px; margin-right:25px;margin-bottom:5px">
<input type="BUTTON" value="X CHIUDI" id="mybt1" class="editBtns" onclick="closeThis();">
<input type="submit" value="&raquo; SALVA"  id="mybt2"  class="editBtns">
</div>
</form>

<script type="text/javascript">
$(document).ready(function() {
$("#mybt2").val(save1);
$('body').css('background','#c1c1c1')
$('body').css('margin','10px 0px 0px 10px')


redimThis()
});

</script>


<%

connection.close%>