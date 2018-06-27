<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_header.asp"-->
<%
if LO_pubbl=False AND Session("online"&numproject)<>"ok1" then
response.redirect("under_construction.asp")
response.end
end If
if Session("online"&numproject)<>"ok1" then
response.redirect("under_construction.asp")
response.end
end if


modeview=request("modeview")

dayss=split(str_days,",")
mesi=split(str_months,",")

%>
<!--#INCLUDE VIRTUAL="/incs/load_language_vars.asp"-->
</head>
<body<%=addclassBody%>>
    
    <!-- Inizio modifica CM 20161116-->
 <div id="fb-root"></div>
  
<script>
 
   
    (function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.8";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    jQuery(document).ready(function($) {
        $(window).bind("load resize", function(){  
        setTimeout(function() {
            var container_width = $('#fbPage').width();    
            $('#fbPage').html('<div class="fb-page" ' + 
            'data-href="https://www.facebook.com/progettiamoch"' +
            ' data-width="' + container_width + '" data-tabs="timeline" data-small-header="true" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="false" data-height="240"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/progettiamoch/"><a href="https://www.facebook.com/progettiamoch/">Progettiamo.ch</a></blockquote></div></div>');
            $('.fb-page').removeClass('fb_iframe_widget fb_iframe_widget_fluid');        
            FB.XFBML.parse(); 
            $('#fbPage').css('display', 'inline');
           
        }, 300);
        $.cookieBar({message: '<%=str_cookie_policy %>',
acceptButton: true,
acceptText: '<%=str_chiudi_cookie %>',
acceptFunction: null,
declineButton: false,
declineText: 'Disable Cookies',
declineFunction: null,
policyButton: true,
policyText: '',
policyURL: '/?2221/privacy',
autoEnable: true,
acceptOnContinue: false,
acceptOnScroll: 200,
acceptAnyClick: false,
expireDays: 365,
renewOnVisit: false,
forceShow: false,
effect: 'slide',
element: 'body',
append: false,
fixed: true,
bottom: true,
zindex: '10000',
domain: 'www.progettiamo.ch',
referrer: 'www.progettiamo.ch'

});  
    }); 
});
</script>
    <!-- Fine modifica CM 20161116-->    
<div id="centered">
    
<header>
<div id="header">

<%If Session("log45"&numproject)<>"req895620schilzej" then%>
<div id="socialMenu">

<div onclick="document.location='/?2226/presenta-un-progetto'"><%=str_pr_presenta%></div>
<div onclick="document.location='/newsletter/'" style="width:auto; margin-left:1px;margin-right:1px;"><%=str_iscrivi_newsletter%></div>
<img src="/images/ico_f.png" alt="Facebook" class="socialIco" onclick="window.open('https://www.facebook.com/pages/Progettiamoch/1416183075301590')"/>
<img src="/images/ico_t.png" alt="Twitter" class="socialIco" onclick="window.open('https://twitter.com/Progettiamoch')"/>


<%If Session("islogged"&numproject)="hdzufzztKJ89ei" then%>
<div onclick="document.location='/actions/logout.asp'"><%=str_logout%></div>
<%else%>
<div onclick="getLogin()"><%=str_login%></div>
<%End if%>
</div>
<%End if%>

<div id="mainLogo">
<p style="margin:0px"><%=str_payoff%></p>
<img src="/images/vuoto.gif" alt="progettiamo.ch" onclick="document.location='/';"/>
</div>

<nav>

<!--#INCLUDE VIRTUAL="./incs/load_menu_main.asp"-->


</nav>
<!--#INCLUDE VIRTUAL="./incs/load_menu_language.asp"-->
<%=addlang%>
</div>

</header>

<%If Session("islogged"&numproject)="hdzufzztKJ89ei" AND Session("log45"&numproject)<>"req895620schilzej" Then%>
<!--#INCLUDE VIRTUAL="./project/load_logged_user_band.asp"-->
<%End if%>