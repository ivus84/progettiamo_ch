<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%

load=request("load")
	SQL="SELECT * FROM p_benefits WHERE CO_p_projects="&load&" ORDER BY IN_value ASC"
	Set rec1=connection.execute(SQL)
If rec1.eof Then 
Response.write "<p>nessun pacchetto di finanziamento definito</p>"
End If

Do While Not rec1.eof 
nB=rec1("TA_nome")
tB=rec1("TX_testo")
vB=rec1("IN_value")
vB1=rec1("IN_value_a")
refB=rec1("ID")
wV=vB
wV1=vB1
wV=setCifra(wV)
wV1=setCifra(wV1)

If Len(wV1)>0 Then wV1="a "&wV1&" Fr."
%>

<div style="float:left; clear:both; min-height:45px; margin-bottom:10px;">
<div style="float:left; margin-left:0px; width:623px; font-size:14px; padding-bottom:0px; text-align:justify">

<p style="margin:0px 0px 0px 0px; padding-top:15px;font-size:16px;"><b>Da <%=wV%> Fr. <%=wV1%> / <%=nB%></b></p>
<div style="position:relative; z-index:5;clear:left;float:right; text-align:right;border-bottom: solid 1px #292f3a;  width:100%; margin:-29px 0px 20px 0px;">
<img src="/images/ico_delete.png" style="cursor:pointer; width:45px; float:right;" onclick="javascript:delBenefit(<%=refB%>)" onmouseover="$(this).attr('src','/images/ico_delete_o.png')" onmouseout="$(this).attr('src','/images/ico_delete.png')"/>
<img src="/images/ico_edit.png" style="cursor:pointer; float:right; width:45px; margin-right:1px" onclick="loadprojectForm(); editBenefit(<%=refB%>)" onmouseover="$(this).attr('src','/images/ico_edit_o.png')" onmouseout="$(this).attr('src','/images/ico_edit.png')"/>
</div>
<div style="position:relative; float:left; width:100%;margin:-20px 0px 10px 0px;">
<%=tB%>
</div>

</div>
</div>

<%
rec1.movenext
Loop

connection.close%>