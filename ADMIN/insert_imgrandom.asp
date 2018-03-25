<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

CO_oggetti=request("CO_oggetti")

SQL0="INSERT INTO _immagini_random (TA_nome) VALUES ('Nuova immagine')"
set recordset0=connection.execute(SQL0)
SQL0="SELECT MAX(ID) as pagina FROM _immagini_random"
set recordset0=connection.execute(SQL0)
pagina=recordset0("pagina")

if len(CO_oggetti)>0 then
SQL0="INSERT INTO associa_ogg_random (CO_immagini,CO_oggetti) VALUES ("&pagina&","&CO_oggetti&")"
set recordset0=connection.execute(SQL0)
end if


response.redirect("diaporama.asp?viewimg="&pagina&"&refogg="&CO_oggetti&"&sessid="&timevalue(now()))
connection.close

%>