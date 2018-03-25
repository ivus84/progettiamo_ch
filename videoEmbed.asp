<!--#INCLUDE VIRTUAL="/incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_header.asp"-->
<script type="text/javascript" src="/js/video_functions.asp"></script>
</head>
<body style="margin:0px;background:transparent">
<%
wembed=request.querystring

If Len(wembed)>0 then

flink="javascript:viewVideoFile('"&wembed&"','embed');"

response.write "<div id=""vVideoAt"" style=""float:left;margin:0px;width:100%""></div>"&Chr(10)&"<script type=""text/javascript"" src=""/js/flowplayer-3.2.6.min.js""></script><script type=""text/javascript"" src=""/js/video_functions.asp""></script>"

End if

%>
<script type="text/javascript">
$(document).ready(function() {

<%=flink%>
});
</script>
<%connection.close%>
</body>
</html>