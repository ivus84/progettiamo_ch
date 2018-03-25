<%
Set recFiles=connection.execute(SQL)
If Not recFiles.eof then

addattchsments=""

totfiles=0
allfiles=""
hfile=0

If session("loggedUserPro"&numproject)="logd"&Day(Now())&Month(Now())&numproject Then
	
	If Len(refsquadra)>0 then
		If tabsquadra="protected_files" And session("areaRis_admin")<>True Then
		
		else
		addDel=True
		End If
	Else
	If tabsquadra="protected_files" And session("areaRis_admin")=True Then addDel=True
	End If
End if

Do While Not recFiles.eof
totfiles=totfiles+1
nomef=recFiles("TA_nome")
reffile=recFiles("ID")
est=LCase(Right(nomef, 4))
titolof=recFiles("TA_titolo")
grandezza=recFiles("TA_grandezza")
If Len(titolof)=0 Or isnull(titolof) Then titolof = "File senza titolo"
If Len(est)>0 Then est=Replace(est,".","")

If Len(titolof)>0 Then  
titolof=Replace(titolof,"0Scheda","Scheda")
titolof=Replace(titolof,"&#39;","'")
titolofl=titolof
titolofl=Replace(titolofl,"Scheda",nome&" Scheda")
titolofl=linkMaker(titolofl)
End if
grandezzaw=""
if Len(grandezza)>0 And grandezza<>"0" then
grandezza=Replace(grandezza,",",".")
	if CInt(grandezza)>1000 then
	grandezzaw=""&Round(grandezza/1000,1)&" MB"
	else
	grandezzaw=""&grandezza&" KB"
	end if
end If

	
hplayertotsized=totsized+CInt(grandezza)
hfile=hfile+1
flink="document.location='download.asp?load="&nomef&"&amp;titolo="&titolofl&"';"

videoextensions=" flv , wmv , .rm , ram , .rv , mov , .qt , mp3 , mp4 , mp2 , mpa , mpe , mpeg , mpg , mpv2 , m4v ,"

Isvid=False
IF Instr(videoextensions, est)<>0 THEN Isvid=True




adimg="generic.png"
If est="pdf" Then adimg="pdf.png"
titolof = ConvertFromUTF8(titolof)
If InStr(titolof,"http://")=0 AND isvid=False Then

flink="onclick="""&flink&""" title="""&titolof&" "&grandezzaw&" "&est&""""

If session("loggedUserPro"&numproject)="logd"&Day(Now())&Month(Now())&numproject  And Len(refsquadra)>0 Then
	titolof="<a href=""javascript:void(0)"" "&flink&">"&titolof&"</a>"
	flink=""
End If

addattchsments=addattchsments& "<div class=""download"" "&flink&">"&titolof&"."&est&"<br/>("&grandezzaw&")</div>"
Else

	if isvid=true then
	titolof="<a class=""embdYtVid"" href=""javascript:void(0)"" onclick=""window.open('/videoEmbed.asp?"&nomef&"','','width=600,height=400')"">"&titolof&" "&est&"</a>"
	else

		videolink=titolof
		videolinkview=mid(videolink,8)
			if len(videolinkview)>33 then videolinkview=mid(videolinkview,1,30)&"..."
		titolof="<a class=""extLink"" href="""&videolink&""" target=""_blank"">"&videolinkview&"</a>"



		If InStr(videolink,"youtube")>0 Then 
		videoid=mid(videolink,instrrev(videolink,"?v=")+3)
		titolof="<a class=""embdYtVid"" href=""http://www.youtube.com/embed/"&videoid&"?autoplay=1&showinfo=0"">Youtube video</a>"
		''videopic="http://img.youtube.com/vi/"&videoid&"/0.jpg"
		End if

		If InStr(videolink,"vimeo.com")>0 Then 
		videoid=mid(videolink,instrrev(videolink,"/")+1)
		titolof="<a class=""embdYtVid"" href=""http://player.vimeo.com/video/"&videoid&"?autoplay=true"">Vimeo video</a>"
		End If
	end if

addattchsments=addattchsments& "<div class=""download"">"&titolof&"</div>"

End if
allfiles=allfiles&","&nomef
recFiles.movenext
Loop

End if%>