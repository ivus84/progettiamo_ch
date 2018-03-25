<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

CO_oggetti=request("pagina")


if Len(CO_oggetti)>0 then
Session("sel0")=CO_oggetti
end if

sel0=request("sel0")
sel1=request("sel1")
sel2=request("sel2")
sel3=request("sel3")
sel4=request("sel4")
sel5=request("sel5")

if Len(sel0)>0 then
Session("sel0")=sel0
end if

if Len(sel1)>0 then
Session("sel1")=sel1
end if

if Len(sel2)>0 then
Session("sel2")=sel2
end if

if Len(sel3)>0 then
Session("sel3")=sel3
end if

if Len(sel4)>0 then
Session("sel4")=sel4
end if

if Len(sel5)>0 then
Session("sel5")=sel5
end if

%>
<!--#INCLUDE VIRTUAL="./ADMIN/retrieve_page_lang.asp"-->
<%
SQL1="SELECT MAX(ID) as newpag From oggetti"
SET recordset1=connection.execute(SQL1)

newpag=recordset1("newpag")

SQL="SELECT MAX(IN_ordine) as ordine FROM newsection WHERE CO_oggetti="&CO_oggetti
SET recordset=connection.execute(SQL)

if not recordset.eof then
ordine=recordset("ordine")
if IsNull(ordine)=True then ordine=0
else
ordine=0
end if

if isnumeric(ordine)=True then
ordine=CInt(ordine)+1
end if


if Isnull(ordine)=False then
SQL="UPDATE oggetti set IN_ordine="&ordine&" WHERE ID="&newpag
SET recordset=connection.execute(SQL)
end if

SQL="INSERT INTO defsections (CO_oggetti,CO_oggetti_)"
SQL=SQL&" VALUES ("&CO_oggetti&","&newpag&")"
SET recordset=connection.execute(SQL)






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

                          Else
                          session("ref")=newpag
                          response.redirect("main.asp?viewmode=edit_page.asp")
end if
connection.close


%>
