<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./incs/common_functions.asp"-->
<%  
    SQL = "select distinct id from p_projects"
    set rec1 = connection.execute(SQL)
    Do While Not rec1.eof
    id = rec1("id")
    SQL = "select count (ID) as coun from MailShares where p_project =  "&id
    set rec2 = connection.execute(SQL)
    count = rec2("coun")
    SQL="UPDATE p_projects set IN_mailShareCount = " &count
    Set rec=connection.execute(SQL)
    rec1.movenext
    loop

    
    
     %>