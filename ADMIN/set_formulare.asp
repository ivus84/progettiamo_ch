<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
ref=request("ref")
titel=request("titel")
subj=request("subj")

if len(titel)>0 then
if instr(titel,"@")>0 then
SQL="UPDATE associa_ogg_formulari SET TA_send_email='"&titel&"' WHERE ID="&ref
SET recordset=connection.execute(SQL)
end if
end if

if len(subj)>0 then
subj=Replace(subj,"'","&#39;")
SQL="UPDATE associa_ogg_formulari SET TA_mail_subject='"&subj&"' WHERE ID="&ref
SET recordset=connection.execute(SQL)
end if

response.redirect("list.asp")
connection.close
%>
