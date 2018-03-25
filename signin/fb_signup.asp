<% session("return_url") = request("return_url") %>
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./incs/common_functions.asp"-->
<script language="JScript" runat="server" src="/app/fb/json2.asp"></script>
<!-- #INCLUDE VIRTUAL="/app/fb/fb_graph_api_app.asp" -->
<!-- #INCLUDE VIRTUAL="/app/fb/fb_app.asp" -->

<%
    

    dim app_id
	dim app_secret
	dim my_url
	dim dialog_url
	dim token_url
	dim resp
	dim token
	dim expires
	dim graph_url
	dim json_str
	dim user
	dim code
	dim strLocation 
	dim strEducation
	dim strEmail
    dim birthday
    dim strID
    dim setcountry

    set fbu = new fb_utility
    token = cookie("token")

	if token = "" then 
		response.write ""	
		response.end
	end if

	'graph_url = "https://graph.facebook.com/me?fields=id,email,name,first_name,last_name,birthday,picture,location{location{city,country_code}}&access_token=" & token
    graph_url = "https://graph.facebook.com/me?fields=id,email,name,first_name,last_name,picture&access_token=" & token
	json_str = fbu.get_page_contents( graph_url )
    
	set user = JSON.parse( json_str )

    SQL = "SELECT * from registeredusers WHERE LO_enabled=True and TA_fbid= '"&user.id&"'"
    Set rec=connection.execute(SQL)
    If Not rec.eof Then
        gname=rec("TA_nome")
        sname=""
        If Len(gname)>0 Then sname=Mid(gname,1,1)
        Session("logged_donator")=rec("ID")
        Session("islogged"&numproject)="hdzufzztKJ89ei"
        Session("logged_name")=gname&" "&rec("TA_cognome")
        Session("logged_name_short")=sname&"."&rec("TA_cognome")
        Session("p_favorites")=rec("TX_favorites")
        Session("projects_promoter")=rec("LO_projects")
        Session("promoter_last_login")=rec("DT_last_login")
        SQL="UPDATE registeredusers SET DT_last_login=Now() WHERE ID="&rec("ID")
        Set rec=connection.execute(SQL)
        connection.close
        Response.Redirect session("return_url")
    end if 
    
	'' Handling properties that might not be there
	on error resume next
    pic = user.picture.data.url
    setmail=user.email'request("setmail")
    setmail= replace( setmail, "\u0040", "@")
    setname=user.last_name'request("setname")
    setfirstname=user.first_name'request("setfirstname")
    'birthday = user.birthday
    'birthdayarray = split(birthday,"/")
    'birthday = birthdayarray(1)&"."&birthdayarray(0)&"."&birthdayarray(2)
    
    'setcity=user.location.location.city
    'setcountry = user.location.location.country_code
    
    pos = instr(pic, "?")
    if pos < 1 then
        'non so cosa 
    else
        pic = left (pic, instr(pic, "?")-1)
    end if  
    on error goto 0
    connection.close
%>
<!--#INCLUDE VIRTUAL="./incs/load_header_login.asp"-->
<body class="fancy nletter" style="width:100%; min-width:560px; overflow-x:hidden">
<div style="position:relative; margin:0 auto; width:100%; max-width:560px;">
<div style="position:relative; width:100%; float:right; margin-right:-100px;">
<p style="clear:both; text-align:left;"><img src="/images/logo_small.png" alt="" style="margin:25px 108px;"/></p>
<p class="title" style="text-align:center; font-size:18px;margin:5px 11px; width:314px;font-weight:normal"><%=str_signup_main%></p>
<p class="errMsg" style="display:none; padding-left:11px"></p>
   <form id="formFBSignup" method="post" style="margin:0px">
	    <p class="fc" style="font-size:18px">
	    <input type="text" name="TA_ente" value="<%=LCase(str_f_Ente)%>" alt="<%=LCase(str_f_Ente)%>" class="str cp" style="margin-left:12px" onfocus="$(this).val('')" onblur="if($(this).val().length==0) $(this).val($(this).attr('alt'))"/>
	    <span style="float:right; font-size:12px; margin:8px 20px 0px 10px;"><%=str_campi_obbligatori%></span><span style="float:right; margin-top:12px;">*</span><br/>
	    *&nbsp;<input type="text" name="TA_nome" value="<%=LCase(str_f_Nome)%>" alt="<%=LCase(str_f_Nome)%>" class="str"/><br/>
	    *&nbsp;<input type="text" name="TA_cognome" value="<%=LCase(str_f_cognome)%>" alt="<%=LCase(str_f_cognome)%>" class="str"/><br/>
	    *&nbsp;<input type="email" name="TA_email" value="email" alt="email" class="str"/><br/>
	    *&nbsp;<input type="text" name="DT_data_nascita" value="<%=LCase(str_f_Data_nascita)%>" alt="<%=LCase(str_f_Data_nascita)%>" class="str dtsr" maxlength="10" value="<%=birthday %>"/><br/>
	    *&nbsp;<input type="text" name="TA_indirizzo" value="<%=LCase(str_f_Indirizzo)%>" alt="<%=LCase(str_f_Indirizzo)%>" class="str"/><br/>
	    *&nbsp;<input type="text" name="TA_cap" value="<%=LCase(str_f_cap)%>" alt="<%=LCase(str_f_cap)%>" class="str"/><br/>
	    *&nbsp;<input type="text" name="TA_citta" value="<%=LCase(str_f_citta)%>" alt="<%=LCase(str_f_citta)%>" class="str"/><br/>
	    <span style="position:relative">
        *&nbsp;<input type="text" name="nazione" class="str" value="<%=LCase(str_f_Nazione)%>" onfocus="$(this).blur(); getNation('#getNations')" /><select id="getNations" style="display:none; position:absolute;" onchange="setNation($(this),'CO_nazioni','nazione'); checkPrefix($('input[name=TA_telefono]'),$(this).val())">
            <!--#INCLUDE VIRTUAL="./actions/get_nations.asp"-->
                                                                                                                                                    </select><input type="hidden" name="CO_nazioni" class="str"/></span><br/>
	    *&nbsp;<input type="tel" name="TA_telefono" value="<%=LCase(str_f_telefono)%>" class="str" alt="<%=LCase(str_f_telefono)%>" onchange="checkPrefix($(this),$('input[name=CO_nazioni]').val())"/><br/>

	    </p>
        <input type="hidden" name ="TA_fbid" value="<%=user.id %>" />
        <input type="hidden" name ="AT_immagine" value="<%=stringformat("https://graph.facebook.com/{0}/picture?height=350&width=350",array(user.id)) %>" />
        <input type="hidden" name ="pic" value="<%=pic %>" />
       <!--
	    <p style="padding-left:11px; width:320px">
	    <%=str_min_password%>
	    </p>

	
        <p class="fc" style="font-size:18px">
	        *&nbsp;<input type="text" name="passw" value="password" class="pwd1" onfocus="$(this).css('display','none'); $('.pwd').css('display','inline'); $('.pwd').focus()"/><input type="password" name="TA_password" value="password" class="str pw pwd" style="display:none" onblur="if ($(this).val().length==0) { $(this).css('display','none'); $('.pwd1').css('display','inline'); }"/><br/>
	        *&nbsp;<input type="text" name="passw" value="<%=str_f_conferma%>" class="pwd2" onfocus="$(this).css('display','none'); $('.pwd0').css('display','inline'); $('.pwd0').focus()"/><input type="password" name="TA_password_1" value="<%=str_f_conferma%>" class="str pw pwd0" style="display:none" onblur="if ($(this).val().length==0) { $(this).css('display','none'); $('.pwd2').css('display','inline'); }"/><br/>
	    </p>

	    <p class="fc" style="padding-left:11px;clear:both;padding-bottom:30px;">
	        <img src="/img_captcha.asp" class="cptch" width="120" height="42" style="120px; height:42px; background-color:#fff; float:left; margin:0px"/>
	        <img src="/images/refresh.png" style="float:left; height:42px; cursor:pointer;" onclick="refreshC()"/>
	        <input type="text" name="cptch" value="" class="str cp" style="float:left; width:88px; text-align:center"/>
	        <img src="/images/check.png" class="chch" style="float:left; height:42px;"/>
	        <span style="float:right; font-size:12px; line-height:14px;margin:8px 20px 0px 10px; padding:0px 0px 0px 0px; width:125px;text-align:left; clear:right"><%=str_copiare_codice%></span>
	    </p>
        -->
	    <p style="padding-left:11px;"><br/>
	    <input type="text" class="sb" value="<%=str_crea_account_1%>" style="cursor:pointer; width:286px;float:left;clear:both;background: #9ba1b3 url(/images/bg_button.png) right top no-repeat;" onfocus="this.blur()" onclick="$('#formFBSignup').submit()"/>
	    <input type="submit" style="width:1px; height:1px; overflow:hidden; opacity:0; filter:alpha(opacity=0)"/>
	    </p>
	    <p style="padding:5px 11px;font-size:12px; line-height:14px; width:316px;text-align:justify; color: #babdc8">
	    <%=str_disclaim%>
	    </p>



    </form>

<p style="padding:15px 40px; width:300px;text-align:center; color: #fff;"><a href="/" style="color:#fff; font-weight:bold; font-size:18px"><%=str_back_home%></a></p>
<p style="margin: 30px 0px; text-align: left; font-size:12px;padding-left:55px;">&copy; <% year(now) %> Progettiamo.ch&nbsp;&nbsp;|&nbsp;&nbsp;All rights reserved</p>

 </div>
 </div>
        <script type="text/javascript">
            $(document).ready(function() {
                $.getScript( "/js/src.nletter.js", function() {
                    makeFBSignup()
                })

                <%if len(setmail)>0 then%>
                $('input[name="TA_email"]').val('<%=setmail%>')
                <%end if%>
                <%if len(setname)>0 then%>
                $('input[name="TA_cognome"]').val('<%=setname%>')
                <%end if%>
                <%if len(setfirstname)>0 then%>
                $('input[name="TA_nome"]').val('<%=setfirstname%>')
                <%end if%>
                <%if len(setcity)>0 then%>
                $('input[name="TA_citta"]').val('<%=setcity%>')
                <%end if%>
                <%if len(birthday)>0 then%>
                $('input[name="DT_data_nascita"]').val('<%=birthday%>')
                <%end if%>

                <%if len(setcountry)>0 then%>
                    
                $('#getNations option[country_code="<%=setcountry%>"]').attr("selected","selected");
                $('#getNations').change();
                <%end if%>
            })
        </script>
    </body>
</html>
