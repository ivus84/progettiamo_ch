<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%nobg=True%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->

&nbsp;
<form name="form1" method="POST" action="ordina_gallery1.asp">

<div style="width:270px;margin-left:10px;">
<%
loadg=request("load")
SQL="SELECT Count(associa_galleries_immagini.ID) as contoimg FROM associa_galleries_immagini INNER JOIN immagini ON immagini.ID=associa_galleries_immagini.CO_immagini WHERE CO_galleries="&loadg
set recordset=connection.execute(SQL)

contoimg=recordset("contoimg")

SQL="SELECT immagini.TA_nome, associa_galleries_immagini.ID, associa_galleries_immagini.IN_ordine FROM associa_galleries_immagini INNER JOIN immagini ON immagini.ID=associa_galleries_immagini.CO_immagini WHERE CO_galleries="&loadg&" ORDER BY associa_galleries_immagini.IN_ordine, associa_galleries_immagini.ID ASC"
set recordset=connection.execute(SQL)

i=contoimg
n=0
do while not recordset.eof


nome=recordset("TA_nome")
pos=recordset("IN_ordine")
ref=recordset("ID")
%><div style="float:left;width:80px;height:60px;margin-bottom:10px"><input type="hidden" name="ref<%=n%>" value="<%=ref%>"><div style="width:70px;height:45px;overflow:hidden"><img src="../img.asp?path=<%=nome%>&width=95" class="imgsTh" width="70" border="0" alt=""/></div>
&raquo;pos.<select class=formtext name="ord<%=n%>">
<%z=0
do while z<i+1
if z=pos then
selle=" selected=""selected"""
else
selle=""
end if
%><option value="<%=z%>"<%=selle%>><%=z%></option>
<%z=z+1
loop%>
</select></div>
<%
n=n+1
recordset.movenext
loop
%>
<input type="hidden" name="totalfield" value="<%=i%>">
<input type="hidden" name="loadg" value="<%=loadg%>">
<div style="float:left"> 
<input type="submit" value="&raquo; SAVE" id="mybt2" class="formtext"/>
</div>


</div>
</form>

<script>
document.getElementById("mybt2").value=save1;
</script>
<script type="text/javascript">

var isVisi=0;
</script>

</body>
</html>



