function delFileInline(urladd,gref) {
    if (confirm('Eliminare l\'elemento selezionato?')) { 
        getUrl="delFileJQ.asp?"+urladd+"&ssid=" + Math.floor((Math.random()*111111)+1);
        $.ajax({
          url: getUrl,
          context: document.body,
          success: function(msg){
        openEdit('edit_page.asp?ref='+gref)
        }});
    }
}


function setAnnoP(vval) {
    if ($.isNumeric(vval)) {
	    $('#data_page').val('12/31/'+vval);
        sendSaveForm();
    }
}


function setEditing() {
    obj=$("#editing_page");
    obj.css('height','50px');
    obj.fadeIn("normal")
    var y = 94;
    y1=$(document).scrollTop();
    obj.css('top',(y+y1)+'px');
}


function redimThis() {
    var pageContainer = $('#editing_page', parent.document);
    pageContainer.css('height','1px');
    //pageContainer.css('display','none');

    hp=$(document).height();
    if (hp<490) hp=490;
    pageContainer.css('height',hp+'px');
    pageContainer.stop().slideDown(500);
}

function closeThis(refreshParent) {
    var pageContainer = $('#editing_page', window.parent.document);
    pageContainer.attr('src','blank.asp');
    pageContainer.css('display', 'none');
    if (refreshParent) window.parent.location.reload(false);
}


function openEditor() {
    $("#saveBtns").css('display','inline');
    $(".edPage").css('display','none');
    $('#txtPreview').css("display","none")
    $('#overEditor').css("display","none")
    gW=$('#contentEdit').width();
    $("#Editor_tmce").css('width',gW+'px');
    $("#Editor_tmce").css('margin-top','-37px');
    $("#Editor_tmce").css('display','inline');
    gH=$(window).height()-$('#Editor_tmce').offset().top-400;
    $("#Editor_tmce").css('height',gH+'px');

    setTimeout(function() {
	$('#elm1').tinymce().focus();},500);

	$(window).bind('resize',function() { openEditor() });
}


function closeEditor() {
    $("#saveBtns").css('display','none');
    $('#txtPreview').fadeIn('normal');
    $('#overEditor').css("display","inline")

    $(".edPage").css('display','inline');
    $('#elm1').tinymce().remove();
    $("#Editor_tmce").css('display','none');
	$(window).unbind('resize');
}

function redimPrev() {
    return;
}


function openwin(cosa,larghezza,altezza) {
    var larga= larghezza;
    var alta= altezza;
    W=(screen.availWidth-larga)/2;
    H=(screen.availHeight-alta)/2;
    seleziona1=cosa;
    window.open(seleziona1, 'pop', 'width='+larga+', height='+alta+',top='+H+',left='+W+',resizable=yes,scrollbars=Yes,LOCATION=no,toolbar = no');
}

function setdest(cosa) {
    obj1=document.getElementById("edit_gallery");
    obj1.style.visibility='visible';
    obj1.style.height='170px';
    obj1.src="./"+cosa;
}

function displayMenu(div) {
    $(".opts").not('#page_'+div).each(function(index) {
        $(this).css('display','none');

        gid =$(this).attr('id');
        gid=gid.replace("page_","menu_");

        $('#'+gid).css('backgroundColor','#efefef');
        $('#'+gid).css('borderBottom','solid 1px #666666');
    });


    objID="page_"+div;
    menID="menu_"+div;

    $('#'+objID).fadeIn('fast');
    $('#'+menID).css('backgroundColor','#c4bebe');
    $('#'+menID).css('borderBottom','solid 1px #c4bebe');
}


function closeDial(div) {
    var obj=document.getElementById(div);
    obj.src="";
    obj.style.height="0px";
    obj.style.width="0px";
    obj.style.visibility="hidden";
}

function getOptUpload() {
var jqXHR1 = $('.fileuploadOpt').fileupload({
    dataType: 'json',
	formData: {tabdest: 'AT_image'},
    progress: function (e, data) {
    mainObj =  $(this).attr("id");
		objBar = $("#"+mainObj+"_bar");
		objFile = $("#"+mainObj+"_file");
		objBar.unbind("click");
		objBar.bind("click",function() { jqXHR1.abort(); });
		objFile.fadeOut(100);
		objBar.parent().fadeIn(200);
        var progress = parseInt(data.loaded / data.total * 100, 10);
        objBar.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+progress+"% - " + parseInt(data.loaded/1000) +"/"+ parseInt(data.total/1000) + " KB");
		objBar.css(
            'width',
            progress + '%'
        );
    },
		done: function (e, data) {
            $.each(data.result, function (index, file) {
                $('#fieldVal').val(file.url);
				$('#formUpld_inside').submit();
				objBar.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ file.name + " successfully uploaded");
				objBar.unbind("click");
            });
        }
   	});
}




function gCalendar() {
    $("#datepicker" ).datepicker({
        onSelect: function(dateText, inst) { 
        $( "#datepicker" ).fadeOut('fast');
        $("#data_page").attr('value',dateText);
        var myDate = new Date(dateText);
        strDate=myDate.getDate()+'/'+(myDate.getMonth()+1)+'/'+myDate.getFullYear();
        $('#view_datapage').text(strDate+' '); 
        sendSaveForm();
     }
    });
    $( "#datepicker" ).fadeIn('fast');

    $("#datepicker").mouseleave( function() { cCalendar() });
}

function cCalendar() {
    $( "#datepicker" ).fadeOut('fast');
}

function vMenu(obj) {
    M=$(obj);

    zInd=parseInt(M.css("z-index"));
    if (zInd==1) {
	    M.css("z-index","100");
    } else {
        M.css("z-index","1");
    }
}


function redimStruct(){
    wp=$("#content_page").width()+20;
    $('#quick_edit', window.parent.document).css('width',wp+'px');

    nst=$('div.elmntStr').size();

    for (xx=0; xx<nst; xx++){
	    $('div.elmntStr').eq(xx).css('display','inline')
	    $('div.elmntStr').eq(xx).css("width",$(this).parent().width()-$(this).next().width()-8)
    }
}


function addBox(gBox,ref,mode){
    seturl="addBox.asp?load="+ref+"&gBox="+gBox+"&mode="+mode;
    $.ajax({
  	    url: seturl,
  	    success: function(data) {
    openEdit('edit_page.asp?ref='+ref)
    }});
}


function viewLevel(ref,lev){
    var $obj=$('#submenu_container'+ref);
    seturl="getLevel.asp?load="+ref+"&lev="+lev;
    chckVL=$obj.html();

    if (chckVL.length>0) seturl="addLevel.asp?load="+ref+"&lev="+lev;
    seturl1="closeLevel.asp?load="+ref+"&lev="+lev;

    if( $obj.is(':visible')) seturl=seturl1;

    $.ajax({
  	    url: seturl+"&ssid="+Math.floor(Math.random()*9999),
  	    success: function(data) {
    if (chckVL.length==0) $obj.html(data);
    $obj.slideToggle('fast', function() {
    redimStruct();

    });
    }});
}

function chb(reff){
    if (chkbs.indexOf(','+reff+',')==-1) {
        chkbs=chkbs+reff+",";
    } else {
        chkbs=chkbs.replace(','+reff+',',',');
    }
    if (chkbs.length > 1) {
        $('#btck').fadeIn('fast');
    } else {
        $('#btck').fadeOut('fast');
    }
}


var refstopen="";

function delSelected(){
    document.location="del_sections.asp?refs="+chkbs;
}

function updEditorW() {
    wdiw1=$('#structureContainerTable').width();
    wdiw2=$('#mainEdit').width();
}

if ($('div.loadSt').size()>0){
    $(window).resize(function() { setLimgs() })
}

setLimgs = function() {
	$('.fImg').parent().bind("click", function() {
	gImg=$(this).find('img').attr("src");
	 //if (gImg.indexOf('folder.png')!=-1) $(this).find('img').attr("src","images/folder.png");
	 //if (gImg.indexOf('folder_open.png')!=-1) $(this).find('img').attr("src","images/folder.png");
	});

$('div.loadSt').each(function() {
    getH=$(this).innerHeight();
    getH1=parseInt($(this).css('max-height'));
    if (getH>=getH1) $(this).css('width','102%');
});

}

function delEdit(gurl) {
	if (confirm('Eliminare l\'elemento selezionato?')) { 
        getUrl=gurl+"&conferma=True&ssid=" + Math.floor((Math.random()*111111)+1);
        document.location=getUrl;
	}
}

function openEdit(gurl) {
if(gurl.length==0) {
    gurl=$('.level_1').eq(0).attr("title");
}

$('body').remove('#elm1');

$.ajax({
  	url: gurl+"&ssid="+Math.floor(Math.random()*9999),
  	success: function(data) {
txt=""+data;
txt = txt.replace(/\n/g, '');
//console.log(txt)
$('#mainEdit').html(txt);
makeSortPages();

$('#contentEdit').css('display','none')
$('html, body').scrollTop(0)
setTimeout(function() {
adptPreview();
	},100);


setTimeout(function() {
    getOptUpload();
    if ($('#selsections2').size()>0) getSlect('selsections2',2,'void(0)');
    if ($('#selsections3').size()>0) getSlect('selsections3',maxlevs,'void(0)');
},1500);


}});
}

function openMainMenu() {
    $('#editing_page').fadeOut(100)
    $('#content_page').fadeOut(200, function() {
	    $('#screenMenu').fadeIn(200);
    });
}

function closeMainMenu() {
    $('#screenMenu').fadeOut(300, function() {
	    $('#content_page').fadeIn(400);
    });
}

var gH1=280; var isie = isie11 = false
function adptPreview() {
    isie = /msie/.test(navigator.userAgent.toLowerCase());
    if (navigator.userAgent.match(/Trident\/7\./)) isie=true;
    $.browser.ff = /firefox/.test(navigator.userAgent.toLowerCase());
    $.browser.chrome = /chrome/.test(navigator.userAgent.toLowerCase());
    $.browser.safari = /safari/.test(navigator.userAgent.toLowerCase());
    gH=parseInt($(window).height()-$('#txtPreview').offset().top);
    setWPrev=$(window).width()-$('#structureContainerTable').width()-60;

    if (setWPrev>1150) setWPrev=1150;
    $('#mainEdit').css('width',setWPrev);
    setWPrev=setWPrev-302
    $('#contentEdit').css('width',setWPrev);
    $('#overEditor').css('width',setWPrev);

    pW=$('#txtPreview').width()/100*70;


    if ($.browser.ff || isie) {
    pW=$('#txtPreview').width();
    gH=gH*1.2;
    gH1=(gH/1.2)-10
    }

    if ($.browser.chrome || $.browser.safari) {
    gH=gH*2;
    if (gH<1330) gH=1330;
    gH1=(gH/2.7)
    }

    maxgH=1400;
    gH=Math.min(gH, maxgH)

    $('#txtPreview').css('height',(gH)+'px');


    $('#txtPreview').removeClass("smallPreview");
	    $('#txtPreview').addClass("normalPreview");

	if (pW<900) {
		$('#txtPreview').addClass("smallPreview");
		$('#txtPreview').removeClass("normalPreview");
	}
    $('#overEditor').css('height',(gH1)-10+'px');
    $('#content_page').css('height',(gH1)+10+'px');
    $('#contentEdit').css('height',(gH1)+10+'px');
    $('#contentEdit').fadeIn(100)

    $(window).unbind('resize');

    $(window).bind('resize',function() {
        adptPreview();
        setLimgs();
    })
}

function movePreview() {
    actSC=$('#txtPreview').contents().scrollTop()+200;
    totSc=parseInt($('#txtPreview').contents().height()/100*70);
    //alert(totSc-actSC)
    if (totSc-actSC < 300) actSC=0;
    $('#txtPreview').contents().scrollTop(actSC)
    }

    function makeSortPages() {
    $( "#ordPages" ).sortable({  
    update: function (event, ui) {
    newPos = ui.item.index()+1;
    getRefi=ui.item.attr("id");
    MovePage=getRefi.substring(getRefi.indexOf("_")+1);
    getSec=$("#ordPages").attr("title");
    gUrl="ord_pages.asp?ref="+MovePage+"&section="+getSec+"&newpos="+newPos+"&ssid=" + Math.floor((Math.random()*111111)+1);
    //window.open(gUrl)
    $.ajax({
      url: gUrl,
      context: document.body,
      success: function(msg){
    //$("<div style='position:absolute; z-index:100000'>"+msg+"</div>").appendTo("body");
    actEdit="ordina.asp?sezio="+getSec;
    getStructure();
	    }});
    }  });
}

function openLevels(gIndex){
    openedStructure=refstopen.split(",");
    if (gIndex<(openedStructure.length)-1){
    ref=openedStructure[gIndex];
    if (ref.length>0) {
    ref=ref.split("#");
    var obj=$('#submenu_container'+ref);
    seturl="getLevel.asp?load="+ref[0]+"&lev="+ref[1]+"&ssid="+Math.floor(Math.random()*9999);
    if (obj.length>0)  {

    //$('#imgLevel'+ref).css("background-image","url(images/folder_open.png)");
    $.ajax({
  	    url: seturl,
  	    success: function(data) {
		    obj.html(data);
		    obj.slideDown(50,function() {
		    redimStruct();
    gIndex=gIndex+1;
	    if (gIndex<=openedStructure.length) openLevels(gIndex);

	});
} 
}); 
    }else{
        gIndex=gIndex+1;
	    if (gIndex<=openedStructure.length) openLevels(gIndex);
    }
    }
}
}

function getOpened() {
    $.ajax({
  	    url: "getSession.asp",
  	    success: function(data) {
		    refstopen=""+data;
        openLevels(1);

    }});
}

var timeThumb="";
function viewThumb(thumb) {
	clearTimeout(timeThumb);
isVisi=1; setw=440; 
isfotosrc="../img.asp?path="+thumb+"&width="+setw;
objimg=$('#prevImgPic', window.parent.document);
objimgC=$('#prevImgPicContainer', window.parent.document);

$("<img/>") 
    .attr("src", isfotosrc)
    .load(function() {
        pic_real_width = this.width;
        pic_real_height = this.height;


if (pic_real_height>pic_real_width) { 
	setw=parseInt(setw / pic_real_height * pic_real_width);
isfotosrc="../img.asp?path="+thumb+"&width="+setw;
}

seth=parseInt((474-parseInt(setw*pic_real_height/pic_real_width))/2)


objimg.css('margin-top',seth+'px');

objimg.css('width',setw+'px');
objimg.attr('src',isfotosrc);
objimgC.fadeIn('fast', function() {
timeThumb = setTimeout("hideThumb()",2000);
isVisi=0;
});

});
}

function hideThumb() {
	clearTimeout(timeThumb);
    objimg=$('#prevImgPic', window.parent.document)
    objimgC=$('#prevImgPicContainer', window.parent.document);
    if (isVisi==0){
        objimgC.delay(100).css('display','none');
        objimg.attr('src','./images/vuoto.gif');
    }
}


function sendSaveForm() {

obj=$('#saveForm');
vals=""
var objs = $('#saveForm :input');

objs.each(function(index) {
adname=$(this).attr("name");
adval=$(this).val();

adval=encodeURIComponent(adval);
vals+=adname+'='+adval+'&';
});

vals+='mode=noredir';
vals=vals.replace(/ /gi,'%20');
$.ajax({
  type: "POST",
  url: "save.asp",
  data: vals
}).done(function( msg ) {
  
isdiv=$('<div id="msgSave" style="position:absolute;left:450px; top:200px;padding:20px; font-weight:bold;height:46px; z-index:1099; width:150px;font-size:12px;opacity:0.8; background:#fff url(../images/lightbox-ico-loading.gif) center 40px no-repeat; border:solid 3px #666; text-align:center;display:none;border-radius:20px;"></div>');
  $('body').append(isdiv);
$('#msgSave').html(msg);
$('#msgSave').fadeIn('fast', function() {
$('#msgSave').delay(1000).fadeOut('fast', function() {

gsrc=$('#txtPreview').attr("src");
$('#txtPreview').attr("src",gsrc);

});
});
});

 }


function saveTxt() {
ed = $('#elm1').tinymce().getContent();
$('#origText').html(ed);
edlang=$('#edLang').val();
edref=$('#edRef').val();

var data1 = {
  myTextarea: ed,
  lang: edlang,
  ref: edref
};

$.ajax({
  type: "POST",
  dataType: "html",
  url: "save_page_simple_editor.asp",
  data: data1
}).done(function( msg ) {
  
isdiv=$('<div id="msgSave" style="position:absolute;left:450px; top:200px;padding:20px; font-weight:bold;height:46px; z-index:1099; width:150px;font-size:12px;opacity:0.8; background:#fff url(../images/lightbox-ico-loading.gif) center 40px no-repeat; border:solid 3px #666; text-align:center;display:none;border-radius:20px;"></div>');
  $('body').append(isdiv);
$('#msgSave').html(msg);
$('#elm1').html(ed)
$('#msgSave').fadeIn('fast', function() {
$('#msgSave').delay(1000).fadeOut('fast',function() {
gsrc=$('#txtPreview').attr("src");
$('#txtPreview').attr("src",gsrc);

});
});
});

return false;
}



function load_editor() {
$('.txtTmce').remove(); 
txtArea=$('<textarea class="txtTmce" id="elm1"></textarea>');
$('#Editor_tmce').append(txtArea);
rfrshTx=$('#origText').html();
$('#elm1').val(rfrshTx);
gH=$(window).height()-$('#Editor_tmce').offset().top-400;
$('#elm1').tinymce({
script_url : '../admin/jscripts/tiny_mce3.5.10/tiny_mce.js',
extended_valid_elements : "div[*],iframe[src|width|height|name|align],script[src|type]",
apply_source_formatting:0,
translate_mode : true,
language : "it",
height : gH,
width: '100%',
theme : "advanced",
plugins : "autoresize,table,save,advimage,advlink,inlinepopups,searchreplace,contextmenu,paste,directionality,noneditable,visualchars,nonbreaking,xhtmlxtras,",
theme_advanced_buttons1 : "|,save,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,|,forecolor",
theme_advanced_buttons2 : "|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,code,|,hr,removeformat,|,sub,sup,charmap,|,ltr,rtl,nonbreaking,|",
theme_advanced_buttons3 : "|,tablecontrols,|,visualaid,|",
save_onsavecallback : "saveTxt",
theme_advanced_toolbar_location : "top",
theme_advanced_toolbar_align : "left",
theme_advanced_statusbar_location : "none",
theme_advanced_resizing : false,

paste_text_sticky : true,
setup : function(ed) {
    ed.onInit.add(function(ed) {
      ed.pasteAsPlainText = true;
    });
},

autoresize_min_height: gH,
content_css : "./text_styles_admin2.css",
theme_advanced_styles : 'Title=titolo;Text=testo', 
external_link_list_url : "lists/link_list.asp",	
external_image_list_url : "lists/image_list.asp"                
});
openEditor();
}


function delTipo(dest) {
    var obj=document.getElementById("upl_sezioni");
    obj.src=dest;
    obj.style.height="140px";
    obj.style.width="260px";
    obj.style.visibility="visible";
}

function addTipo(ref) {
    var selObj = document.formp.newsectionref;
    var selIndex = selObj.selectedIndex;
    ref3 = selObj.options[selIndex].value;
    var obj=document.getElementById("upl_sezioni");
    obj.src='addtipo.asp?ref='+ref+'&ref1='+ref3;
    obj.style.height="90px";
    obj.style.width="100px";
}

function loadEditorMini(gid) {
    $('#'+gid).tinymce({
    script_url : '../admin/jscripts/tiny_mce3.5.10/tiny_mce.js',
    translate_mode : true,
		    language : "it",
		    width : 220,
		    height : 280,
            theme : "advanced",
                            plugins : "style,save,advlink,inlinepopups,searchreplace,contextmenu,paste,noneditable,visualchars,xhtmlxtras",
           theme_advanced_buttons1 : "|,save,copy,paste,pastetext,|,bold,italic,|,link,unlink,code,removeformat,charmap|",
		    theme_advanced_buttons2 : "",
		    theme_advanced_buttons3 : "",
		    save_onsavecallback : "sendSaveForm",
                            theme_advanced_toolbar_location : "top",
                            theme_advanced_toolbar_align : "left",
                            theme_advanced_statusbar_location : "none",
                            theme_advanced_resizing : false,
	    theme_advanced_source_editor_height: 280, 
	    invalid_elements : "span",
    content_css : "./text_styles_admin2.css",
    extended_valid_elements : "iframe[src|width|height|name|align],script[src|type]",
    external_link_list_url : "lists/link_list.asp",	external_image_list_url : "lists/image_list.asp"});
}



function load_editorSmall(gW,gH) {

$('.tEditor').tinymce({
script_url : '../admin/jscripts/tiny_mce3.5.10/tiny_mce.js',
translate_mode : true,
		language : "it",
		width : gW,
		height : gH,
        theme : "advanced",
                        plugins : "style,table,save,advimage,advlink,inlinepopups,searchreplace,contextmenu,paste,directionality,noneditable,visualchars,nonbreaking,xhtmlxtras,",
       theme_advanced_buttons1 : "|,cut,copy,paste,pastetext,pasteword,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,|",
		theme_advanced_buttons2 : "|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,cleanup,code,|,hr,removeformat,|,sub,sup,charmap,|",
		theme_advanced_buttons3 : "",
		save_onsavecallback : "saveTxt",
                        theme_advanced_toolbar_location : "top",
                        theme_advanced_toolbar_align : "left",
                        theme_advanced_statusbar_location : "none",
                        theme_advanced_resizing : false,
	theme_advanced_source_editor_height: 400, 
	invalid_elements : "span",
		content_css : "./text_styles_admin.css",
extended_valid_elements : "iframe[src|width|height|name|align],script[src|type]",
theme_advanced_styles : 'Text=testo;Title=titolo', external_link_list_url : "lists/link_list.asp",	external_image_list_url : "lists/image_list.asp",
setup : function(ed) {
      ed.onLoadContent.add(function(ed, o) {
		if ($('#edNews', parent.document).size()==0) redimThis();
      });
   }	
});


}

function load_editorSm(gW,gH) {

$('.tEditor').tinymce({
script_url : '../admin/jscripts/tiny_mce3.5.10/tiny_mce.js',
translate_mode : true,
		language : "it",
		width : gW,
		height : gH,
        theme : "advanced",
                        plugins : "style,table,save,advimage,advlink,inlinepopups,searchreplace,contextmenu,paste,directionality,noneditable,visualchars,nonbreaking,xhtmlxtras,",
       theme_advanced_buttons1 : "|,cut,copy,paste,pastetext,pasteword,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,|,forecolor",
		theme_advanced_buttons2 : "|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,cleanup,code,|,hr,removeformat,|,sub,sup,charmap,nonbreaking,|",
		theme_advanced_buttons3 : "",
		save_onsavecallback : "saveTxt",
                        theme_advanced_toolbar_location : "top",
                        theme_advanced_toolbar_align : "left",
                        theme_advanced_statusbar_location : "none",
                        theme_advanced_resizing : false,
	theme_advanced_source_editor_height: 400, 
	invalid_elements : "span",
		content_css : "./text_styles_admin.css",
extended_valid_elements : "iframe[src|width|height|name|align],script[src|type]",
theme_advanced_styles : 'Text=testo;Title=titolo', external_link_list_url : "lists/link_list.asp",	external_image_list_url : "lists/image_list.asp",
setup : function(ed) {
      ed.onLoadContent.add(function(ed, o) {
		
      });
   }	
});


}



function makePublic(field, val, ref) {
$.ajax({
  	url: "pubblica_oggetto.asp?campo="+field+"&pubb="+val+"&ref="+ref+"&ssid="+Math.floor(Math.random()*9999),
  	success: function(data) {
		actEdit='edit_page.asp?ref='+ref;
		getStructure();
	}});
}

getStructure = function () {

$.ajax({
url: "load_structure.asp?ssid="+Math.floor(Math.random()*9999),
  	success: function(data) {
txt=data.substring(0,data.indexOf("##$$##"));
admenu=data.substring(data.indexOf("##$$##")+6);
$('#structMenu').html(admenu);
$('#structureContainerTable').html(txt);

getOpened();
$('.loadSt').css('max-height',($(window).height()-300)+"px")
openEdit(actEdit);
setTimeout(function() {  setLimgs(); },100)


if ($('#selsections3').size()>0) getSlect('selsections3',maxlevs,'void(0)');


}});
}

function set_preview() {
if ($("#setPreview_site").size()==0) {
$('<iframe id="setPreview_site"></iframe><div id="closePreview" onclick="javascript:set_preview()">CHIUDI&nbsp;PREVIEW</div><div id="bgPreview" onclick="javascript:set_preview()"></div>').appendTo("body");
$("#setPreview_site").attr("src","set_preview.asp");
}
else {
$("#setPreview_site").remove();
$("#closePreview").remove();
$("#bgPreview").remove();
}}


getSlect = function (objdest, maxlev, doAct) {
if (loadedStructure.length==0) {
	if (maxlev.length==0) maxlev=4;
$.ajax({
  	url: "./jscripts/load_select_sections.asp?maxlevels="+maxlev+"&mode=unpublished",
success: function(data) {
loadedStructure=data;
setTimeout(function() { getSlect(objdest,maxlev,doAct); } ,100);

}});
} else {

$('#'+objdest+' option').remove();
$('#'+objdest).append('<option value="0">...</option>');
struct=loadedStructure.split("#");

	for (x=0; x<struct.length; x++) {
	getLev=struct[x].split(",");
	levRef=getLev[0];
	levName=getLev[1];
	levLev=getLev[2];

	var s = "";
			for (var i = 0; i < levLev; i++) {
				s += "|";
			}

	levName= s + " "+levName;
	if (parseInt(levLev)<parseInt(maxlev)) $('#'+objdest).append('<option value="'+levRef+'">'+levName+'</option>');
	
	if (x==struct.length-1) eval(doAct)

	}

if ($('#selsections3').size()>0 && $('#refRedir').size()>0) {
	if ($('#refRedir').val().length>0) $('#selsections3').val($('#refRedir').val());
}

}}