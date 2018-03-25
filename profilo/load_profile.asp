<!--#include virtual="./incs/rc4.inc"-->
<div class="pContainer">
	<div class="pText" style="min-height:1000px">
	<h1 class="titolo" style="background: #292f3a; padding:10px 0px"><span style="padding:10px"><%=str_my_profile%></span></h1>
	<%

If Session("islogged"&numproject)="hdzufzztKJ89ei" Then

SQL="SELECT * FROM QU_donators WHERE QU_donators.ID="&Session("logged_donator")
Set rec=connection.execute(SQL)
If Not rec.eof then
imgp=rec("AT_immagine")
luogo=rec("TA_citta")
email=rec("TA_email")

email = EnDeCrypt(email, npass, 2)


emailr=rec("TA_email_recupero")
emailr = EnDeCrypt(emailr, npass, 2)

If Len(emailr)=0 Or isnull(emailr) Then emailr="non impostata"
ente=rec("TA_ente")
nazio=rec("CO_nazioni")
nazione=rec("nazione")
luogo=rec("TA_citta")
indirizzo=rec("TA_indirizzo")

facebook=rec("TA_facebook")
twitter=rec("TA_twitter")
linkedin=rec("TA_linkedin")
cap=rec("TA_cap")
tel=rec("TA_telefono")
tel=  EnDeCrypt(tel, npass, 2)
natel=rec("TA_natel")
natel=  EnDeCrypt(natel, npass, 2)

fax=rec("TA_fax")
professione=rec("TA_societa")
nome=rec("TA_nome")
cognome=rec("TA_cognome")
data_nascita=rec("DT_data_nascita")
If Len(data_nascita)=0 Or isnull(data_nascita) Or datediff("yyyy",data_nascita,Now())<18 Then data_nascita="gg.mm.aaaa"
LO_notifica_50=rec("LO_notifica_50")
LO_notifica_75=rec("LO_notifica_75")
LO_notifica_90=rec("LO_notifica_90")
LO_notifica_100=rec("LO_notifica_100")
LO_notifica_deleted=rec("LO_notifica_deleted")
LO_notifica_finished=rec("LO_notifica_finished")
LO_notifica_updates=rec("LO_notifica_updates")
LO_notifica_favorites=rec("LO_notifica_favorites")
LO_no_notifica=rec("LO_no_notifica")
LO_projects=rec("LO_projects")
CO_lingue=rec("CO_lingue")
TA_lang=rec("TA_lang")
TA_lang_notif = rec("TA_lang_notif")
SQL="SELECT SUM(IN_promessa) as promised FROM QU_donators WHERE QU_donators.ID="&Session("logged_donator")
Set rec=connection.execute(SQL)
promised=rec("promised")

SQL="SELECT COUNT(CO_p_projects) as prog_promised FROM (SELECT DISTINCT CO_p_projects FROM QU_donators WHERE QU_donators.ID="&Session("logged_donator")&")"
Set rec=connection.execute(SQL)
prog_promised=rec("prog_promised")


promised=setCifra(promised)
If Len(imgp)=0 Or isnull(imgp) Then imgp="ico_profile.png"
End if
	%>

<div class="profileImage" style="background-image:url(/<%=imgscript%>?path=<%=imgp%>$324); background-size:auto 100%"></div>


<div class="profileContent">
<p style="font-size:24px;"><b><%=nome%>&nbsp;<%=cognome%></b></p>
<div class="profileData">
<p>
<%If Len(ente)>0 then%><b><%=ente%></b><br/><%End if%>
<%=indirizzo%><br/>
<%=cap%>&nbsp;<%=luogo%><br/>
<%=nazione%>
</p>

<p><span style="float:left; width:60px;"><%=str_f_Tel%>:</span> <span style="float:left; margin-left:30px;"><%=tel%></span></p>
<p><span style="float:left; width:60px;">&nbsp;</span></p>
<p><br/><%=str_professione%>: <%=professione%></p>
<p>
<span style="float:right;margin-right:14px;"><a href="javascript:deleteAccount()" style="color:#9ba1b3;">[<%=str_cancella_account%>]</a></span>
<span style="float:left;margin-right:44px;"><a href="javascript:editProfile()" style="color:#9ba1b3;">[<%=str_modifica_dati%>]</a></span></p>
</div>
</div>

<div class="profileContent profileData">
<p style="font-size:16px; margin-top:82px; margin-bottom:10px;"><b><%=str_email_main%></b></p>
<p style="color:#9ba1b3;margin-top:0px;"><span style="float:left; width:160px; height:30px; overflow:hidden;cursor:pointer" title="<%=email%>" alt="<%=email%>"><%=email%></span> <a href="javascript:editEmail()" style="color:#9ba1b3;"><span style="float:left; margin-left:30px;">[<%=str_modifica%>]</span></a>
</p>
<p style="font-size:16px; margin-top:55px; margin-bottom:10px;"><b><%=str_email_recupero%></b></p>
<p style="color:#9ba1b3;margin-top:0px;"><span style="float:left; width:160px; height:30px; overflow:hidden;cursor:pointer" title="<%=emailr%>" alt="<%=emailr%>"><%=emailr%></span> <a href="javascript:editEmailR()" style="color:#9ba1b3;"><span style="float:left; margin-left:30px;">[<%=str_modifica%>]</span></a>
</p>

<p style="font-size:16px; margin-top:90px; margin-bottom:10px;text-transform:capitalize"><b><%=str_password%></b></p>
<p style="color:#9ba1b3;margin-top:0px;"><span style="float:left;"><input type="password" onfocus="this.blur()" value="xxxxxxx" style="border:0px; background:transparent; width:160px;"/></span>  <a href="javascript:editPassword()" style="color:#9ba1b3;"><span style="float:left; margin-left:30px;">[<%=str_modifica%>]</span></a>
</p>
</div>

<div style="clear:both"></div>
<div class="profileContent" id="areaNotifica" style="margin-left:17%;padding-left:10px;width:60%">
<p style="font-size:16px; margin-top:42px; margin-bottom:20px;"><b><%=str_notifiche_main%></b></p>
<p class="notifyOptions" style="clear:left;padding-top:20px;"><%=str_notif_lingua%>:<br /><br />
<label class="input" style="width:61%; margin:0px 15% 4px 0px;"><span><%=str_lingua%></span><select class="tx" name="CO_lingue_notif" onchange="setNotifLang('TA_lang_notif',$(this))"><%
SQL="SELECT * FROM lingue WHERE LO_pubblica=True"
Set rec=connection.execute(SQL)
do While Not rec.eof
nl=rec("TA_nome")
vl=rec("IN_valore")
tl=rec("TA_abbreviato")
adsl=""
If tl=TA_lang_notif Then adsl=" selected=""selected"""
Response.write "<option value="""&vl&""" rel="""&tl&""""&adsl&">"&ConvertFromUTF8(nl)&"</option>"
rec.movenext
loop%>
</select><input type="hidden" class="TA_lang_notif" name="TA_lang_notif" value="<%=TA_lang_notif%>"/></label>
<br/><br/><br/>
</p>
<p>
<span class="notifica" style="width:47%; font-size:14px"><%=str_notifiche_nessuna%> <input class="cb" id="LONO" type="checkbox" <%If LO_no_notifica then%>checked="checked" <%End if%> onclick="setNotifica('LO_no_notifica',$(this))"/><label for="LONO"><span></span></label></span>
</p>
<p class="notifyOptions" style="clear:left;padding-top:20px;">
<%=str_notifiche_aggiornamenti%>
<br/><br/>

<span class="notifica" style="width:47%; font-size:14px"><%=str_notifiche_realizzazione%><input class="cb" id="LORE" type="checkbox" <%If LO_notifica_finished then%>checked="checked" <%End if%> onclick="setNotifica('LO_notifica_finished',$(this))"/><label for="LORE"><span></span></label></span>
<br/><br/><br/>
<span class="notifica" style="width:47%; font-size:14px"><%=str_notifiche_aggiornamento%><input class="cb" id="LOUP" type="checkbox" <%If LO_notifica_updates then%>checked="checked" <%End if%> onclick="setNotifica('LO_notifica_updates',$(this))"/><label for="LOUP"><span></span></label></span>
<br/><br/><br/>
<span class="notifica" style="width:47%; font-size:14px"><%=str_notifiche_preferiti%><input class="cb" id="LOFA" type="checkbox" <%If LO_notifica_favorites then%>checked="checked" <%End if%> onclick="setNotifica('LO_notifica_favorites',$(this))"/><label for="LOFA"><span></span></label></span>
</p>
<p class="notifyOptions">
<br/><span style="float:left; clear:both;"><%=str_notifiche_status%>:</span>
<br/><br/>
<span class="notifica">50%<input class="cb" id="LO50" type="checkbox" <%If LO_notifica_50 then%>checked="checked" <%End if%> onclick="setNotifica('LO_notifica_50',$(this))"/><label for="LO50"><span></span></label></span>
<span class="notifica">75%<input class="cb" id="LO75" type="checkbox" <%If LO_notifica_75 then%>checked="checked" <%End if%> onclick="setNotifica('LO_notifica_75',$(this))"/><label for="LO75"><span></span></label></span>
<span class="notifica">90%<input class="cb" id="LO90" type="checkbox" <%If LO_notifica_90 then%>checked="checked" <%End if%> onclick="setNotifica('LO_notifica_90',$(this))"/><label for="LO90"><span></span></label></span>
<span class="notifica" style="display:none">100%<input class="cb" id="LO100" type="checkbox" <%If LO_notifica_100 then%>checked="checked" style="border:solid 2px #7ac943" <%End if%> onclick="setNotifica('LO_notifica_100',$(this))"/><label for="LO100"><span></span></label></span>
</p>


</div>

<div class="profileContent" id="areaDati" style="position:relative; margin-left:17%;padding-left:10px; margin-top:-80px; width:70%; display:none">
<form id="editProfile">
<label class="input" style="width:61%; margin:0px 15% 4px 0px;"><span><%=str_lingua%></span><select class="tx" name="CO_lingue" onchange="$('.TA_lang').val($(this).find(':selected').attr('rel'))"><%
SQL="SELECT * FROM lingue WHERE LO_pubblica=True"
Set rec=connection.execute(SQL)
do While Not rec.eof
nl=rec("TA_nome")
vl=rec("IN_valore")
tl=rec("TA_abbreviato")
adsl=""
If vl=CO_lingue Then adsl=" selected=""selected"""
Response.write "<option value="""&vl&""" rel="""&tl&""""&adsl&">"&nl&"</option>"
rec.movenext
loop%>
</select><input type="hidden" class="TA_lang" name="TA_lang" value="<%=TA_lang%>"/></label>
<label class="input" style="width:61%;"><span><%=str_f_Ente%></span><input type="text" class="tx" name="TA_ente" value="<%=ente%>" /></label>
<label class="input" style="width:61%;"><span><%=str_f_Nome%></span><input type="text" class="tx ob" name="TA_nome" value="<%=nome%>"/></label><br/>
<label class="input" style="width:61%;"><span><%=str_f_Cognome%></span><input type="text" class="tx ob" name="TA_cognome" value="<%=cognome%>"/></label>
<label class="input" style="width:61%;"><span><%=str_f_Data_nascita%></span><input type="text" class="tx ob" name="DT_data_nascita" value="<%=data_nascita%>"/></label>
<label class="input" style="width:61%;"><span><%=str_f_Indirizzo%></span><input type="text" class="tx ob" name="TA_indirizzo" value="<%=indirizzo%>"/></label>
<label class="input" style="width:61%;"><span><%=str_f_Luogo%></span><input type="text" class="tx ob" name="TA_citta" value="<%=luogo%>"/></label>
<label class="input" style="width:51%;"><span><%=str_f_Cap%></span><input type="text" class="tx ob" name="TA_cap" value="<%=cap%>" maxlength="6" style="width:35%;padding-left:42%"/></label>
<label class="input" style="width:61%;"><span><%=str_f_Nazione%></span><input type="text" class="tx ob" name="nazione" value="<%=nazione%>" maxlength="6" onfocus="this.blur(); getNation('#getNations')"/><input type="hidden" name="CO_nazioni" value="<%=nazio%>"/>
<select id="getNations" style="display:none; position:absolute; left:35%; top:1px; border:0px; width:82%; height:42px;" onchange="setNation($(this),'CO_nazioni','nazione'); checkPrefix($('input[name=TA_telefono]'),$(this).val())"></select>
</label>
<label class="input" style="width:61%;"><span><%=str_f_Tel1%></span><input type="tel" class="tx ob" name="TA_telefono" value="<%=tel%>" onchange="checkPrefix($(this), $('input[name=CO_nazioni]').val())"/></label>
<label class="input" style="width:61%;"><span><%=str_f_Tel2%></span><input type="tel" class="tx" name="TA_natel" value="<%=natel%>"/></label>
<label class="input"  style="width:61%;"><span><%=str_f_Professione%></span><input type="text" class="tx" name="TA_societa" value="<%=professione%>"/></label>
<%If LO_projects then%>
<label class="input" style="width:61%;"><span>Link Facebook</span><input type="text" class="tx" name="TA_facebook" value="<%=facebook%>"/></label>
<label class="input" style="width:61%;"><span>Link Twitter</span><input type="text" class="tx" name="TA_twitter" value="<%=twitter%>"/></label>
<label class="input" style="width:61%;"><span>Link Linkedin</span><input type="text" class="tx" name="TA_linkedin" value="<%=linkedin%>"/></label>

<%End if%>
<span style="float:right; margin-right:28%">
<input class="bt" type="button" value="<%=str_f_annulla%>" onclick="closeEditProfile()">
<input class="bt bt1" type="submit" value="<%=str_f_salva%>">
</span>
</form>

</div>

<div class="profileContent" id="areaPassword" style="position:relative; margin-left:17%;padding-left:10px; margin-top:-120px; width:70%; display:none">
<form id="editPassword">
<p style="width:55%"><b><%=str_mod_password%></b><br/>
<%=str_min_password%></p>
<label class="input"  style="width:44%"><span><%=str_current_password%></span><input type="password" class="tx" name="pass1" value="" style="padding-left:48%"/></label>
<label class="input"  style="width:44%"><span><%=str_new_password%></span><input type="password" class="tx" name="pass2" value="" style="padding-left:48%"/></label>
<label class="input"  style="width:44%"><span><%=str_repeat_password%></span><input type="password" class="tx" name="pass3" value="" style="padding-left:48%"/></label>
<span style="clear:both; float:right; margin-right:42%">
<input class="bt" type="button" value="<%=str_f_annulla%>" onclick="$('#areaPassword').css('display','none'); $('.profileData,#areaNotifica').css('display','inline')">
<input class="bt bt1" type="submit" value="<%=str_f_salva%>">
</span></form>
</div>

<div class="profileContent" id="areaEmail" style="position:relative; margin-left:17%;padding-left:10px;  margin-top:-120px; width:70%; display:none">
<form id="editMail">
<p style="width:55%"><b><%=str_mod_email%></b><br/>
<%=str_mod_email_msg%></p>
<label class="input"  style="width:41%"><span><%=str_new_email%></span><input type="text" class="tx" name="email" value="" style="padding-left:55%"/></label>
<span style="clear:both; float:right; margin-right:43%">
<input class="bt" type="button" value="<%=str_f_annulla%>" onclick="$('#areaEmail').css('display','none'); $('.profileData,#areaNotifica').css('display','inline')">
<input class="bt bt1" type="submit" value="<%=str_f_salva%>">
</span></form>
</div>

<div class="profileContent" id="areaEmailr" style="position:relative; margin-left:17%;padding-left:10px;  margin-top:-120px; width:70%; display:none">
<form id="editMailr">
<p style="width:55%"><b><%=str_mod_rec_email%></b><br/>
<%=str_mod_rec_email_msg%></p>
<label class="input"  style="width:41%"><span><%=str_new_email%></span><input type="text" class="tx" name="emailr" value="" style="padding-left:55%"/></label>
<span style="clear:both; float:right; margin-right:43%">
<input class="bt" type="button" value="<%=str_f_annulla%>" onclick="$('#areaEmailr').css('display','none'); $('.profileData,#areaNotifica').css('display','inline')">
<input class="bt bt1" type="submit" value="<%=str_f_salva%>">
</span></form>
</div>

<div class="profileContent" id="areaCancel" style="position:relative; margin-left:17%;padding-left:10px;  margin-top:-120px; width:70%; display:none">
<form id="cancelAccount">
<p style="width:55%"><b><%=str_delete_account%></b><br/>
<%=str_delete_account_msg%></p>
<p>
<input class="bt" type="button" value="<%=str_f_annulla%>" onclick="$('#areaCancel').css('display','none'); $('.profileData,#areaNotifica').css('display','inline')">
<input class="bt bt1" type="submit" style="width:210px" value="<%=str_delete_confirm%>">
</p></form>
</div>


<div class="contUpload">
<form id="fileupload_1" class="fileupload" action="<%=uploadscript%>" method="POST" enctype="multipart/form-data" style="margin:0px">
<p id="fileupload_1_file"><input class="fInput" id="ff" type="file" name="files[]">
<label for="ff" style="cursor:pointer;"><%=str_ins_foto%><br/><span style="font-size:10px">Jpg, Png, min. 350x350 pixel</span></label></p>
<div class="barContain" style="display:none;height:70px"><div class="bar" id="fileupload_1_bar">&nbsp;uploading ...</div></div>
<input type="hidden" name="tabdest" value="registeredusers"/>
</form>

<form id="formUpld_inside" method="POST" style="opacity:0.0; margin:0px">
<input type="hidden" name="table" value="registeredusers"/>
<input type="hidden" name="fieldF" value="AT_immagine"/>
<input type="hidden" id="fieldVal" name="fieldVal" value=""/>
</form>
</div>


<script src="/js/vendor/jquery.ui.widget.js"></script>
<script src="/js/jquery.iframe-transport.js"></script>
<script src="/js/jquery.fileupload.js"></script>

<script>
$('#formUpld_inside').submit(function(e) {
e.preventDefault();

$.ajax({
  type: "POST",
  url: "/actions/addFileJQ.asp",
  data:  $("#formUpld_inside").serialize(),
  timeout: 6000,
  success    : function(msg) {
	setTimeout(function() { document.location="/profilo/"; },2000) 
  }})

return false;
  });


$('.fileupload').each(function () {
mainObj =  $(this).attr("id");
$(this).fileupload({
dataType: 'json',
dropZone: $('.profileImage'),
add: function (e, data) {
        $('p.dispError').remove()
		var goUpload = true;
        var uploadFile = data.files[0];
        if (!(/\.(jpg|jpeg|png|gif)$/i).test(uploadFile.name)) {
            $('<p class="dispError" style="clear:both;"><br/>'+str_file_upload_ext+'</p>').appendTo($(this));
            goUpload = false;
        }
        if (uploadFile.size > 3100000) { 
			$('<p class="dispError" style="clear:both;"><br/>'+str_maxupload+': 3MB</p>').appendTo($(this));
            goUpload = false;
        }
        if (goUpload == true) {
            jqXHR = data.submit();
        }
    },
start: function() {
		mainObj =  $(this).attr("id");

		objBar = $("#"+mainObj+"_bar");
		objFile = $("#"+mainObj+"_file");
		objBar.parent().fadeIn(200);
		objFile.fadeOut(100);
	    objBar.html('<p style="text-align:center"><span></span><br/><a href="javascript:abortUpload($(\'#'+mainObj+'_file\'),$(\'#'+mainObj+'_bar\'))">'+str_annulla+'</a></p>');

	},
progress: function (e, data) {
    	var progress = parseInt(data.loaded / data.total * 100, 10);
        objBar.find('span').html(progress+'%');
    },
	done: function (e, data) {
            $.each(data.result, function (index, file) {
				objBar.html(str_upload_ended);
$('#fieldVal').val(file.url);
$('#formUpld_inside').submit()
$('<img/>').attr('src','/<%=imgscript%>?path='+file.url+'$324')


            });
        }
    });
	});



	</script>
<%
Else
Response.redirect(pagelog)
End if%>

	</div>
</div>