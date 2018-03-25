<%
'session.abandon
%>
<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="/incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_header.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->

<%
Session("licensekey")=""
Session("lang")=0
Session("logged_donator")=""
Session("islogged"&numproject)=""


SQL="SELECT * FROM utenticantieri WHERE LO_attivo=True AND LO_amministrazione=True AND TA_login='"&request("user1")&"'"
set recordset=connection.execute(SQL)
if recordset.eof then
    response.redirect("admin.asp")
    response.end
end if
'VB:Gestisco l'ingresso in test col solo username
if 1<>1 then
'if request("user1")<>"admin" then
    passcheck=recordset("TA_password")

    pwd0=request("psw1")&numproject

    Dim ObjSHA1

    Set ObjSHA1 = New clsSHA1
    StrDigest = ObjSHA1.SecureHash(pwd0)
    Set ObjSHA1 = Nothing


    if passcheck<>StrDigest then
	    response.redirect("admin.asp")
	    response.end
    end if
end if 


Session("log45"&numproject)="req895620schilzej"
Session("online")="ok1"
Session("allow_contenuti"&numproject)=recordset("LO_contenuti")
session("Group")="admin"
session("Cantiere")=1
Session("userfrm")="admin"
Session("username")=recordset("TA_nome")&" "&recordset("TA_cognome")
Session("nome")=Session("username")
Session("emailutente")=recordset("TA_email")
Session("IDuser")=recordset("ID")

Session("adm_intimages")=recordset("LO_consulenza")
Session("adm_newsletter")=recordset("LO_newsletter")
Session("adm_users")=recordset("LO_utenti")

'VB:Gestione delle aree per la nuova sezione Amici
Session("adm_area")=0
if recordset("CO_p_area")<>"" then Session("adm_area")=recordset("CO_p_area")

Session("adm_languages")=recordset("LO_software")
Session("adm_config")=recordset("LO_cantieri")
Session("adm_admusers")=recordset("LO_admusers")

Session("adm_networking")=recordset("LO_iscrizioni")
Session("adm_anmeldung")=recordset("LO_admanmeldung")

Session("adm_files")=recordset("LO_admkontakt")
Session("adminlanguageactive")=recordset("TA_admin_language")



SQL="SELECT hdi FROM hdi"
set recordseth=connection.execute(SQL)
hdi=recordseth("hdi")



Set rstSchema = connection.OpenSchema(adSchemaColumns,Array(Empty, Empty, "_config_admin"))
i=0

disallowed_columns=" ID "

do Until rstSchema.EOF

if InStr(allowed_columns," "&rstSchema("COLUMN_NAME")&" ")=0 then

SQL="SELECT "&rstSchema("COLUMN_NAME")&" as valore FROM _config_admin"
Set recordtem=connection.execute(SQL)


Session(""&Mid(rstSchema("COLUMN_NAME"),4,Len(rstSchema("COLUMN_NAME")))&""&numproject)=recordtem("valore")
end if
rstSchema.movenext
loop

Session.timeout=240



if LCase(request("user1"))="admin" then
Session("adm_intimages")=True
Session("adm_newsletter")=True
Session("adm_users")=True
Session("adm_languages")=True
Session("adm_config")=True
Session("adm_networking")=True
Session("adm_admusers")=True
Session("adm_anmeldung")=True
Session("adm_files")=True
psv="admpro07"
Set Connection1=Server.CreateObject("ADODB.Connection")
Connection1.Open "PROVIDER=Microsoft.Jet.OLEDB.4.0;" & "Data Source=" & licensepath & ";" & "Jet OLEDB:Database Password="&psv
SQL="SELECT value FROM licensekey"
set record=connection1.execute(SQL)
value=record("value")
if value=psv then
Session("licensekey")=value
end if
end if

Session("viewpass")="adhhfzttdu"

if len(Session("adminlanguageactive"))=0 then Session("adminlanguageactive")="it"
response.redirect("./")
response.end
%>
