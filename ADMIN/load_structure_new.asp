<div style="clear:both; height:15px"></div>

<div id="structMenu"></div>	
<div id="structureContainerTable"></div>

<%
If Len(request("viewMode"))>0 Then srcf=request("viewMode")
If Len(request("viewMode1"))>0 Then srcf=srcf&"?viewmode="&request("viewMode1")
if srcf="edit_page.asp" then srcf=srcf&"?ref="&session("ref")
if len(srcf)=0 AND len(session("ref"))>0 then srcf=srcf&"edit_page.asp?ref="&session("ref")

%>
<div id="mainEdit" style="margin-top:0px;"></div>


<script type="text/javascript">
var chkbs=",";
var maxlevs=5;
var loadedStructure="";
var actEdit='<%=srcf%>';

$(document).ready(function() {
getStructure();
});


</script>