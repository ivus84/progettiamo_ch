<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->

<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
  <div id="content_page" style="width:600px">

<p class="titolo"><script>document.write(txt42);</script></p>
<table border=0 width=400 cellspacing=0 cellpadding=4 style="border:solid 1px #e1e1e1; margin-top:20px">
<tr bgcolor=#EFEFEF><td class="titolo"><script>document.write(txt43);</script></td><td class=titolo align=center><script>document.write(txt44);</script></td><td class=titolo align=center><script>document.write(txt45);</script></td><td class=titolo align=center><script>document.write(txt46);</script></td></tr>
<%if Session("allow_languages"&numproject)=True then%>
<%
SQL="SELECT * FROM lingue WHERE LO_enabled=True ORDER BY IN_ordine ASC"
set record=connection.execute(SQL)

do while not record.eof
reflang=LCase(record("ID"))
nomel=record("TA_nome")
vall=record("IN_valore")
LO_attiva=record("LO_attiva")
LO_pubblica=record("LO_pubblica")
LO_main=record("LO_main")
TA_bandiera=record("TA_bandiera")

if LO_attiva=True then
chekka="checked"
else
chekka=""
end if

if LO_main=True then
chekka2="checked"
else
chekka2=""
end if


if LO_pubblica=True then
adda="<b>"
chekka1="checked"
else
adda=""
chekka1=""
end if

if colore1="FFFFFF" then
colore1="EFEFEF"
else
colore1="FFFFFF"
end if
%>
<tr bgcolor="#<%=colore1%>"><td class=testoadm><img src="/images/flags/<%=TA_bandiera%>" align=absmiddle width=18 style="border:solid 1px #999999"> <%=adda%><%=nomel%></td><td align=center class=testoadm><input type="CHECKBOX" name="LO_attiva" <%=chekka%> onclick="document.location='attiva_lingua.asp?pubb=<%=LO_attiva%>&ref=<%=reflang%>'"></td>
<td align=center class=testoadm><input type="CHECKBOX" name="LO_pubblica" <%=chekka1%> onclick="document.location='pubblica_lingua.asp?pubb=<%=LO_pubblica%>&ref=<%=reflang%>'"></td>
<td align=center class=testoadm><%if lo_pubblica=True then%><input type="CHECKBOX" name="LO_main" <%=chekka2%> onclick="document.location='main_lingua.asp?pubb=<%=LO_main%>&ref=<%=reflang%>'"><%end if%></td>
</tr>
<%
record.movenext
loop
end if%>
</table><br><br>
</td>

</tr>

</table>
</div>
<script type="text/javascript">
$(document).ready(function() {
$('.mMenu').not('.hMenu').eq(6).addClass('active');
})
</script>


</body>
</html>



