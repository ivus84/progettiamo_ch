<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<!-- #include VIRTUAL = "./admin/clsSHA-1.asp" -->

<%

''ON ERROR RESUME NEXT
pagina=request("pagina")
tabella=request("tabella")
sel0=request("sel0")
sel1=request("sel1")
da=request("da")
mode=request("mode")
group=request("group")
%>
<!--#INCLUDE VIRTUAL="./admin/load_allowed_columns.asp"-->
<%
allowed_columns=allowed_columns&" , AT_post_img ,"

contacampi=CInt(request("contacampi"))
encryptedFields=",TA_telefono,TA_natel,TA_email,"
encodedFields =",TX_testo_bonus,"
if tabella="registeredusers" then
	If Len(request("TA_email"))<5 then
	    %>
	    <script type="text/javascript">
	    alert("E-mail non valida\nSi prega di riprovare");
	    history.back();
	    </script><%

	    Response.End
    End if
    If InStr(request("TA_email"),"@")=0 OR InStr(request("TA_email"),".")=0 Or Len(request("TA_email"))<5 then
        %>
        <script type="text/javascript">
        alert("E-mail non valida\nSi prega di riprovare");
        history.back();
        </script><%

        Response.End
    End If
    emailCheck=request("TA_email")
    If Len(emailCheck)>0 Then emailCheck=LCase(emailCheck)

    emailCheck = EnDeCrypt(emailCheck, npass, 1)

    SQL="SELECT * FROM "&tabella&" WHERE ID<>" & pagina&" AND (TA_email='" & emailCheck & "' OR TA_email_recupero='" & emailCheck & "')"
    set rec=connection.execute(SQL)
    if not rec.eof then
        %>
        <script type="text/javascript">
        alert("E-mail già associata ad un altro utente\nSi prega di riprovare");
        history.back();
        </script><%
        response.end
    end if
end if

Set rstSchema = connection.OpenSchema(adSchemaColumns,Array(Empty, Empty, "" & tabella & ""))
'VB Se pagina 0 è l'inserimento di un nuovo record
if pagina=0 then 
    set record0=connection.execute("select max(id) as maxid from " & tabella)
    maxid=record0("maxid")+1
    connection.execute("INSERT INTO " & tabella & " (id) values(" & maxid & ")")
    pagina=maxid
end if

SQL="UPDATE " & tabella & " SET"

i=0

Do Until rstSchema.EOF
    colName=rstSchema("COLUMN_NAME")
    if InStr(allowed_columns," "&colName&" ")>0 then

    Session("test"&i)=rstSchema("DESCRIPTION") &":"
    Session("val"&i)=request(""&colName)
    inputItem=Mid(colName, 1, 2)

    valore=CStr(Session("val"&i))

    sep=","

    if inputItem="TA" AND len(valore)>255 Then valore=Mid(valore,1,255)

    If colName="TA_password" AND Len(valore)<20 Then

    pwd0=valore&numproject

    Dim ObjSHA1

    Set ObjSHA1 = New clsSHA1
    valore = ObjSHA1.SecureHash(pwd0)
    Set ObjSHA1 = Nothing
    SQL=SQL & sep &" " & colName & "='" & valore & "'"

    elseif inputItem="TA" OR inputItem="TX" OR inputItem="TE" OR inputItem="AT" then
    if instr(encodedFields,colName)then
        valore = Server.HTMLEncode(valore)
        valore = replace(valore,"'","&apos;")	
    end if
    If InStr(encryptedFields,colname) Then 
        If colname="TA_email" And Len(valore)>0 Then valore=LCase(valore)
        valore = EnDeCrypt(valore, npass, 1)
    End if

    if colName="TX_datadef" then
    valore=Request("datadef")
    valore = Replace(valore,  "'", "�")
    valore = Replace(valore,  Chr(34), "")

    elseif inputItem<>"TE" And colName<>"TX_testo" then
    valore = Replace(valore,  "'", "''")
    valore = Replace(valore, CHR(34), CHR(34)&CHR(34))
    valore = Replace(valore,CHR(10), "<br />")
    else
    valore = Replace(valore,  "'", "''")
    valore = Replace(valore,  "admin/", "")
    end If

    if colName="TX_desc" Then
        If Len(valore)>0 Then valore=Replace(valore,Chr(34)&Chr(34),Chr(34))
    End if

    SQL=SQL & sep & " " & colName & "='" & valore & "'"

    elseif inputItem="DT" Then
    SQLdt="SELECT " & colName & " AS prevval FROM " & tabella & " WHERE ID=" & pagina
    Set rec=connection.execute(SQLdt)
    prevval=rec("prevval")
    If IsNull(prevval) Then prevval=Month(Now())&"/"&Day(Now())&"/"&Year(Now())
    tvalu=TimeValue(prevval)
	
	    if Len(valore)=0 then
	    valore=FormatDateTime(Now(), 2)
	    else
	    valore=Request(""&colName)
	    If Len(valore)>0 Then
	    valore=Replace(valore,"/",".")
	    valored=Split(valore,".")
	    valore=valored(1)&"/"&valored(0)&"/"&valored(2)
	    If Not isdate(valore) Then valore=now()
	    valore=FormatDateTime(valore, 2)

	    End if
	    end if

    valore=Replace(valore,".","/")&" "&tvalu

    SQL=SQL & sep & " " & colName & "=#" & valore & "#"

    elseif inputItem="LO" then
    if Len(valore)=0 then
    valore="False"
    end if 

    SQL=SQL & sep & " " & colName & "=" & valore

    elseif inputItem="IN" OR inputItem="CO" then
    valore=Replace(valore, ",", ".")
    valore=Replace(valore, "'", "")

    SQL=SQL & sep & " " & colName & "=" & valore

    elseif inputItem="CX" Or inputItem="CR" OR inputItem="CL" Or inputItem="CI" then

    SQL=SQL&sep&" "&colName&"='"&valore&"'"

    end if
    i=i+1

        rstSchema.MoveNext

        else
        rstSchema.MoveNext
        end if
Loop
    rstSchema.Close

SQL=Replace(SQL,tabella&" SET,",tabella&" SET")
SQL=SQL&" WHERE ID="&pagina
'response.write SQL
'response.end
SET recordset=connection.execute(SQL)

d=0
do while d<contacampi
    Session("val"&d)=""
    d=d+1
loop

If err.number>0 then
    response.write "VBScript Errors Occured:" & "<P>"
    response.write "Error Number=" & err.number & "<P>"
    response.write "Error Descr.=" & err.description & "<P>"
    response.write "Help Context=" & err.helpcontext & "<P>"
    response.write "Help Path=" & err.helppath & "<P>"
    response.write "Native Error=" & err.nativeerror & "<P>"
    response.write "Source=" & err.source & "<P>"
    response.write "SQLState=" & err.sqlstate & "<P>"
end if
IF connection.errors.count> 0 then
    response.write "Database Errors Occured" & "<P>"
    response.write SQL & "<P>"
    for counter= 0 to connection.errors.count
        response.write "Error #" & connection.errors(counter).number & "<P>"
        response.write "Error desc. -> " & connection.errors(counter).description & "<P>"
    next

else
goto1="main.asp"
if len(da)>0 Then goto1=da&".asp"
%>
<!DOCTYPE html>
<html lang="it">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script> 
</head>
<body>
<script type="text/javascript">
$(document).ready(function() {
    document.location="edit.asp?tabella=<%=tabella%>&mode=<%=mode%>&da=<%=da%>&pagina=<%=pagina%>&group=<%=group%>";
    if ($('#listGet', parent.document).size()>0) {
	    parent.GetList()
    }
});
</script>
</body>
<%
end if
connection.close


%>
