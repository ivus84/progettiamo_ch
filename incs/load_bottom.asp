<%if ishomepage Then%>
	

	<!--#INCLUDE VIRTUAL="./incs/load_bottom_home.asp"-->


<div class="testimonial">
	<div></div>
	<div></div>
	<div></div>
</div>
<%End if%>
<%if ishomepage Then%>

    <div class="homeTotals">
    <%
    If Len(Session("viewStat"&Session("reflang")))=0 Then 
        SQL1="SELECT COUNT(ID) as num, sum(IN_raccolto) as fondi FROM QU_projects WHERE LO_confirmed AND LO_deleted=False AND (LO_realizzato OR fondi_raccolti>=IN_cifra OR LO_aperto)"
        SQL2="SELECT COUNT(ID) as subscribers FROM (SELECT DISTINCT ID FROM QU_projects_promises WHERE LO_confirmed AND LO_deleted=False AND (LO_realizzato OR fondi_raccolti>=IN_cifra OR LO_aperto))"
        SQL3="SELECT SUM(IN_viewed) as num_visits FROM QU_projects WHERE LO_confirmed AND LO_deleted=False AND (LO_realizzato OR fondi_raccolti>=IN_cifra OR LO_aperto)"
        SQL4="SELECT COUNT(ID) as num_success FROM QU_projects WHERE IN_raccolto>0 AND (LO_realizzato OR (DateDiff('d',DT_termine,Now())>=0 AND fondi_raccolti>=IN_cifra))"
        SQL5="SELECT COUNT(ID) as num_ended FROM QU_projects WHERE ((LO_deleted AND fondi_raccolti<IN_cifra) OR (IN_raccolto>0 AND DateDiff('d',DT_termine,Now())>=0 AND fondi_raccolti<IN_cifra))"

	    Set rec1=connection.execute(SQL1)
	    Set rec2=connection.execute(SQL2)
	    Set rec3=connection.execute(SQL3)
	    Set rec4=connection.execute(SQL4)
	    Set rec5=connection.execute(SQL5)

	    num_projects=rec1("num")
	    num_fondi=rec1("fondi")
	    If isnull(num_fondi) Then num_fondi=0
	    num_subscribers=rec2("subscribers")
	    num_visits=rec3("num_visits")

        pmedia=0
        If num_fondi>0 Then pmedia=Round(num_fondi/num_subscribers,2)

        num_fondi=setCifra(num_fondi)
        pmedia=setCIfra(pmedia)
	

        num_success=rec4("num_success")
        num_ended=rec5("num_ended")
        'Response.write num_success&"/"&num_ended
        totended=num_success+num_ended
        If totended>0 Then perc_success=Round(num_success/totended*100,0)
        colorc="#9ba1b3"

        addstats_general="&nbsp;"
        If num_projects>0 Then
            addstats_general="<div class=""catInfo""><p>" & str_progettiamo_in_cifre & "</p>" &_
            "<div>"&str_tot_projects1&" <div><span><img src=""/images/vuoto.gif"" style=""background-image: url(/images/ico_presenti.png)"" alt=""""/>"& num_projects &"</span></div></div>"&_
            "<div>"&str_tot_visits&"<div><span><img src=""/images/vuoto.gif"" style=""background-image: url(/images/ico_sostenitori.png); margin-right:0px;"" alt=""""/>"& num_visits &"</span></div></div>"&_
            "<div>"&str_finanziatori&"<div><span><img src=""/images/vuoto.gif"" style=""width:46px;height:54px;background-image: url(/images/ico_finanziatori.png); margin-top:-23px;"" alt=""""/>"& num_subscribers &"</span></div></div>"&_
            "<div>"&str_promessa_media&" Fr.<div><span><img src=""/images/vuoto.gif"" style=""background-image: url(/images/ico_fondi.png)"" alt=""""/>"& pmedia &"</span></div></div>"&_
            "<div>"&str_funds&" Fr.<div><span><img src=""/images/vuoto.gif"" style=""background-image: url(/images/ico_fondi.png);margin-right:3px;"" alt=""""/>"& num_fondi &"</span></div></div>"&_
            "<div alt=""tasso di successo dei progetti a scadenza"" title=""tasso di successo dei progetti a scadenza"" style=""cursor:pointer"">"&str_tasso_successo&"<div><span><img src=""/images/vuoto.gif"" style=""background-color:transparent; background-position:center top; background-image: url(/images/ico_win.png)"" alt=""""/>"& perc_success &"&#37;</span></div></div>"&_
            "</div>"
        End If
        Session("viewStat"&Session("reflang"))=addstats_general
    End if

    Response.write Session("viewStat"&Session("reflang"))


    %>
    </div>
    <%
    'VB:Aggiunti agli Iframe di seguito lo style display:none
    SQL="SELECT * FROM QU_projects WHERE LO_aperto AND LO_confirmed AND DateDiff('d',DT_apertura,Now())=7"
    Set record=connection.execute(SQL)
    Do while Not record.eof
        Response.write"<iframe style=""width:100px;height:10px;border:0px;overflow:hidden; opacity:1; filter:alpha(opacity=0);display:none;"" src=""/actions/set_notifica.asp?load="&record("ID")&"&amp;val=1week""></iframe>"
        record.movenext
    Loop

    SQL="SELECT * FROM QU_projects WHERE LO_aperto AND LO_confirmed AND DateDiff('d',DT_apertura,Now())=30"
    Set record=connection.execute(SQL)
    Do while Not record.eof
        Response.write"<iframe style=""width:100px;height:10px;border:0px;overflow:hidden; opacity:1; filter:alpha(opacity=0);display:none;"" src=""/actions/set_notifica.asp?load="&record("ID")&"&amp;val=1month""></iframe>"
        record.movenext
    Loop

    SQL="SELECT * FROM QU_projects WHERE LO_aperto AND LO_confirmed AND DateDiff('d',Now(),DT_termine)=30"
    Set record=connection.execute(SQL)
    Do while Not record.eof
        Response.write"<iframe style=""width:100px;height:10px;border:0px;overflow:hidden; opacity:1; filter:alpha(opacity=0);display:none;"" src=""/actions/set_notifica.asp?load="&record("ID")&"&amp;val=lastmonth""></iframe>"
        record.movenext
    Loop

End if%>

</div>


	<!--#INCLUDE VIRTUAL="./incs/load_footer.asp"-->

<div id="fb-root"></div>
<%
connection.close
Set connection=Nothing

hypenetalang=main_lang
If hypenetalang="ti" Then hypenetalang="it"
%>
<script src="/js/Chart.min.js"></script>
	<script type="text/javascript">
	var langHype='<%=hypenetalang%>'
	var fb_lang='<%=fb_lang%>'
	$(document).ready(function() {
	<%
	mode="none"
	if ishomepage then mode="all"

	if projectsFound=False AND ishomepage then addscript=addscript&"hideHome()"
	%>
	    iniSite('<%=mode%>','<%=smode%>');
	<%=addscript%>
        <%'addscriptP = convertfromutf8(addscriptp)%>
	    queuedScript="<%=addscriptP%>"
	});
	</script>
</body>
</html>