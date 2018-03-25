<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%nobg=True%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->

<p class="titolo">Modifica Amico Prigettiamo.ch</p>

<%

ref1=request("ref1")

nFixed=Session("nFixed")
isAdmin=False
if Session("adm_area")=0 then isAdmin=true

SQL="SELECT * FROM friends WHERE ID=" & request("ref1")
set record1=connection.execute(SQL)
If record1.eof Then%>
    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            closeThis();
        });
    </script>
<%
Response.End
End if

nameprefix="friends_" & Day(Now()) & Month(Now()) & Right(Year(Now()),2) & Hour(Now()) & Minute(Now()) & Second(Now())

nome=record1("p_name")
title=record1("TA_title")
enabled=""
if record1("LO_pubblica") then enabled="checked"
fixed=""
if record1("fixed") then fixed="checked"
image=record1("at_main_img")
%>

<!--<form name="frmData" id="frmData" action="amici_utente1.asp" method="POST">
    <table width="100%">
        <tr><td class="testoadm"></td></tr>
        <tr><td>Nome:<input type="text" id="nome" name="nome" value="<%=nome %>" class="formtext2"/>
        <input id="ref1" type='hidden' value="<%=ref1 %>" name='ref1'/>
        </td></tr>
        <tr><td>Titolo:<input type="text" id="titolo" name="titolo" value="<%=title %>" class="formtext2"/></td></tr>
        <tr><td>Attivo:<input type="checkbox" id="enabled" name="enabled" value="" class="formtext2" <%=enabled%> onclick="setChkEnabled(<%=nFixed %>,'<%=isAdmin %>');"/>
        <input id="enabledH" type='hidden' value='<%=record1("lo_pubblica") %>' name='enabledH'/></td></tr>
        <tr><td>Fixed:<input type="checkbox" id="chkFixed" name="fixed" value="" class="formtext2" <%=fixed %> onclick="return setChkFixed(<%=nFixed %>,'<%=isAdmin %>')"/>
        <input id="fixedH" type='hidden' value='<%=record1("fixed") %>' name='fixedH'/></td></tr>
        <tr><td><img id="img" src="getImage.asp?filename=<%=imagespath & image%>" style="width:200px;height:200px;" alt =""/></td></tr>
        <tr><td><input id="cmdChange" type="button" value="Cambia" onclick="hidePhoto()"/></td></tr>
        <tr><td><input type="hidden" id="image" name="image" value="<%=image %>"/></td></tr>
    </table>
    <input type="submit" value="" id="cmdFakeSubmit"/>
</form>-->
<form id="fileupload_1" class="fileupload" action="../actions/friendsUpdate.asp" method="post" enctype="multipart/form-data">

    <table width="100%">
        <tr><td class="testoadm"></td></tr>
        <tr><td>Nome:<input type="text" id="nome" name="nome" value="<%=nome %>" class="formtext2"/>
        <input id="ref1" type='hidden' value="<%=ref1 %>" name='ref1'/>
        </td></tr>
        <tr><td>Titolo:<input type="text" id="titolo" name="titolo" value="<%=title %>" class="formtext2"/></td></tr>
        <tr><td>Attivo:<input type="checkbox" id="enabled" name="enabled" value="" class="formtext2" <%=enabled%> onclick="setChkEnabled(<%=nFixed %>,'<%=isAdmin %>');"/>
        <input id="enabledH" type='hidden' value='<%=record1("lo_pubblica") %>' name='enabledH'/></td></tr>
        <tr><td>Fixed:<input type="checkbox" id="chkFixed" name="fixed" value="" class="formtext2" <%=fixed %> onclick="return setChkFixed(<%=nFixed %>,'<%=isAdmin %>')"/>
        <input id="fixedH" type='hidden' value='<%=record1("fixed") %>' name='fixedH'/></td></tr>
        <tr><td><img id="img" src="getImage.asp?filename=<%=imagespath & image%>" style="width:200px;height:200px;" alt =""/></td></tr>
        <tr><td><input id="cmdChange" type="button" value="Cambia" onclick="hidePhoto()"/></td></tr>
        <tr><td><input type="hidden" id="image" name="image" value="<%=image %>"/></td></tr>
    </table>
    <p id="pUpload" style="display:none">Immagine Amico &nbsp;<input class="fInput" id="fileupload_1_file" type="file" name="files[]"/></p>
    <input type="hidden" name="nameprefix" value="<%=nameprefix %>" class="formtext2"/>
    <input type="hidden" id="imageName" name="imageName" value="<%=image %>" class="formtext2"/>
    <input type="hidden" name="operationType" value="update" class="formtext2"/>
    <input type="submit" value=""  id="mybt2"  class="editBtns" />
    <input type="button" value="X CHIUDI" id="mybt1" class="editBtns" onclick="closeThis();"/>
</form>

<script type="text/javascript">
    $(function () {
        //$("#cmdFakeSubmit").hide();
        $("#mybt2").val(save1);
        $('body').css('background', '#c1c1c1')
        $('body').css('margin', '10px 0px 0px 10px')
        redimThis()

        $("#fileupload_1_file").change(function (e) {
            var files = e.currentTarget.files; // puts all files into an array
            if (files[0] == null) return;
            var filesize = ((files[0].size / 1024) / 1024).toFixed(4); // MB
            if (filesize > 1) {
                alert(friends_txt_max_size);
                document.getElementById("fileupload_1_file").value = "";
                return;
            }
            imgName = document.getElementById("fileupload_1_file").value
            if (imgName != undefined && imgName.length > 0) {
                if (!imgName.toLowerCase().match(/\.(jpg|jpeg|png|gif)$/)) {
                    alert(friends_txt_attach_image);
                    document.getElementById("fileupload_1_file").value = "";
                    return;
                } else {
                    imgExt = imgName.substr(imgName.lastIndexOf('.') + 1)
                    document.getElementById("imageName").value = document.getElementById("nameprefix").value + "_1." + imgExt
                }
            }
        });
    });

    hidePhoto = function () {
        $("#cmdChange").hide();
        $("#img").hide();
        $("#pUpload").css('display', 'block');
    }
    var addedFriend = 0;
    setChkEnabled = function (nFixed,isAdmin) {
        if (document.getElementById("enabled").checked) {
            if (document.getElementById("chkFixed").checked) {
                addedFriend++;
                if (((nFixed + addedFriend) > maxFriends) && isAdmin == 'False') {
                    alert(friends_txt_max_friend);
                    document.getElementById("chkFixed").checked = false;
                    document.getElementById("fixedH").value = "False"
                }
            }
            document.getElementById("enabledH").value = "True"
        } else {
            document.getElementById("enabledH").value = "False"
        }
    }

    setChkFixed = function (nFixed, isAdmin) {
        if (document.getElementById("chkFixed").checked) {
            addedFriend++;
            if (((nFixed + addedFriend) > maxFriends) && isAdmin == 'False') {
                alert(friends_txt_max_friend);
                return false;
            }
            document.getElementById("fixedH").value = "True"
        } else {
            addedFriend--;
            document.getElementById("fixedH").value = "False"
        }
    }

    document.getElementById("mybt2").value = save1;

    </script>