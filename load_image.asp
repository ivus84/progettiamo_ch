<!--#INCLUDE VIRTUAL="./config/dbconfig.asp"-->
<%
photoPath=Request("path")

Response.Expires = 86400
Response.CacheControl = "Public"
Response.AddHeader "PRAGMA", "CACHE"

immagine=mid(photoPath,1,instr(photoPath,"$")-1)

width=mid(photoPath,instr(photoPath,"$")+1)
if IsNumeric(width) then
width = Cint(width)
else
width= 1
end if 
ext=LCase(Mid(immagine,InstrRev(immagine,".")+1))

If InStr(immagine,"@") Then 
bw=1
immagine=Replace(immagine,"@","")
End If

if width>2000 then width=2000

if width<=2000  then

	cnt="image/"&ext
	if ext="jpg" then cnt="image/jpeg"

	thumbsaved=imagespath&"thumbs\"&width&"_" & immagine
	immaginepr=projectspath&immagine
	immaginefs=filespath&immagine
	immagine=imagespath&immagine



	Set fs=Server.CreateObject("Scripting.FileSystemObject")
	getThumb=True

	If (fs.FileExists(immagine))=False Then immagine=immaginepr
	If (fs.FileExists(immagine))=False Then immagine=immaginefs

	If (fs.FileExists(thumbsaved))=False Then getThumb=False

	if getThumb=True then immagine = thumbsaved
    
	If (fs.FileExists(immagine)) and ext <> "pdf" then
		response.contenttype = cnt


		Set Jpeg = Server.CreateObject("Persits.Jpeg")
		Jpeg.Open( immagine )

		if bw=1 then Jpeg.Grayscale 1
		if ext="png" then Jpeg.PNGOutput = True
		if getThumb=False then 
		Jpeg.Width =  width
		Jpeg.Height = Jpeg.OriginalHeight * Jpeg.Width / Jpeg.OriginalWidth
		Jpeg.Quality = 100
		Jpeg.Interpolation = 1
		end if
		if getThumb=False then Jpeg.Save thumbsaved
	Jpeg.SendBinary
	Set Jpeg = nothing
end If
set fs = nothing
end If


%>
