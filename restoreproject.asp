<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%  id = request("ID")
    if  id <> "" then
        call restoreproject (id)
        response.Write StringFormat("Progetto con ID {0} ripristinato", Array(id))
    else
        response.write "Per ripristinare un progetto, inserire ?ID=#num_progetto"
    end if

    sub restoreproject (id)

    SQL = StringFormat ("INSERT INTO p_projects SELECT * from p_deleted_projects where id = {0}" , array(ID))
    connection.execute(SQL)
    SQL = stringformat ("DELETE FROM p_deleted_projects where id = {0}" , array(ID))
     connection.execute(SQL)

    end sub
   
     %>