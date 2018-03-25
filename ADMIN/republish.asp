<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->

 <div id="content_page" style="position:absolute;left:16px;top:100px;white-space:nowrap;width:100%;border:0">
<%
ref=request("ref")
ref1=request("ref1")

if len(ref1)=0 then

text_it="Selezionare la sezione in cui pubblicare la pagina"
text_de="Bitte w&auml;hlen Sie den Publikationsbereich"
text_en="Please select the Section for publishing"

textwrite=Eval("text_"&Session("adminlanguageactive"))
%>
<%=textwrite%> 
<select name="ref3" id="ref3" class="testoadm" style="width:300px" onchange="document.location='republish.asp?ref=<%=ref%>&ref1='+this.options[this.selectedIndex].value;">
</select>
<%
else


SQL="UPDATE oggetti set lo_pubblica=False, lo_deleted=False where ID="&ref
set recordset3=connection.execute(SQL)

SQL="INSERT INTO defsections (CO_oggetti,CO_oggetti_) VALUES ("&ref1&","&ref&")"
set recordset3=connection.execute(SQL)
''response.redirect("edit_page.asp?ref="&ref)

response.redirect("main.asp?viewMode=edit_page.asp?ref="&ref)
response.end
end if
connection.close
%>
</div>
<script type="text/javascript">
var maxlevs=3;
var loadedStructure="";

$(document).ready(function() {
getSlect('ref3', maxlevs,'void(0)');
});
</script>