<%
nobg=True
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<center><br/><br/>
COMANDO ESEGUITO<br>
</center>
</body>
<script type="text/javascript">
 function chkClose() {

 if (parent.document.form2)
 {
 parent.document.form2.submit(); 
closeThis();
  return;
}

 if (window.opener.document.form2)
 {
 window.opener.document.form2.submit(); 
 self.close();
 return;
 }
 
  
 
 }

 setTimeout("chkClose();",1000);
</script>