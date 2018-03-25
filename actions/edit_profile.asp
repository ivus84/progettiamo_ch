<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->

<%


Response.CharSet = "UTF-8"
If Len(Session("logged_donator"))>0 Then

encryptedFields="TA_telefono,TA_natel"

getform=request.form
If Len(getform)>0 Then getform=Replace(getform,"%2F","/")
If Len(getform)>0 Then getform=Replace(getform,"%3A",":")
'If Len(getform)>0 Then getform=Replace(getform,"%2B","+")

If Len(getform)>0 then
getform=Split(getform,"&")

SQL="UPDATE registeredusers SET "
For x=0 To Ubound(getform)
gtval=getform(x)
gtval=Split(gtval,"=")
nval=gtval(0)
vval=gtval(1)
If Len(vval)>0 Then vval=Replace(vval,"+"," ")
If Len(vval)>0 Then vval=Replace(vval,"%2B","+")
If Mid(nval,1,3)="CO_" OR Mid(nval,1,3)="IN_" AND isnumeric(vval) Then SQL=SQL&nval&"="&vval&", "

If Mid(nval,1,3)="DT_" Then 
vvalg=split(vval,".")
SQL=SQL&nval&"=#"&vvalg(1)&"/"&vvalg(0)&"/"&vvalg(2)&"#, "
End if

If Mid(nval,1,3)="TA_" Then 
If Len(vval)>0 Then vval=Replace(vval,"'","''")

If InStr(encryptedFields,nval) Then 
vval = EnDeCrypt(vval, npass, 1)
Else
vval = URLDecode(vval)
End if

SQL=SQL&nval&"='"&vval&"', "
End if

Next
SQL=SQL&"LO_updated=True WHERE ID="&Session("logged_donator")
Set rec=connection.execute(SQL)

Session("lang")=request("CO_lingue")
	If Session("lang")>0 Then 
		Session("reflang")="_"&Session("lang")
	Else
		Session("reflang")=""
	End If

Session("langref")=request("TA_lang")

Response.write "OK"
End if
End if
connection.close%>