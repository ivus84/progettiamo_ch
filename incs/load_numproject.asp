<%
If Len(Session("numproject"))=0 Then 
SQL="SELECT IN_numproject AS numproject,* from _config_admin"
set record=connection.execute(SQL)
numproject=record("numproject")
Session("numproject")=numproject
Session("allow_languages"&numproject)=record("LO_allow_languages")
Session("allow_galleries"&numproject)=record("LO_allow_galleries")
Session("allow_ecommerce"&numproject)=record("LO_allow_ecommerce")
Session("allow_mailing"&numproject)=record("LO_allow_mailing")
Session("allow_attachments"&numproject)=record("LO_allow_attachments")
End If

numproject=Session("numproject")

%>