<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%  id = request("ID")
    if  id <> "" then
        call deleteproject (id)
        response.Write StringFormat("Progetto con ID {0} cancellato", Array(id))
    else
        response.write "Per cancellare un progetto, inserire ?ID=#num_progetto"
    end if

    sub deleteproject (id)
       
        SQL = StringFormat ("INSERT INTO p_deleted_projects SELECT * from p_projects where id = {0}" , array(ID))
        connection.execute(SQL)
        SQL = stringformat ("DELETE FROM p_projects where id = {0}" , array(ID))
        connection.execute(SQL)
    end sub
  
%>