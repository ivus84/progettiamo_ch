<%
className="homeSlideshow"
If Session("islogged" & numproject)="hdzufzztKJ89ei" Then
    className=""%>
<%End if%>
<div class="<%=className%>" >
    
	<%
   
    linkbanner = ""
    if len(session("linkbanner")) > 0  then linkbanner = session("linkbanner")
 

	Session("banner_added")=""
	If Len(Session("homebanner"))>3 And Len(Session("banner_added"))=0 Then
	    Session("banner_added")="done"
	    %>
       
        <div class="homeBanner">
            <a href="/?<%=linkbanner %>/"> <img alt="" src="/<%=imgscript%>?path=<%=Session("homebanner")%>$1920" style="border:0px"/></a>
        </div>

	<%End if%>

   
	<div class="slide">
		<div class="container">
		</div>
	</div>
    
    <p class="dots"></p>
    <script>

    </script>
<ul>
<%
numadded=0  
if className<>"" Then Response.write "<li><a href=""javascript:void(0)"" onclick=""getProjectsHome(0,$(this))"" class=""active"">" & str_evidenza & "</a></li>"
%>
</ul>
</div>