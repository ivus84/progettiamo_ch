<%

'' This page is included after the sitebuilder framework

'' Set the facebook app values here, remember to remove
'' this from your fb_app.asp file. 

'dim FACEBOOK_APP_ID: FACEBOOK_APP_ID = page("FACEBOOK_APP_ID")
'dim FACEBOOK_SECRET: FACEBOOK_SECRET = page("FACEBOOK_SECRET")
'dim FACEBOOK_SCOPE: FACEBOOK_SCOPE = page("FACEBOOK_SCOPE")

%>
<script language="JScript" runat="server" src="/app/fb/json2.asp"></script>
<!-- #INCLUDE VIRTUAL="/app/fb/fb_graph_api_app.asp" -->
<!-- #INCLUDE VIRTUAL="/app/fb/fb_app.asp" -->
<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<!-- #include VIRTUAL = "/admin/clsSHA-1.asp" -->
<%
'' JSON 2 Library from: 
''   https://github.com/nagaozen/asp-xtreme-evolution/tree/master/lib/axe/classes/Parsers
''

fb_sb_main

''
'' Facebook for Sitebuilder
''
function fb_sb_main
	dim app_id
	dim app_secret
	dim my_url
	dim dialog_url
	dim token_url
	dim resp
	dim token
	dim expires
	dim graph_url
	dim json_str
	dim user
	dim code
	dim strLocation 
	dim strEducation
	dim strEmail
	dim strFirstName
	dim strLastName
	dim strFullName
    dim strID
    dim fbu

    set fbu = new fb_utility
	token = cookie("token")

	if token = "" then 
		response.write ""	
		exit function
	end if

	graph_url = "https://graph.facebook.com/me?fields=id,email,name,first_name,last_name,birthday,picture,location{location{city,country_code}}&access_token=" & token
   json_str = fbu.get_page_contents( graph_url )
    
	set user = JSON.parse( json_str )

	'' These properties should always be there provided
	'' we ask the right questions user.id & user.name
	strFirstName = user.first_name
	strLastName = user.last_name
	strFullName = user.name
    strID = user.id
	pic = user.picture.data.url
	'' Handling properties that might not be there
	on error resume next
	strLocation = user.location.name
	strEducation = user.education.get(0).school.name
	strEMail = user.email
	strEmail = replace( strEmail, "\u0040", "@")

	on error goto 0

	response.write "USER ID: " & strID & "<br/>"
	response.write "First Name: " & strFirstName & "<br/>"
	response.write "Last Name: " & strLastName & "<br/>"
    response.write "Picture:" & pic & "<br/>"
	response.write "Location: " & strLocation & "<br/>"
	response.write "Education: " & strEducation & "<br/>"
	response.write "Email: " & strEMail & "<br/>"
    response.write "Birthday: " & user.birthday & "<br/>"
    	response.write "<p/>"
    	response.write "JSON String: <br/>"
   	response.write json_str

    response.write "<img src='"
    graph_url= "https://graph.facebook.com/"&user.id&"/picture?height=350&width=350" 'per ottenere la foto a grandezza desiderata
    
    response.Write graph_url & "'/>"
    pos = instr(pic, "?")
    if pos < 1 then
    
    else
     pic = left (pic, instr(pic, "?")-1)
    
    end if  
    'pic = mid(pic, instrrev(pic, "/")+1)
    response.Write pic & "<br>"
    ext="."&Right(pic,3)
    If InStr(pic,".")>0 Then ext=Mid(pic,InstrRev(pic,"."))
    response.Write ext

    'response.write getAndSaveImage (graph_url, strid&ext)
   

    
    echo "<br>"
    echo strEMail&"<br>"
    echo server.URLEncode(stremail)&"<br>"
    mailcr = EnDeCrypt(strEMail, npass, 1)
    echo mailcr&"<br>"
    email = EnDeCrypt(mailcr, npass, 2)
    echo email&"<br>"

    echo npass
end function    

    

%>