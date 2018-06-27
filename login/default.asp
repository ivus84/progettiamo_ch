<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./incs/common_functions.asp"-->
<%
If Session("islogged"&numproject)="hdzufzztKJ89ei" Then
    Response.redirect("/")
    Response.End
End If

SQL = stringformat("SELECT count(ID) as registered_users from registeredusers WHERE LO_enabled=True AND LO_deleted=False",array())
Set rec=connection.execute(SQL)
num_users = rec("registered_users")


    
connection.close
referrer_page=request("referrer_page")
If Len(referrer_page)=0 Then referrer_page="/"

If Len(referrer_page)>0 Then referrer_pageorig=Replace(referrer_page,"/donate/","/")

%>
<!--#INCLUDE VIRTUAL="./incs/load_header_login.asp"-->
<%str_register = replace(str_register, "#num_pers_reg#", num_users) %>
<body class="fancy nletter" style="width: 98%; min-width: 560px;">
    <div style="position: relative; margin: 0 auto; width: 100%;">
        <p style="clear: both; text-align: center; width: 100%">
            <img src="/images/logo_small.png" alt="" style="margin: 25px 108px;" /></p>
        <form id="formLogin" method="post" style="margin: 0px" accept-charset="ISO-8859-1">
            <div class="row">
                <div class="column" style="">
                    <div style="float:right;padding-bottom:5px; padding-right:40px">
                        <div style="height:200px;">
                            <p class="title" style="text-align: left; font-size: 18px; margin: 5px 0px 6px 11px; font-weight: normal"><%=str_already_registered%></p>
                            <p class="errMsg" style="display: none; padding-left: 11px"></p>

                            <p class="fc" style="padding-left: 11px; font-size: 18px; width:100%;">

                                <span style="position: relative;">
                                    <label for="eml"><%=str_email%></label><input id="eml" type="email" name="email" value="" /></span><br />
                                <span style="position: relative;">
                                    <label class="pwd" for="pss"><%=str_password%></label><input id="pss" type="password" name="password" value="" class="pwd" /></span>
                                <br />
                            </p>
                            <p class="fc" style="padding-left: 11px; clear: both; margin: -10px 0px 0px 0px; display: none">
                                <img src="/images/vuoto.gif" class="cptch" width="120" height="42" style="120px; height: 42px; background-color: #fff; float: left; margin: 0px" />
                                <img src="/images/refresh.png" style="float: left; height: 42px; cursor: pointer;" onclick="refreshC()" />
                                <input type="text" name="cptch" value="" class="str cp" style="float: left; width: 88px; text-align: center" />
                                <img src="/images/check.png" class="chch" style="float: left; height: 42px;" />
                                <span style="float: left; font-size: 12px; line-height: 14px; margin: 8px 20px 0px 10px; padding: 0px 0px 0px 0px; width: 125px; text-align: left; clear: right"><%=str_copiare_codice%></span>
                            </p>
                        </div>
                        <p style="padding-left: 11px">
                            <input type="text" class="login" value="<%=str_entra%>" style="cursor: pointer; width: 286px;  clear: both; " onfocus="this.blur()" onclick="$('#formLogin').submit()" />
                            <input type="submit" style="width: 1px; height: 1px; overflow: hidden; display:none;opacity: 0; filter: alpha(opacity=0)" />
                        </p>

                        <input type="hidden" name="goto" value="" /><br />
                        <a href="javascript:void(0)" onclick="makeForget(); $('img.cptch').attr('src','/img_captcha.asp'); $(this).remove()" style="color: #9ba1b3; padding-left:11px;"><%=str_password_dimenticata%></a>
                    </div>
                    <div style="clear: both"></div>
                   
                </div>
                <div class="column reg" style="width:47%;border-left: 1px solid white; ">
                    <div style="width: 316px;padding-left:30px; ">
                        <p class="title " style="text-align: left; width:100%; font-size: 18px; margin: 5px 0px 6px 10px; font-weight: normal; height:200px"><%=str_register%></p>

                        <p class="crt" style="padding: 0px 11px">
                            <input type="text" class="login" value="<%=str_register_1%>" style="cursor: pointer; width: 286px; float: left; clear: both; " onfocus="this.blur()" onclick="document.location='/signin/'" />
                      
                        </p>
                    </div>
                </div>
            </div>

        </form>
       
        <p class="or" style="text-align: center; width:100% "><%=str_or%></p>
        <p class="fbl" style="padding: 20px 11px; width: 300px; text-align: justify; margin: 0 auto">
            <input type="text" class="sb fbl" value="<%=str_facebook_login%>" onfocus="this.blur()" onclick="fb_signup('<%=referrer_page %>')" />

        </p>
        <p class="bck" style="padding:15px 20px; width:100%;text-align:center; color: #fff;"><a href="<%=referrer_pageorig%>" style="color:#fff; font-weight:bold; font-size:18px"><%=str_prev_page%></a></p>
        <p style=" text-align: center; font-size: 12px; width:100%; clear: both">&copy; <%=year(now) %> Progettiamo.ch&nbsp;&nbsp;|&nbsp;&nbsp;All rights reserved</p>
        
        <div class="recover" style="display: none"><%=str_pass_recover%></div>
        <a class="refer" href="<%=referrer_page%>" style="display: none"></a>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            $.getScript( "/js/src.nletter.js", function() {
                makeLogin()
            })
        })
    </script>
    <div id="fb-root"></div>
    <script>
        appID = '798763516805232';
        appID = '119299055442524';
        
        appID = '308051059706107';//test
      window.fbAsyncInit = function() {
      FB.init({
        appId      : appID,
        status     : true,
        cookie     : true,
        xfbml      : true
      });
      };


      (function(d){
       var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
       if (d.getElementById(id)) {return;}
       js = d.createElement('script'); js.id = id; js.async = true;
       js.src = "//connect.facebook.net/it_IT/all.js";
       ref.parentNode.insertBefore(js, ref);
      }(document));


    var data1;
    var setMail;

    </script>
    <div id="dialog" title="Titolo">
      <p><%=str_privacy_policy_login %></p>
    </div>
</body>
</html>
