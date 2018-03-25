<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche.asp"-->
<!--#INCLUDE VIRTUAL="./incs/load_language_notif.asp"-->

<%
Const adTypeBinary = 1
Const adTypeText = 2

load=request("load")
conferma=request("conferma")

If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
    SQL="SELECT * FROM QU_projects WHERE LO_deleted=False AND ID="&load&" AND CO_registeredusers="&Session("logged_donator")
    Set rec=connection.execute(SQL)
    If rec.eof Then
    Response.End
End If
getArea=rec("CO_p_area")

If getArea=0 Or isnull(getArea) Then
    %>
    <script type="text/javascript">
    alert("Occorre definire l'ERS di riferimento del progetto.")
    document.location='/project/project_make_1.asp?load=<%=load%>';
    </script>
    <%
    Response.end
End if

If Not rec.eof Then
    If conferma="true" then
        SQL="SELECT TA_email_ref FROM p_area WHERE ID="&getArea
        Set rec=connection.execute(SQL)
        mailArea=rec("TA_email_ref")
    End if
    %>
    <!--#INCLUDE VIRTUAL="./project/project_make_header.asp"-->
    <div class="ppath"></div>

    <%If conferma="true" Then
        'VB:Sezione di conferma del progetto
        
        SQL="SELECT * FROM QU_projects WHERE ID="&load
        Set rec=connection.execute(SQL)
        pName=rec("TA_nome")
        pText=rec("TE_abstract")
        pCat=rec("area")
        pCifra=rec("IN_cifra")
        pMezzipropri=rec("IN_mezzi_propri")
        pMail=rec("TA_email")
        pMail = EnDeCrypt(pMail, npass, 2)
        pName=AlterCharset(pName,"windows-1252", "UTF-8")
        pText=AlterCharset(pText,"windows-1252", "UTF-8")
        If Len(pName)>0 Then pName=Replace(pName,"#","'")
        Response.codepage = 65001
        pName=mailString(pName)

        txt_project="<p>Promotore: "&Session("logged_name")&"</p><p>Progetto:<br/><b>"&pName&"</b><br/>"&pText&"<br/><br/>ERS di riferimento: "&pCat&"<br/>Ammontare complessivo progetto Fr. "&pCifra&"</p>"

        HTML=str_txt_notifica_body&chr(10) & str_notifica_sendproject &chr(10)& str_txt_notifica_body_end
        HTML=replace(HTML,"#txt_project#",txt_project)
        mailsubject=str_subject_sendproject

        If Not mailSendDisabled And Session("log45"&numproject)<>"req895620schilzej" Then

            sendto=pMail
            sendtobcc=mailArea
            %>
            <!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
            <%
        End if

        SQL="UPDATE p_projects SET LO_complete=True,LO_toconfirmed=True,LO_rejected=false WHERE ID="&load&" AND CO_registeredusers="&Session("logged_donator")
        Set rec=connection.execute(SQL)

        SQL = "SELECT * from p_shorturls where id_progetto = "&load
        set rec=connection.execute(SQL)
        if rec.eof then
            SQL = "insert into p_shorturls (url_original,id_progetto)values(   '/?progetti/" & load & "/"&pName&"' ,"&load&")" 
        else
            SQL = "UPDATE p_shorturls set url_original = '/?progetti/" & load & "/"&pName&"' where id_progetto = " & load 
        end if 
        set rec=connection.execute(SQL)

        %>
        <p><strong>Procedura di inserimento progetto completata,<br/>il progetto viene sottoposto agli amministratori per convalidarne la pubblicazione.</strong></p>
        <span class="btn">
        <input type="button" class="bt" style="width:180px" value="torna ai tuoi progetti" onclick="documen.location='/myprojects/'"/>
        <input type="button" class="bt" value="anteprima" onclick="window.open('/?progetti/<%=load%>/preview-project')"/>
        </span>
    <%else%>
        <p><strong>Desideri inviare il progetto per approvazione?</strong></p>
        <input type="button" class="bt" value="annulla" onclick="document.location='project_make_3.asp?load=<%=load%>'"/>
        <input type="button" class="bt" value="conferma" onclick="document.location='project_make_8.asp?load=<%=load%>&conferma=true'"/>
        <span class="btn">
        <input type="button" class="bt" value="indietro" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(5)"/>
        </span>
<%End if%>
        <script type="text/javascript">
            $(document).ready(function() {
                make_edit(6);
                <%If conferma="true" then%>
                setTimeout(function() {
                parent.document.location="/myprojects/"
                },5000)
                <%End if%>
            })
        </script>
    </body>
</html>

<%
End if
End if
connection.close%>