<!--VB:Utilizzata per la dialog di assenza di progetti-->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>



<div class="searchMenu">
<%
If Session("log45"&numproject)<>"req895620schilzej" Then
Response.write "<span style=""margin-left:7px"" class=""cerca_per"">"&str_cerca_per&":</span>"

Session("p_category")=""

disableType=True

If Not disableType then%>
<span style="cursor:pointer; display:none" onclick="viewCat($(this))"><dt style="float:left"><%=str_categoria%></dt><img src="/images/arrow_down.png"/>
<ul class="areaList">
<%

SQL="SELECT * FROM p_subcategory ORDER BY TA_nome"
Set rec=connection.execute(SQL)

Do While Not rec.eof
    ncat=rec("TA_nome")
    rcat=rec("ID")
    Response.write "<li onclick=""searchprojects('category',"&rcat&",$(this))"">"&ncat&"</li>"
    rec.movenext
loop
%>
<li class="active" onclick="searchprojects('category',0,$(this))"><%=str_tutto%></li>

</ul>
</span>
<%End if%>
<span style="cursor:pointer; margin-left:17px;" onclick="viewCat($(this))"><dt style="float:left"><%=str_area%></dt><img src="/images/arrow_down.png"/>
<ul>
<%

'VB: Modificata query per il calcolo dei progetti nel menu
Session("p_area")=""
'response.write "<script>alert('sbianco area')</script>"
SQL="SELECT a.ta_nome,a.id,count(a.id) as nPrj FROM p_area a inner join p_projects p on p.co_p_area=a.id group by a.id,a.ta_nome"
Set rec=connection.execute(SQL)
tot=0

Do While Not rec.eof
    ncat=rec("TA_nome")' & " (" & rec("nprj") & ")" Commentata dopo ave parlato con Alessandro
    tot=tot+rec("nprj")
    rcat=rec("ID")
    Response.write "<li onclick=""searchprojects('area',"&rcat&",$(this))"">"&ncat&"</li>"
    rec.movenext
loop
%>
<li onclick="searchprojects('area',0,$(this))"><%=str_tutte_aree%></li>

</ul>
</span>


<%End if%>

</div>
<div id="dialog" title="Progettiamo.ch">
    <span id="msg"></span>
</div>
