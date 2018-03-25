<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./incs/common_functions.asp"-->
<%  createtable ()
    
    sub  createtable()
        SQL=StringFormat("SELECT * INTO p_deleted_projects FROM p_projects ",Array())
          connection.execute(SQL)
          SQL = "delete from p_deleted_projects" 
          connection.execute(SQL)
    end sub
     %>