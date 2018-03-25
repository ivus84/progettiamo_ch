<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%
'Response.CodePage  = 65001
load=request("load")
If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE LO_deleted=False AND ID="&load&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
If rec.eof Then
Response.End
End If

ptitle=rec("TA_nome")
pSubTitle = rec("TA_nome_1")
    ptitle = ConvertFromUTF8(ptitle)
pSubTitle = ConvertFromUTF8(pSubTitle)

'IB 170220 Fix titolo in finestra modifica progetto
If Len(pTitle)>0 Then pTitle=Replace(pTitle,"#","'")
'IB 170220 Fix titolo in finestra modifica progetto
'IB 170319 - Modifiche layout
If Len(pSubTitle)>0 Then pSubTitleTitle=Replace(pTitle,"#","'")
'IB 170319 - Modifiche layout
cifra=rec("IN_cifra")
mezzi=rec("IN_mezzi_propri")
abstract=rec("TE_abstract")
cat=rec("CO_p_category")
area=rec("CO_p_area")
keywords=rec("TX_keywords")
termine=rec("DT_termine")
luogo=rec("TA_luogo")
nazione=rec("TA_nazione")
imgp=rec("AT_main_img")
imgp1=rec("AT_banner")
dedu=rec("LO_deducibile")

plink=linkMaker(ptitle)


abstract = ConvertFromUTF8(abstract)
keywords = ConvertFromUTF8(keywords)
luogo = ConvertFromUTF8(luogo)
If Len(imgp)=0 Or isnull(imgp) Then imgp="thumb_picture_1.png"
If Len(imgp1)=0 Or isnull(imgp1) Then imgp1="thumb_picture_1.png"
If len(termine)>0 Then termine=datevalue(termine)

SQL="SELECT CO_p_area FROM registeredusers WHERE ID="&Session("logged_donator")
Set rec1=connection.execute(SQL)
refareap=rec1("CO_p_area")
If area=0 Or isnull(area) Or Len(area)=0 Then area=refareap

If Len(Nazione)=0 OR isnull(nazione) Then Nazione="Svizzera"
%>
<!--#INCLUDE VIRTUAL="./project/project_make_header.asp"-->
<!--#INCLUDE VIRTUAL="./project/project_make_path.asp"-->
<div style="clear:both"></div>

<div id="mainForm">
<p>
<b>Tutti</b> i campi di questa pagina (testi e fotografie) sono obbligatori.
</p>
<p>
<span style="float:left; margin-right:10px; display:none;">
Categoria<br/>
<select id="category" style="width:370px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px"><option value="0">...</option>
<%SQL="SELECT * FROM p_category"
Set rec=connection.execute(SQL)
Do While not rec.eof
refA=rec("ID")
addsl=""
If refA&""=cat&"" then addsl=" selected=""selected"""
Response.write "<option value="""&refA&""""&addsl&">"&rec("TA_nome")&"</option>"
rec.movenext
loop%>
</select>
</span>

<span style="float:left">
ERS di Riferimento<br/>
<select id="area" style="width:370px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px"><option value="0">...</option>
<%SQL="SELECT * FROM p_area ORDER BY TA_nome"
Set rec=connection.execute(SQL)
Do While not rec.eof
refA=rec("ID")
addsl=""
If refA&""=area&"" then addsl=" selected=""selected"""
Response.write "<option value="""&refA&""""&addsl&">"&rec("TA_nome")&"</option>"
rec.movenext
loop%>
</select>
</span>

<span style="float:left; width:40%;margin-right:10px; margin-left:10px; padding-top:17px; font-size:13px">
<input type="checkbox" id="dedu" style="display:inline;float:left; width:20px; height:20px; margin:0px 6px 22px 0px" value="True" <%If dedu then%>checked="checked"<%End if%>/>
Selezionare se le donazioni a questo progetto sono
fiscalmente deducibili in quanto versate a un ente di
pubblica utilit&agrave;.
</span>
</p>
<div style="clear:both"></div>
<p>
<span style="float:left; margin-right:10px">
Titolo<br/>
<input type="text" id="title" style="width:358px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value="<%=ptitle%>"/>
</span>
<span style="float:left; margin-right:10px">
Luogo<br/>
<input type="text" id="luogo" style="width:358px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value="<%=luogo%>"/>
</span>

</p>
<div style="clear:both"></div>
<p>
<span style="float:left; margin-right:10px">
Sottotitolo (max 80 caratteri) <span class="tCount1" style="float:right;font-size:12px;color:#666"></span><br/>
<input type="text" id="subtitle" 
        style="width:736px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" 
        value="<%=pSubTitle%>"/>
</span>
</p>
<div style="clear:both"></div>

<p>
<span style="float:left;margin-right:10px; display:none;">
Nazione<br/>
<input type="text" id="nazione" style="width:358px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value="<%=Nazione%>"/>
</span>

<span style="float:left; margin-right:10px">
Ammontare totale progetto Fr.<br/>
<input type="text" id="cifra" style="width:358px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value="<%=cifra%>"/>
</span>
<span style="float:left">
Altri finanziamenti (incluso mezzi propri) Fr.<br/>
<input type="text" id="mezzi" style="width:358px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value="<%=mezzi%>"/>
</span>

</p>
<div style="clear:both"></div>

<p>
<span style="float:left; margin-right:10px">
Abstract (max 250 caratteri) <span class="tCount" style="float:right;font-size:12px;color:#666"></span>
<textarea id="medit" class="editarea"><%=abstract%></textarea>
<span class="nosave" style="font-size:11px; color:#ff0000"></span></span>
<span style="float:left; margin-top:0px; ">
Parole chiave (separate da virgola)<br/>
<input type="text" id="keywords" style="width:358px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" value="<%=keywords%>"/>
</span>

<span style="float:left;width:358px;">
<br/>Termine raccolta fondi<br/>
<input type="text" id="termine" style="width:95px; cursor:pointer; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px" onfocus="$(this).blur()" value="<%=termine%>"/>
</span>

</p>
</div>
<div style="clear:both; margin-bottom:10px;"></div>
<div style="position:relative; float:left; width:368px">
<p>
Immagine principale<br/><span style="font-size:12px">formato quadrato o 4:3, file png o jpg<br/>dimensione minima consigliata: 500 x 500 pixel<br/>dimensione massima file: 3MB</span><br/>
</p>
<div id="fileupload_1_uimg" class="profileImage" style="background-color:#ccc; height:140px; width:188px;  background-color:#797979; background-size: auto 100%; background-image:url(/<%=imgscript%>?path=<%=imgp%>$400); cursor:pointer" onclick="$('#labUpl1').trigger('click')"></div>
<div style="clear:both"></div>
<p style="margin-top:-6px; clear:left;">
<form id="fileupload_1" class="fileupload" action="<%=uploadscript%>" method="POST" enctype="multipart/form-data" style="margin:0px">
<p id="fileupload_1_file"><input class="fInput" id="ff" type="file" name="files[]">
<label for="ff" id="labUpl1" class="lblUpload">Carica immagine</label></p>
<div class="barContain" style="display:none; width:120px"><div class="bar" id="fileupload_1_bar">&nbsp;uploading ...</div></div>
<input type="hidden" name="tabdest" value="p_projects"/>
</form>

<form id="fileupload_1_upl" class="formUpld" method="POST" style="opacity:0.0; margin:0px">
<input type="hidden" name="table" value="p_projects"/>
<input type="hidden" name="fieldF" value="AT_main_img"/>
<input type="hidden" class="fieldVal" name="fieldVal" value=""/>
<input type="hidden" name="fieldRef" value="<%=load%>"/>
</form>

</p>

</div>

<div style="position:relative; float:left;width:368px; margin-left:12px;">
<p>
Banner homepage<br/><span style="font-size:12px">formato 4:3 o 16:9, file png o jpg<br/>dimensione minima consigliata: minimo <span style="color:Red">2200 x 900 pixel</span><br/>dimensione massima file: <span style="color:Red">3MB</span></span><br/>
</p>
<div id="fileupload_2_uimg" class="profileImage" style="height:205px; width:368px; background-size: auto 100%; background-color:#797979; background-image:url(/<%=imgscript%>?path=<%=imgp1%>$400); cursor:pointer" onclick="$('#labUpl2').trigger('click')"></div>
<div style="clear:both"></div>
<p style="margin-top:-6px">

<form id="fileupload_2" class="fileupload" action="<%=uploadscript%>" method="POST" enctype="multipart/form-data" style="margin:0px">
<p id="fileupload_2_file"><input class="fInput" id="ff1" type="file" name="files[]">
<label for="ff1" id="labUpl2" class="lblUpload">Carica immagine</label></p>
<div class="barContain" style="display:none; width:120px"><div class="bar" id="fileupload_2_bar">&nbsp;uploading ...</div></div>
<input type="hidden" name="tabdest" value="p_projects"/>
</form>

<form id="fileupload_2_upl" class="formUpld" method="POST" style="opacity:0.0; margin:0px">
<input type="hidden" name="table" value="p_projects"/>
<input type="hidden" name="fieldF" value="AT_banner"/>
<input type="hidden" class="fieldVal" name="fieldVal" value=""/>
<input type="hidden" name="fieldRef" value="<%=load%>"/>
</form>

</p>

</div>

<div style="clear:both"></div>

<p style="text-align:right; width:750px;">
<span class="btn">
<input type="button" class="bt" value="avanti" onclick="$('.myprojectsFrame iframe')[0].contentWindow.parentEdit(1)"/>
<input type="button" class="bt" value="indietro" onclick="document.location='/myprojects/'"/>
<input type="button" class="bt" value="anteprima" onclick="document.location='/?progetti/<%=load%>/preview-project'"/>
</span>
<input type="hidden" id="edRef" value="<%=load%>" />
</p>

<script type="text/javascript" src="/js/datepicker.it.js"></script>
<script src="/js/vendor/jquery.ui.widget.js"></script>
<script src="/js/jquery.iframe-transport.js"></script>
<script src="/js/jquery.fileupload.js"></script>

<script>
$.datepicker.setDefaults( $.datepicker.regional[ "it" ] );
$(document).ready(function () {
    subtitleLength = 0;
    $('#subtitle').keyup(function (event) {


        text = $('#subtitle').val();


        outputstr = text.replace(regex, "");
        outputstr = outputstr.replace(/&nbsp;/g, " ");

        outputstr1 = outputstr.replace(/^\s+|\s+$/g, '');
        //outputstr1=outputstr.trim()
        tLength = 80 - (outputstr1.length)
        subtitleLength = tLength

        if (tLength >= 0) $('.tCount1').html(tLength + " rimanenti")
        if (tLength < 0) $('.tCount1').html('<font style="color:#ff0000">+' + (tLength * -1) + ' caratteri in eccesso</font>')
    });
    $('div.ppath span').eq(0).find('span').addClass('active')
    make_edit(0)
    $("#termine").datepicker();
    $('#mainForm input').bind('change', function () { SaveForm(2) })
    $('#mainForm select').bind('change', function () { SaveForm(2) })

    if (oldIeBrowser) {
        $('#ff').css('display', 'inline')
        $('#ff').css('filter', 'alpha(opacity=0)')
        $('#ff1').css('display', 'inline')
        $('#ff1').css('filter', 'alpha(opacity=0)')
    }



    $('#subtitle').keyup();
    $('.editarea').tinymce({
        script_url: '/admin/jscripts/tiny_mce3.5.10/tiny_mce.js',
        translate_mode: true,
        language: "it",
        width: 370,
        height: 129,
        theme: "advanced",
        plugins: "style,inlinepopups,paste",
        theme_advanced_buttons1: "bold,italic",
        theme_advanced_toolbar_location: "bottom",
        theme_advanced_toolbar_align: "left",
        theme_advanced_statusbar_location: "none",
        theme_advanced_resizing: false,
        invalid_elements: "span,div,p",
        entities: "38,amp,34,quot,162,cent,8364,euro,163,pound,165,yen,169,copy,174,reg,8482,trade",
        setup: function (ed) {
            ed.onChange.add(function (ed, l) {

                SaveForm(2)
            });

            ed.onPaste.add(function (ed, e) {
                ed.pasteAsPlainText = true;
                getStats('medit')
            });

            ed.onKeyUp.add(function (ed, e) {

                getStats('medit')
            });

            ed.onInit.add(function (ed) {
                ed.pasteAsPlainText = true;
                getStats('medit')

            });
        }
    });




    $('.formUpld').submit(function (e) {
        e.preventDefault();
        $.ajax({
            type: "POST",
            url: "/actions/addFileJQ.asp",
            data: $(this).serialize(),
            timeout: 6000,
            success: function (msg) {
                $('p.dispError').remove()

                setTimeout(function () { SaveForm(0) }, 1000)

            }
        })

        return false;
    });


    $('.fileupload').each(function () {
        mainObj = $(this).attr("id");
        $(this).fileupload({
            dataType: 'json',
            dropZone: $('#' + mainObj + '_uimg'),
            add: function (e, data) {
                $('p.dispError').remove()
                var goUpload = true;
                var uploadFile = data.files[0];
                if (!(/\.(jpg|jpeg|png|gif)$/i).test(uploadFile.name)) {
                    $('<p class="dispError" style="clear:both;"><br/>Scegliere un file in formato png o jpg</p>').appendTo($(this));
                    goUpload = false;
                }
                /*if (uploadFile.size > 6100000) {
                    $('<p class="dispError" style="clear:both;"><br/>Dimensione massima consentita per il file: 6MB</p>').appendTo($(this));*/
                if (uploadFile.size > 3100000) {
                    $('<p class="dispError" style="clear:both;"><br/>Dimensione massima consentita per il file: 3MB</p>').appendTo($(this));
                    goUpload = false;
                }
                if (goUpload == true) {
                    jqXHR = data.submit();
                }
            },
            start: function () {
                mainObj = $(this).attr("id");

                objBar = $("#" + mainObj + "_bar");
                objFile = $("#" + mainObj + "_file");
                objBar.parent().fadeIn(200);
                objFile.fadeOut(100);
                objBar.html('<p style="text-align:center"><span></span><br/><a href="javascript:abortUpload($(\'#' + mainObj + '_file\'),$(\'#' + mainObj + '_bar\'))">ANNULLA</a></p>');

            },
            progress: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                objBar.find('span').html(progress + '%');
            },
            done: function (e, data) {
                $.each(data.result, function (index, file) {
                    objBar.html("Upload terminato");
                    $('#' + mainObj + '_upl input.fieldVal').val(file.url);
                    $('#' + mainObj + '_upl').submit()
                    $('<img/>').attr('src', '/<%=imgscript%>?path=' + file.url + '$324')
                });
            }
        });
    });


})


SaveForm = function(mode) {
ed = $('.editarea').tinymce().getContent();
$('.nosave').html('')
 if (abstractLength < 0) {
 $('.nosave').html('Impossibile salvare, ridurre lunghezza testo abstract.')
 return;
}
if (subtitleLength < 0) {
    $('.nosave').html('Impossibile salvare, ridurre lunghezza testo sottotitolo.')
    return;
}
edref=$('#edRef').val();
title1 = $('#title').val();
subtitle = $('#subtitle').val();
cifra1=$('#cifra').val();
mezzi1=$('#mezzi').val();
cat=$('#category').val();
area1=$('#area').val();
keywords1=$('#keywords').val();
termine1=$('#termine').val();
luogo1=$('#luogo').val();
nazione1=$('#nazione').val();
dedu="False"
if ($('#dedu:checked').size()>0) dedu="True"
var data1 = {
  myTextarea: ed,
  ref: edref,
  title: title1,
  subtitle:subtitle,
  dedu: dedu,
  cifra: cifra1,
  mezzi: mezzi1,
  keywords: keywords1,
  cat: cat,
  area: area1,
  luogo: luogo1,
  nazione: nazione1,
  termine: termine1

};

$.ajax({
  type: "POST",
  dataType: "html",
  url: "/project/project_make_1_save.asp",
  timeout:8000,
  data: data1, 
  success: function (msg) { 
  if (mode==0) parent.document.location=""+parent.document.location.href;
  if (mode==1) parentEdit(1)
  },
error: function(msg) {}
})

}

var abstractLength = 0;
var regex = /<[^>]*>/gi;
getStats = function(id) {


text = $('.editarea').tinymce().getContent();
    

    outputstr=text.replace(regex,"");	
    outputstr=outputstr.replace(/&nbsp;/g," ");	
	
    outputstr1 = outputstr.replace(/^\s+|\s+$/g, ''); 
	//outputstr1=outputstr.trim()
	tLength=250-(outputstr1.length)
	abstractLength=tLength

	if (tLength>=0) $('.tCount').html(tLength+" rimanenti")
	if (tLength<0) $('.tCount').html('<font style="color:#ff0000">+'+(tLength*-1)+' caratteri in eccesso</font>')
}


</script>
</body>
</html>

<%
End if
connection.close%>