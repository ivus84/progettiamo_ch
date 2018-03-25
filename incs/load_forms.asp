<%
		
SQL="SELECT formulari.ID, formulari.TA_nome from formulari INNER JOIN associa_ogg_formulari ON associa_ogg_formulari.CO_formulari=formulari.ID where associa_ogg_formulari.CO_oggetti="&load
set recordset=connection.execute(SQL)

addform=""
do while not recordset.eof

formref=recordset("ID")
formname=recordset("TA_nome")

%>
<!--#INCLUDE VIRTUAL="./incs/load_form.asp"-->
<%
recordset.movenext
loop

if len(addform)>0 then
'addform=replSpec(addform)

If IsNull(testo)=False AND InStr(testo,"$_form_$")>0 then

testo=Replace(testo,"$_form_$",addform)

Else

testo=testo&chr(10)&chr(10)&addform&chr(10)

End if

if len(addform)>0 then addscript=addscript&chr(10)&"makeCapthca();"
end if
%>