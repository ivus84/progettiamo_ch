<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->

<%

load=request("load")
tab=request("tab")
valt=request("val")

	If valt="True" then
	maxnum=4
	If tab="LO_newsletter" Then maxnum=1

		If Session("adm_area")>0 Then 
			//SQL="SELECT COUNT(ID) as num FROM p_projects WHERE "&tab&"=True AND CO_p_area="&Session("adm_area")
            SQL="SELECT COUNT(ID) as num FROM p_projects WHERE "&tab&"=True AND LO_deleted = False and CO_p_area="&Session("adm_area")
			Set rec=connection.execute(SQL)
			num=rec("num")

				If num>=maxnum then
				%>
			<script>
			    alert("Numero massimo raggiunto per <%=mid(tab,4)%>")
			    //alert("<%=SQL%>")
				parent.document.location='projects.asp?vMode=<%=mid(tab,4)%>&ssid=' + Math.floor((Math.random()*111111)+1);

				</script>
				<%
				Response.end
				End If
		End If

	End if

SQL="UPDATE p_projects SET "&tab&"="&valt&" WHERE ID="&load
Set rec=connection.execute(SQL)


%>
	<script>
    <% if valt then %>
	alert("progetto impostato <%=mid(tab,4)%>")
    <% else %>
    alert("progetto rimosso <%=mid(tab,4)%>")
    <%end if %>
	setTimeout(function() {
	parent.document.location='projects.asp?vMode=<%=mid(tab,4)%>&ssid=' + Math.floor((Math.random()*111111)+1);
	},500)

	</script>
	
<%
connection.close%>