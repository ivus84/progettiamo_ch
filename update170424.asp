<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./incs/common_functions.asp"-->
<html>
<body>
<table>
<tr>
<th>ID_Project</th><th>link</th><th>fblink</th>
</tr>

<% 



if request("creatabella") = "yes" then
    SQL1 = stringformat("ALTER TABLE p_projects add column TX_fblink TEXT (255)",array())
    Set rec1=connection.execute(SQL1)
    %>table modified<%
else
    SQL="SELECT * FROM QU_projects "
    Set rec=connection.execute(SQL)
    Do While Not rec.eof
        pTitle=rec("TA_nome")
        If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")
        plink=linkMaker(pTitle)
        fblink = StringFormat("/?progetti/{0}/{1}",array(rec("ID"),plink))
        %>
        <tr>
        <td><%=rec("ID") %></td><td><%=fblink%></td><td><%=rec("TX_fblink")%></td>
        </tr>
        <%
        if request("aggiornatabella") = "yes" then
            SQL1 = stringformat("UPDATE p_projects SET TX_fblink = '{0}' where id={1}", array(fblink,rec("ID")))
            Set rec1=connection.execute(SQL1)
        end if
        rec.movenext
    loop
end if 
 %>
</table>
</body>
</html>