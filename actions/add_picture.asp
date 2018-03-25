<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
fval=request("fval")
fpro=request("fpro")
fref=request("fref")
'VB:aggiunge l'immagine per la fotogallery nella creazione progetto
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
    SQL="SELECT * FROM p_projects WHERE ID="&fpro&" AND CO_registeredusers="&Session("logged_donator")
    Set rec=connection.execute(SQL)
    If Not rec.eof Then
        SQL="SELECT MAX(IN_ordine) as mord FROM p_pictures WHERE CO_p_projects="&fpro&" AND CO_p_description="&fref
        Set rec=connection.execute(SQL)
        mord=rec("mord")
        If isnull(mord) Then mord=0
        mord=mord+1
        SQL="INSERT INTO p_pictures (CO_p_projects,CO_p_description,AT_file,IN_ordine) VALUES ("&fpro&","&fref&",'"&fval&"',"&mord&")"
        Set rec=connection.execute(SQL)
    End if
End if
connection.close%>