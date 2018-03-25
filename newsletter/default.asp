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
			<!-- Begin MailChimp Signup Form -->
			<div id="mc_embed_signup">
				<form action="//progettiamo.us11.list-manage.com/subscribe/post?u=600a439a7accfcad76d5cdd07&amp;id=5c474d3692" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
					<div id="mc_embed_signup_scroll">
						<p class="fc" style="font-size:18px">
							*&nbsp;<input type="text" name="FNAME" value="" placeholder="nome" data-content="nome" class="required str" id="mce-FNAME"/>
							<span style="float:right; font-size:12px; margin:8px 20px 0px 10px;"><%=str_campi_obbligatori%></span><span style="float:right; margin-top:12px;">*</span><br/>
							*&nbsp;<input type="text" name="LNAME" value="" placeholder="cognome" data-content="cognome" class="required str" id="mce-LNAME"/><br/>
							*&nbsp;<input type="email" name="EMAIL" value="" placeholder="email" data-content="email" class="required email str" id="mce-EMAIL"/><br/>
						</p>
						<div class="fc" style="padding-left:11px;clear:both;margin-bottom:20px;">
							<div id="mce-responses" class="clear">
								<div class="response" id="mce-error-response" style="display:none"></div>
								<div class="response" id="mce-success-response" style="display:none"></div>
							</div>
						</div>
						<p>&nbsp;</p>
						<div style="padding:10px 0px 0px 11px">
							<div style="position: absolute; left: -5000px;"><input type="text" name="b_600a439a7accfcad76d5cdd07_5c474d3692" tabindex="-1" value=""><!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups--></div>
							<div class="clear"><input type="submit" value="<%=str_invia_richiesta%>" name="subscribe" id="mc-embedded-subscribe" style="cursor:pointer; height: 42px; width:315px;float:left:clear:both;" class="button sb"></div>
						</div>
					</div>
				</form>
				<p class="fc" style="padding:5px 11px;font-size:12px; line-height:14px; width:316px;text-align:justify; color: #babdc8"><%=str_accept_condition_1%></p>
				<p style="padding:15px 40px; width:300px;text-align:center; color: #fff;"><a href="/" style="color:#fff; font-weight:bold; font-size:18px"><%=str_back_home%></a></p>
				<p style="margin: 30px 0px; text-align: left; font-size:12px;padding-left:55px;">© 2014 Progettiamo.ch&nbsp;&nbsp;|&nbsp;&nbsp;All rights reserved</p>
			</div>
			<script type='text/javascript' src='//s3.amazonaws.com/downloads.mailchimp.com/js/mc-validate.js'></script><script type='text/javascript'>(function($) {window.fnames = new Array(); window.ftypes = new Array();fnames[0]='EMAIL';ftypes[0]='email';fnames[1]='FNAME';ftypes[1]='text';fnames[2]='LNAME';ftypes[2]='text'; /*
			 * Translated default messages for the $ validation plugin.
			 * Locale: IT
			 */
			$.extend($.validator.messages, {
				   required: "Campo obbligatorio.",
				   remote: "Controlla questo campo.",
				   email: "Inserisci un indirizzo email valido.",
				   url: "Inserisci un indirizzo web valido.",
				   date: "Inserisci una data valida.",
				   dateISO: "Inserisci una data valida (ISO).",
				   number: "Inserisci un numero valido.",
				   digits: "Inserisci solo numeri.",
				   creditcard: "Inserisci un numero di carta di credito valido.",
				   equalTo: "Il valore non corrisponde.",
				   accept: "Inserisci un valore con un&apos;estensione valida.",
				   maxlength: $.validator.format("Non inserire pi&ugrave; di {0} caratteri."),
				   minlength: $.validator.format("Inserisci almeno {0} caratteri."),
				   rangelength: $.validator.format("Inserisci un valore compreso tra {0} e {1} caratteri."),
				   range: $.validator.format("Inserisci un valore compreso tra {0} e {1}."),
				   max: $.validator.format("Inserisci un valore minore o uguale a {0}."),
				   min: $.validator.format("Inserisci un valore maggiore o uguale a {0}.")
			});}(jQuery));var $mcj = jQuery.noConflict(true);</script>
		</div>
	</div>
</body>

</html>