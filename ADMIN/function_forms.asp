<script type="text/javascript">

function upd_datadef() {

nname=document.form2.fieldname.value;
nvalue=document.form2.fieldvalue.value;

if (document.form2.mandvalue.checked) { nmand='True';} else { nmand='False' };
if (document.form2.multvalue.checked) { nmult='True';} else { nmult='False' };
if (document.form2.checkvalue.checked) { ncheck='True'; nmult='False'; nsel='false';} else { ncheck='False' };
if (document.form2.multcheckvalue.checked) { mcheck='True'; nmult='False'; ncheck='False'; nsel='False'} else { mcheck='False' };
if (document.form2.selectvalue.checked) { nsel='True'; nmult='False'; mcheck='False';ncheck='False'} else { nsel='False' };

addline=nname+'|'+nvalue+'|'+nmand+'|'+nmult+'|'+ncheck+'|'+mcheck+'|'+nsel+'#';

document.form2.datadef.value=document.form2.datadef.value+addline;
document.form2.submit();

}

<%if len(inidatadef)>0 then%>
function del_field(linedel) {

upddata="";

<%
datadef=Split(Mid(inidatadef,1,len(inidatadef)-1),"#")
for x=LBound(datadef) to UBound(datadef)
field_n=datadef(x)

%>
if (<%=x%>!=linedel) { upddata=upddata+"<%=field_n%>#"; }
<%Next%>

document.form2.datadef.value=upddata;
document.form2.submit();

}

function up_field(lineup) {
lineprev=lineup-1;
linepost=lineup+1;

upddata="";
upddataprev="";
upddatapost="";
<%
datadef=Split(Mid(inidatadef,1,len(inidatadef)-1),"#")
for x=LBound(datadef) to UBound(datadef)
field_n=datadef(x)%>
if (<%=x%><lineprev) { upddataprev=upddataprev+"<%=field_n%>#"; }
if (<%=x%>>=linepost) { upddatapost=upddatapost+"<%=field_n%>#"; }
if (<%=x%>==lineprev) { upddatapost=upddatapost+"<%=field_n%>#"; }
if (<%=x%>==lineup) { upddataprev=upddataprev+"<%=field_n%>#"; }
<%Next%>
upddata=upddataprev+upddatapost;
document.form2.datadef.value=upddata;
document.form2.submit();
}

function down_field(linedown) {
lineprev=linedown-1;
linepost=linedown+1;

upddata="";
upddataprev="";
upddatapost="";
<%
datadef=Split(Mid(inidatadef,1,len(inidatadef)-1),"#")
for x=LBound(datadef) to UBound(datadef)
field_n=datadef(x)%>

if (<%=x%><linedown) { upddataprev=upddataprev+"<%=field_n%>#"; }
if (<%=x%>>linepost) { upddatapost=upddatapost+"<%=field_n%>#"; }
if (<%=x%>==linepost) { upddataprev=upddataprev+"<%=field_n%>#"; }
if (<%=x%>==linedown) { upddatapost=upddatapost+"<%=field_n%>#"; }
<%Next%>
upddata=upddataprev+upddatapost;
document.form2.datadef.value=upddata;
document.form2.submit();
}


<%end if%>
<%if len(inidatadef)>0 then%>
function change_field(linechange,valchange,val) {
upddata="";
<%
	datadef=Split(Mid(inidatadef,1,len(inidatadef)-1),"#")
	for x=LBound(datadef) to UBound(datadef)
	field_n=datadef(x)
	%>

	if (linechange==<%=x%>) {
	changeline="";
	<%
	field_def=Split(field_n,"|")
		for y=LBound(field_def) to UBound(field_def)
		col_def=field_def(y)
		%>
		if (valchange==<%=y%>) {
		changeline+=val+"|";
		} else {
		changeline+="<%=col_def%>|";
		}
		<%
		Next

		if y<5 then
		%>
		changeline+="False|";
		<%

		end if
		if y<6 then
				%>
						changeline+="False|";
				<%

				end if

				if y<7 then
								%>
										changeline+="False|";
								<%

				end if
		%>
changeline=changeline.substring(0,changeline.length-1);
	} else {
	changeline="<%=field_n%>";
	}
	upddata+=changeline+"#";
	<%
	Next
	%>
//alert(upddata);
document.form2.datadef.value=upddata;
document.form2.submit();
}
<%end if%>

var obj1=document.getElementById("datadefcontent");
document.form2.datadef.value="<%=inidatadef%>";

<%if len(inidatadef)=0 OR isnull(inidatadef)=True then%>
obj1.innerHTML='Nessun campo definito';
<%else%>
viewfields="<table width=97% border=0 cellpadding=2 cellspacing=1>"
viewfields=viewfields+"<tr><td class=testoadm><b>Nome</b></td>";
viewfields=viewfields+"<td class=testoadm><b>Val.default</b></td>";
viewfields=viewfields+"<td class=testoadm><b>Obl.</b></td>";
viewfields=viewfields+"<td class=testoadm><b>Long Txt</b></td>";
viewfields=viewfields+"<td class=testoadm><b>Single Choice</b></td>";
viewfields=viewfields+"<td class=testoadm><b>Mult. Choice</b></td>";
viewfields=viewfields+"<td class=testoadm><b>Drop down</b></td></tr>";
<%
datadef=Split(Mid(inidatadef,1,len(inidatadef)-1),"#")
n=1
for x=LBound(datadef) to UBound(datadef)
field_n=datadef(x)
%>
viewfields=viewfields+"<tr bgcolor='#efefef'>";
<%
field_def=Split(field_n,"|")

	for y=LBound(field_def) to UBound(field_def)
	islarg=100
if field_def(y)="True" OR field_def(y)="False" then
addcx=""
changeval="True"

if field_def(y)="True" then
addcx=" CHECKED"
changeval="False"
end if
	%>
	viewfields=viewfields+"<td class=testoadm><input type='hidden' value='<%=field_def(y)%>'/><input type='checkbox' onchange=javascript:change_field(<%=x%>,<%=y%>,'<%=changeval%>'); class='testoadm'<%=addcx%>/></td>";
	<%

else

	%>
	viewfields=viewfields+"<td class=testoadm><input type='text' onchange=\"javascript:change_field(<%=x%>,<%=y%>,this.value);\" style=\"width:<%=islarg%>px\" value=\"<%=field_def(y)%>\" class=\"testoadm\"/></td>";
	<%
	end if

	Next%>
	<%
	if y<5 then%>viewfields=viewfields+"<td class=\"testoadm\"><input type=\"checkbox\" onchange=javascript:change_field(<%=x%>,4,'True'); class=\"testoadm\"/></td>";<%end if
	if y<6 then%>viewfields=viewfields+"<td class=\"testoadm\"><input type=\"checkbox\" onchange=javascript:change_field(<%=x%>,5,'True'); class=\"testoadm\"/></td>";<%end if
	if y<7 then%>viewfields=viewfields+"<td class=\"testoadm\"><input type=\"checkbox\" onchange=javascript:change_field(<%=x%>,6,'True'); class=\"testoadm\"/></td>";<%end if
%>
viewfields=viewfields+"<td nowrap><%if x<UBound(datadef) then%><a style=\"font-size:16px\" href=\"javascript:down_field(<%=x%>);\">&#8659;</a><%end if%> <%if x>0 then%><a style=\"font-size:16px\" href=\"javascript:up_field(<%=x%>);\">&#8657;</a><%end if%> <a href=\"javascript:del_field(<%=x%>);\"><img src=./images/delete1.gif border=0/></a></td></tr>";
<%
n=n+1
next
%>
viewfields=viewfields+'</table>';
obj1.innerHTML=viewfields;

<%end if%></script>