
<div class="homeNews lprojects" style="margin-top: 60px;">
    <div><p><%=str_pr_in_scadenza%></p>
        <div class="newsScroller">
        <%
        SQL="SELECT QU_projects.* FROM QU_projects WHERE QU_projects.LO_aperto=True ORDER BY DT_termine ASC"
        mode="termine"
        iPageSize = 12

        %>
        <!--#INCLUDE VIRTUAL="./project/load_projects_list_bottom_home.asp"-->
        </div>
    </div>
    <img class="arrHome" src="/images/arrow_down_w.png" alt=""/>
</div>

<div class="homeNews lprojects lasthomenews">
    <div><p><%=str_pr_sostenuti_recente%></p>
        <div class="newsScroller">
        <%
        'SQL="SELECT QU_projects.*,QU_projects_promises.IN_promessa as promessa, QU_projects_promises.DT_data as data_promessa FROM QU_projects INNER JOIN QU_projects_promises ON QU_projects.ID = QU_projects_promises.CO_p_projects WHERE QU_projects.LO_aperto=True ORDER BY QU_projects_promises.DT_data DESC"
            SQL="SELECT QU_projects.*,QU_projects_promises.IN_promessa as promessa, QU_projects_promises.DT_data as data_promessa FROM QU_projects INNER JOIN QU_projects_promises ON QU_projects.ID = QU_projects_promises.CO_p_projects ORDER BY QU_projects_promises.DT_data DESC"
        mode="donation"
        ''' IB aumento pages BEGIN
        'iPageSize = 4
        iPageSize = 12
        ''' IB aumento pages END
        %>
        <!--#INCLUDE VIRTUAL="./project/load_projects_list_bottom_home.asp"-->
        </div>
    </div>
    <img class="arrHome" src="/images/arrow_down_w.png" alt=""/>
</div>
<!--VB:Nuova Sezione Amici di progettiamo-->


<div class="homeNews" style="cursor:default;height:330px;">
<div class="frn"><p><%=str_friends%></p>
<div class="newsScroller" style="cursor:default">


<%

iPageSize = 12
iCurrentPage = 1

Set RecordSet = Server.CreateObject("ADODB.Recordset")
'VB:Prendo prima gli ID dei record fixed (quelli che devono essere sempre visibili)
 
SQL="Select id from friends where fixed=True and lo_pubblica=True"
RecordSet.Open SQL, Connection, adOpenStatic, adLockReadOnly

fixedId=""
nOfFixed=RecordSet.RecordCount
do while not RecordSet.EOF
    if fixedId="" then
        fixedId=RecordSet("ID")
    else
        fixedId = fixedId & "," & RecordSet("ID")
    end if
    RecordSet.movenext
loop
RecordSet.Close
'response.write fixedId

SQL="SELECT top " & iPageSize - nOfFixed & " friends.*,Rnd(-10000000*TimeValue(Now())*[id]) from friends where lo_pubblica=True and fixed=False "
if nOfFixed>0 then SQL= SQL & " UNION SELECT friends.*,Rnd(-10000000*TimeValue(Now())*[id]) from friends where id in (" & fixedId & ") "
SQL=SQL & " ORDER BY 11"

'response.write SQL
'response.End

RecordSet.Open SQL, Connection, adOpenStatic, adLockReadOnly
'RecordSet.PageSize = iPageSize
'RecordSet.CacheSize = iPageSize
intCurrentRecord = 1
friendsIDs=""
do While intCurrentRecord <= iPageSize

    if not recordset.eof then
        refnews=RecordSet("ID")
        'friendsIDs=friendsIDs & refnews & ","
        pcolor=RecordSet("TA_color")
        pname=RecordSet("p_name")
        pdata=datevalue(RecordSet("DT_data"))
        ptitle=RecordSet("TA_title")
        pimg=RecordSet("AT_main_img")

        If Len(pname)>0 Then pname=Replace(pname,"#","'")
        'VB:Il path di riferimento per le immagini è ../database/images
        addbimg="<img id=""img_friends_" & intCurrentRecord & """ class=""bnews friends"" src=""/images/vuoto.gif"" style="" cursor:default;opacity:1;background-color:" & pcolor & "; background-image:url(/" & imgscript & "?path="& pimg & "$600)"" alt=""""/>"

        'VB:lightbox
        'lightBoxImg="<img id=""" & "img_ligthbox_" & intCurrentRecord & """ src=""/images/vuoto.gif"" style="" cursor:default;height:400px;width:400px;display:none;background-color:" & pcolor & "; background-image:url(/" & imgscript & "?path="& pimg & "$400)"" alt=""""/>"
        'title=pname & " " & ptitle
        'Response.write "<div id=""" & "div_ligthbox_" & intCurrentRecord & """ title=""" & title & """ style=""display:none"">"
        'Response.write lightBoxImg 
        'Response.write "</div>"


        Response.write "<div style=""cursor:default;min-height:200px;background-color:" & pcolor & """>"
        Response.write "<div id=""" & "div_friends_" & intCurrentRecord & """ img_url=""" & imgscript & "?path=" & pimg & "$400"" class=""nContentF friends"" style=""display:none""><p><br/><br/><br/><span>" & pname & "</span><br/>" & ptitle & "</p>"
        Response.write "</div>"
        Response.write addbimg 
        Response.write "</div>"

        

        RecordSet.movenext
    End If
    intCurrentRecord=intCurrentRecord+1
loop
%>
</div>
<%=friendsIDs %>
</div>
<!--<img class="arrHome" src="/images/arrow_down_w.png" alt=""/>-->
<img class="arrHome arrUp" onclick="$('html,body').animate({scrollTop: 0},1200)" alt="" src="/images/arrow_up.png"/>
</div>





   