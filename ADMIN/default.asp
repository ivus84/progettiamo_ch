<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
if Session("log45"&numproject)<>"req895620schilzej" then
getProt=Request.ServerVariables("HTTPS")
getBrow=Request.ServerVariables("HTTP_USER_AGENT")
servname=Request.ServerVariables("HTTP_HOST")
If InStr(servname,"www.")=0 Then servname="www."&servname

If getProt<>"on" And InStr(servname,"lavb")=0 Then
    'Response.redirect("https://"&servname&"/admin/")
    'Response.end
End if

%>
<!--#INCLUDE VIRTUAL="./ADMIN/admin.asp"-->
<%
response.end
end If
connection.close

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_langref.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
<script type="text/javascript">

$(document).ready(function() {
$('.closeMenu').css('display','none');
$('.mMenu').css('display','none');
$('#screenMenu').fadeIn(400)
});
</script>
</body>
</html>