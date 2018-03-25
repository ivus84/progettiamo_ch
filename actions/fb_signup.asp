<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche_it.asp"-->

<%


getform=request.form
If Len(getform)>0 Then 
    If Len(getform)>0 Then getform=Replace(getform,"+"," ")
    If Len(getform)>0 Then getform=Replace(getform,"%40","@")
    If Len(getform)>0 Then getform=Replace(getform,"%2F","/")


    getform=Split(getform,"&")
    email=request("TA_email")
    If Len(email)>0 Then email=lcase(email)
    emailclean=email
    email = EnDeCrypt(email, npass, 1)

    SQL="SELECT * FROM registeredusers WHERE TA_email='"&email&"' OR TA_email_recupero='"&email&"'"
    Set rec=connection.execute(SQL)

    If Not rec.eof Then
        Response.write"Exist"
        Response.end
    End if
    
    checkpass=request("TA_fbid")
    pwd0=checkpass&numproject

    Dim ObjSHA1

    Set ObjSHA1 = New clsSHA1
    StrDigest = ObjSHA1.SecureHash(pwd0)
    Set ObjSHA1 = Nothing

    pwd0=email&numproject&checkpass&now()

    Set ObjSHA1 = New clsSHA1
    StrDigest1 = ObjSHA1.SecureHash(pwd0)
    Set ObjSHA1 = Nothing

    encryptedFields="TA_email,TA_telefono,TA_natel"

    SQL="INSERT INTO registeredusers ("
    SQL1=" VALUES ("
    For x=0 To Ubound(getform)
        gtval=getform(x)
        gtval=Split(gtval,"=")
        nval=gtval(0)
        vval=gtval(1)

        If Mid(nval,1,3)="TA_" And nval<>"TA_password" And nval<>"TA_password_1" Then 
            If Len(vval)>0 Then vval=Replace(vval,"'","''")
            If vval="ente/ragione sociale" Then vval=""
            SQL=SQL&nval&", "

            If InStr(encryptedFields,nval) Then 
    
                vval = EnDeCrypt(vval, npass, 1)

            Else
                vval = URLDecode(vval)
            End if
        
            SQL1=SQL1&"'"&vval&"', "
        End if


        If Mid(nval,1,3)="CO_" Then 
            SQL=SQL&nval&", "
            SQL1=SQL1&""&vval&", "
        End if

        If Mid(nval,1,3)="DT_" Then 
            vvalg=split(vval,".")
            SQL=SQL&nval&", "
            SQL1=SQL1&"#"&vvalg(1)&"/"&vvalg(0)&"/"&vvalg(2)&"#, "
        End if


    Next
    fbid= request("TA_fbid") 

    image = request("AT_immagine") 
    pic = request("pic")
    ext="."&Right(pic,3)
    If InStr(pic,".")>0 Then ext=Mid(pic,InstrRev(pic,"."))
    if len(image) > 0 then
        image =  getAndSaveImage(image, fbid&ext) 
    end if 

    logginDonation=Session("project_wanted")&"#"&Session("chf_wanted")
    If Len(Session("langref"))=0 Then Session("langref")="it"
    If Len(Session("lang"))=0 Then Session("lang")=0

    SQL=SQL&"LO_enabled,TA_password,TA_confcode,TA_logging_donation,TA_lang,CO_lingue,TA_lang_notif,AT_immagine)"
    SQL1=SQL1&"False,'"&StrDigest&"','"&StrDigest1&"','"&logginDonation&"','"&Session("langref")&"',"&Session("lang")&",'"&Session("langref")&"','"&image&"')"
    SQL=SQL&SQL1

    Set rec=connection.execute(SQL)

    Response.codepage = 65001

    SQL="SELECT * FROM registeredusers WHERE LO_enabled=False AND TA_confcode='"&StrDigest1&"'"
    Set rec=connection.execute(SQL)

    loggingWant=rec("TA_logging_donation")
    gname=rec("TA_nome")
    sname=""
    If Len(gname)>0 Then sname=Mid(gname,1,1)
    Session("logged_donator")=rec("ID")
    Session("islogged"&numproject)="hdzufzztKJ89ei"
    Session("logged_name")=gname&" "&rec("TA_cognome")
    Session("logged_name_short")=sname&"."&rec("TA_cognome")
    Session("p_favorites")=rec("TX_favorites")
    Session("projects_promoter")=rec("LO_projects")
    Session("promoter_last_login")=rec("DT_last_login")
    Session("logged_ente")=rec("TA_ente")
    Session("log45"&numproject)="none"
    Session("lang")=rec("CO_lingue")
    Session("langref")=rec("TA_lang")

    SQL="UPDATE registeredusers SET LO_enabled=True,DT_last_login=Now() WHERE ID="&rec("ID")
    Set rec=connection.execute(SQL)
    gotopage=site_mainurl
    loggingWanted=loggingWant
    If Len(loggingWant)>1 Then
        loggingWant=Split(loggingWant,"#")
        projectGo=loggingWant(0)
        projectVal=loggingWant(1)
        SQL="SELECT * from p_projects WHERE ID="&projectGo
        Set rec=connection.execute(SQL)
        If Not rec.eof Then
            proj_name = rec("TA_nome")
            nomeprogetto=linkMaker(proj_name)
            proj_main = gotopage&"?progetti/"&projectGo&"/"&nomeprogetto
            gotopage=gotopage&"?progetti/"&projectGo&"/"&nomeprogetto&"/donate/"
            Session("project_wanted")=projectGo
            Session("chf_wanted")=projectVal

        End if
    End if
    
    Response.write gotopage
else
    Response.write "If Len(getform)>0 Then"
End if

connection.close%>