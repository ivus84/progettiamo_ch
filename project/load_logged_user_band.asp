<%
SQL="SELECT * FROM QU_donators WHERE QU_donators.ID="&Session("logged_donator")
Set rec=connection.execute(SQL)
If Not rec.eof then
    imgp=rec("AT_immagine")
    luogo=rec("TA_citta")
    nazione=rec("nazione")
    enabled_user=rec("LO_enabled")
    If not enabled_user Then
        session.abandon
        Response.redirect("/")
        Response.end
    End if
    SQL="SELECT SUM(IN_promessa) as promised FROM QU_donators WHERE QU_donators.ID="&Session("logged_donator")
    Set rec=connection.execute(SQL)
    if not rec.eof then
        promised=rec("promised")
    end if 

    If isnull(promised) Then promised=0
    promised=setCifra(promised)
    If Len(imgp)=0 Or isnull(imgp) Then imgp="ico_profile.png"
    adName=Session("logged_name")
    If Len(adName)<2 Or isnull(Session("logged_name")) Then adName=Session("logged_ente")
%>
<div class="headerLogged">
<div>
<div class="profileImage" style="background-image:url(/<%=imgscript%>?path=<%=imgp%>$324);"></div>
<div class="profileEdit">
<a href="/profilo/"><img class="edp" src="/images/vuoto.gif" alt="modifica profilo"/></a>
<p style="padding-left:10px;font-size:15px; color:#292f3a"><%=str_welcome%></p>
<p style="padding-left:10px; font-weight:bold; width:270px; font-size:20px;margin:4px 0px 20px 0px; line-height:23px"><%=adName%></p>
<p style="padding-left:10px;font-size:15px; color:#292f3a">
<%=luogo%>
<br/><%=nazione%>
</p>
</div>
<div class="profileEdit" style="width:25%">
<p style="padding-left:10px;color:#9ba1b3;font-size:15px;">
<%=str_promesso%>
</p>
<p style="color:#9ba1b3;font-size:15px; padding:20px 40px 0px 10px;text-align:right;">
<span style="font-weight:bold; font-size:36px; line-height:43px; ">
<img style="float:left; width:51px; margin-right:20px; margin-top:-7px" src="/images/fin_grey.png" alt=""/><%=promised%> 
</span>
</p>
</div>

<%If Session("projects_promoter")=True Then
    SQL="SELECT COUNT(ID) as myprojects FROM p_projects WHERE LO_deleted=False AND CO_registeredusers="&Session("logged_donator")
    Set rec=connection.execute(SQL)
    if not rec.EOF then
        myprojects=rec("myprojects")
    
%>
<div class="profileEdit" style="width:24.5%;border-right:0px;">
<a href="/myprojects/"><img class="edm" src="/images/vuoto.gif" alt="<%=str_miei_progetti%>"/></a>
<p style="padding-left:10px;color:#9ba1b3;font-size:15px;">
<a href="/myprojects/" style="color:#9ba1b3;"><%=str_gestione_progetti%></a></p>
<p style="color:#9ba1b3;font-size:15px; padding:20px 40px 0px 10px;text-align:right;">
<span style="font-weight:bold; font-size:36px; line-height:43px; ">
<img style="float:left; width:51px; margin-right:20px; margin-top:-7px" src="/images/ico_idea.png" alt=""/><%=myprojects%>
</span>
</p>
</div>

<%
    end if
End if%>

</div>
<div style="background:#c3c7d1; height:39px; width:100%;hoverflow:hidden; color:#fff; text-align:center;">
<div class="profileSelector" onclick="getProjectsLogged(0)"><%=str_promesse%></div>
<div class="profileSelector" onclick="getProjectsLogged(1)"><%=str_progetti_finanziati%></div>
<div class="profileSelector" onclick="getProjectsLogged(2)"><%=str_progetti_preferiti%></div>
<%If Session("projects_promoter")=True Then%>
<div class="profileSelector" onclick="document.location='/actions/project_add.asp'"><%=str_pr_add%></div>
<%else%>
<div class="profileSelector" onclick="document.location='/?2152/contatto'"><%=str_pr_presenta%></div>
<%End if%>
<div class="profileContainer"><div></div></div>
</div>
</div>
<%End if%>
