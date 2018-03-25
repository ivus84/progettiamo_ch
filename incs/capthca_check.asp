<%
val1=request("val")
If val1=Session("checkcaptcha") Then
Response.write "OK"
Response.End
End If
%>