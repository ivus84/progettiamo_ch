<!--#INCLUDE VIRTUAL="/incs/load_connection.asp"-->
<%

load=request("load")
If Len(Session("logged_donator"))>0 then
SQL="SELECT * FROM registeredusers WHERE ID="&Session("logged_donator")&" AND Instr(TX_rated,',"&load&",')>0"
Set rec=connection.execute(SQL)
%>
<!DOCTYPE html>
<html lang="it">
<head><title>Progettiamo.ch - Il Ticino insieme - Crowdfunding promosso dagli Enti Regionali per lo Sviluppo del Canton Ticino</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="/css/styles.1.css" media="all" />
<script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
<link rel="shortcut icon" href="/prog.ico" />
<meta name="robots" content="noindex"/>
</head>
<body class="progetti" style="background:#fff;text-align:left; width:90%; padding:0px 4%">
<div class="pText">
<%If rec.eof then%>
<p><%=str_vota_progetto%></p>
<p>

				<div style="position:relative; margin-top:15px; margin-left:0%; height:24px; text-align:left; width:95%; left top no-repeat;">
<%For x=0 To 4
Response.write "<img src=""/images/star.png"" class=""star"" style=""position:absolute; top:0px; left:"&x*28&"px; cursor:pointer"" onmouseover=""overStars("&x&")"" onmouseout=""noverStars()"" onclick=""makeVote("&(x+1)&","&load&")""/>"
next%>

				</div>

</p>
<%else%>
<p><%=str_gia_votato_progetto%></p>
<%End if%>
</div>
<script type="text/javascript">
 $(document).ready(function() {
$('<div>'+$('div.pInfo',parent.document).html()+'</div>').prependTo('div.pText')
})

noverStars = function(gg) {
$('img.star').attr('src','/images/star.png')
}


overStars = function(gg) {
for (x=0; x<=gg; x++)
{
	$('img.star').eq(x).attr('src','/images/star_over.png')

}
}

makeVote = function (vote, project) {

$('img.star').attr('onmouseout','void(0)')
$('img.star').attr('onmouseover','void(0)')

var data1 = {
vote: vote, 
project: project
};

var msgVoted="<%=str_vota_messaggio%>"
$.ajax({
  type: "POST",
  url: "/actions/vote.asp",
  data: data1,
  timeout: 6000,
  success    : function(msg) {
$('div.pText p').remove();
msgVoted=msgVoted.replace('#rate#',vote)
$('<p>'+msgVoted+'</p>').appendTo('div.pText')
setTimeout(function() {parent.$.fancybox.close( true )},4000)
  }});
}
 </script>
 </body>
</html>
<%End if
connection.close%>