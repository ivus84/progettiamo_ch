<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%

urldest=request("returnurl")
tabadd=request("table")
fieldF=request("fieldF")
connectTable=request("connectTable")
addFields=request("addFields")
modeupl=request("modeupl")
fieldVal=request("fieldVal")

If InStr(modeupl,"update")>0 Then
		modeupl=Split(modeupl,",")
		reffile=modeupl(1)
		
		SQL="UPDATE "&tabadd&" SET "&fieldF&"='"&fieldVal&"' WHERE ID="&reffile
		set recordset=connection.execute(SQL)


		Else
		SQL="INSERT INTO "&tabadd&" ("&fieldF&") values ('"&fieldVal&"')"
		response.write SQL
		set recordset=connection.execute(SQL)

		SQL="SELECT MAX(ID) as ref1 from "&tabadd
		set recordset=connection.execute(SQL)

		reffile=recordset("ref1")
End If

if len(connectTable)>1 then
connectTable=Split(connectTable,",")
		cnctTable=connectTable(0)
		cnctField=connectTable(1)
		cnctValue=connectTable(2)
				SQL="INSERT INTO "&cnctTable&" ("&cnctField&",CO_"&tabadd&") values ("&cnctValue&","&reffile&")"
				If cnctTable="associa_ogg_files" Then SQL="INSERT INTO "&cnctTable&" ("&cnctField&",CO_"&tabadd&",CO_lingue) values ("&cnctValue&","&reffile&","&Session("lang")&")"
		response.write SQL
		set recordset=connection.execute(SQL)
end if

if len(addFields)>1 then
addFields=Split(addFields,",")

		For y=0 TO UBound(addFields)
		namefield=addFields(y)
		fieldValue=request(""&namefield)

		If Len(fieldValue)>0 Then
		fieldValue=Replace(fieldValue,"'","&#39;")
						SQL="UPDATE "&tabadd&" SET "&namefield&"='"&fieldValue&"' WHERE ID="&reffile
						set recordset=connection.execute(SQL)
		End if
			
		Next

end if


response.redirect(urldest)

connection.close
%>
