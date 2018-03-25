
makeComment = function(refmsg,refproject,mode) {

gtval=$('textarea.addComment').val()
if ($('textarea.addComment').hasClass('changed') && gtval.length>3) {
gtval=gtval.replace(/(?:\r\n|\r|\n)/g, '<br />');
$.ajax({
  type: "POST",
  url: "/project/addComments.asp?txtval="+gtval+"&load="+refmsg+"&refproject="+refproject+"&mode="+mode+"&ssid=" + Math.floor((Math.random()*111111)+1),
  dataType: 'html',
  timeout: 6000,
  error    : function(msg) {
	$('<p style="color:#ff0000;clear:both">'+str_generic_error+'</p>').appendTo($('div.comments div.blog:last'))
  },
  success    : function(msg) {
	if (msg=="NOTLOGGED")
	{
	$('<p style="color:#ff0000;clear:both">'+str_login_error+'</p>').appendTo($('div.comments div.blog:last'))
	} else {
	viewComments(refmsg,refproject)
	}
  }});

}
}

makeReplica = function(replicaObj,refmsg,refproject,mode) {
$('div.addreplica').remove()
$('input.replica').parent().css('height','25px')
$('input.replica').parent().css('margin-bottom','30px')
$('input.replica').css('display','inline')
$('<div class="addreplica" style="float:right; width:90%; margin-top:-25px;"><textarea class="addComment" style="height:70px" onfocus="if (!$(this).hasClass(\'changed\')) {$(this).val(\'\');$(this).addClass(\'changed\')}">'+str_add_replica+'</textarea><input type="button" class="bt" onclick="makeComment('+refmsg+','+refproject+','+mode+')" value="'+str_pubblica+'" style="float:right; margin-top:-4px; margin-right:-1px;"/></div>').appendTo(replicaObj.parent())
replicaObj.css('display','none')
replicaObj.parent().css('height','65px')
replicaObj.parent().css('margin-bottom','65px')
}

viewComments = function(refmsg,refproject) {

$('body.progetti div.pDesc').eq(5).removeClass("active")
$('body.progetti div.comments').remove()
$('<div class="pDesc comments"></div>').appendTo($('div.pCenter'))

$.ajax({
  type: "GET",
  url: "/project/getComments.asp?load="+refmsg+"&refproject="+refproject+"&ssid=" + Math.floor((Math.random()*111111)+1),
  timeout: 6000,
  error    : function(msg) {
	$('body.progetti div.comments').html('<p>'+str_generic_error+'</p>')
	$('body.progetti div.comments').css('display','inline')
  },
  success    : function(msg) {
      msg = msg.replace(/&lt;/g, '<');
      msg = msg.replace(/&gt;/g, '>');
      msg = msg.replace(/&amp;/g, '&');

      $('body.progetti div.comments').html(msg)
	$('body.progetti div.comments').css('display','inline')

	if ($('div.blogcontainer').size()>0)
	{
	minH=($('div.blogcontainer').innerHeight()+$('div.blogcontainer').position().top+$('div.comments').position().top+330)
	if ($('body.progetti div.pText').height()<minH) $('body.progetti div.pText').css('min-height',minH+"px")
	}

	setTimeout(function() { $('html,body').animate({scrollTop: $('body.progetti div.comments').offset().top-220},500)},200)
  }});


}


getEdit = function(dest,refProject,lobj) {
$('div.pText').css('height','100px')
$('div.pContainer').css('height','100px')
$("div.myprojectsFrame iframe").css("opacity","0.0")

$("html, body").animate({scrollTop: '160px'},200)

$("body.progetti div.pButton").not(lobj).css("color","#fff")
	$("body.progetti div.pButton").not(lobj).each(function() {
	$(this).find('img').attr('src',$(this).find('img').attr("longdesc"))
	})


	$("body.progetti div.pButton").removeClass("active, actfin")
	$("body.progetti div.edit").not('.fin').addClass("a"+$('#maincat').html())
	lobj.not('.fin').css("color",$('#maincolor').html())

	if (lobj.hasClass("fin")) {
		lobj.addClass("actfin")
		lobj.css("color","#292f3a")
		}


	lobj.removeClass("a"+$('#maincat').html())
	lobj.addClass("active")
	altImg=lobj.find('img').attr('rel')
	lobj.find('img').attr('src',altImg)

	$("div.myprojectsFrame iframe").attr("src","/project/project_make_"+dest+".asp?load="+refProject)
}


init_projectPage = function() {
$('body.progetti a.gImg').find('img').eq(0).hover(function() {$(this).attr('src','/images/thumb_picture.png')}, function() {$(this).attr('src','/images/vuoto.gif')})



$('body.progetti div.pButton').not('.edit').click(function() {
	actObj=$(this)
	var index = $("body.progetti div.pButton").index(this);
	$('body.progetti div.comments').remove()

	$('div.fancyLavb-container').remove();
	$('.btclgl').remove(); 
	$('div.fancyLavb-dots').remove()
	$("body.progetti div.pButton").not(actObj).css("color","#fff")
	$("body.progetti div.pButton").not(actObj).each(function() {
	$(this).find('img').attr('src',$(this).find('img').attr("longdesc"))
	})

	$("body.progetti div.pButton").removeClass("active")
	$("body.progetti div.pButton").removeClass("actfin")
	$("body.progetti div.pButton").not('.fin').addClass("a"+$('#maincat').html())
	actObj.not('.fin').css("color",$('#maincolor').html())
		if (actObj.hasClass("fin")) {
		actObj.addClass("actfin")
		actObj.css("color","#292f3a")
		}

	actObj.removeClass("a"+$('#maincat').html())
	actObj.addClass("active")
	$('body.progetti div.pLeft div.anchor').remove()
	addancres=$('body.progetti div.pDesc').eq(index).find('div.anchor').html()
	$('<div class="anchor">'+addancres+'</div>').appendTo($('body.progetti div.pLeft'))
	altImg=actObj.find('img').attr('rel')
	actObj.find('img').attr('src',altImg)
	$('body.progetti div.pDesc').removeClass("active")
	divTarget=$('body.progetti div.pDesc').eq(index)
	divTarget.addClass("active")
	divTarget.find('div.mm').stop().fadeIn()

	if (divTarget.html().indexOf("#$login$#")!=-1)
	{
	    gtDest=$('meta[property="og:url"]').attr('content')
	    if (gtDest.indexOf("/donate/")==-1) $('meta[property="og:url"]').attr('content',gtDest+"/donate/")
	    getLogin()
	    return;
	}




resizeProject(divTarget)
});





$('body.progetti div.pDesc div.mm').each(function() {
$(this).find('a.gImg').eq(0).css('display','inline')
})


for (xv=0; xv<$('body.progetti div.pDesc img.vImg').size(); xv++)
{
videoImg=$('body.progetti div.pDesc img.vImg').eq(xv)	
videoSrc=videoImg.attr("rel");
    
	getVideoImg(videoImg,videoSrc)

}

if ($('body').hasClass('progetti')) {
    
    doSharing();
	eval($('a.firstAction').attr('href'))
}


$('a.imgG').fancybox({
   	openEffect	: 'fade',
   	closeEffect	: 'none',
	nextEffect : 'fade',
prevEffect : 'none',
autoDimensions: false,
autoSize: false,
maxHeight: '75%',
maxWidth: '80%',
type: 'image',
autoResize: true,
padding:0,
beforeLoad : function(){
var url= $(this.element).attr("data-href");
this.href = url
 },

		helpers	: {
			overlay : {
            css : {
            'background' : 'rgba(255, 255, 255, 0.8)'
            }}
	}});



}

resizeProject = function(actobj) {
	hmin1=actobj.innerHeight()+230
	hmin2=$('body.progetti div.pRight').innerHeight()+200
	hmin3=(actobj.find('div.mm').size()*390/2)+170
	hMin=Math.max(hmin1,hmin2,hmin3)
	$('body.progetti div.pText').css('min-height',hMin+'px')
}

var xv=1
getVideoImg = function (videoImg, videoSrc) {
    videoSrc = videoImg.attr("rel");
    console.log(videoSrc);
    if (videoSrc.length > 0) {

        videoImg.hoverIntent(function () { $(this).attr('src', '/images/thumb_video.png') }, function () { $(this).attr('src', '/images/vuoto.gif') });
        videoImg.click(function () { videoOpen($(this)) })

        videoId = videoSrc;
        if (videoId.indexOf('/') != -1) videoId = videoId.substring(videoSrc.lastIndexOf("/") + 1)
        if (videoId.indexOf('?') != -1) videoId = videoId.substring(0, videoId.indexOf("?"))
        if (videoId.indexOf('&') != -1) videoId = videoId.substring(0, videoId.indexOf("&"))
        console.log(videoId);
        videoImg.attr("id", videoId);
        if (videoSrc.indexOf('vimeo.com') != -1) {
            //loadVimeoThumb(videoId,xv*500)
            loadVimeoThumb(videoImg, xv * 500)
        }

        if (videoSrc.indexOf('youtu') != -1) {
            videoImg.css('background-image', 'url(http://img.youtube.com/vi/' + videoId + '/hqdefault.jpg)');
        }


    }
}

setDonate = function() {
    $('#formDonate').submit(function(e) {
        e.preventDefault();
        gtVal=parseFloat($('#donation_value').val())
        gtProject=$('#refProject').val()
        gtProjectName=$('#refProjectName').val()
        minVal=parseFloat($('#minval').val())

        if (gtVal>0 && gtVal>=minVal)
        {
            $('.fDonate').remove()
            $('.fDImg').remove()
            $('.donationMaker').html(str_promise_sending);

            gtUrl="/setDonation.asp?load=" + gtProject + "&val=" + gtVal + "&projectname="+gtProjectName+"&ssid=" + Math.floor((Math.random()*111111)+1)
            $.ajax({
                url: gtUrl,
                error: function(msg){
                    $('.donationMaker').html('<p>'+str_generic_error+'</p>')
                },
                success: function(data){
	
	                if (data=='DONE')
	                {
	                    msgadd = str_promise_sent.replace('#',gtVal)
	                    $('.donationMaker').html('<p>' + msgadd + '</p>')
	                    setTimeout(function() { document.location=""+$('meta[property="og:url"]').attr('content'); },4000)
	                }

	                if (data=='LOGIN') {
	                    gtDest=$('meta[property="og:url"]').attr('content')
	                    if (gtDest.indexOf("/donate/")==-1) $('meta[property="og:url"]').attr('content',gtDest+"/donate/")
	                    getLogin()

	                }

                }
            });
        }
    })
}

confirmDonation = function (userlogged) {
    vVal = $('p.mmake input.sDonate').val();
    $('input.fDonate').attr('onfocus', 'this.blur()')
    $('.donationMaker p.cmake').remove();
    $('.donationMaker p.premake').css('display', 'inline-block');
    $('.donationMaker input.sDonate').css('display', 'none');
    str_promise_tmp = '';
    str_button_confirm = '<input type="button" class="sDonate" style="width:154px;display:inline-block;" value="' + str_annulla +
            '" onclick="noDonation()"/>&nbsp;&nbsp;<input type="button" class="sDonate" style="display:inline-block; width:154px" value="' + str_conferma +
            '" onclick="$(\'#formDonate\').submit()"/>';
    if (userlogged == 0) {
        str_promise_tmp = str_promise_pre;
        gtDest = $('meta[property="og:url"]').attr('content')
        if (gtDest.indexOf("/donate/") == -1) $('meta[property="og:url"]').attr('content', gtDest + "/donate/")
        str_button_confirm = '<a class="btn" style=" background: url(/images/btn_big_clear.png) left top no-repeat;clear:both;width:290px" href="#" onclick="$(\'#formDonate\').submit()">' + str_promise_conf_access + '</a>';
    }
    $('<p class="cmake cmakef">' + str_promise_conf + ' <b>' + $('input.fDonate').val() + '</b> Fr.?</p><p class="cmake" style="clear:both;font-size:12px; margin:10px 0px">' +
            str_promise_tmp + '</p><p class="cmake cmakef"><br/>' + str_button_confirm + '<br/><br/></p>').appendTo($('.donationMaker'))
    resizeProject($('div.pDesc').eq(4))

}

noDonation=function() {
$('.donationMaker p.cmake').remove()
$('.donationMaker p.mmake').css('display','inline-block')
$('input.fDonate').attr('onfocus','void(0)')
$('body.progetti img.fDImg').removeClass('fDImgActive')
$('.donationMaker').css('display','inline-block')
$('.donationMaker p.premake').css('display','none')
resizeProject($('div.pDesc').eq(4))

}


setDonation = function (inp, mode, userlogged) {
    $('body.progetti input.fDonate').removeClass('fActive')
    $('body.progetti img.fDImg').removeClass('fDImgActive')

    inVal = inp.val();
    regexp1 = /[^0-9\.\'\-\,]+/g
    if (regexp1.test(inVal)) {
        inVal = inVal.replace(regexp1, '');
        inVal = inVal.replace(/,/g, '.');
        inp.val(inVal)
    }
    inVal = inVal.replace(/,/g, '.');
    inVal = inVal.replace(/\'/g, '');
    inVal = inVal.replace(/.-/g, '.00');
    inVal = parseFloat(inVal)
    $('#donation_value').val(inVal)
    $('p.mmake input.sDonate').val($('input.sDonate').attr('rel') + " Fr. " + inVal)
    $('body.progetti img.fDImg').addClass('fDImgActive')

   
        $('.donationMaker').fadeIn(300, function () {
            confirmDonation(userlogged)
            })
    
    
    resizeProject($('div.pDesc').eq(4))
}


filterMM = function(mode,obj) {
$('div.fancyLavb-container').remove();
$('.btclgl').remove(); $('div.fancyLavb-dots').remove()
$('div.pDesc div.mm').not('.'+mode).css('display','none')
$('div.pDesc div.'+mode).stop().fadeIn(200)
$('body.progetti div.pLeft div.anchor a').removeClass('active')
$(obj).addClass('active')
}

toAnchor = function(ancre) {
$('html, body').animate({scrollTop: $('a[name="'+ancre+'"]').offset().top-50},800)
goToAnchor=$('a[name="'+ancre+'"]').position().top+45;
maxTop=$('body.progetti div.pCenter').innerHeight()-190-$('body.progetti div.pLeft div.anchor a').last().position().top
if (goToAnchor>maxTop) goToAnchor=maxTop;
$('body.progetti div.pLeft div.anchor').animate({marginTop: goToAnchor },600)
$('body.progetti div.pLeft div.anchor a').removeClass('active')
$('body.progetti div.pLeft #'+ancre).addClass('active')
}

addtoFavorites = function (pref) {
var data1 = {
project: pref
};


$.ajax({
  type: "POST",
  url: "/actions/favorite.asp",
  data: data1,
  timeout: 6000,
  success    : function(msg) {
  document.location=""+$('meta[property="og:url"]').attr('content')
  }});

}

doSharing = function () {

    

    if ($('#facebook').size() > 0) {
        shareUrl = $('meta[property="og:url"]').attr('content')
        $('#eml').click(function () {
            document.location = 'mailto:inserire@indirizzo.mail?subject=Progettiamo.ch&body=' + shareUrl
        })

        $('#googleplus').click(function () {
            gUrl = 'https://plus.google.com/share?url=' + encodeURIComponent(shareUrl)
            window.open(gUrl, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');
            return false;
        })

        $('#pinterest').click(function () {
            shareImage = $('meta[property="og:image"]').attr('content')
            shareDesc = $('meta[property="og:title"]').attr('content')

            gUrl = 'http://www.pinterest.com/pin/create/button/?url=' + encodeURIComponent(shareUrl) + "&media=" + encodeURIComponent(shareImage) + "&description=" + encodeURIComponent(shareDesc)
            window.open(gUrl, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');
            return false;
        })

        $('#facebook').sharrre({

            share: {
                facebook: true
            },
            template: '<a class="box" href="#"><div class="share"><span></span></div></a>',
            url: shareUrl,
            action:'like',
            enableHover: false,
            enableTracking: true,
            click: function (api, options) {
                api.simulateClick();
                api.openPopup('facebook');
                //alert('popup open');
            }
        });

        $('#twitter').sharrre({

            share: {
                twitter: true
            },
            template: '<a class="box" href="#"><div class="share"><span></span></div></a>',
            url: shareUrl,
            enableHover: false,
            enableTracking: true,
            click: function (api, options) {
                api.simulateClick();
                api.openPopup('twitter');
            }
        });

    }

}


$.fn.fancyLavb = function () {
		that = $(this)
		that.click(function(e) {
			e.preventDefault();
			mainPar=$(this).parent();
			var actThumbs=""
				mainPar.find(that).each(function(){
				gthref=$(this).attr("href")
				gttitle=$(this).attr("longdesc")
				actThumbs+="|"+gthref+'$$'+gttitle
				})
			mainPar.parent().find('div').css('display','none')
$('.btclgl').remove()
$('div.fancyLavb-dots').remove()
var actPageThumbs=0;

			$('<div class="fancyLavb-container"></div>').prependTo(mainPar.parent())

				actThumbs=actThumbs.split('|')
				$('<div class="fancyLavb-thumbs"><div></div></div>').prependTo($('div.fancyLavb-container'))

				if (actThumbs.length<3) $('div.fancyLavb-thumbs').css('display','none') 
				if (actThumbs.length>5)
				$('<div class="fancyLavb-dots"></div>').appendTo(mainPar.parent())

				{
				pageThumbs=Math.ceil((actThumbs.length-1)/4)

				for (y=1; y<=pageThumbs; y++)
				{
				$('<a><img/></a>').appendTo($('div.fancyLavb-dots'));
				}
				$('div.fancyLavb-dots a img').attr('src','/images/vuoto.gif')
				$('div.fancyLavb-dots a').click(function() {
				gtaInd=$(this).index('div.fancyLavb-dots a')
				$('div.fancyLavb-dots a').removeClass('active')
				$(this).addClass('active')
actPageThumbs=gtaInd
			sizeleft=$('div.fancyLavb-thumbs').width()
			newleft=sizeleft*gtaInd*-1
			$('div.fancyLavb-thumbs > div').animate({left: newleft},800)
				})
$('div.fancyLavb-dots a').eq(0).addClass('active')
			}
				
			$('<input type="button" class="bt btclgl" value="'+str_chiudi_gallery+'" style="margin:40px 0px 0px 42.5%" onclick="$(\'div.pButton\').eq(2).trigger(\'click\'); $(\'.btclgl\').remove(); $(\'div.fancyLavb-dots\').remove()"/>').appendTo(mainPar.parent())

				for (x=1; x<actThumbs.length; x++)
				{
				gtT=actThumbs[x].split('$$')
				$('<img src="/images/vuoto.gif" style="background-image:url('+gtT[0]+')" data-href="'+gtT[0]+'" longdesc="'+gtT[1]+'"/>').appendTo($('div.fancyLavb-thumbs > div'))
				}

			var actTumb=0; thumbSize=$('div.fancyLavb-thumbs > div img').size()

if (thumbSize>1) {
$('<div class="arrow back" rel="-1"></div>').prependTo($('div.fancyLavb-container'))
$('<div class="arrow next" rel="+1"></div>').prependTo($('div.fancyLavb-container'))
}

if (actThumbs.length>4 && $('div.fancyLavb-thumbs > div').innerWidth()>$('div.fancyLavb-thumbs').width()) {
$('<div class="arrow1 back1" rel="-"></div>').appendTo($('div.fancyLavb-container'))
$('<div class="arrow1 next1" rel="+"></div>').appendTo($('div.fancyLavb-container'))
}



			$('div.fancyLavb-container > div.arrow1').click(function() {
			gtmode=$(this).attr('rel')
			newPageThumbs=eval(actPageThumbs+gtmode+"1")

			if (newPageThumbs<0 || newPageThumbs>=pageThumbs) return
			$('div.fancyLavb-dots a').eq(newPageThumbs).trigger('click')

			})


			$('div.fancyLavb-container > div.arrow').click(function() {
			gtmode=$(this).attr('rel')
			newimg=eval(actTumb+gtmode);
			if (newimg<0) newimg=thumbSize-1;
			if (newimg==thumbSize) newimg=0;
			newimgPage=Math.ceil(newimg/4+0.1)-1
			$('div.fancyLavb-dots a').eq(newimgPage).trigger('click')

			$('div.fancyLavb-thumbs > div img').eq(newimg).trigger('click')
			})

			$('div.fancyLavb-thumbs > div img').hover(function() {$(this).attr('src','/images/over_thumb.png')}, function() {$(this).attr('src','/images/vuoto.gif')})

			$('div.fancyLavb-thumbs > div img').click(function() {
			thumb=$(this);
			gtIndex=thumb.index('div.fancyLavb-thumbs > div img')
			actTumb=gtIndex;
			newload=$('<div class="fancyLavb-image"></div>').prependTo($('div.fancyLavb-container'))
				tTitle=thumb.attr('longdesc')
				if (tTitle.length>0) tTitle="<p>"+tTitle+"</p>"

			$('<div class="fancyLavb-title"><div class="fancyLavb-titleBg"></div><div class="fancyLavb-titleTx"><span>'+(gtIndex+1) + "/"+ thumbSize+'</span>'+ tTitle+'</div></div>').appendTo($('div.fancyLavb-image'))
			$('<img/>').load(function() {
			$('div.fancyLavb-image').not(newload).fadeOut()
			newload.css('background-image','url('+this.src+')')
			newload.fadeIn()
				})
				.attr('src',thumb.attr('data-href'))
			})
			$('html, body').animate({scrollTop: $('div.fancyLavb-container').offset().top-200},400)

			$('div.fancyLavb-thumbs > div img').eq(0).trigger('click')
		})
	}


delNews = function(bref) {
gtref=$('#edRef').val()

if (confirm(str_del_news)) {
var data1 = {
load: gtref,
refb: bref
};

$.ajax({
  type: "POST",
  url: "/actions/del_news.asp",
  data: data1,
  timeout: 6000,
  success    : function() {
	document.location=""+document.location.href;

  }});
}
}

editNews = function(gload) {
gtref=$('#edRef').val()
viewFormAdd(gload)
}

viewFormAdd=function(gload) {
$('input.bt').parent().fadeOut(100); 
gtref=$('#edRef').val()
if (gload==0) gload="";

$('div.myprojectsFrame iframe').attr('src','/actions/project_update.asp?load='+gtref+'&edref='+gload+'&ssid=' + Math.floor((Math.random()*111111)+1));

$('.myprojectsFrame').fadeIn(100, function() {
resizeProject($('div.pDesc').eq(5))
	$("html, body").animate({scrollTop: $('.myprojectsFrame').offset().top -100 },200)

});

}

closeFormAdd=function() {
$('input.bt').parent().fadeIn(100); 
$('.myprojectsFrame').fadeOut(150, function() {
resizeProject($('div.pDesc').eq(5))
});
}