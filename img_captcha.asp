<%
Function generatePassword(passwordLength)
Dim sDefaultChars
Dim iCounter
Dim sMyPassword
Dim iPickedChar
Dim iDefaultCharactersLength
Dim iPasswordLength
sDefaultChars="abcdefghijkLmnopqrstuvxyz123456789"
iPasswordLength=passwordLength
iDefaultCharactersLength = Len(sDefaultChars)
Randomize
For iCounter = 1 To iPasswordLength
iPickedChar = Int((iDefaultCharactersLength * Rnd) + 1)
sMyPassword = sMyPassword & Mid(sDefaultChars,iPickedChar,1)
Next
generatePassword = sMyPassword
End Function


cnt="image/gif"
response.contenttype=cnt
vtext=generatePassword(4)
Session("checkcaptcha")=vtext
response.redirect("/incs/load_writeimage_c.aspx?bold=true&vtext="&vtext&"&timesession="&Now())
	response.end

%>