<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_allowed_columns.asp"-->
<%
hh=156


da=request("da")
tabella=request("tabella")
contacampi=CInt(request("contacampi"))

Set rstSchema = connection.OpenSchema(adSchemaColumns,Array(Empty, Empty, ""&tabella&""))

SQL="INSERT INTO "&tabella&" ("

i=0

Do Until rstSchema.EOF

if InStr(allowed_columns," "&rstSchema("COLUMN_NAME")&" ")>0 AND rstSchema("COLUMN_NAME")<>("ID") then

SQL=SQL&rstSchema("COLUMN_NAME")

i=i+1

sep=","
SQL=SQL&sep

rstSchema.movenext
else
rstSchema.movenext
end if

loop
rstSchema.movefirst


SQL=Mid(SQL,1,Len(SQL)-1)&")"

SQL=SQL&" VALUES ("


i=0

Do Until rstSchema.EOF

if InStr(allowed_columns," "&rstSchema("COLUMN_NAME")&" ")>0 AND rstSchema("COLUMN_NAME")<>("ID") then

inputItem=Mid(rstSchema("COLUMN_NAME"), 1, 2)


if inputItem<>"AT" then
Session("val"&i)=request(""&rstSchema("COLUMN_NAME"))
On Error resume next
response.write Session("val"&i)
end if

valore=Session("val"&i)

if inputItem="TX" OR inputItem="TA" OR inputItem="CR"  OR inputItem="CL" OR inputItem="CI" then
valore = Replace(valore,  "'", "&#39;")
valore = Replace(valore,CHR(10), "<BR/>")

SQL=SQL&"'"&valore&"'"

elseif inputItem="DT" then
if Len(valore)=0 then
valore=FormatDateTime(Now(), 2)
else
valore=request(""&rstSchema("COLUMN_NAME")&"m")&"/"&request(""&rstSchema("COLUMN_NAME")&"g")&"/"&request(""&rstSchema("COLUMN_NAME")&"a")
valore=FormatDateTime(valore, 2)
end if
valore=Replace(valore,".","/")
SQL=SQL&"#"&valore&"#"

elseif inputItem="LO" then
if Len(valore)=0 then
valore="False"
end if
if valore="Vero" then
valore="True"
end if

SQL=SQL&valore

elseif inputItem="IN" OR inputItem="CO"  then
if len(valore)=0 then valore=0
valore=Replace(valore, ",", ".")
valore=Replace(valore, "'", "")

SQL=SQL&valore

elseif inputItem="AT" then



nome=request(""&rstSchema("COLUMN_NAME")&"n")

if Len(nome)>0 then
ext=Right(nome, 3)


nomeyy= Day(Now())&Month(Now())&Year(Now())&Hour(Now())&Minute(Now())&Second(Now()) &hh& "."&ext

Session("reff"&hh)=nomeyy

hh=hh+1

else

nomeyy=""

end if


SQL=SQL&"'"&nomeyy&"'"


end if



i=i+1

sep=","
SQL=SQL&sep

    rstSchema.MoveNext

    else
    rstSchema.MoveNext
    end if



    Loop
    rstSchema.Close




SQL=Mid(SQL,1,Len(SQL)-1)&")"



SET recordset=connection.execute(SQL)

d=0
do while d<contacampi
Session("val"&d)=""
d=d+1
loop

If err.number>0 then
response.redirect("open.asp?sell=1&tabella="&tabella)
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

if Mid(tabella,1,10)="networking" OR tabella="fails" OR tabella="registeredusers" then
SQL="SELECT MAX(ID) as ref from "&tabella
set rec=connection.execute(SQL)

ref=rec("ref")

if tabella="fails" then 
response.redirect("files.asp")
response.end
end If


response.redirect("edit.asp?pagina="&ref&"&tabella="&tabella&"&da=list&group="&request("CO_networking_groups"))



else
							  response.redirect(""&da&".asp")
end if
                          end if
connection.close


%>
