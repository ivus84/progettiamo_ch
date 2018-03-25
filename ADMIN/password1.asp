<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<!-- #include VIRTUAL = "./admin/clsSHA-1.asp" -->
<%


actual_password=request("actual_password")
new_password=request("new_password")
cnew_password=request("cnew_password")
TA_admin_language=request("TA_admin_language")
SQL="UPDATE utenticantieri SET TA_admin_language='"&TA_admin_language&"' WHERE ID="&Session("IDuser")
set rec=connection.execute(SQL)
wwrite="Admin language: "&TA_admin_language
addwrite="The password was not changed"


Session("adminlanguageactive")=TA_admin_language

if len(actual_password)>0 AND len(new_password)>3 AND new_password=cnew_password AND instr(new_password,"'")=0 then

pwd0=actual_password&numproject

Dim ObjSHA1

Set ObjSHA1 = New clsSHA1
StrDigest0 = ObjSHA1.SecureHash(pwd0)
Set ObjSHA1 = Nothing

SQL="SELECT * FROM utenticantieri WHERE TA_password='"&StrDigest0&"' AND ID="&Session("IDuser")
set rec=connection.execute(SQL)
if not rec.eof then

pwd1=new_password&numproject

Set ObjSHA1 = New clsSHA1
StrDigest = ObjSHA1.SecureHash(pwd1)
Set ObjSHA1 = Nothing



SQL="UPDATE utenticantieri SET TA_password='"&StrDigest&"' WHERE ID="&Session("IDuser")
set rec=connection.execute(SQL)

addwrite="Password successfully changed"

end if
end if

addwrite=addwrite&"<br/><br/>"&wwrite

titletop="<script>document.write(menu13);</script>"

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
 <div id="content_page" style="position:absolute;left:180px;width:800px;top:120px">

<b><%=titletop%></b>
<br/><br/><span class="testoadm">
<%=addwrite%></span></div>
</body>
</html>
