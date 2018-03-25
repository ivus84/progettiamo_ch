<%
	If Len(Session("logged_donator"))>0 then
	    hidedonation=False
		TotDonato=0
		totdaydonation=0
		totmindonation=99
		SQL="SELECT SUM(IN_promessa) As TotDonato FROM associa_registeredusers_projects WHERE CO_registeredusers=" & Session("logged_donator") & " AND CO_p_projects=" & refProject
		Set rec1=connection.execute(SQL)

		If Not rec1.eof Then 'se ha già donato 
			TotDonato=rec1("TotDonato")
    		
			If len(totdonato)>0 Then Response.write "<p style=""margin:30px 0px; font-size:16px; line-height:21px;""><b>" & Session("logged_name") & "</b><br/>" & str_hai_promesso & "<br/>" & str_cifra_promessa &": <strong style=""font-size:18px"">" & setCifra(TotDonato) & " Fr.</strong></p>"
	        'controlli su donazioni
            'quante donazioni ha fatto nella giornata. se > 2 allora non permettere donazioni
            SQL="SELECT COUNT(ID) as totdaydonation FROM associa_registeredusers_projects WHERE CO_registeredusers=" & Session("logged_donator") & " AND CO_p_projects=" & refProject& " AND DateDiff('d',DT_data,Now())=0"
			Set rec1=connection.execute(SQL)
			if not rec1.eof then
			    totdaydonation=rec1("totdaydonation")
            end if
             'quando ha fatto la donazione. se < 5 min allora non permettere donazioni
            SQL="SELECT DateDiff('n',DT_data,Now()) as totmindonation FROM associa_registeredusers_projects WHERE CO_registeredusers=" & Session("logged_donator") & " AND CO_p_projects=" & refProject & " order by Dt_DAtA desc"
            Set rec1=connection.execute(SQL)
            if not rec1.eof then 
                totmindonation=rec1("totmindonation")
            end if
            if totmindonation<5 Then
                 hidedonation=true
			     Response.write "<p style=""margin:30px 0px; font-size:16px;"" class=""notrans"">" & str_min_promessa & "</p>"
            else
                If totdaydonation>1   Then
		            hidedonation=true
			        Response.write "<p style=""margin:30px 0px; font-size:16px;"" class=""notrans"">" & str_max_promessa & "</p>"
		        End If	
            end if
		
        End if
       
	End if
	userlogged=0
	if Session("islogged" & numproject)="hdzufzztKJ89ei" Then userlogged=1

	If Not hidedonation then	
		%>
		<p class="notrans"><strong><%=str_quanto_promettere%></strong></p>
		<form id="formDonate">
		<%
		firstvalue=0
		makeDonation=True
		min=minimo
		minW=min
		If minimo>0 Then firstvalue=minvalue
		
		firstview=" style=""display:none"""
		
		If Len(Session("project_wanted"))>0 Then
			If Session("project_wanted") & ""=refProject & "" then 
			    min=Session("chf_wanted")
			    firstvalue=min
			    firstview=""
			    addscriptP=addscriptP & "confirmDonation(" & userlogged & ");"
			End if
		End if

		min=setCifra(min)
		%>
		<p class="md notrans" style="width:405px;">
		- <%=str_inserire_cifra%> (<%=str_minimo%> <%=minW%> Fr.) <%=str_premere_tasto%> <img src="/images/check_1.png" style="width:23px; height:22px; float:right; margin-right:10px; margin-top:-4px;" alt=""/>
		<br/><br/><input type="text" onchange="setDonation($(this),1,<%=userlogged%>)" class="fDonate min" value="<%=min%>" rel="<%=minimo%>"/><img src="/images/vuoto.gif" class="fDImg" onclick="setDonation($('.fDonate'),1,<%=userlogged%>)" />
		</p>
		<%
		smode="setDonate()"
		%>
		
			<%If (Len(Session("logged_donator"))>0 AND puser=Session("logged_donator")) Or Session("log45"&numproject)="req895620schilzej" Then%>
				<p style="margin-top:30px" class="notrans"><%=str_altri_utenti_promettono%></p>
				<%else%>
				<div class="donationMaker" <%=firstview%>>
				<p class="mmake premake notrans"><%=srt_promessa_sara_registrata%></p>
				<p class="mmake notrans"><input type="button" class="sDonate" value="Prometti Fr. <%=firstvalue%>" rel="Prometti" onclick="confirmDonation(<%=userlogged%>)"/></p>
				</div>
			<%End if%>

	<p style="clear:left; margin:0px; font-size:13px;" class="notrans">&gt; <a href="<%=str_location_guida_finanziatori%>" target="_blank" style="color:#9ba1b3; font-size:13px;"><%=str_scarica_guida_finanziatori%></a><% if getlangtxts="it" then %> (pdf, 145 KB)<% end if %></p>
		<input id="donation_value" style="display: none;" value="<%=firstvalue%>"/>
		<input id="refProject" value="<%=refProject%>" style="display: none;" />
		<input id="refProjectName" value="<%=pTitle%>" style="display: none;" />
		<input id="minval" value="<%=minimo%>" style="display: none;" />
		
	</form>
	<%End if%>

	