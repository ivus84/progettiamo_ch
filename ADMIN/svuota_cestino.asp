<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.ASP"-->
<%
if request("conferma")="True" then

if Session("allow_contenuti"&numproject)=True then



SQL="SELECT ID, IN_letto, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE LO_deleted=True AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordout=connection.execute(SQL)

if recordout.eof then
response.write"Nessun file sul desktop"
end if

do while not recordout.eof

IDout=recordout("ID")


SQL6="DELETE FROM oggetti WHERE ID="&IDout
set record6=connection.execute(SQL6)

recordout.movenext
loop

response.redirect("cestino.asp")



end if


else

%>

<body style="font-family:verdana" bgcolor=#d4d0c8><center>
<script language="Javascript" src="./main_lang/langedit_<%=Session("adminlanguageactive")%>.js"></script>
<br><br><br><br>
<center>
<script>document.write(txt17);</script>?<br><br>



<input type=button value="" id="mybt1" style="width:100px" onclick="document.location='cestino.asp';"> <input type=button id="mybt2" value="" style="width:100px" onclick="document.location='svuota_cestino.asp?conferma=True';">

<script>
document.getElementById("mybt1").value=txt67;
document.getElementById("mybt2").value=txt66;
</script>

</center>


<%

end if

%>






