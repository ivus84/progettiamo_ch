<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!--#INCLUDE VIRTUAL="./config/txts_notifiche.asp"-->
<!--#INCLUDE VIRTUAL="./incs/load_language_notif.asp"-->
<%
load=request("load")
refproject=request("refproject")
mode=request("mode")
txtval=request("txtval")

If Len(Session("logged_donator"))=0 Then 
Response.write"NOTLOGGED"
Response.End
End if

txtval=Replace(txtval,"'","''")
txtval=Replace(txtval,Chr(10),"<br/>")

	SQL="INSERT INTO p_comments (TX_testo,CO_registeredusers,CO_p_description,CO_p_comments) VALUES ('"&txtval&"',"&Session("logged_donator")&","&load&","&mode&")"
	Set rec2=connection.execute(SQL)

	SQL="SELECT MAX(ID) as lastcomment FROM p_comments WHERE CO_registeredusers="&Session("logged_donator")
	Set rec2=connection.execute(SQL)
lastcomment=rec2("lastcomment")

	SQL="SELECT QU_projects.*,QU_comments.news as newstitle FROM QU_comments INNER JOIN QU_projects ON QU_projects.ID=QU_comments.refproject WHERE QU_comments.ID="&lastcomment
	Set rec3=connection.execute(SQL)

projectname=rec3("TA_nome")

TA_email_ref=rec3("TA_email_ref")
TA_email=rec3("TA_email")
newstitle=rec3("newstitle")

donatorEmail = EnDeCrypt(TA_email, npass, 2)
sendtobcc = TA_email_ref

HTML=str_txt_notifica_body&chr(10) & str_notifica_commento &chr(10)& str_txt_notifica_body_end
mailsubject=str_subject_commento

HTML=replace(HTML,"#project_name#",projectname)
HTML=replace(HTML,"#news_title#",newstitle)

mailsubject=replace(mailsubject,"#project_name#",projectname)

HTML=replace(HTML,"#txt_comment#",txtval)

If Not mailSendDisabled Then
sendTo=donatorEmail
%>
<!--#INCLUDE VIRTUAL="./incs/load_mailcomponents.asp"-->
<%
end if

connection.close%>