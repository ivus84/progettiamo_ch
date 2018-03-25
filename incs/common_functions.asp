


<%
    Response.CharSet = "ISO-8859-1"
Response.CodePage = 28591
Function StringToBytes(Str,Charset)
  Dim Stream : Set Stream = Server.CreateObject("ADODB.Stream")
  Stream.Type = 2
  Stream.Charset = Charset
  Stream.Open
  Stream.WriteText Str
  Stream.Flush
  Stream.Position = 0
  Stream.Type = 1
  StringToBytes= Stream.Read
  Stream.Close
  Set Stream = Nothing
End Function

Function BytesToString(Bytes, Charset)
    
  Dim Stream : Set Stream = Server.CreateObject("ADODB.Stream")
  Stream.Charset = Charset
  Stream.Type = 1
  Stream.Open

  Stream.Write Bytes
  Stream.Flush
  Stream.Position = 0
  Stream.Type = 2
  BytesToString= Stream.ReadText
  Stream.Close
  Set Stream = Nothing
End Function
   
Function AlterCharset(Str, FromCharset, ToCharset)
    Dim Bytes
    Bytes = StringToBytes(Str, FromCharset)
    'VB:Questa funzione in test andava in errore
    On Error Resume Next
    AlterCharset = BytesToString(Bytes, ToCharset)
   
    If Err.Number <> 0 Then AlterCharset=Str
End Function



Function setCifra(num) 
If Len(num)>0 Then
num=FormatNumber(num)
num=Replace(num,",",".")
If InStr(num,".") Then
If Mid(num,InStrRev(num,"."))=".00" Then  num = Mid(num,1,InStrRev(num,"."))&"-"
End if

End If
setCifra=num
End function

Function getVideoSrc(gtemb)
If InStr(gtemb,"src=") Then
gtemb=Replace(gtemb,Chr(34)&Chr(34),Chr(34))
gtemb=Mid(gtemb,InStr(gtemb,"src=")+5)
gtemb=Mid(gtemb,1,InStr(gtemb,"""")-1)

		If InStr(gtemb,"youtube") Then
			If InStr(gtemb,"?") Then gtemb=gtemb&"&amp;rel=0&amp;showinfo=0amp;controls=auto"
			If Not InStr(gtemb,"?") Then gtemb=gtemb&"?rel=0&amp;showinfo=0amp;controls=auto"
		End If
		
		If InStr(gtemb,"vimeo") Then
			If InStr(gtemb,"?") Then gtemb=gtemb&"&amp;title=0&amp;byline=0&amp;portrait=0&amp;color=292f3a"
			If Not InStr(gtemb,"?") Then gtemb=gtemb&"?title=0&amp;byline=0&amp;portrait=0&amp;color=292f3a"
		End If


End if
getVideoSrc=gtemb
End Function

Function HEXCOL2RGB(HexColor)
    if not isNull (HexColor)  then
Color = Replace(HexColor, "#", "") 
Red = CLng("&H" & Mid(Color, 1, 2)) 
Green = CLng("&H" & Mid(Color, 3, 2))
Blue = CLng("&H" & Mid(Color, 5, 2))
HEXCOL2RGB = Red&","&Green&","&Blue
    end if
End Function



Function mailString(gtstr)
nomemail = gtstr
if Len(nomemail)>0 Then
nomemail=Replace(nomemail,"é","&eacute;")
nomemail=Replace(nomemail,"è","&egrave;")
nomemail=Replace(nomemail,"à","&agrave;")
nomemail=Replace(nomemail,"á","&aacute;")
nomemail=Replace(nomemail,"ò","&ograve;")
nomemail=Replace(nomemail,"É","&Eacute;")
nomemail=Replace(nomemail,"È","&Egrave;")
nomemail=Replace(nomemail,"ù","&ugrave;")
nomemail=Replace(nomemail,"ì","&igrave;")
nomemail=Replace(nomemail,"ê","&ecirc;")
nomemail=Replace(nomemail,"Ê","&Ecirc;")
nomemail=Replace(nomemail,"Ü","&Uuml;")
nomemail=Replace(nomemail,"ü","&uuml;")
nomemail=Replace(nomemail,"Ä","&Auml;")
nomemail=Replace(nomemail,"ä","&auml;")
nomemail=Replace(nomemail,"Ö","&Ouml;")
nomemail=Replace(nomemail,"ö","&ouml;")
nomemail=Replace(nomemail,"'"," ")
nomemail=Replace(nomemail,Chr(34),"")
End if
mailString=nomemail
End function

Function linkMaker(gtlink)
nomelink = gtlink
If Len(nomelink)>0 Then
nomelink=Trim(nomelink)
nomelink=replace(nomelink,"'","-")
nomelink=replace(nomelink,".","")
nomelink=replace(nomelink,",","")
nomelink=replace(nomelink,"<br/>","-")
nomelink=replace(nomelink,"/"," ")
nomelink=replace(nomelink,Chr(34),"")
nomelink=replace(nomelink,"&amp;","-")
nomelink=replace(nomelink,"&#39;","-")
nomelink=replace(nomelink,"&#45;"," ")
nomelink=Replace(nomelink,"é","e")
nomelink=Replace(nomelink,"è","e")
nomelink=Replace(nomelink,"à","a")
nomelink=Replace(nomelink,"á","a")
nomelink=Replace(nomelink,"ò","o")
nomelink=Replace(nomelink,"ù","u")
nomelink=Replace(nomelink,"ì","i")
nomelink=Replace(nomelink,"ê","e")
nomelink=Replace(nomelink,"Ê","e")
nomelink=Replace(nomelink,"Ü","ue")
nomelink=Replace(nomelink,"ü","ue")
nomelink=Replace(nomelink,"Ä","ae")
nomelink=Replace(nomelink,"ä","ae")
nomelink=Replace(nomelink,"Ö","oe")
nomelink=Replace(nomelink,"ö","oe")
nomelink=Replace(nomelink,"&","")
nomelink=Replace(nomelink,"#","")
nomelink=Replace(nomelink,"!","")
nomelink=Replace(nomelink,"?","")
nomelink=server.urlencode(nomelink)
nomelink=replace(nomelink,"%5F","_")

stripChars="%2F,%2D,%E2,%80,%93,%94,%99,%A0,%A6,%C2,%AB,%BB,%2B,%3B,%9C,%9D,%26,%C3,%A2,%22,%3A,%A8,%40,%41"
stripChars=split(stripChars,",")

for i=0 To UBound(stripChars) 
	nomelink=Replace(nomelink,stripChars(i),"")
Next


nomelink=replace(nomelink,"%","")
nomelink=replace(nomelink,"+","-")
nomelink=replace(nomelink,"--","-")
nomelink=LCase(nomelink)
End if
linkMaker=nomelink
End function

function replSpec(vStringa)

If Len(vStringa)>0 Then
vStringa = Replace(vStringa, Chr(34),"\""")
vStringa = Replace(vStringa, Chr(10),"")
vStringa = Replace(vStringa, Chr(128),"&euro;")

y=0
While y<32
vStringa = Replace(vStringa, Chr(y),"")
y=y+1
Wend

End If

replSpec=vStringa
end Function
Public Function URLEncodeNew( StringVal )
  Dim i, CharCode, Char, Space
  Dim StringLen

  StringLen = Len(StringVal)
  ReDim result(StringLen)

  Space = "+"
  'Space = "%20"

  For i = 1 To StringLen
    Char = Mid(StringVal, i, 1)
    CharCode = AscW(Char)
    If 97 <= CharCode And CharCode <= 122 _
    Or 64 <= CharCode And CharCode <= 90 _
    Or 48 <= CharCode And CharCode <= 57 _
    Or 45 = CharCode _
    Or 46 = CharCode _
    Or 95 = CharCode _
    Or 126 = CharCode Then
      result(i) = Char
    ElseIf 32 = CharCode Then
      result(i) = Space
    Else
      result(i) = "&#" & CharCode & ";"
    End If
  Next
  URLEncodeNew = Join(result, "")
End Function
Function URLDecode(sConvert)
    Dim aSplit
    Dim sOutput
    Dim I
    If IsNull(sConvert) Then
       URLDecode = ""
       Exit Function
    End If
   sOutput = REPLACE(sConvert, "+", " ")
   If InStr(sOutput,"%") Then
   aSplit = Split(sOutput, "%")

    If IsArray(aSplit) Then
      sOutput = aSplit(0)
      For I = 0 to UBound(aSplit) - 1
        sOutput = sOutput & _
          Chr("&H" & Left(aSplit(i + 1), 2)) &_
          Right(aSplit(i + 1), Len(aSplit(i + 1)) - 2)
      Next
    End If
End if
    URLDecode = sOutput
End Function
'    FUNCTION URLDecode(str)
'// This function:
'// - decodes any utf-8 encoded characters into unicode characters eg. (%C3%A5 = å)
'// - replaces any plus sign separators with a space character
'//
'// IMPORTANT:
'// Your webpage must use the UTF-8 character set. Easiest method is to use this META tag:
'// <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
'//
 '   Dim objScript
 '   Set objScript = Server.CreateObject("ScriptControl")
 '   objScript.Language = "JavaScript"
 '   URLDecode = objScript.Eval("decodeURIComponent(""" & str & """.replace(/\+/g,"" ""))")
 '   Set objScript = NOTHING
'END FUNCTION

function generatePassword(passwordLength)
sDefaultChars="abcdefghijklmnopqrstuvxyz-!+ABCDEFGHIJKLMNOPQRSTUVXYZ0123456789"
iPasswordLength=passwordLength
iDefaultCharactersLength = Len(sDefaultChars)
Randomize
For iCounter = 1 To iPasswordLength
iPickedChar = Int((iDefaultCharactersLength * Rnd) + 1)
sMyPassword = sMyPassword & Mid(sDefaultChars,iPickedChar,1)
Next
generatePassword = sMyPassword
End Function



Function formatData(strDate,mode)
    if isdate(strDate) then
	    If mode=0 Then strDate=Month(strDate)&"/"&Day(strDate)&"/"&Year(strDate)
	    If mode=1 Then strDate=Day(strDate)&"."&Month(strDate)&"."&Year(strDate)
	    If mode=2 Then 
	    gDay=Day(strDate)
	    gMonth=Month(strDate)
	    If gDay<10 Then gDay="0"&gDay
	    If gMonth<10 Then gMonth="0"&gMonth
	    strDate=gDay&"."&gMonth&"."&Year(strDate)
	    End if
    end if
    formatData=strDate
End Function


Function getYouTubePic(strEmbed)
	if len(strEmbed)>0 and instr(strEmbed,"http://")>0 then
		strEmbed = mid(strEmbed, instr(strEmbed,"http://"))
		strEmbed = mid(strEmbed, 1, instr(strEmbed,chr(34))-1)
		strEmbed = mid(strEmbed, instrrev(strEmbed,"/")+1)
		if instr(strEmbed,"?")>0 then strEmbed = mid(strEmbed, 1, instr(strEmbed,"?")-1)
		strEmbed="http://img.youtube.com/vi/"&strEmbed&"/mqdefault.jpg"
	end if
getYouTubePic=strEmbed
	End Function

Function setYouTubeMovie(strEmbed)
	if len(strEmbed)>0 and instr(strEmbed,"http://")>0 then
		strEmbed = mid(strEmbed, instr(strEmbed,"http://"))
		strEmbed = mid(strEmbed, 1, instr(strEmbed,chr(34))-1)
		strEmbed = mid(strEmbed, instrrev(strEmbed,"/")+1)
		if instr(strEmbed,"?")>0 then strEmbed = mid(strEmbed, 1, instr(strEmbed,"?")-1)
strEmbed="<iframe src=""http://www.youtube.com/embed/"&strEmbed&"?rel=0&autoplay=1&controls=1&showinfo=0&wmode=transparent&autohide=1"" frameborder=""0"" allowfullscreen></iframe>"
	end if
setYouTubeMovie=strEmbed
	End Function

function truncateTxt2(strHTML, maxlength)
    if len(strHTML)>maxlength then
        truncateTxt2 = left(strHTML, maxlength) & "..."
    end if
end function

	Function truncateTxt(strHTML, maxlength)
	    originalLength = len(strHTML) 
		if len(strHTML)>maxlength then
		'strHTML=ClearHTMLTags(strHTML,0)
		    isemptyright=False
			do while isemptyright=False
			    if maxlength=len(strHTML) then isemptyright=True
			    strHTML1=Mid(strHTML,1,maxlength)
			    if right(strHTML1,1)=" " AND InStr(right(strHTML1,2),",")=0 AND InStr(right(strHTML1,3)," e")=0 then
			        isemptyright=True
			        strHTML=Trim(strHTML1)
			    end if
			    maxlength=maxlength+1
			loop
		end if
        if originalLength = len(strHTML) then
            truncateTxt=strHTML
        else
            truncateTxt=strHTML&"..."
        end if
	End Function
	
	function ClearHTMLTags(strHTML, intWorkFlow)
	If IsNull(strHTML) Then strHTML=""
		
		dim regEx, strTagLess
		
		strTagless = strHTML
		set regEx = New RegExp 

		regEx.IgnoreCase = True
		regEx.Global = True

		if intWorkFlow = 0 then
		
			regEx.Pattern = "<[^>]*>"
			strTagLess = regEx.Replace(strTagLess, " ")
			strTagLess = replace(strTagLess,"&nbsp;"," ")						
			strTagLess = replace(strTagLess,Chr(10)," ")						
		end if
		

		
		
		set regEx = nothing
		ClearHTMLTags = strTagLess
	end function
    Function AddSlashes(input)
    AddSlashes = replace(input,"\","\\")
    AddSlashes = replace(AddSlashes,"'","\'")
    AddSlashes = replace(AddSlashes,chr(34),"\" & chr(34))
End Function
    sub log ( Text, Data ) 

    end sub

    function dton ( data)
         dton = year(data) & month(data) & day(data) & hour(data) & minute ( data) & second(data) 
    end function 


    sub setLangNotif(lang)
    getlangnotif = lang
    If getlangnotif="it" then
	%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_it.asp"-->
	<%elseif getlangnotif="fr" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_fr.asp"-->
	<%elseif getlangnotif="de" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_de.asp"-->
	<%elseif getlangnotif="en" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche_en.asp"-->
	<%elseif getlangnotif="di" then%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche.asp"-->
    <%else%>
	<!--#INCLUDE VIRTUAL="/config/txts_notifiche.asp"-->
	<%End if
    end sub
    function setDonation(proj, val, proj_name)
    gotopage= site_mainurl
    gotopage=gotopage&"/setDonation.asp?load="&proj&"&val="&val&"&projectname="&proj_name&"&ssid="&Rnd
    setDonation = GetTextFromUrl(gotopage)
    end function
    Function GetTextFromUrl(url)

  Dim oXMLHTTP
  Dim strStatusTest

  Set oXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP.3.0")

  oXMLHTTP.Open "GET", url, False
  oXMLHTTP.setRequestHeader "Cookie", Request.ServerVariables ("HTTP_COOKIE")
  oXMLHTTP.Send

  If oXMLHTTP.Status = 200 Then

    GetTextFromUrl = oXMLHTTP.responseText

  End If

End Function

Function HTMLDecodeSimple(sText)
    if isNull(stext)  then 
	    HTMLDecodeSimple = ""
	else
        Dim regEx
        Dim matches
        Dim match
        sText = Replace(sText, "&quot;", Chr(34))
        sText = Replace(sText, "&lt;"  , Chr(60))
        sText = Replace(sText, "&gt;"  , Chr(62))
        sText = Replace(sText, "&amp;" , Chr(38))
        sText = Replace(sText, "&nbsp;", Chr(32))
    end if
    HTMLDecodeSimple = sText
End Function

Function HTMLDecode(sText)
    if isNull(stext)  then 
	    HTMLDecode = ""
	else
        Dim regEx
        Dim matches
        Dim match
        sText = Replace(sText, "&quot;", Chr(34))
        sText = Replace(sText, "&lt;"  , Chr(60))
        sText = Replace(sText, "&gt;"  , Chr(62))
        sText = Replace(sText, "&amp;" , Chr(38))
        sText = Replace(sText, "&nbsp;", Chr(32))
        sText = Replace(sText, "&iexcl;", Chr(161))
        sText = Replace(sText, "&pound;", Chr(163))
        sText = Replace(sText, "&yen;", Chr(165))
        sText = Replace(sText, "&copy;", Chr(168))
        sText = Replace(sText, "&laquo;", Chr(171))
        sText = Replace(sText, "&raquo;", Chr(187))
        sText = Replace(sText, "&iquest;", Chr(191))
        sText = Replace(sText, "&Agrave;", Chr(192))
        sText = Replace(sText, "&Aacute;", Chr(193))
        sText = Replace(sText, "&Acirc;", Chr(194))
        sText = Replace(sText, "&Atilde;", Chr(195))
        sText = Replace(sText, "&Auml;", Chr(196))
        sText = Replace(sText, "&Aring;", Chr(197))
        sText = Replace(sText, "&AElig;", Chr(198))
        sText = Replace(sText, "&Ccedil;", Chr(199))
        sText = Replace(sText, "&Egrave;", Chr(200))
        sText = Replace(sText, "&Eacute;", Chr(201))
        sText = Replace(sText, "&Ecirc;", Chr(202))
        sText = Replace(sText, "&Euml;", Chr(203))
        sText = Replace(sText, "&Igrave;", Chr(204))
        sText = Replace(sText, "&Iacute;", Chr(205))
        sText = Replace(sText, "&Icirc;", Chr(206))
        sText = Replace(sText, "&Iuml;", Chr(207))
        sText = Replace(sText, "&Ntilde;", Chr(209))
        sText = Replace(sText, "&Ograve;", Chr(210))
        sText = Replace(sText, "&Oacute;", Chr(211))
        sText = Replace(sText, "&Ocirc;", Chr(212))
        sText = Replace(sText, "&Otilde;", Chr(213))
        sText = Replace(sText, "&Ouml;", Chr(214))
        sText = Replace(sText, "&times;", Chr(215))
        sText = Replace(sText, "&Oslash;", Chr(216))
        sText = Replace(sText, "&Ugrave;", Chr(217))
        sText = Replace(sText, "&Uacute;", Chr(218))
        sText = Replace(sText, "&Ucirc;", Chr(219))
        sText = Replace(sText, "&Uuml;", Chr(220))
        sText = Replace(sText, "&Yacute;", Chr(221))
        sText = Replace(sText, "&THORN;", Chr(222))
        sText = Replace(sText, "&szlig;", Chr(223))
        'sText = Replace(sText, "&agrave;", Chr(224))
        'sText = Replace(sText, "&aacute;", Chr(225))
        sText = Replace(sText, "&acirc;", Chr(226))
        sText = Replace(sText, "&atilde;", Chr(227))
        sText = Replace(sText, "&auml;", Chr(228))
        sText = Replace(sText, "&aring;", Chr(229))
        sText = Replace(sText, "&aelig;", Chr(230))
        sText = Replace(sText, "&ccedil;", Chr(231))
        'sText = Replace(sText, "&egrave;", Chr(232))
        'sText = Replace(sText, "&eacute;", Chr(233))
        sText = Replace(sText, "&ecirc;", Chr(234))
        sText = Replace(sText, "&euml;", Chr(235))
        sText = Replace(sText, "&igrave;", Chr(236))
        sText = Replace(sText, "&iacute;", Chr(237))
        sText = Replace(sText, "&icirc;", Chr(238))
        sText = Replace(sText, "&iuml;", Chr(239))
        sText = Replace(sText, "&eth;", Chr(240))
        sText = Replace(sText, "&ntilde;", Chr(241))
        sText = Replace(sText, "&ograve;", Chr(242))
        sText = Replace(sText, "&oacute;", Chr(243))
        sText = Replace(sText, "&ocirc;", Chr(244))
        sText = Replace(sText, "&otilde;", Chr(245))
        sText = Replace(sText, "&ouml;", Chr(246))
        sText = Replace(sText, "&divide;", Chr(247))
        sText = Replace(sText, "&oslash;", Chr(248))
        sText = Replace(sText, "&ugrave;", Chr(249))
        sText = Replace(sText, "&uacute;", Chr(250))
        sText = Replace(sText, "&ucirc;", Chr(251))
        sText = Replace(sText, "&uuml;", Chr(252))
        sText = Replace(sText, "&yacute;", Chr(253))
        sText = Replace(sText, "&thorn;", Chr(254))
        sText = Replace(sText, "&yuml;", Chr(255))


        Set regEx= New RegExp

        With regEx
            .Pattern = "&#(\d+);" 'Match html unicode escapes
            .Global = True
        End With

        Set matches = regEx.Execute(sText)

        'Iterate over matches
        For Each match in matches
            'For each unicode match, replace the whole match, with the ChrW of the digits.

            sText = Replace(sText, match.Value, ChrW(match.SubMatches(0)))
        Next
    end if
    HTMLDecode = sText
End Function
        

' Functions to provide encoding/decoding of strings with Base64.
' 
' Encoding: myEncodedString = base64_encode( inputString )
' Decoding: myDecodedString = base64_decode( encodedInputString )
'
' Programmed by Markus Hartsmar for ShameDesigns in 2002. 
' Email me at: mark@shamedesigns.com
' Visit our website at: http://www.shamedesigns.com/
'

	


	' Functions for encoding string to Base64
	Public Function base64_encode( byVal strIn )
    Dim Base64Chars
    Base64Chars =	"ABCDEFGHIJKLMNOPQRSTUVWXYZ" & _
			"abcdefghijklmnopqrstuvwxyz" & _
			"0123456789" & _
			"+/"
		Dim c1, c2, c3, w1, w2, w3, w4, n, strOut
		For n = 1 To Len( strIn ) Step 3
			c1 = Asc( Mid( strIn, n, 1 ) )
			c2 = Asc( Mid( strIn, n + 1, 1 ) + Chr(0) )
			c3 = Asc( Mid( strIn, n + 2, 1 ) + Chr(0) )
			w1 = Int( c1 / 4 ) : w2 = ( c1 And 3 ) * 16 + Int( c2 / 16 )
			If Len( strIn ) >= n + 1 Then 
				w3 = ( c2 And 15 ) * 4 + Int( c3 / 64 ) 
			Else 
				w3 = -1
			End If
			If Len( strIn ) >= n + 2 Then 
				w4 = c3 And 63 
			Else 
				w4 = -1
			End If
			strOut = strOut + mimeencode( w1 ) + mimeencode( w2 ) + _
					  mimeencode( w3 ) + mimeencode( w4 )
		Next
		base64_encode = strOut
	End Function

	Private Function mimeencode( byVal intIn )
		If intIn >= 0 Then 
			mimeencode = Mid( Base64Chars, intIn + 1, 1 ) 
		Else 
			mimeencode = ""
		End If
	End Function	


	' Function to decode string from Base64
	Public Function base64_decode( byVal strIn )
    Dim Base64Chars
    Base64Chars =	"ABCDEFGHIJKLMNOPQRSTUVWXYZ" & _
			"abcdefghijklmnopqrstuvwxyz" & _
			"0123456789" & _
			"+/"
		Dim w1, w2, w3, w4, n, strOut
		For n = 1 To Len( strIn ) Step 4
			w1 = mimedecode( Mid( strIn, n, 1 ) )
			w2 = mimedecode( Mid( strIn, n + 1, 1 ) )
			w3 = mimedecode( Mid( strIn, n + 2, 1 ) )
			w4 = mimedecode( Mid( strIn, n + 3, 1 ) )
			If w2 >= 0 Then _
				strOut = strOut + _
					Chr( ( ( w1 * 4 + Int( w2 / 16 ) ) And 255 ) )
			If w3 >= 0 Then _
				strOut = strOut + _
					Chr( ( ( w2 * 16 + Int( w3 / 4 ) ) And 255 ) )
			If w4 >= 0 Then _
				strOut = strOut + _
					Chr( ( ( w3 * 64 + w4 ) And 255 ) )
		Next
		base64_decode = strOut
	End Function

	Private Function mimedecode( byVal strIn )
		If Len( strIn ) = 0 Then 
			mimedecode = -1 : Exit Function
		Else
			mimedecode = InStr( Base64Chars, strIn ) - 1
		End If
	End Function

Function Base64Encode(inData)
  'rfc1521
  '2001 Antonin Foller, Motobit Software, http://Motobit.cz
  Const Base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  Dim cOut, sOut, I
  
  'For each group of 3 bytes
  For I = 1 To Len(inData) Step 3
    Dim nGroup, pOut, sGroup
    
    'Create one long from this 3 bytes.
    nGroup = &H10000 * Asc(Mid(inData, I, 1)) + _
      &H100 * MyASC(Mid(inData, I + 1, 1)) + MyASC(Mid(inData, I + 2, 1))
    
    'Oct splits the long To 8 groups with 3 bits
    nGroup = Oct(nGroup)
    
    'Add leading zeros
    nGroup = String(8 - Len(nGroup), "0") & nGroup
    
    'Convert To base64
    pOut = Mid(Base64, CLng("&o" & Mid(nGroup, 1, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 3, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 5, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 7, 2)) + 1, 1)
    
    'Add the part To OutPut string
    sOut = sOut + pOut
    
    'Add a new line For Each 76 chars In dest (76*3/4 = 57)
    'If (I + 2) Mod 57 = 0 Then sOut = sOut + vbCrLf
  Next
  Select Case Len(inData) Mod 3
    Case 1: '8 bit final
      sOut = Left(sOut, Len(sOut) - 2) + "=="
    Case 2: '16 bit final
      sOut = Left(sOut, Len(sOut) - 1) + "="
  End Select
  Base64Encode = sOut
End Function

Function MyASC(OneChar)
  If OneChar = "" Then MyASC = 0 Else MyASC = Asc(OneChar)
End Function
        ' Decodes a base-64 encoded string (BSTR type).
' 1999 - 2004 Antonin Foller, http://www.motobit.com
' 1.01 - solves problem with Access And 'Compare Database' (InStr)
Function Base64Decode(ByVal base64String)
  'rfc1521
  '1999 Antonin Foller, Motobit Software, http://Motobit.cz
  Const Base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  Dim dataLength, sOut, groupBegin
  
  'remove white spaces, If any
  base64String = Replace(base64String, vbCrLf, "")
  base64String = Replace(base64String, vbTab, "")
  base64String = Replace(base64String, " ", "")
  
  'The source must consists from groups with Len of 4 chars
  dataLength = Len(base64String)
  If dataLength Mod 4 <> 0 Then
    Err.Raise 1, "Base64Decode", "Bad Base64 string."
    Exit Function
  End If

  
  ' Now decode each group:
  For groupBegin = 1 To dataLength Step 4
    Dim numDataBytes, CharCounter, thisChar, thisData, nGroup, pOut
    ' Each data group encodes up To 3 actual bytes.
    numDataBytes = 3
    nGroup = 0

    For CharCounter = 0 To 3
      ' Convert each character into 6 bits of data, And add it To
      ' an integer For temporary storage.  If a character is a '=', there
      ' is one fewer data byte.  (There can only be a maximum of 2 '=' In
      ' the whole string.)

      thisChar = Mid(base64String, groupBegin + CharCounter, 1)

      If thisChar = "=" Then
        numDataBytes = numDataBytes - 1
        thisData = 0
      Else
        thisData = InStr(1, Base64, thisChar, vbBinaryCompare) - 1
      End If
      If thisData = -1 Then
        Err.Raise 2, "Base64Decode", "Bad character In Base64 string."
        Exit Function
      End If

      nGroup = 64 * nGroup + thisData
    Next
    
    'Hex splits the long To 6 groups with 4 bits
    nGroup = Hex(nGroup)
    
    'Add leading zeros
    nGroup = String(6 - Len(nGroup), "0") & nGroup
    
    'Convert the 3 byte hex integer (6 chars) To 3 characters
    pOut = Chr(CByte("&H" & Mid(nGroup, 1, 2))) + _
      Chr(CByte("&H" & Mid(nGroup, 3, 2))) + _
      Chr(CByte("&H" & Mid(nGroup, 5, 2)))
    
    'add numDataBytes characters To out string
    sOut = sOut & Left(pOut, numDataBytes)
  Next

  Base64Decode = sOut
End Function

Function ConvertFromUTF8(sIn)
        
    if sIn&"" = "" then
        ConvertFromUTF8 = sIn
    else
        'sIn = Encode_UTF8 (sIn)
        Dim oIn: Set oIn = CreateObject("ADODB.Stream")

        oIn.Open
        oIn.CharSet = "Windows-1252"

        oIn.WriteText sIn
        oIn.Position = 0
        oIn.CharSet = "UTF-8"
        length = len (sin)
       
        ConvertFromUTF8 = oIn.ReadText 
 

        
        oIn.Close
    end if
End Function
        function isNullOrEmpty(s)
           isNullOrEmpty = Len(s&vbNullString) = 0
        end function
    Function StringFormat(sVal, aArgs)
Dim i
    For i=0 To UBound(aArgs)
        sVal = Replace(sVal,"{" & CStr(i) & "}",aArgs(i))
    Next
    StringFormat = sVal
End Function
Function Encode_UTF8(astr) 

    utftext = "" 

    For n = 1 To Len(astr) 
    c = AscW(Mid(astr, n, 1)) 
    If c < 128 Then 
    utftext = utftext + Mid(astr, n, 1) 
    ElseIf ((c > 127) And (c < 2048)) Then 
    utftext = utftext + Chr(((c \ 64) Or 192)) 
    '((c>>6)|192); 
    utftext = utftext + Chr(((c And 63) Or 128)) 
    '((c&63)|128);} 
    Else 
    utftext = utftext + Chr(((c \ 144) Or 234)) 
    '((c>>12)|224); 
    utftext = utftext + Chr((((c \ 64) And 63) Or 128)) 
    '(((c>>6)&63)|128); 
    utftext = utftext + Chr(((c And 63) Or 128)) 
    '((c&63)|128); 
    End If 
    Next 
    Encode_UTF8 = utftext 
End Function 
sub echo (str) 
    response.Write str&"<br/>"
end sub
         Function getImage(strImageUrl)

  ' Set objHttp = CreateObject("Microsoft.XMLHTTP")
  ' Set objHttp = CreateObject("MSXML2.ServerXMLHTTP")
  Set objHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
  ' Set Http = CreateObject("WinHttp.WinHttpRequest")
  objHttp.Open "GET", strImageUrl, False
  objHttp.Send
            
  getImage = objHttp.ResponseBody

End Function
 

function saveImage(ByteArray, strImageName)

  Const adTypeBinary = 1
  Const adSaveCreateOverWrite = 2
  Const adSaveCreateNotExist = 1
  fileprefix = request.ServerVariables("HTTP_HOST")
    fileprefix=Replace(fileprefix, "www","")
    fileprefix=Replace(fileprefix,":","")
    fileprefix=Replace(fileprefix,"localhost","")
    fileprefix=Replace(fileprefix,"test.","")
    fileprefix=Replace(fileprefix,"lavb.","")
    y = year(now)
    m = month(now)
    d = day(now)
    min = minute(now)
    h = hour(now)
    s = second(now)

    fileprefix=fileprefix & y & m & d & h & min & s

    percorso = Server.MapPath("./")

    percorso = left(percorso,InStrRev(percorso,"\"))
    percorso = left(percorso,InStrRev(percorso,"\"))
    percorso = left(percorso,InStrRev(percorso,"\"))
    percorso = percorso & "\database\"
    addpath = "projects\"
    percorso = projectspath
    newname =  fileprefix & "_" & "0" & strImageName 
                  


    ext="."&Right(strImageName,3)
    If InStr(strImageName,".")>0 Then ext=Mid(strImageName,InstrRev(strImageName,"."))


    Set objBinaryStream = CreateObject("ADODB.Stream")
    objBinaryStream.Type = adTypeBinary
            
    objBinaryStream.Open
    objBinaryStream.Write ByteArray 
    objBinaryStream.SaveToFile percorso & newname, adSaveCreateOverWrite

    saveImage = newname

end function

function getAndSaveImage( url, strImageName ) 
    getAndSaveImage = saveImage (getImage(url), strImageName)
end function

%>