
<div class="homeProjects" id="homeProjects">
<%
projectsFound=False
SQL="SELECT * FROM p_category order by IN_ordine"
Set rec=connection.execute(SQL)
'VB:qui vengono caricati i div dei progetti per tipo
Do While Not rec.eof
    nomec=rec("TA_nome")
    colorc=rec("TA_color")
    ref=rec("ID")

    disablecounts=True
    SQL="SELECT COUNT(ID) as num, sum(IN_raccolto) as fondi FROM p_projects WHERE LO_confirmed=True AND CO_p_category="&ref
    Set rec1=connection.execute(SQL)
    if not rec1.eof then
        num_projects=rec1("num")
    end if
    If Not disablecounts then
        SQL="SELECT COUNT(ID) as num, sum(IN_raccolto) as fondi FROM p_projects WHERE LO_confirmed=True AND CO_p_category="&ref
        Set rec1=connection.execute(SQL)
        if not rec1.eof then
        num_projects=rec1("num")
        num_fondi=rec1("fondi")
        end if 
        If isnull(num_fondi) Then num_fondi=0
        
        SQL="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE CO_p_category=" & ref & ")"
        Set rec1=connection.execute(SQL)
        num_subscribers=rec1("subscribers")

        SQL="SELECT SUM(IN_viewed) as num_visits FROM QU_projects WHERE (LO_confirmed=True AND LO_deleted=false) AND CO_p_category=" & ref
        Set rec1=connection.execute(SQL)
        num_visits=rec1("num_visits")

        SQL="SELECT COUNT(ID) as num FROM p_projects WHERE LO_confirmed=True AND LO_realizzato=True AND CO_p_category=" & ref
        Set rec1=connection.execute(SQL)
        num_done=rec1("num")

        num_fondi=setCifra(num_fondi)
    End if
    
    If Len(nomec)>0 Then nomec=Replace(nomec,"Sosteniamo",str_sosteniamo)
    If Len(nomec)>0 Then nomec=Replace(nomec,"Doniamo",str_doniamo)
    If Len(nomec)>0 Then nomec=Replace(nomec,"Finanziamo",str_finanziamo)

    response.write"<div class=""projectsContainer""><div id=""p_" & ref & """ class=""projectsTitle"" style=""background-color:"&colorc&""" rel="""&colorc&"""><span>"&nomec&"</span></div>"
    If num_projects>0 Then
       'VB:La variabile projectfound a false nasconde la selezione delle aree
        projectsFound=True
    End If

    Response.write"</div>"

    rec.movenext
Loop

response.write"<div class=""projectsContainer""><div id=""p_0"" class=""projectsTitle"" style=""background-color:#9ba1b3"" rel=""#9ba1b3""><span>"&str_realizzati&"</span></div></div>"

%>
<div class="projectsList"></div>
<!--#INCLUDE VIRTUAL="./incs/load_search_menu.asp"-->
    <div style="text-align:center"><img class="arrHome" src="/images/arrow_down_w.png" alt="" /></div>
    
</div>
