<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" NAME="CDO for Windows 2000 Library" -->
<!--METADATA TYPE="typelib" UUID="00000205-0000-0010-8000-00AA006D2EA4" NAME="ADODB Type Library" -->
<%
Response.codepage = 65001
Response.Charset = "utf-8"
%>
<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->
<%

load=request("load")
htmlbody=request("htmlbody")
test_email=request("test_email")
mailsubject=request("subject")
mode=request("mode")

if len(test_email)>0 then
	sendto=test_email
	issent=False
Else

issent=True
'sendto="newsletter@progettiamo.ch"

End if

HTML=htmlbody

If Len(sendto)>0 And Not mailSendDisabled Then

sendmailer="info@progettiamo.ch"
sendpassword="fjh76kUi$d"

%>
<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
<%
End if



'if issent=True then
If Len(sendto)=0 then
HTML=Replace(HTML,"'","''")
	SQL="UPDATE newsletter SET TE_testo='"&HTML&"', LO_sent=True, DT_sent=Now() WHERE ID="&load
	set record=connection.execute(SQL)
response.write"<script type=""text/javascript"">alert(""NEWSLETTER SALVATA""); parent.document.location='newsletter.asp';</script>"
else
response.write"<script type=""text/javascript"">alert(""NEWSLETTER TEST INVIATO A "&sendTo&"""); parent.document.location='newsletter.asp';</script>"
end if


response.end

connection.close
%>
