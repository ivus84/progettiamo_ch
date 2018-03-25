<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="/incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_header.asp"-->
<%
load=request("load")
pname=request("pname")
If Session("islogged"&numproject)="hdzufzztKJ89ei" And  Session("projects_promoter")=True Then

SQL="SELECT QU_comments.* FROM QU_comments INNER JOIN QU_projects ON QU_comments.refproject=QU_projects.ID WHERE QU_projects.CO_registeredusers="&Session("logged_donator")&" AND QU_projects.ID="&load&" ORDER BY DT_data DESC"
Set rec=connection.execute(SQL)


%>
<body class="fancyPage">
<div class="titPage"><span>Gestione commenti progetto <%=pname%></span></div>
<div style="width:95%">
<%
If rec.eof Then Response.write "<p style=""padding:10px 10px 20px 10px; border-bottom:solid 1px"">Nessun commento al progetto</p>"
Do While Not rec.eof
testo=rec("TX_testo")
nn=rec("ID")
user_n=rec("TA_ente")&" "&rec("TA_cognome")&" "&rec("user_n")
data=rec("DT_data")
news=rec("news")

If Len(testo)>0 Then testo=ClearHTMLTags(testo,0)

If Len(testo)>250 Then testo=Mid(testo,1,250)&" ..."

%>
<p style="padding:10px 10px 20px 10px; border-bottom:solid 1px">Commento di <%=user_n%> il <%=DateValue(data)%> sulla news <b><%=news%></b> <br/>
Commento: <i><%=testo%></i><input type="button" value="ELIMINA" onclick="deleteComment(<%=nn%>)" style="float:right; border:0px; background:#292f3a; color:#fff; padding:10px 20px; width:60px; cursor:pointer"/>
</p>
<%

rec.movenext
loop%>
</div>
<script type="text/javascript">
$(document).ready(function() {
setTimeout(function() {
$('.fancybox-close', parent.document).css('display','none');
$('.fancybox-close', parent.document).addClass('fancybox-close-alt');
$('.fancybox-close-alt', parent.document).removeClass('fancybox-close');
$('.fancybox-close-alt', parent.document).css('display','inline');
},300)
})

deleteComment = function(load) {
if (confirm("ELIMINARE IL COMMENTO?\nVerranno eliminate anche eventuali risposte al commento"))
{
$.ajax({
  url: "/project/deleteComments.asp?load="+load+"&ssid=" + Math.floor((Math.random()*111111)+1),
  success: function(data){
	  if (data=="OK")
	  {
		document.location="/getCommentsEdit.asp?load=<%=load%>&pname=<%=pname%>"
	  } else {
	  alert("Spiacenti.\nNon e' stato possibile eliminare il commento.")
	  }
  }});
} else {}
}

</script>
</body>
</html>
<%
End If
connection.close%>