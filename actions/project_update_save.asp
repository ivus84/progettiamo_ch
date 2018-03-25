<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche.asp"-->
<!--#INCLUDE VIRTUAL="./incs/load_language_notif.asp"-->


<%
ref=request("ref")
edref=request("edref")

If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT TA_nome,TA_email_ref FROM QU_projects WHERE ID="&ref&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
If Not rec.eof Then
pTitle=rec("TA_nome")
avvisa_mail=rec("TA_email_ref")

myTextarea=request("myTextarea")
title=request("title")
imgadd=request("imgadd")
embd=request("embd")

If Len(myTextarea)>0 And Len(title)>0 Then
myTextarea=Replace(myTextarea,"'","''")
title=Replace(title,"'","''")
myTextarea=Replace(myTextarea,"<p>","")
myTextarea=Replace(myTextarea,"</p>","<br/>")
myTextarea=Replace(myTextarea,Chr(34)&Chr(34),Chr(34))

If Len(embd)>0 Then
embd=Replace(embd,"'","''")
embd=Replace(embd,Chr(34)&Chr(34),Chr(34))
End If

If Len(edref)=0 then
SQL="INSERT INTO p_description (TA_type,CO_p_projects,LO_confirmed,TX_testo,TA_nome,AT_file,TX_embed) VALUES ('update',"&ref&",False,'"&myTextarea&"','"&title&"','"&imgadd&"','"&embd&"')"
Else
If Len(imgadd)>0 Then SQL="UPDATE p_description set TX_testo='"&myTextarea&"',TA_nome='"&title&"',LO_confirmed=False,AT_file='"&imgadd&"',TX_embed='"&embd&"' WHERE CO_p_projects="&ref&" AND ID="&edref
If Len(imgadd)=0 Then SQL="UPDATE p_description set TX_testo='"&myTextarea&"',TA_nome='"&title&"',LO_confirmed=False,TX_embed='"&embd&"' WHERE CO_p_projects="&ref&" AND ID="&edref
End If


Set rec=connection.execute(SQL)

If Len(edref)=0 then

mailsubject=str_subject_news
mailsubject=replace(mailsubject,"#project_name#",pTitle)	

HTML=str_txt_notifica_body&chr(10) & str_txtmail_news &chr(10)& str_txt_notifica_body_end
HTML=replace(HTML,"#project_name#",pTitle)
HTML=replace(HTML,"#news_title#",title)
HTML=replace(HTML,"#news_text#",myTextarea)

	if Not mailSendDisabled Then
	sendto = avvisa_mail
	%>
	<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
	<%
	end if


End if

End If
End If

End if
connection.close%>