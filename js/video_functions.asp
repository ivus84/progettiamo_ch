var prevContent=$("#txtContent").html();
var serverloc = "http://<%=Request.ServerVariables("HTTP_HOST")%>";
var mode="replaceText";

function addFP(file) {
$("#vVideoAt").html('');
if (file.indexOf('mp3')==-1) {

$f("vVideoAt", "/videoplayers/flowplayer-3.2.7.swf", {
playlist: [ {
			url: file, 
			autoPlay: true, 
			autoBuffering: true,
			provider: 'pseudo'
		}
 ],
 plugins: {	pseudo: { url: '/videoplayers/flowplayer.pseudostreaming-3.2.7.swf' }, 

	controls: {
		url: '/videoplayers/flowplayer.controls-3.2.5.swf',
		opacity: 0.6,
		timeColor: '#ffffff',durationColor:	'#ff0000',progressColor:	'#d8d6d6',progressGradient:	'low',bufferColor:	'#efefef',bufferGradient:	'medium',sliderColor:	'#000000',buttonColor:	'#f4f4f4',  buttonOverColor:	'#ff0000', autoHide: { fullscreenOnly: false, hideDelay: 20000} , backgroundColor: '#000000'}},
	
	clip: {
		onStart: function(clip) {this.setVolume(50); }
	}  

});
} else {
$f("vVideoAt", "/videoplayers/flowplayer-3.2.7.swf", {
 plugins: {
		audio: {
			url: '/videoplayers/flowplayer.audio-3.2.2.swf'
		}
	}, 

	clip: {
		url: file,
		coverImage: { url: '../img.asp?path=w_empty1.jpg', scaling: 'scale' },
		provider: "audio"
	}
});

}
}


function viewVideoFile(fvideo,modex) {
ftype=fvideo.substring(fvideo.length-3).toLowerCase();
$('#vPlayer').html('');

file=serverloc+"/load_video.aspx?nome="+fvideo;
quickvideo="mov,.qt";
flashvideo="flv,m4v,mpg,mp4,mp3";
winvideo="wmv,wma,mp2,mpa,mpe,mpeg,mpg,mpv2";
realvideo=".rm,ram,.rv";



if ($('#vVideoAt').length==0) {
$('#vPlayer').html('');
ifr = $('<div id="vVideoAt" style="width:100%;height:100%"></div>').appendTo($('#vPlayer'));


}

var obj=$('#vVideoAt');
obj.html('');

if(modex=='embed') {
obj.width($(window).width());
hplayer=$(window).height()-10;
wplayer=obj.width()
} else {
wplayer=obj.width();
hplayer=parseInt((wplayer/4)*2.5);

}


obj.css("height",hplayer+"px");


if (quickvideo.indexOf(ftype)!=-1) {
file="/videoplayers/load_video_file.asp?nome="+fvideo;

createplayerMov='<div><object classid=\"clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B\" codebase=\"http://www.apple.com/qtactivex/qtplugin.cab\" width=\"'+wplayer+'\" height=\"'+hplayer+'\" align=\"center\"><param name=\"allowScriptAccess\" value=\"sameDomain\" /><param name=\"src\" value=\"'+file+'\" /><param name=\"controller\" value=\"true\" /><param name=\"autoplay\" value=\"true\" /><param name=\"pluginspage\" value=\"http://www.apple.com/QuickTime/download/\" /><param name=\"wmode\" value=\"transparent\" /><embed src=\"'+file+'\" menu=\"false\" controller=\"true\" autoplay=\"true\" bgcolor=\"#FFFFFF\" width=\"'+wplayer+'\" height=\"'+hplayer+'\" align=\"center\" allowScriptAccess=\"sameDomain\" pluginspage=\"http://www.apple.com/QuickTime/download/indext.html\" /></object></div>';}

if (winvideo.indexOf(ftype)!=-1) {
createplayerWin='<OBJECT ID=\"Player\" width=\"'+wplayer+'\" height=\"'+hplayer+'\" CLASSID=\"CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6\"><PARAM name=\"autoStart\" value=\"True\"><PARAM name=\"URL\" value\="'+file+'\"></OBJECT>';}
if (realvideo.indexOf(ftype)!=-1) {
createplayerReal='<object id=\"player\" classid=\"clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA\" width=\"'+wplayer+'\"  height=\"'+hplayer+'\"><param name=\"CONTROLS\" value=\"imagewindow\"> <param name=\"AUTOGOTOURL\" value=\"FALSE\"><param name=\"CONSOLE\" value=\"radio\"><param name=\"AUTOSTART\" value=\"TRUE\"><param name=\"SRC\" value=\"'+file+'\"><embed name=\"player\" type=\"audio/x-pn-realaudio-plugin\" height=\"'+hplayer+'\" width=\"'+wplayer+'\"  autostart=\"true\" console=\"radio\" controls=\"ImageWindow\" src=\"'+file+'\"></object><br/><OBJECT ID=\"player\" CLASSID=\"clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA\" HEIGHT=30 WIDTH=\"'+wplayer+'\"><PARAM NAME=\"controls\" VALUE=\"ControlPanel\"><PARAM NAME=\"console\" VALUE=\"radio\"><EMBED type=\"audio/x-pn-realaudio-plugin\" CONSOLE=\"radio\" CONTROLS=\"ControlPanel\" HEIGHT=30 WIDTH=\"'+wplayer+'\" AUTOSTART=true></OBJECT>';}

if (flashvideo.indexOf(ftype)!=-1) {

addFP(file);
}



if (quickvideo.indexOf(ftype)!=-1) obj.html(createplayerMov);
if (winvideo.indexOf(ftype)!=-1) obj.html(createplayerWin);
if (realvideo.indexOf(ftype)!=-1) obj.html(createplayerReal);
}