<!-- #include VIRTUAL="./admin/aspUpload.asp" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
server.scriptTimeout=3600

npref=Replace(Request.ServerVariables("HTTP_HOST"),".","")

npref=Replace(npref,"www","")
npref=Replace(npref,":","")
npref=Replace(npref,"lavb","")
npref=Replace(npref,"localhost","progettiamo.ch")
npref=Replace(npref,"test.","")

Dim uploadsDirVar
Dim Upload, fileName, fileSize, ks, i, fileKey

Set Upload = New FreeASPUpload
    
Upload.ReadForm()



nome=Upload.Form("nome")
titolo=Upload.Form("titolo")
fixed=Upload.Form("fixedH")
nameprefix=Upload.Form("nameprefix")

imageName=Upload.Form("imageName")

operationType=Upload.Form("operationType")

ref1=Upload.Form("ref1")
enabled=Upload.Form("enabledH")

nome=Replace(nome, "'", "´")
titolo=Replace(titolo, "'", "´")

if operationType="insert" then
    SQL="INSERT INTO friends (p_name,TA_title,fixed,at_main_img,lo_pubblica,ta_color,dt_data,co_p_area) VALUES ('" & nome & "','" & titolo & "'," & fixed & ",'" & imageName & "',True,'#ffffff',date()," & session("adm_area") & ")"
elseif operationType="update" then
    SQL="UPDATE friends set p_name='" & nome & "',ta_title='" & titolo & "',lo_pubblica=" & enabled & ",fixed=" & fixed & ",at_main_img='" & imageName & "' WHERE ID=" & ref1
end if
set record1=connection.execute(SQL)

uploadsDirVar = imagespath
Upload.Save(uploadsDirVar)

if operationType="insert" then
    response.redirect "../admin/amici.asp"
elseif operationType="update" then
    response.write "<script>window.parent.parent.location.reload(false);</script>"
end if
%>