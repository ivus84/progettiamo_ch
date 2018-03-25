<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
ref=request("ref")
refp=request("refp")
newpos=request("newpos")

If Len(Session("logged_donator"))>0 And Session("projects_promoter")=True Then
SQL="SELECT * FROM p_projects WHERE ID="&refp&" AND CO_registeredusers="&Session("logged_donator")
Set rec=connection.execute(SQL)
	If Not rec.eof Then

	SQL="SELECT CO_p_description,IN_ordine FROM p_pictures WHERE CO_p_projects="&refp&" AND ID="&ref
	Set rec=connection.execute(SQL)
	refD=rec("CO_p_description")
	prevord=rec("IN_ordine")

	mode=0
	if prevord<cint(newpos) then mode=1

	SQL="UPDATE p_pictures SET IN_ordine="&newpos&" WHERE ID="&ref
	set record1=connection.execute(SQL)
	
	if mode=1 then
	SQL="SELECT * FROM p_pictures WHERE CO_p_description="&refD&" AND ID<>"&ref&" AND IN_ordine>="&prevord&" AND IN_ordine<="&newpos&" ORDER BY IN_ordine ASC"
	Else
	SQL="SELECT * FROM p_pictures WHERE CO_p_description="&refD&" AND ID<>"&ref&" AND IN_ordine>="&newpos&" ORDER BY IN_ordine ASC"
	End If
	
	set rec=connection.execute(SQL)

		do while not rec.eof
		ref1=rec("ID")
		ord1=rec("IN_ordine")
		if mode=0 Then ord1=ord1+1
		if mode=1 Then ord1=ord1-1

		if ord1<=0 then ord1=1
		
		SQL="UPDATE p_pictures SET IN_ordine="&ord1&" WHERE CO_p_description="&refD&" AND ID="&ref1
		set record2=connection.execute(SQL)
		rec.movenext
		loop

	End if

End if
connection.close%>