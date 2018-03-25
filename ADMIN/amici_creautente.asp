<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%
ref=request("ref")
nome=request("nome")
nameprefix="friends_" & Day(Now()) & Month(Now()) & Right(Year(Now()),2) & Hour(Now()) & Minute(Now()) & Second(Now())
nFixed=Session("nFixed")
isAdmin=False
if Session("adm_area")=0 then isAdmin=true
%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
 <div id="content_page" style="position:absolute;left:16px;top:100px;width:600px">

    <!--<form name="frmData" id="frmData" action="amici_creautente1.asp" method="POST" >
        <table width="100%" cellpadding="4" cellspacing="0">
            <tr>
            <td class="testo" colspan=2><font class="titolo"><b><script type="text/javascript">document.write(txt9_1);</script></b></font><br/></td></tr>
            <tr><td class="testoadm">Nome Completo:</td>
            <td class="testo"><input type="text" name="nome" id="nome" size="26" maxlength="100" value="" class="formtext2"/></td></tr>
            <tr><td class="testoadm">Titolo:</td>
            <td class="testo"><input type="text" name="titolo" id="titolo" size="26" maxlength="100" value="" class="formtext2"/></td></tr>
            <tr><td class="testoadm">Fixed:</td>
            <td> <input id="fixedH" type='hidden' value='False' name='fixedH'/>
                <input id="chkFixed" type='checkbox' value='False' onclick="return setChkFixed(<%=nFixed %>,'<%=isAdmin %>')"/>
            </td></tr>
            <tr><td><input type="hidden" id="image" name="image" value=""/></td></tr>
        </table>
        <input type="submit" value="Save" id="cmdFakeSubmit"/>
    </form>-->
    <form id="fileupload_1" class="fileupload" action="../actions/friendsUpdate.asp" method="post" enctype="multipart/form-data" style="margin-top:45px; margin-bottom:5px">
        <table width="100%" cellpadding="4" cellspacing="0">
            <tr>
            <td class="testo" colspan=2><font class="titolo"><b><script type="text/javascript">document.write(txt9_1);</script></b></font><br/></td></tr>
            <tr><td class="testoadm">Nome Completo:</td>
            <td class="testo"><input type="text" name="nome" id="nome" size="26" maxlength="100" value="" class="formtext2"/></td></tr>
            <tr><td class="testoadm">Titolo:</td>
            <td class="testo"><input type="text" name="titolo" id="titolo" size="26" maxlength="100" value="" class="formtext2"/></td></tr>
            <tr><td class="testoadm">Fixed:</td>
            <td> <input id="fixedH" type='hidden' value='False' name='fixedH'/>
                <input id="chkFixed" type='checkbox' value='False' onclick="return setChkFixed(<%=nFixed %>,'<%=isAdmin %>')"/>
            </td></tr>
        </table>
        <p style="width:100%">Immagine Amico &nbsp;<input class="fInput" id="fileupload_1_file" type="file" name="files[]"/></p>
        <input type="hidden" id="nameprefix" name="nameprefix" value="<%=nameprefix %>" class="formtext2"/>
        <input type="hidden" name="operationType" value="insert" class="formtext2"/>
        <input type="hidden" id="imageName" name="imageName" value="" class="formtext2"/>
        <div class="barContain"><div class="bar" id="fileupload_1_bar" style="width: 0%;">&nbsp;uploading ...</div></div>
        <input type="submit" value="" id="mybt1" onclick="return checkData()" class="formtext3"/>
        <input type="button" value="Cancel" id="cancel" onclick="window.location='../admin/amici.asp'" class="formtext3"/>
    </form>
    <script type="text/javascript">
        $(function () {
            //$("#cmdFakeSubmit").hide();
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

        setChkFixed = function (nFixed,isAdmin) {
            if (document.getElementById("chkFixed").checked) {
                if (((nFixed+1)>maxFriends) && isAdmin=='False') {
                    alert(friends_txt_max_friend);
                    return false;
                }
                document.getElementById("fixedH").value = "True"
            } else {
                document.getElementById("fixedH").value = "False"
            }
        }

        checkData = function () {
            if (document.getElementById("nome").value.length <= 2 || document.getElementById("titolo").value.length <= 2) {
                alert(friends_txt_input_error);
                return false;
            }
        }

//        saveData = function (namePrefix) {
//            imgName = document.getElementById("fileupload_1_file").value
//            if (imgName != undefined && imgName.length > 0) {
//                imgExt = imgName.substr(imgName.lastIndexOf('.') + 1)
//                document.getElementById("nameprefix").value = namePrefix + "_1." + imgExt
//            }
//            //$("#frmData").submit();
//        }
        document.getElementById("mybt1").value = save1;
    </script>
</div>