<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
server.scriptTimeout=3600

npref=Replace(Request.ServerVariables("HTTP_HOST"),".","")
npref=Replace(npref,"www","")
npref=Replace(npref,"preview","")
npref=Replace(npref,":","")
npref=Replace(npref,"distanze","")

nameprefix=npref&Day(Now())&Month(Now())&Right(Year(Now()),2)&Hour(Now())&Minute(Now())&Second(Now())

Set Upload = Server.CreateObject("Persits.Upload.1")
Upload.SetMaxSize 90000, True
Upload.Save 


tabadd=Upload.Form("table")
fieldF=Upload.Form("fieldF")
connectTable=Upload.Form("connectTable")
addFields=Upload.Form("addFields")
returnurl=Upload.Form("returnurl")
modeupl=Upload.Form("modeupl")

uploadsDirVar = imagespath
If tabadd="fails" Then uploadsDirVar = filespath
If tabadd="immagini" Then uploadsDirVar = imagespath
If tabadd="fails_prodotti" Then uploadsDirVar = filespath
If tabadd="_immagini_random" Then uploadsDirVar = imagespath
If tabadd="immagini_prodotti" Then uploadsDirVar = imagespath
If fieldF="AT_image" Then uploadsDirVar = imagespath
If fieldF="AT_file" Then uploadsDirVar = filespath



    SaveFiles = ""
	totfiles=""
	totfile=0
		
		for each File in Upload.Files
			totfile=totfile+1
			
			origName=File.FileName	
			
ext=Mid(origName,InstrRev(origName,"."))

newname=nameprefix&"_"&totfile&ext
File.SaveAs uploadsDirVar & newname
gSize=File.Size
totfiles=totfiles&","&nameprefix&"_"&totfile & ext&"#"& gSize

next




	If Len(tabadd)>0 And Len(fieldF)>0 And Len(totfiles)>0 Then

		totfiles=Split(totfiles,",")

		filesrefs=""
			For x=1 To UBound(totfiles)
			
			gFile=totfiles(x)
		gFile=Split(gFile,"#")
		fname=gFile(0)
		fsize=gFile(1)
		Session("fsize"&x)=Round(fsize/1000,0)

		If InStr(modeupl,"update")>0 Then
		modeupl=Split(modeupl,",")
		reffile=modeupl(1)
				fname=Replace(fname,"'","&#39;")

		SQL="UPDATE "&tabadd&" SET "&fieldF&"='"&fname&"' WHERE ID="&reffile
		set recordset=connection.execute(SQL)

		filesrefs=filesrefs&","&reffile
		
		Else
		SQL="INSERT INTO "&tabadd&" ("&fieldF&") values ('"&fname&"')"
		set recordset=connection.execute(SQL)

		SQL="SELECT MAX(ID) as ref1 from "&tabadd
		set recordset=connection.execute(SQL)

		filesrefs=filesrefs&","&recordset("ref1")
		End If
		
			Next

	End if


	If Len(connectTable)>0 Then
		connectTable=Split(connectTable,",")
		cnctTable=connectTable(0)
		cnctField=connectTable(1)
		cnctValue=connectTable(2)
		uploads=Split(filesrefs,",")

			For x=1 To UBound(uploads)
				gref=uploads(x)

				SQL="INSERT INTO "&cnctTable&" ("&cnctField&",CO_"&tabadd&") values ("&cnctValue&","&gref&")"
				If cnctTable="associa_ogg_files" Then SQL="INSERT INTO "&cnctTable&" ("&cnctField&",CO_"&tabadd&",CO_lingue) values ("&cnctValue&","&gref&","&Session("lang")&")"
				set recordset=connection.execute(SQL)
			Next
	End if


	If Len(addFields)>0 Then
		addFields=Split(addFields,",")
		uploads=Split(filesrefs,",")



		For y=0 TO UBound(addFields)
		namefield=addFields(y)
			For x=1 To UBound(uploads)
				gref=uploads(x)
			fieldValue=Upload.Form(namefield&"_"&x)
			If namefield="TA_grandezza" Then fieldValue=Session("fsize"&x)

				If Len(fieldValue)>0 Then
				fieldValue=Replace(fieldValue,"'","&#39;")
						SQL="UPDATE "&tabadd&" SET "&namefield&"='"&fieldValue&"' WHERE ID="&gref
						set recordset=connection.execute(SQL)
				End if
			Next
		Next
	End if


If InStr(returnurl,"linkDialog")=0 then
response.redirect(returnurl)
Else
%>
<html><body>
<script type="text/javascript">
parent.document.location="./jscripts/tinymce/plugins/advlink/link.htm?ssid="+Math.random();
</script>
</body></html>
<%
End if
%>