<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->

<%
''ON ERROR RESUME NEXT

titletop="Gestione Sostenitori"


titletop=titletop&" "&Session("name_areap")

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->

<script type="text/javascript">
    $(function () {
        function show(item, index) {
            //alert("item:" + item);
            $("li[key='" + item + "']").show();
        }
        searchUsers = function () {
            $.ajax({
                type: "POST",
                url: "/admin/cerca_users_by_key.asp",
                //dataType: 'json',
                data: { key: $("#txtChiave").val() },
                timeout: 6000,
                success: function (msg) {
                    $("li.pp").hide();
                    msg.split("~").forEach(show);
                    return;


                },
                error: function (msg) {

                    alert("error: " + msg);
                    return;
                    //            $('.errMsg').html(str_generic_error);
                    //            $('html, body').animate({ scrollTop: 0 }, 300)
                    //            $('.errMsg').fadeIn();

                }
            })
        }
        $("#txtChiave").bind("enterKey", searchUsers);
        $("#txtChiave").keyup(function (e) {
    if(e.keyCode == 13)
    {
        $(this).trigger("enterKey");
    }
});
$("#btn_search").click(searchUsers);
        clear = function () {
        $("li.pp").show();
        $("#txtChiave").val('');
    }
    $("#btn_clear").click(clear);
    });

    
</script>
<div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">
<p class="titolo"> <%=titletop%></p>


<p>

<div id="structureContainerTable" style="position:relative;float:left;width:960px; min-height:400px; border:solid 1px #999;margin-top:-1px;margin-left:-1px">

<div id="contentMenu">

<div id="previmgs_c" class="testoadm">
<%
load=request("load")

SQL="SELECT * FROM registeredusers WHERE LO_projects=False "
SQL1="SELECT COUNT(ID) as totp FROM registeredusers WHERE LO_projects=False "

SQL=SQL&" ORDER BY TA_ente,TA_cognome"
set rec=connection.execute(SQL)
set rec1=connection.execute(SQL1)
totp=rec1("totp")


%>

<p style="padding:8px;background:#efefef;margin:0px;font-size:12px; line-height:18px;">
<input class="btn12" type="button" style="float:right; width:120px; margin:0px 2px;" onclick="$('#edNews').attr('src','projects_addpromoter.asp?mode=0')" value="Crea sostenitore"/><b><%=totp%> sostenitori </b>

<span style="float: left">
Filtro: <input type="text" name="txtChiave" id="txtChiave" /><br />
<button id="btn_search">Ricerca</button>
<button id="btn_clear">Cancella</button></span>
<span style="clear:both"></span>
</p>
<ul style="margin:0; padding:0; list-style: none">
<%

if not rec.eof then
mimgs=""
hnr=0
do while not rec.eof

nn=rec("ID")
usrN=rec("TA_nome")
usrC=rec("TA_cognome")
usrE=rec("TA_ente")
usrEm=rec("TA_email")
emailCheck = EnDeCrypt(usrEm, npass, 2)

''creata=recordset("DT_data")
''inviata=recordset("LO_sent")
''If inviata=True Then inviata=recordset("DT_data_invio")

SQL="SELECT COUNT(CO_p_projects) as totprojects FROM (SELECT DISTINCT CO_p_projects FROM QU_donators WHERE ID="&nn&")"
Set rec1=connection.execute(SQL)
totprojects=rec1("totprojects")

%>
<li class="pp" key="<%=nn %>">
<p style="margin-bottom:3px;cursor:pointer;"><b style="font-size:12px"><%=usrE%></b> <%=usrC%>&nbsp;<%=usrN%><br/><br/>
<%=totprojects%> progetti sostenuti
</p>
<%If totprojects=0 then%>
<input class="btn12" type="button" value="del" onclick="$('#edNews').attr('src','del.asp?tabella=registeredusers&pagina=<%=nn%>&da=projects_sostenitori')"/>
<%End if%>
<input class="btn12" type="button" style="float:left; width:156px; margin:4px 5px;" onclick="$('#edNews').attr('src','projects_convertpromoter.asp?email=<%=emailCheck%>');" value="Converti in promotore"/>

<input class="btn12" type="button" style="float:right; width:50px; margin:4px 5px;" onclick="$('#edNews').attr('src','edit.asp?tabella=registeredusers&pagina=<%=nn%>&mode=notmodal');" value="Edit"/>
</li>
<%

rec.movenext
loop
rec.movefirst
End if

setWImg=640

%>





</ul></div></div>
<div id="EditNewsletter" class="testoadm" style="position:relative;float:left; margin-top:10px;margin-left:10px; width:<%=setWImg%>px;height:100%;">
<iframe id="edNews" scrolling="auto" style="position:relative; width:<%=setWImg%>px; height:97%;border:solid 0px"></iframe>
</div>
</div>

<script type="text/javascript">

$(document).ready(function() {
resizeWin()
$(window).resize(function() {resizeWin()})

<%if len(load)>0 then%>
$('#edNews').attr('src','edit.asp?tabella=registeredusers&pagina=<%=load%>&mode=notmodal');
<%end if%>

});

resizeWin=function() {
$('#structureContainerTable').height($(window).height()-$('#structureContainerTable').offset().top-20)
}

</script>
</body>
</html>
<%
response.End
%>