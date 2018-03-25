<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<%

mail=request("email")
area=request("area")

	emailCheck = EnDeCrypt(mail, npass, 1)


	SQL="SELECT * FROM registeredusers WHERE LO_projects=False AND (TA_email='"&emailCheck&"' OR  TA_email_recupero='"&emailCheck&"')"
	'Response.write SQL
	set rec=connection.execute(SQL)
	if not rec.eof then
	
	refid=rec("ID")
	SQL="UPDATE registeredusers SET LO_projects=True WHERE ID="&refid
	set rec=connection.execute(SQL)
	If Len(Session("adm_area"))>0 Then
		SQL="UPDATE registeredusers SET CO_p_area="&Session("adm_area")&" WHERE ID="&refid
		Else
		If Len(area)=0 Or isnull(area) Then area=0
		SQL="UPDATE registeredusers SET CO_p_area="&area&" WHERE ID="&refid
	End if
		set rec=connection.execute(SQL)
%>
<p style="font-family:arial">ACCOUNT CONVERTITO IN PROMOTORE</p>
<script>
setTimeout(function() {
parent.document.location='promoters.asp?load=<%=refid%>&ssid=' + Math.floor((Math.random()*111111)+1);
},2000)

</script>
<%
Response.end
End if
connection.close%>