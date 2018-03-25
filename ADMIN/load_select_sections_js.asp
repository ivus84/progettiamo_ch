<%response.contentType="text/javascript"%>
<script type="text/javascript">


function AddToOptionList(OptionList, OptionValue, OptionText,colOption,colBold) {
   OptionList=document.getElementById(OptionList);
   OptionList[OptionList.length] = new Option(OptionText, OptionValue);
   OptionList.options[OptionList.options.length - 1].style.backgroundColor = "#"+colOption;
if (colBold==1) {
   OptionList.options[OptionList.options.length - 1].className = "titoloadm";
}
}

function populateList(opList,levs) {
<%

if len(ref)=0 then ref=0
if isloadedselect<>True then
SQL00="SELECT * FROM limita_contenuti WHERE CO_utenticantieri="&Session("IDuser")
set recordset00=connection.execute(SQL00)
if recordset00.eof then
SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica, newsection.LO_contact_page as scelti FROM newsection WHERE  LO_pubblica"&Session("reflang")&"=True AND ID<>"&ref&" AND LO_deleted=False AND (IsNUll(CO_oggetti)=True OR CO_oggetti=0) ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
else
SQL="SELECT DISTINCT newsection.ID AS ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM limita_contenuti INNER JOIN newsection ON limita_contenuti.CO_oggetti = newsection.ID WHERE  newsection.LO_pubblica"&Session("reflang")&"=True AND newsection.LO_deleted=False AND limita_contenuti.CO_utenticantieri="&Session("IDuser")
end if
set recordset5=connection.execute(SQL)
end if


col1="EFEFEF"

do while not recordset5.eof
IDr=recordset5("ID")
nome=recordset5("TA_nome")
nome=ClearHTMLTags(nome, 0)
nome=replace(nome,"&#39;","'")
nome=reptext(nome)
if col1="FFFFFF" then
		col1="EFEFEF"
		else
		col1="FFFFFF"
		end if%>
AddToOptionList(opList,'<%=IDr%>',"<%=nome%>","<%=col1%>",1);

	<%
	if maxlevels>1 then
%>
if (levs>0) {
<%

SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica, newsection.LO_news AS news FROM newsection WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
set recordset6=connection.execute(SQL)

do while not recordset6.eof
IDr1=recordset6("ID")
nome=recordset6("TA_nome")
nome=ClearHTMLTags(nome, 0)
nome=replace(nome,"&#39;","'")
nome=reptext(nome)
news=recordset6("news")
if col1="FFFFFF" then
		col1="EFEFEF"
		else
		col1="FFFFFF"
		end if
%>
AddToOptionList(opList,'<%=IDr1%>',"| <%=nome%>","<%=col1%>",0);
	<%
	if maxlevels>2 and news<>true and instr(nome," News")=0 then
	%>if (levs>1) {<%
	SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr1&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
	set recordset7=connection.execute(SQL)

	do while not recordset7.eof
	IDr2=recordset7("ID")
	nome=recordset7("TA_nome")
	nome=ClearHTMLTags(nome, 0)
	nome=replace(nome,"&#39;","'")
	nome=reptext(nome)
if col1="FFFFFF" then
		col1="EFEFEF"
		else
		col1="FFFFFF"
		end if%>

	AddToOptionList(opList,'<%=IDr2%>',"|| <%=nome%>","<%=col1%>",0);

		<%
		if maxlevels>3 then
		%>if (levs>2) {<%SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr2&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
		set recordset8=connection.execute(SQL)

		do while not recordset8.eof
		IDr3=recordset8("ID")
		nome=recordset8("TA_nome")
		nome=ClearHTMLTags(nome, 0)
		nome=replace(nome,"&#39;","'")
		nome=reptext(nome)
		if col1="FFFFFF" then
		col1="EFEFEF"
		else
		col1="FFFFFF"
		end if
%>
		AddToOptionList(opList,'<%=IDr3%>',"||| <%=nome%>","<%=col1%>",0);
			<%
			if maxlevels>4 then
			%>if (levs>3) {<%SQL="SELECT ID, newsection.TA_nome"&Session("reflang")&" as TA_nome, newsection.LO_pubblica"&Session("reflang")&" AS LO_pubblica FROM newsection WHERE newsection.LO_pubblica"&Session("reflang")&"=True AND ID<>"&ref&" AND LO_deleted=False AND CO_oggetti="&IDr3&" ORDER BY newsection.IN_ordine, newsection.TA_nome"&Session("reflang")&" ASC"
			set recordset9=connection.execute(SQL)

			do while not recordset9.eof
			IDr4=recordset9("ID")
			nome=recordset9("TA_nome")
			nome=ClearHTMLTags(nome, 0)
			nome=replace(nome,"&#39;","'")
			nome=reptext(nome)
if col1="FFFFFF" then
		col1="EFEFEF"
		else
		col1="FFFFFF"
		end if%>
			AddToOptionList(opList,'<%=IDr4%>',"|||| <%=nome%>","<%=col1%>",0);
			<%
			recordset9.movenext
			loop
			%>}<%
			end if

		recordset8.movenext
		loop
		%>}<%
		end if
	recordset7.movenext
	loop
	%>}<%
	end if
recordset6.movenext
loop
%>}<%
end if
recordset5.movenext
loop
recordset5.movefirst
isloadedselect=True
%>}</script>
