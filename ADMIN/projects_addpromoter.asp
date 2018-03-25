<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<!-- #include VIRTUAL = "./admin/clsSHA-1.asp" -->

<%

mail=request("mail")

If Len(mail)>0 Then 
	If Len(mail)<5 then
	%>
	<script type="text/javascript">
	alert("E-mail non valida\nSi prega di riprovare");
	history.back();
	</script><%

	Response.End
	End if
	If InStr(mail,"@")=0 OR InStr(mail,".")=0 Or Len(mail)<5 then
	%>
	<script type="text/javascript">
	alert("E-mail non valida\nSi prega di riprovare");
	history.back();
	</script><%

	Response.End
	End If
	
If Len(mail)>0 Then mail=LCase(mail)

	emailCheck = EnDeCrypt(mail, npass, 1)


	If Len(request("mode"))=0 Then
	SQL="SELECT * FROM registeredusers WHERE LO_projects=True AND (TA_email='"&emailCheck&"' OR  TA_email_recupero='"&emailCheck&"')"
	set rec=connection.execute(SQL)
	if not rec.eof then
	%>
	<script type="text/javascript">
	alert("E-mail già associata ad un altro utente\nSi prega di riprovare");
	history.back();
	</script><%
	response.end
	end if
	end if


	If Len(request("mode"))=0 Then
	SQL="SELECT * FROM registeredusers WHERE LO_projects=False AND (TA_email='"&emailCheck&"' OR  TA_email_recupero='"&emailCheck&"')"
	set rec=connection.execute(SQL)
	if not rec.eof then
	%>
	<script type="text/javascript">
	
	if (confirm('E-mail associata ad un utente finanziatore\nConvertirlo in account promotore?')) { 
document.location='projects_convertpromoter.asp?email=<%=mail%>&area=<%=request("area")%>';
} else { history.back(); }
	</script><%
	response.end
	end if
	end if

	If Len(request("mode"))>0 Then
	SQL="SELECT * FROM registeredusers WHERE (TA_email='"&emailCheck&"' OR  TA_email_recupero='"&emailCheck&"')"
	set rec=connection.execute(SQL)
	if not rec.eof then
	%>
	<script type="text/javascript">
	alert("E-mail già associata ad un altro utente\nSi prega di riprovare");
	history.back();
	</script><%
	response.end
	end if
	end if


If Session("adm_area")=0 Or isnull(Session("adm_area")) AND Len(request("mode"))=0 Then 
area=request("area")
If Len(area)=0 Then 
	%>
	<script type="text/javascript">
	alert("Definire area di riferimento");
	history.back();
	</script><%
	response.End
	End if
Else
area=Session("adm_area")
End If


pass=generatePassword(7)
pwd1=pass&numproject

Set ObjSHA1 = New clsSHA1
pwdck = ObjSHA1.SecureHash(pwd1)
Set ObjSHA1 = Nothing

If Len(area)=0 Or isnull(area) Then area=0
SQL="INSERT INTO registeredusers (TA_cognome,TA_email,TA_password,TA_password_iniziale,CO_p_area,LO_projects) VALUES (' Nuovo promotore','"&emailCheck&"','"&pwdck&"','"&pass&"',"&area&",True)"
If Len(request("mode"))>0 Then SQL="INSERT INTO registeredusers (TA_cognome,TA_email,TA_password,TA_password_iniziale,CO_p_area,LO_projects) VALUES (' Nuovo promotore','"&emailCheck&"','"&pwdck&"','"&pass&"',"&area&",False)"

Set rec=connection.execute(SQL)

SQL="SELECT ID FROM registeredusers WHERE TA_email='"&emailCheck&"'"
Set rec=connection.execute(SQL)
load=rec("ID")
%>
<p>Account creato</p>
<script>
setTimeout(function() {
<%If Len(request("mode"))=0 Then%>
parent.document.location='promoters.asp?load=<%=load%>&ssid=' + Math.floor((Math.random()*111111)+1);
<%else%>
parent.document.location='projects_sostenitori.asp?load=<%=load%>&ssid=' + Math.floor((Math.random()*111111)+1);
<%end if%>
},2000)

</script>
<%
Response.end

else
%>
<html>
<head>
</head>
<body style="font-family:arial; font-size:14px;" bgcolor="#efefef"><center>
<br><br><br><br>
<form action="projects_addpromoter.asp" method="post">
<input type="hidden" name="conferma" value="True"/>
<input type="hidden" name="mode" value="<%=request("mode")%>"/>
<center>
Inserire l'indirizzo e-mail per l'account
<br/><br/>
<input name="mail" style="width:290px; text-align:left;border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px; font-family:arial" maxlength="100"/>
<br/>
<%If Session("adm_area")=0 Or isnull(Session("adm_area")) And Len(request("mode"))=0 Then%>
<br/>Area<br/>
<select name="area" style="width:290px; border:solid 1px #292f3a; font-size:16px; height:37px; padding:5px"><option value="">...</option>
<%SQL="SELECT * FROM p_area"
Set rec=connection.execute(SQL)
Do While not rec.eof
refA=rec("ID")
addsl=""
If refA&""=area&"" then addsl=" selected=""selected"""
Response.write "<option value="""&refA&""""&addsl&">"&rec("TA_nome")&"</option>"
rec.movenext
loop%>
</select><br/><br/>
<%End if%>

<input type="button" value="ANNULLA" onclick="document.location='blank1.asp'"/>
<input type="submit" value="CONFERMA"/>
</form>
</body></html>
<%end If
connection.close%>