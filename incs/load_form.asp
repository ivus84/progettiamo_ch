<%
Session("titlepage_form")=titolo


addform="<form id=""anm_"&formref&""" class=""cForm"" style=""clear:both; margin:5px 0px 25px 0px"">"

SQL="SELECT * from formulari WHERE ID="&formref
set rec=connection.execute(SQL)

if not rec.eof then

addform=addform&chr(10)&"<div class=""fContain"">"&chr(10)

message=rec("TX_message")
inidatadef=rec("TX_datadef")
text_oblig=rec("TX_text_oblig")

addform=addform&"<input type=""hidden"" name=""CO_formulari"" value="""&formref&"""/>"
addform=addform&"<input type=""hidden"" name=""CO_oggetti"" value="""&load&"""/>"
addform=addform&"<input type=""hidden"" name=""titlepage"" value="""&titolo&"""/>"
addform=addform&"<input type=""hidden"" name=""TX_datadef"" value="""&inidatadef&"""/>"



Session("message_after_form")=rec("TX_message_after_send")

if len(text_oblig)=0 or isnull(text_oblig)=True then text_oblig=""



addform=addform&"<div class=""testo"">"
if len(message)>1 then addform=addform&""&message&"<br/><br/>"
if len(text_oblig)>1 then addform=addform&text_oblig&"<br/><br/>"
addform=addform&"</div>"

datadef=Split(Mid(inidatadef,1,len(inidatadef)-1),"#")

for x=LBound(datadef) to UBound(datadef)
field_n=datadef(x)

field_def=Split(field_n,"|")
fieldcheck="False"

fieldname=field_def(0)
fieldvalue=field_def(1)
fieldmand=field_def(2)
fieldmult=field_def(3)
if UBound(field_def)>3 then
fieldcheck=field_def(4)
end if
if UBound(field_def)>4 then fieldcheckm=field_def(5)
if UBound(field_def)>5 then fieldselect=field_def(6)

bg1="FFFFFF"
if fieldmand="True" then
add1="*"
classmand="class=""obl"""
fieldname="<b>"&fieldname&"</b>"
else
add1=""
classmand=""
end if

If instr(fieldname,"mail") And fieldmand Then classmand="class=""obl eml"""



If InStr(fieldvalue,"CO_") Then
gttab=Mid(fieldvalue,4)
SQL="SELECT * FROM "&gttab&" ORDER BY IN_ordine"
Set rec=connection.execute(SQL)
fieldselect1="True"
addselect1="<select name=""formfield_"&x&""" style=""width:117.5%;"""&classmand&"><option value="""">...</option>"
Do While Not rec.eof
addselect1=addselect1&"<option value="""&rec("TA_email_ref")&""" class=""testo"">"&rec("TA_nome")&"</option>"
rec.movenext
Loop
addselect1=addselect1&"</select>"
End If

if fieldcheck="True" then
if len(fieldvalue)>0 then
checkvals=Split(fieldvalue,"/")
addradio=""
for y=Lbound(checkvals) TO UBound(checkvals)
addradio=addradio&"<span style=""float:right; width:80px; min-width:80px""><input type=""radio"" name=""formfield_"&x&""" value="""&checkvals(y)&""" style=""float:left;margin-top:-3px;"""&classmand&"/>"&checkvals(y)&"</span>"
Next

end if
end if

if fieldcheckm="True" then
if len(fieldvalue)>0 then
checkvals=Split(fieldvalue,"/")
addchkbox=""
for y=Lbound(checkvals) TO UBound(checkvals)
addchkbox=addchkbox&"<input type=""checkbox"" name=""formfield_"&x&""" value="""&checkvals(y)&""""&classmand&"/> "&checkvals(y)&"<br/>"
Next

end if
end if


if fieldselect="True" then
if len(fieldvalue)>0 then
checkvals=Split(fieldvalue,"/")
addselect="<select name=""formfield_"&x&""""&classmand&"><option value="""">...</option>"
for y=Lbound(checkvals) TO UBound(checkvals)
addselect=addselect&"<option value="""&checkvals(y)&""" class=""testo"">"&checkvals(y)&"</option>"
Next
addselect=addselect&"</select>"
end if
end if



addform=addform&"<label class=""container""><span>"&ConvertFromUTF8(fieldname&add1)&"</span>"

if fieldmult="True" Then
addform=addform&Chr(10)&"<textarea name=""formfield_"&x&""" style=""height:200px;padding-top:10px;"""&classmand&">"&fieldvalue&"</textarea>"&Chr(10)
elseif fieldcheck="True" and len(fieldvalue)>0 then
addform=addform&addradio
elseif fieldcheckm="True" and len(fieldvalue)>0 then
addform=addform&addchkbox
elseif fieldselect="True" and len(fieldvalue)>0 then
addform=addform&addselect
elseif fieldselect1="True" and len(fieldvalue)>0 then
addform=addform&addselect1
else
addform=addform&"<input name=""formfield_"&x&""" value="""&ConvertFromUTF8(fieldvalue)&""" maxlength=""255"""&classmand&"/>"

end if

addform=addform&"</label>"&chr(10)
n=n+1
Next
sendl="INVIA"
sendl_1="SEND"
sendl_2="SENDEN"

addform=addform&"<div class=""container"">"&_
"<p><img src=""/img_captcha.asp"" class=""cptch"" width=""120"" height=""42"" style=""120px; height:42px; background-color:#fff; float:left; margin:0px""/>"&_
"	<img src=""/images/refresh.png"" style=""float:left; height:42px; cursor:pointer;"" onclick=""refreshCaptcha()""/>"&_
"	<input type=""text"" name=""cptch"" value="""" class=""str cp""/>"&_
"	<img src=""/images/check.png"" class=""chch"" style=""float:left; height:42px;""/>"&_
"	<span style=""float:right; font-size:12px; line-height:14px;margin:8px 20px 10px 10px; padding:0px 0px 0px 0px; width:125px;text-align:left; clear:right"">Copiare il codice<br/>dell'immagine a lato</span><br/>"&_
"</p>"

addform=addform&"	<input type=""text"" class=""sb"" value=""Invia richiesta"" style=""cursor:pointer; width:286px;float:left:clear:both;"" onfocus=""this.blur()"" onclick=""$('#anm_"&formref&"').submit()""/><input name=""submm"" type=""submit""style=""width:1px; height:1px;opacity:0;visibility:hidden""/></div></div></form>"


end if%>