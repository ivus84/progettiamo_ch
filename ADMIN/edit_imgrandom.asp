<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

pagina=request("pagina")
TA_nome=request("TA_nome")
TA_sottotitolo=request("TA_sottotitolo")
IN_intimage_crop=request("IN_intimage_crop")
IN_ordine=request("IN_ordine")
CO_oggetti=request("CO_oggetti")
LO_no_diaporama=request("LO_no_diaporama")
if isnumeric(IN_ordine)=False then IN_ordine=0
if len(TA_nome)>0 then TA_nome=replace(TA_nome,"'","&#39;")
if len(TA_nome)>0 then TA_nome=replace(TA_nome,"|"," ")
if len(TA_sottotitolo)>0 then TA_sottotitolo=replace(TA_sottotitolo,"'","&#39;")
if len(TA_sottotitolo)>0 then TA_sottotitolo=replace(TA_sottotitolo,"|"," ")

if len(LO_no_diaporama)=0 then LO_no_diaporama="False"
SQL0="UPDATE _immagini_random SET TA_nome='"&TA_nome&"',TA_sottotitolo='"&TA_sottotitolo&"', IN_intimage_crop='"&IN_intimage_crop&"',LO_no_diaporama="&LO_no_diaporama&",IN_ordine="&IN_ordine&" WHERE ID="&pagina
set recordset0=connection.execute(SQL0)


If IsNumeric(CO_oggetti) Then
SQL0="UPDATE _immagini_random SET CO_oggetti="&CO_oggetti&" WHERE ID="&pagina
set recordset0=connection.execute(SQL0)
else
SQL0="UPDATE _immagini_random SET CO_oggetti=Null WHERE ID="&pagina
set recordset0=connection.execute(SQL0)

End if


response.redirect("diaporama.asp?viewimg="&pagina&"&refogg="&CO_oggetti&"&sessid="&timevalue(now()))
connection.close

%>