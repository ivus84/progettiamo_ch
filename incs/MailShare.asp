
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./incs/common_functions.asp"-->

<%
    
    servername=Request.ServerVariables("HTTP_HOST")
    ID = request("message")
    SQL = "SELECT * from (MailShares left join p_projects on p_projects.ID=MailShares.p_project) where MailShares.ID="& ID
    Set rec=connection.execute(SQL)
     if not rec.EOF then
    pTitle = rec("TA_nome")
    pageDesc = rec("TE_ABSTRACT")
    pageDesc= ConvertFromUTF8(pageDesc)
    pImage = rec("AT_main_img")
    If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")
    plink=linkMaker(pTitle)
    fulllink = "http://"&servername&"/"&rec("p_project")&".aspx"
    if len(pImage)>0 Then href="http://"&servername&"/"&imgscript&"?path="&pImage&"$350" end if
    end if
     %>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
</head>
<body>
    <div style="font-family: Arial,Helvetica,sans-serif;float:left; clear:left; width:100%; padding-bottom:0px; margin-bottom:5px; border: 1px solid black;">
        <%=rec("Message") %>

        </div>
        <div class="boxProject" style="float: left; text-align: left;border: 1px solid #efefef; padding: 0px; margin:0px">
            <img style="width: 160px; height: 160px; float: left;margin-bottom:5px; margin-right:5px;" src="<%=href %>" id="imgSharePrj">
            <div class="title">
                <span ID="imgShareTitle" style="font-weight: bold;"   ><%=pTitle %></span></div>
            <div class="abstract" id="imgShareDescription"><%=pageDesc %></div>
            <div class="site" style="margin-top: 10px;"><a id="imgShareUrlLink" style="color: #000000;text-transform: uppercase;" href="<%=fulllink %>">progettiamo.ch</a></div>
        </div>
    <div id="footer" style="padding-top:50px;clear:both">
        <div>Sostieni questo progetto su</div>
        <div><a href="<%=fulllink %>"><img src="<%=site_mainurl%>images/progettiamo_logo_mail.png"/></a></div>
    </div>
</body>
</html>
