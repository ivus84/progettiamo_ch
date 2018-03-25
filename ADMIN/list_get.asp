<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./admin/load_reptext.asp"-->
<%
If Len(Session("sqlList"))>0 then




iCurrentPage = Request("getPage")
tabella = Request("tabella")
psize = Request("psize")

vedicampo_="TA_nome"
if tabella="resellers" then vedicampo_="TA_nazione"
if tabella="commenti" then  vedicampo_="reford"
if tabella="registeredusers" then  vedicampo_="TA_cognome"


If iCurrentPage = "" Or Len(iCurrentPage)=0 Then iCurrentPage = 1
iCurrentPage = CInt(iCurrentPage)
iPageSize = CInt(psize)

sSQLStatement = Session("sqlList")

Set RecordSet = Server.CreateObject("ADODB.Recordset")
RecordSet.PageSize = iPageSize
RecordSet.CacheSize = iPageSize
RecordSet.Open sSQLStatement, Connection, adOpenStatic, adLockReadOnly

if recordset.eof then
response.write "Nessun elemento trovato"
Else

RecordSet.AbsolutePage = iCurrentPage
Totale=RecordSet.RecordCount

intCurrentRecord=1

	do While intCurrentRecord <= iPageSize
	if not recordset.eof then

	hnr=hnr+1
	ID=recordset("ID")
	vedicampo=Mid(recordset(""&vedicampo_), 1, 60)
if tabella="registeredusers" then  vedicampo= vedicampo&" "&recordset("TA_nome")&" "&recordset("TA_ente")

	classe="class='textarea2'"
	if colore="#fff" then
	colore="#f7f7f7"
	else
	colore="#fff"
	end if

	editpage="edit.asp"
	if len(vedicampo)>40 then vedicampo=mid(vedicampo,1,40)
	%>
	<div style="clear:both; width:<%=wList%>px; padding:4px; background-color:<%=colore%>; height:18px;  margin-top:-1px;border-top:solid 1px #f2f2f2;" onmouseover="$(this).css('background','#f2f2f2');" onmouseout="$(this).css('background','<%=colore%>');">
	<%if tabella<>"registeredusers" then%><a href="del.asp?tabella=<%=tabella%>&pagina=<%=ID%>&da=list" target="editing_page" onclick="setEditing();"><img src="images/del.png" border="0" alt="DELETE" title="DELETE" style="float:right; width:18px;" /></a><%End if%>
	<a href="edit.asp?tabella=<%=tabella%>&pagina=<%=ID%>" target="editing_page" onclick="setEditing();"><img src="images/edit.png" alt="EDIT" title="EDIT" border="0" style="float:right; width:18px; margin-right:6px"/></a> 
	<a href="edit.asp?tabella=<%=tabella%>&pagina=<%=ID%>" target="editing_page" onclick="setEditing();" style="text-decoration:none"><b><%=vedicampo%></b></a>

	<!-- FORMS //-->
	<%if tabella="formulari" then%>
	<div style="clear:both; width:400px;">
	Collegato a:&nbsp;
	<%SQL="SELECT associa_ogg_formulari.ID, associa_ogg_formulari.TA_send_email,associa_ogg_formulari.TA_mail_subject, associa_ogg_formulari.CO_oggetti, oggetti.TA_nome"&Session("reflang")&" as nomeogg FROM (associa_ogg_formulari INNER JOIN formulari on formulari.ID=associa_ogg_formulari.CO_formulari) inner join oggetti ON oggetti.ID=associa_ogg_formulari.CO_oggetti WHERE associa_ogg_formulari.CO_formulari="&ID
					set recordp=connection.execute(SQL)


					ispubb=""
					do while not recordp.eof
					publ=recordp("ID")
					ogg=recordp("CO_oggetti")
					send_mail=recordp("TA_send_email")
					mail_subject=recordp("TA_mail_subject")
					nomeogg=recordp("nomeogg")
					ispubb=ispubb&ogg&","

	if len(send_mail)=0 OR isnull(send_mail)=True then send_mail="info@progettiamo.ch"

					SQL="SELECT COUNT(ID) as subscr from formulari_dati WHERE CO_formulari="&ID&" AND CO_oggetti="&ogg
					set rec=connection.execute(SQL)

					subscr=rec("subscr")
	%><br/><input type="text" class="testoadm" style="width:150px; border:solid 0px #666666; background-color:#dcd9d2" value="<%=nomeogg%>"/> <%if subscr>0 then%>&nbsp;(<a href="extract_formular.asp?ref=<%=ogg%>&formular=<%=ID%>&da=list" target="editing_page" onclick="setEditing();"><%=subscr%> <img src=./images/utenti.gif alt="view submitted forms" border=0 align="absmiddle"/></a>)<%else%>&nbsp;(<%=subscr%> <img src=./images/utenti_off.gif alt="view submitted forms" border=0 align="absmiddle"/>)<%end if%> - Invia a: <input type="text" class="testoadm" value="<%=send_mail%>" onchange="document.location='set_formulare.asp?ref=<%=publ%>&titel='+this.value;" style="width:117px" maxlength="255"/><br/>Oggetto Mail: <input type="text" class="testoadm" value="<%=mail_subject%>" onchange="document.location='set_formulare.asp?ref=<%=publ%>&subj='+this.value;" style="width:292px" maxlength="255"/> - <a href="del.asp?pagina=<%=publ%>&tabella=associa_ogg_formulari&da=list"><img src=./images/delete1.gif border=0 align="absmiddle"/></a><hr size=1 width="400" color="#999999" align="left"/>
					<%recordp.movenext
					loop
					%>

				  <br/> Collega alla pagina: <select id="selobj<%=ID%>" name="CO_oggetti" class="testoadm" style="width:280px" onchange="document.location='set_pubbl_formulari.asp?formular=<%=ID%>&ref=<%=publ%>&ogg='+this.options[this.selectedIndex].value;"><option value="0">Selezionare...</option>
					</select>
	<hr size=1 width="400" color="#999999" align="left"/>
	<%adScript=adScript&"getSlect('selobj"&ID&"',maxlevs,'void(0)');"&chr(10)%>
	</div>
	<%end if%>
	</div>

	<%

	recordset.movenext
	end if

	intCurrentRecord=intCurrentRecord+1
	Loop
	
	Response.write"#$#"&adScript
End if
End if

connection.close
%>