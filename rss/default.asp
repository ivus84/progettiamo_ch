<?xml version="1.0" encoding="UTF-8" ?>
<!--#INCLUDE VIRTUAL="./incs/load_connection.asp"-->
<%
mode=request("mode")
load=request("load")
author="Progettiamo.ch"
response.charset = "UTF-8"
response.contentType="text/xml"

Function date2RFC822(data, offset)
   data = CDate(data)
   dayss=",Sun,Mon,Tue,Wed,Thu,Fri,Sat"
dayss=split(dayss,",")

mesi=",Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec"
mesi=split(mesi,",")

   giorno = dayss(Weekday(data))
   giornoN = Day(data)
   mese = mesi(Month(data))
   anno = Year(data)
   hours = zeroPad(Hour(data), 2)
   minutes = zeroPad(Minute(data), 2)
   seconds = zeroPad(Second(data), 2)

   date2RFC822 = giorno &", "& giornoN &" "& mese &" "& anno &" "& hours&":"& minutes&":"& seconds&" "& offset
End Function

Function zeroPad(m, t)
	zeroPad = String( t - Len(m), "0") & m
End Function


SQL="SELECT * FROM p_projects WHERE LO_confirmed AND LO_aperto AND dateDiff('d',Now(),DT_termine)>=0 ORDER BY DT_apertura DESC"
set record=connection.execute(SQL)

mainlink="http://"&Request.ServerVariables("HTTP_HOST")&"/"

If Not record.eof then
lastupd=record("DT_apertura")

lastupd=date2RFC822(lastupd, "+0100")
%>
<rss xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:sy="http://purl.org/rss/1.0/modules/syndication/" xmlns:admin="http://webns.net/mvcb/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:media="http://search.yahoo.com/mrss/" version="2.0">
<channel>
<title>News <%=author%></title>
<link><%=mainlink%></link>
<description>News <%=author%></description>
<copyright>Copyright <%=Year(Now())%> - <%=author%></copyright>
<language>it-IT</language>
<lastBuildDate><%=lastupd%></lastBuildDate>
<generator>Dsm Pro Cms</generator>
<image>
<title>News <%=author%></title>
<url><%=mainlink%>images/logo_small.png</url>
<link><%=mainlink%></link>
<width>140</width>
<height>40</height>
<description>News <%=author%> versione rss</description>
</image>
<atom:link href="<%=mainlink%>rss" rel="self" type="application/rss+xml" />


<%Do While Not record.eof
img=record("AT_main_img")
data=record("DT_apertura")
refitem=record("ID")
titolo=record("TA_nome")
txt=record("TE_abstract")
gLink=linkmaker(titolo)
	If Len(txt)>0 Then
	txt=ClearHTMLTags(txt,0)
	mlenght=800
			if len(txt)>mlenght then
			isemptyright=False
			do while isemptyright=False
			if mlenght=len(txt) then isemptyright=True
			testo1=Mid(txt,1,mlenght)
			if right(testo1,1)=" " then
			isemptyright=True
			txt=Trim(testo1)&"..."
			end if
			mlenght=mlenght+1

			loop
			end If
	End If

	If Len(titolo)>0 Then titolo=Replace(titolo,"&#45;","-")
	If Len(titolo)>0 Then titolo=Replace(titolo,"&quot;","")	
	If Len(titolo)>0 Then titolo=Replace(titolo,"&#39;","'")
	If Len(titolo)>0 Then titolo=Replace(titolo,"&nbsp;"," ")

	data=date2RFC822(data, "+0100")

%>
<item>
<title>
<![CDATA[ <%=titolo%> ]]>
</title>
<description>
<![CDATA[ <%=txt%> ]]>
</description>
<link>
<![CDATA[ <%=mainlink%>?progetti/<%=refitem%>/<%=gLink%> ]]>
</link>
<dc:creator>
<![CDATA[ <%=author%> ]]>
</dc:creator>
<guid isPermaLink="true">
<![CDATA[ <%=mainlink%>?progetti/<%=refitem%>/<%=gLink%> ]]>
</guid>
<category domain="<%=mainlink%>"><%=mode%></category>
<pubDate><%=data%></pubDate>
<%if len(img)>0 then%>
<media:content url="<%=mainlink%>?image/350/<%=img%>" type="image/jpeg" />
<%End if%>
</item>
<%record.movenext
loop%>


</channel>
</rss>

<%End if%>