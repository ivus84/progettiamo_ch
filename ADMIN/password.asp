<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<%
titletop="<script>document.write(menu13);</script>"

SQL="SELECT TA_admin_language FROM utenticantieri WHERE ID="&Session("IDuser")
set rec=connection.execute(SQL)
if not rec.eof then
lang=rec("TA_admin_language")
if len(lang)=0 then lang="en"
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
 <div id="content_page">

<p class="titolo"> <%=titletop%></p>
<form action="password1.asp" method="POST"><br/>
<table>
<tr><td class="testoadm">Password*</td><td><input type="password" class="testoadm" name="actual_password"/></td></tr>
<tr><td class="testoadm">New Password*</td><td><input type="password"  class="testoadm" name="new_password"/></td></tr>
<tr><td class="testoadm">Confirm new Password*</td><td><input type="password" class="testoadm" name="cnew_password"/></td></tr>

<%allowchangel=False
if allowchangel=True then%>
<tr><td class="testoadm">Admin language</td><td><select class="testoadm" maxlength="10" name="TA_admin_language">
<option value="en" <%if lang="en" then%>selected<%end if%>>en</option>
<option value="de" <%if lang="de" then%>selected<%end if%>>de</option>
<option value="it" <%if lang="it" then%>selected<%end if%>>it</option></select></tr><%else%>
<input type="hidden" name="TA_admin_language" value="<%=lang%>"/><%end if%>
<tr><td class="testoadm"></td><td><input type="submit" class="testoadm" maxlength="10" value="SAVE"/></td></tr>


</select></td></tr>

</form>
</div>
<%end if%>
<script type="text/javascript">
$(document).ready(function() {
$('.mMenu').not('.hMenu').eq(5).addClass('active');
})
</script>

</body>
</html>
