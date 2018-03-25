<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
connection.close
%>
<!--#INCLUDE VIRTUAL="./incs/load_header_login.asp"-->

<body class="fancy nletter" style="width:100%; min-width:560px;">
<div style="position:relative; margin:0 auto; width:100%; max-width:560px;">
<div style="position:relative; width:100%; float:right; margin-right:-105px;">
<p style="clear:both; text-align:left;"><img src="/images/logo_small.png" alt="" style="margin:25px 108px;"/></p>
<p class="title" style="text-align:left; font-size:18px;margin:5px 70px; font-weight:normal"><%=str_newsletter_main%></p>
<p class="errMsg" style="display:none; padding-left:11px"></p>
   
   <form id="formContact" method="post" style="margin:0px">
	<p class="fc" style="font-size:18px">
	*&nbsp;<input type="text" name="nome" value="nome" class="str"/>
		<span style="float:right; font-size:12px; margin:8px 20px 0px 10px;"><%=str_campi_obbligatori%></span><span style="float:right; margin-top:12px;">*</span><br/>
	*&nbsp;<input type="text" name="cognome" value="cognome" class="str"/><br/>
	*&nbsp;<input type="email" name="email" value="email"/><br/>
	</p>
	<p class="fc" style="padding-left:11px;clear:both;margin-bottom:20px;">
	<img src="/img_captcha.asp" class="cptch" width="120" height="42" style="120px; height:42px; background-color:#fff; float:left; margin:0px"/>
	<img src="/images/refresh.png" style="float:left; height:42px; cursor:pointer;" onclick="refreshC()"/>
	<input type="text" name="cptch" value="" class="str cp" style="float:left; width:88px; text-align:center"/>
	<img src="/images/check.png" class="chch" style="float:left; height:42px;"/>
	<span style="float:right; font-size:12px; line-height:14px;margin:8px 20px 10px 10px; padding:0px 0px 0px 0px; width:125px;text-align:left; clear:right"><%=str_copiare_codice%></span><br/>
	</p>
	<p>&nbsp;</p>
    <p style="padding:10px 0px 0px 11px">
	<input type="submit" style="display:none"/>
	<span class="fc" style="float:right; font-size:12px; line-height:14px; margin-right:0px; padding-left:10px; width:225px;text-align:left;display:none"><%=str_accept_condition%></span>
	<input type="text" class="sb" value="<%=str_invia_richiesta%>" style="cursor:pointer; width:286px;float:left:clear:both;" onfocus="this.blur()" onclick="$('#formContact').submit()"/>
	</p>
	</form>
    
	<p class="fc" style="padding:5px 11px;font-size:12px; line-height:14px; width:316px;text-align:justify; color: #babdc8">
	<%=str_accept_condition_1%>
	</p>

	<p style="padding:15px 40px; width:300px;text-align:center; color: #fff;"><a href="/" style="color:#fff; font-weight:bold; font-size:18px"><%=str_back_home%></a></p>
	<p style="margin: 30px 0px; text-align: left; font-size:12px;padding-left:55px;">© 2014 Progettiamo.ch&nbsp;&nbsp;|&nbsp;&nbsp;All rights reserved</p>

 </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function() {
	makeContact()
	})
 </script>
 </body>
</html>
