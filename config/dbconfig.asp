<%

Session.LCID=2064
'Session.LCID=1031
 
%>
<!--#INCLUDE VIRTUAL="./incs/common_functions.asp"-->
<%
    
dbpath = LCase(Server.MapPath("./"))
dbpath=Mid(dbpath,1,Instrrev(dbpath,"\")-1)
checklast=Mid(dbpath,Instrrev(dbpath,"\")+1)

If checklast="admin" Then 
dbpath=Mid(dbpath,1,Instrrev(dbpath,"\")-1)
checklast=Mid(dbpath,Instrrev(dbpath,"\")+1)
End if

If checklast="web" Or checklast="public_html" Or checklast="admin" Then dbpath=Mid(dbpath,1,Instrrev(dbpath,"\")-1)
'If checklast="web" Or checklast="public_html" Or checklast="progettiamo" Or checklast="admin" Then dbpath=Mid(dbpath,1,Instrrev(dbpath,"\")-1)

dbpath=dbpath & "\database\"
dbname="dsm_progettiamo.v1.mdb"
'dbname="dsm_progettiamo.v2.mdb"

imagespath=dbpath & "images\"
filespath=dbpath & "files\"
projectspath=dbpath & "projects\"
licensepath=dbpath & "license.mdb"

dbpath=dbpath&dbname

'imgscript="load_image.aspx"
imgscript="load_image.asp"

uploadscript="/actions/uploadJQuery.aspx"

'pagelog="https://www.progettiamo.ch/login/"
pagelog="/login/"
mailhost="smtp.progettiamo.ch"
sendmailer="no-reply@progettiamo.ch"
sendpassword="djk-Lo8HJk"

component="CdoSys"
mailSendDisabled=false
sendmaildefault="info@progettiamo.ch"
'VB:modificato suffisso https in http
site_mainurl="http://" & Request.ServerVariables("HTTP_HOST") & "/"

'Password used to encrypt user data, NEVER CHANGE!
npass="prgttmc"

%>