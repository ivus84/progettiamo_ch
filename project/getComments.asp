<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="/incs/load_language_vars.asp"-->
<%
    response.codepage=1252
load=request("load")
refproject=request("refproject")

SQL="SELECT * FROM p_description WHERE TA_type='update' AND LO_confirmed=True AND ID="&load&" AND CO_p_projects="&refProject&" ORDER BY DT_data DESC"
Set rec1=connection.execute(SQL)

If rec1.eof Then
Response.write"<p>"&str_no_element&"</p>"
Response.end
End if


if Not rec1.eof then
	dName=rec1("TA_nome")
	dContent=rec1("TX_testo")
	dTime=datevalue(rec1("DT_data"))
refD=rec1("ID")
	If Len(dContent)>0 Then dContent=Replace(dContent,Chr(34)&Chr(34),Chr(34))

	SQL="SELECT count(ID) as numcomments FROM p_comments WHERE LO_deleted=false AND CO_p_description="&refD
	Set rec2=connection.execute(SQL)
	numcomments=rec2("numcomments")

	Response.write "<div class=""blog"" style=""min-height:50px; padding-top:15px; width:97%""><p style=""margin-bottom:9px"" class=""tit"">"&dName&"</p><p style=""margin:0px;""><span><img src=""/images/ico_cal_blog.png"" style=""float:left; margin:0px 10px 0px 0px"" alt=""""/>"&dTime&"</span><span>"&numcomments&"<img src=""/images/ico_comment_blog.png"" alt=""""/></span><span><a href=""javascript:$('body.progetti div.pButton').eq(5).trigger('click')"">"&str_chiudi_commenti&"</a></span></p>"&Chr(10)&"<p style=""clear:left;margin-top:0px"">"&dContent&"</p>"
	
	Response.write "</div>"
	
If numcomments>0 Then
Response.write "<div class=""blog blogcontainer"" style=""width:97%;height:auto;display:inline-block;""><p style=""border-bottom:solid 1px #D7D9E1; margin:0px 0px 20px 0px; padding-bottom:5px;"">"&str_comments&"</p>"

	SQL="SELECT p_comments.*, registeredusers.TA_ente, registeredusers.TA_nome as nomeu, registeredusers.TA_cognome as cnomeu, registeredusers.AT_immagine as imgu FROM p_comments LEFT JOIN registeredusers ON p_comments.CO_registeredusers=registeredusers.ID WHERE p_comments.LO_deleted=false AND p_comments.CO_p_comments=0 AND p_comments.CO_p_description="&refD
	Set rec2=connection.execute(SQL)

	Do While Not rec2.eof
	imgusr="/images/ico_profile.png"
	imgadd=rec2("imgu")
	dTime=datevalue(rec2("DT_data"))	
	dTimeV=timevalue(rec2("DT_data"))	
	dTimeV=Mid(dTimeV,1,5)
	refcomment=rec2("ID")
	txtcomment=rec2("TX_testo")
	nomeutente=rec2("nomeu")&" "&rec2("cnomeu")
	If Len(nomeutente)<3 Then nomeutente=rec2("TA_ente")
	If Len(imgadd)>4 Then imgusr="/"&imgscript&"?path="&imgadd&"$84"

	adimg="<span style=""float:left;width:42px; height:42px; background:url("&imgusr&") center center no-repeat; background-size:42px auto; border-radius:20px""></span>"

	Response.write "<div class=""blog"" style=""margin-top:-10px; height:auto;"">"&adimg&"<p style=""float:left;margin:0px 0px 0px 20px;""><span><strong>"&nomeutente&"</strong></span><span><img src=""/images/ico_cal_blog.png"" style=""float:left; margin:0px 10px 0px 0px"" alt=""""/>"&dTime&"</span><span><img src=""/images/ico_time_comment.png"" style=""float:left; margin:0px 10px 0px 0px"" alt=""""/>"&dTimeV&"</span></p><p style=""clear:both;float:left; margin-top:-10px; margin-left:10%;border-bottom:solid 1px #D7D9E1; padding-bottom:20px; width:90%"">"&txtcomment&"</p></div>"

			SQL="SELECT p_comments.*, registeredusers.TA_ente, registeredusers.TA_nome as nomeu, registeredusers.TA_cognome as cnomeu, registeredusers.AT_immagine as imgu FROM p_comments LEFT JOIN registeredusers ON p_comments.CO_registeredusers=registeredusers.ID WHERE p_comments.LO_deleted=false AND p_comments.CO_p_comments="&refcomment&" AND p_comments.CO_p_description="&refD
			Set rec3=connection.execute(SQL)

			Do While Not rec3.eof
			imgusr="/images/ico_profile.png"
			imgadd=rec3("imgu")
			dTime=datevalue(rec3("DT_data"))	
			dTimeV=timevalue(rec3("DT_data"))	
			dTimeV=Mid(dTimeV,1,5)
			refcomment1=rec3("ID")
			txtcomment=rec3("TX_testo")
			
			nomeutente=rec3("nomeu")&" "&rec3("cnomeu")
			If Len(nomeutente)<3 Then nomeutente=rec3("TA_ente")

			If Len(imgadd)>4 Then imgusr="/"&imgscript&"?path="&imgadd&"$84"

			adimg="<span style=""float:left;width:42px; height:42px; background:url("&imgusr&") center center no-repeat;background-size:42px auto;  border-radius:20px""></span>"

			Response.write "<div class=""blog"" style=""margin-top:-10px; margin-left:12%; width:88%;height:auto;"">"&adimg&"<p style=""float:left;margin:0px 0px 0px 20px;""><span><strong>"&nomeutente&"</strong></span><span><img src=""/images/ico_cal_blog.png"" style=""float:left; margin:0px 10px 0px 0px"" alt=""""/>"&dTime&"</span><span><img src=""/images/ico_time_comment.png"" style=""float:left; margin:0px 10px 0px 0px"" alt=""""/>"&dTimeV&"</span></p><p style=""clear:both;float:left; margin-top:-10px; margin-left:11%;border-bottom:solid 1px #D7D9E1; padding-bottom:20px; width:89%"">"&txtcomment&"</p></div>"

			rec3.movenext
			loop

If Len(Session("logged_donator"))>0 Then 
Response.write "<div class=""blog"" style=""clear:both; height:25px; margin-bottom:30px;""><input type=""button"" class=""bt replica"" style=""background:#9ba1b3; float:right; margin-top:-25px;"" value="""&str_replica&""" onclick=""makeReplica($(this),"&load&","&refProject&","&refcomment&")""/></div>"
End if

	rec2.movenext
	loop
Response.write"</div>"
End if

	Response.write "<div class=""blog"" style=""width:97%;clear:both;padding-top:40px;height:auto;""><p>"&str_add_commento&"</p><p><textarea class=""addComment"" onfocus=""if (!$(this).hasClass('changed')) {$(this).val('');$(this).addClass('changed')}"">"&str_scrivi_commento&"</textarea><br/>"
	If Len(Session("logged_donator"))=0 Then  Response.write "<span style=""color:#9ba1b3;padding:0px; border-left:0px;"">"&str_mustlogin_commento&"</span>"
	Response.write "<input type=""button"" class=""bt"" onclick=""makeComment("&load&","&refProject&",0)"" value="""&str_pubblica&""" style=""float:right; margin-top:-5px; margin-right:-2px;""/></p></div>"

End if
%>
<%connection.close%>