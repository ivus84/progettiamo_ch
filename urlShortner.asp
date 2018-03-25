<!--#INCLUDE VIRTUAL="/incs/load_connection.asp"-->

<% path = request("aspxerrorpath")
path = replace(path,".aspx","")
path = replace(path,"/","")

'SQL = "select url_original from p_shorturls where id_progetto = " & path
SQL = "select * from p_projects where id = " & path
Set rec=connection.execute(SQL)
    if not rec.eof then
response.Redirect("/?progetti/"&path&"/"&ConvertFromUTF8(linkMaker(rec("ta_nome"))))
    else 
    response.Redirect ( "/")
    end if 
'server.Transfer(rec("url_original"))


 %>