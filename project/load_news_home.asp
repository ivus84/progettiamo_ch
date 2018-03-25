<div class="homeNews first" >

<div><p><%=str_news%></p>
    <div id="fbPage" style="z-index: 100; position: relative; width: 468px; height: 242px; padding-left: 8px; background-color: white; display: none; float: left; top: 8px">

        <div class="fb-page" data-href="https://www.facebook.com/progettiamoch" data-tabs="timeline" data-width="468" data-height="240" data-small-header="true" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="false" style="bottom: auto; width: 468px;">
            <blockquote cite="https://www.facebook.com/progettiamoch/" class="fb-xfbml-parse-ignore">
                <a href="https://www.facebook.com/progettiamoch/">Progettiamo.ch</a>
            </blockquote>

        </div>

    </div>

<div class="newsScroller" style="left:476px">


<%

'SQL="SELECT QU_projects.AT_main_img, QU_updates.* FROM QU_updates INNER JOIN QU_projects ON QU_updates.CO_p_projects = QU_projects.ID WHERE (((QU_projects.LO_aperto)=True) AND ((QU_updates.LO_confirmed)=True)) OR (((QU_projects.LO_realizzato)=True)) ORDER BY QU_updates.DT_data DESC"
    'SQL="SELECT QU_projects.AT_main_img, QU_updates.* FROM QU_updates INNER JOIN QU_projects ON QU_updates.CO_p_projects = QU_projects.ID ORDER BY QU_updates.DT_data DESC"
    SQL="SELECT QU_projects.AT_main_img, QU_updates.* FROM QU_updates INNER JOIN QU_projects ON QU_updates.CO_p_projects = QU_projects.ID WHERE (QU_updates.LO_confirmed)=True ORDER BY QU_updates.DT_data DESC"
iCurrentPage = 1

iPageSize = 12

sSQLStatement = SQL

Set RecordSet = Server.CreateObject("ADODB.Recordset")
RecordSet.PageSize = iPageSize
RecordSet.CacheSize = iPageSize
RecordSet.Open sSQLStatement, Connection, adOpenStatic, adLockReadOnly

intCurrentRecord = 1
do While intCurrentRecord <= iPageSize

if not recordset.eof then
refnews=RecordSet("ID")
pcolor=RecordSet("TA_color")
pname=RecordSet("p_name")
pdata=datevalue(RecordSet("DT_data"))
ptitle=RecordSet("TA_nome")
pimg=RecordSet("AT_main_img")
newsimg=RecordSet("AT_file")
newsembed=RecordSet("TX_embed")
refProject=RecordSet("CO_p_projects")
ncolor=HEXCOL2RGB(pcolor)
If Len(pname)>0 Then pname=Replace(pname,"#","'")
pLink=linkMaker(pname)

ptitle = ConvertFromUTF8(htmldecode(ptitle))
pname = ConvertFromUTF8(htmldecode(pname))

icoNews="ico_quote.png"
If Len(newsimg)>3 Then icoNews="ico_img_news.png"
If Len(newsembed)>3 Then icoNews="ico_vid_news.png"
If Len(newsimg)>3 Then pimg=newsimg
addbimg=""
If Len(pimg)>4 Then addbimg="<img class=""bnews"" src=""/images/vuoto.gif"" style=""background-color:"&pcolor&"; background-image:url(/"&imgscript&"?path="&pimg&"$600)"" alt="""" onclick=""document.location='/?progetti/"&refProject&"/"&pLink&"/news/'""/>"

adcmnts=""

	SQL="SELECT count(ID) as numcomments FROM p_comments WHERE LO_deleted=false AND CO_p_description="&refnews
	Set rec2=connection.execute(SQL)
	numcomments=rec2("numcomments")
If numcomments>0 Then adcmnts="<img src=""/images/ico_comment_home.png"" alt="""" style=""float:right; width:18px; margin-right:8px;""/><span style=""float:right"">"&numcomments&"</span>"

Response.write "<div style=""background-color:"&pcolor&""">"
Response.write "<div class=""nContent"" onclick=""document.location='/?progetti/"&refProject&"/"&pLink&"/news/'"" ><p><img src=""/images/"&icoNews&""" alt=""""/><br/><span>&quot;"&ptitle&"&quot;</span><br/>"&pname&"</p></div>"
Response.write addbimg&"<div><img src=""/images/ico_cal1.png"" alt=""""/><span>"&pdata&"</span>"&adcmnts&"</div>"
Response.write "</div>"

RecordSet.movenext
End If
intCurrentRecord=intCurrentRecord+1
loop
%>
</div>
</div>
<img class="arrHome" src="/images/arrow_down_w.png" alt=""/>
</div>
