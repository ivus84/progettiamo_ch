<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
ref=request("ref")
nome=request("nome")
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
 <div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">

<form name="form1" action="cantiere_creautente1.asp" method="POST">
<table width=100% cellpadding="4" cellspacing="0">
<tr>
<td class=testo colspan=2><font class=titolo><b><script>document.write(txt9);</script></b></font><br></td></tr>
<tr><td class=testoadm><script>document.write(fname1);</script>:</td>
<td class=testo><input type="text" name="nome" size=26 maxlength="100" value="" class=formtext2></td></tr>
<tr><td class=testoadm><script>document.write(name1);</script>:</td>
<td class=testo><input type="text" name="cognome" size=26 maxlength="100" value="" class=formtext2></td></tr>
<tr><td class=testoadm>Email:</td>
<td class=testo><input type="text" name="email" size=26 maxlength="100" value="" class=formtext2></td></tr>
<tr><td class=testoadm>Login:</td>
<td class=testo><input type="text" name="login" maxlength="8" size=26 maxlength="100" value="" class=formtext2></td></tr>
<tr><td class=testoadm><script>document.write(pass1);</script>:</td>
<td class=testo><input type="password" name="pass" size=26 maxlength="15" value="" class=formtext2></td></tr>
<tr style="display:none"><td class=testoadm>Language:</td>
<td class=testo><select name="lang" class=formtext2><option value="it" selected="selected">it</option><option value="de">de</option>
<option value="en">en</option></select>
</td></tr>

<input name="tipo" type="hidden" value="1">
<input type="hidden" name="amm1" value="True">
<input type="hidden" name="avvisi" value="False">
<input type="hidden" name="lettura" value="True">
<tr>
<td class=testo>&nbsp;</td>
<td class=teston>
<input type="hidden" value="<%=ref%>" name="ref">
<input type="submit" value="" id="mybt1" class=formtext3></td></tr>
<tr>
<td class=testo>&nbsp;</td>
<td class=testo>&nbsp;</td></tr>
<script>
document.getElementById("mybt1").value=save1;
</script>
</table>
</form></div>
<%connection.close%>