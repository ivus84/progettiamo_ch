<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%  refProject=request("proj")
    email = request("email")
    fromname = request("name")
    messaggio = request("txtmessaggio")
    servername=Request.ServerVariables("HTTP_HOST")

    SQL = "INSERT into MailShares (P_Project,Message,Sender,Receiver) values ("&refProject&",'"&messaggio&"','"&fromname&"','"&email&"')"
    Set rec=connection.execute(SQL)
    SQL = "SELECT @@Identity"
    Set rec=connection.execute(SQL)
    ID = rec(0)
    'response.write id 
    'response.End

    SQL="SELECT * FROM QU_projects WHERE ID="&refProject
Set rec=connection.execute(SQL)
    if not rec.EOF then
    'pageDesc = rec("TE_ABSTRACT")
    'pImage = rec("AT_main_img")
    pTitle = rec("TA_nome")
    end if
    
    If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")

'plink=linkMaker(pTitle)
   ' if len(pImage)>0 Then href="http://"&servername&"/"&imgscript&"?path="&pImage&"$350" end if
'if len(pageDesc)>160 then pageDesc=truncateTxt(pageDesc,160)&" ..."
    mailsubject = pTitle
    href="http://"&servername&"/incs/MailShare.asp?message="&ID
    'response.write href
    'response.End
    sendto=email
    
    'HTML = str_txt_notifica_body&chr(10)
    'HTML = HTML&"<div>"&messaggio&"</div>"

    'HTML = HTML&"<div class=""boxProject"" style=""float: left; text-align: left;border: 1px solid #efefef; padding: 0px; margin:0px""><img style=""width: 160px; height: 160px; float: left;"" id=""imgSharePrj"" src=""cid:img.jpeg""><div class=""title""><span ID=""imgShareTitle"" style=""font-weight: bold""  >"&pTitle&" - Progettiamo.ch</span></div><div class=""abstract"" id=""imgShareDescription"">"&pageDesc&"</div><div class=""site""><a id=""imgShareUrlLink"" style=""color: #efefef;text-transform: uppercase;"" href="""&pLink&""">progettiamo.ch</a></div></div>"
    'HTML = HTML&chr(10)& str_txt_notifica_body_end
    %>
		<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
		<%
    SQL="UPDATE p_projects set IN_mailShareCount = IN_mailShareCount + 1 WHERE ID="&refProject
    Set rec=connection.execute(SQL)
    response.Write "OK"
    connection.close
%>
