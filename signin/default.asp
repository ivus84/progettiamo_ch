<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
connection.close

setmail=request("setmail")
setname=request("setname")
setfirstname=request("setfirstname")
setcity=request("setcity")
%>
<!--#INCLUDE VIRTUAL="./incs/load_header_login.asp"-->
<body class="fancy nletter" style="width:100%; min-width:560px; overflow-x:hidden">
<div style="position:relative; margin:0 auto; width:100%; max-width:560px;">
<div style="position:relative; width:100%; float:right; margin-right:-100px;">
<p style="clear:both; text-align:left;"><img src="/images/logo_small.png" alt="" style="margin:25px 108px;"/></p>
<p class="title" style="text-align:center; font-size:18px;margin:5px 11px; width:314px;font-weight:normal"><%=str_signup_main%></p>
<p class="errMsg" style="display:none; "></p>
   <form id="formSignup" method="post" style="margin:0px">
	<p class="fc" style="font-size:18px">
	<input type="text" name="TA_ente" value="<%=LCase(str_f_Ente)%>" alt="<%=LCase(str_f_Ente)%>" class="str cp" style="margin-left:12px" onfocus="$(this).val('')" onblur="if($(this).val().length==0) $(this).val($(this).attr('alt'))"/>
	<span style="float:right; font-size:12px; margin:8px 20px 0px 10px;"><%=str_campi_obbligatori%></span><span style="float:right; margin-top:12px;">*</span><br/>
	*&nbsp;<input type="text" name="TA_nome" value="<%=LCase(str_f_Nome)%>" alt="<%=LCase(str_f_Nome)%>" class="str"/><br/>
	*&nbsp;<input type="text" name="TA_cognome" value="<%=LCase(str_f_cognome)%>" alt="<%=LCase(str_f_cognome)%>" class="str"/><br/>
	*&nbsp;<input type="email" name="TA_email" value="email" alt="email" class="str"/><br/>
	*&nbsp;<input type="text" name="DT_data_nascita" value="<%=LCase(str_f_Data_nascita)%>" alt="<%=LCase(str_f_Data_nascita)%>" class="str dtsr" maxlength="10"/><br/>
	*&nbsp;<input type="text" name="TA_indirizzo" value="<%=LCase(str_f_Indirizzo)%>" alt="<%=LCase(str_f_Indirizzo)%>" class="str"/><br/>
	*&nbsp;<input type="text" name="TA_cap" value="<%=LCase(str_f_cap)%>" alt="<%=LCase(str_f_cap)%>" class="str"/><br/>
	*&nbsp;<input type="text" name="TA_citta" value="<%=LCase(str_f_citta)%>" alt="<%=LCase(str_f_citta)%>" class="str"/><br/>
	<span style="position:relative">
    *&nbsp;<input type="text" name="nazione" class="str" value="<%=LCase(str_f_Nazione)%>" onfocus="$(this).blur(); getNation('#getNations')"/><select id="getNations" style="display:none; position:absolute;" onchange="setNation($(this),'CO_nazioni','nazione'); checkPrefix($('input[name=TA_telefono]'),$(this).val())"></select><input type="hidden" name="CO_nazioni" class="str"/></span><br/>
	*&nbsp;<input type="tel" name="TA_telefono" value="<%=LCase(str_f_telefono)%>" class="str" alt="<%=LCase(str_f_telefono)%>" onchange="checkPrefix($(this),$('input[name=CO_nazioni]').val())"/><br/>

	</p>
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
	<p style="padding-left:11px;"><br/>
	<input type="text" class="sb" value="<%=str_crea_account_1%>" style="cursor:pointer; width:286px;float:left;clear:both;background: #9ba1b3 url(/images/bg_button.png) right top no-repeat;" onfocus="this.blur()" onclick="$('#formSignup').submit()"/>
	<input type="submit" style="width:1px; height:1px; overflow:hidden; opacity:0; filter:alpha(opacity=0)"/>
	</p>
	<p style="padding:5px 11px;font-size:12px; line-height:14px; width:316px;text-align:justify; color: #babdc8">
	<%=str_disclaim%>
	</p>



</form>

<p style="padding:15px 40px; width:300px;text-align:center; color: #fff;"><a href="/" style="color:#fff; font-weight:bold; font-size:18px"><%=str_back_home%></a></p>
<p style="margin: 30px 0px; text-align: left; font-size:12px;padding-left:55px;">&copy; 2014 Progettiamo.ch&nbsp;&nbsp;|&nbsp;&nbsp;All rights reserved</p>

 </div>
 </div>
 <script type="text/javascript">
$(document).ready(function() {
$.getScript( "/js/src.nletter.js", function() {
makeSignup()
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
})
 </script>
 </body>
</html>
<%
 Response.CharSet = "ISO-8859-1"
Response.CodePage = 28591
%>