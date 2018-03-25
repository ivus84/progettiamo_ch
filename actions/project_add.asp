<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%

If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then

SQL="INSERT INTO p_projects (TA_nome,CO_registeredusers,DT_apertura) VALUES ('Nuovo progetto',"&Session("logged_donator")&",Now())"
Set rec=connection.execute(SQL)
Response.redirect("/myprojects/")
End if
connection.close%>