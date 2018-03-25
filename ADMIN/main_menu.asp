<div id="menu_upmain" style="<%=adddispmenu%>">
<div id="mLogo">
<a href="./"><img src="./images/dsm_logo.png" style="width:170px; border:0px;"/></a>
<span></span>
</div>

<div class="mMenu" onclick="openMainMenu(); $(this).css('display','none');  $(this).next().css('display','inline')">
<a href="javascript: void(0)">Main Menu</a>
</div>
<div class="mMenu hMenu" onclick="closeMainMenu(); $(this).css('display','none');  $(this).prev().css('display','inline')">
<a href="javascript: void(0)">Chiudi Menu</a>
</div>

<div class="mMenu">
<a href="logout.asp"><script type="text/javascript">document.write(menu9);</script></a>
</div>

</div>

<div id="screenMenu"><div>
<%if Session("allow_contenuti"&numproject)=True then%>
<div class="sMenu" style="background:#04aeda">
<a href="main.asp">
<div><script type="text/javascript">document.write(menu2);</script></div>
<img src="./menu/contenuti.png">
</a>
</div>

<%If limiteduser=False Then%>
<div class="sMenu" style="background:#ff9000">
<a href="cestino.asp">
<div><script type="text/javascript">document.write(menu3);</script></div>
<img src="./menu/cestino.png">
</a>
</div>
<%end if%>
<%end if%>

<%if Session("adm_files")=True then%>
<div class="sMenu" style="background:#ec008c">
<a href="files.asp">
<div>Files</div>
<img src="./menu/files.png">
</a>
</div>
<%end if%>


<%if Session("adm_users")=True then%>
<div class="sMenu" style="background:#ea2f11">
<a href="projects.asp">
<div>Progetti</div>
<img src="./menu/boxes.png">
</a>
</div>
<%end if%>

<%if Session("adm_newsletter")=True then%>
<div class="sMenu" style="background: #ca00e2">
<a href="promoters.asp">
<div>Promotori</div>
<img src="./menu/users.png">
</a>
</div>


<div class="sMenu" style="background: #ff4af0">
<a href="projects_sostenitori.asp">
<div>Sostenitori</div>
<img src="./menu/users.png">
</a>
</div>
<%end if%>


<%If limiteduser=False AND Session("allow_contenuti"&numproject)=True Then%>


<div class="sMenu" style="background:#01b32b">
<a href="list.asp?tabella=testimonianze">
<div>Testimonial</div>
<img src="./menu/Tags.png">
</a>
</div>

<div class="sMenu" style="background:#3cfd08">
<a href="list.asp?tabella=sponsors"><div>Sponsors</div>
<img src="./menu/templates.png"></a>
</div>

<%if Session("adm_intimages")=True then%>
<div class="sMenu hMenu" style="background:#ca00e2">
<a href="diaporama.asp">
<div>Slideshow</div>
<img src="./menu/slideshow.png">
</a>
</div>

<div class="sMenu hMenu" style="background:#ff2a00">
<a href="list_images1.asp">
<div>Immagini</div>
<img src="./menu/images.png">
</a>
</div>
<%end if%>
<%end if%>

<%if Session("allow_languages"&numproject)=True AND Session("adm_languages")=True then%>

<div class="sMenu" style="background:#30e9d5">
<a href="languages.asp">
<div><script type="text/javascript">document.write(menu7);</script></div>
<img src="./menu/lingue.png">
</a>
</div>

<%end if%>

<!--VB:Aggiunta del tasto per la gestione degli Amici di progettiamo (sempre visibile)-->
<div class="sMenu" style="background: #0e4430">
<a href="amici.asp">
<div>Amici</div>
<img src="./menu/users.png">
</a>
</div>

<%if Session("adm_admusers")=True then%>

<div class="sMenu" style="background: #0e5d30">
<a href="utenti.asp">
<div>Utenti Admin</div>
<img src="./menu/users.png">
</a>
</div>

<div class="sMenu" style="background:#01b32b">
<a href="list.asp?tabella=formulari">
<div>Formulari</div>
<img src="./menu/Tags.png">
</a>
</div>

<%end if%>


<%if Session("adm_config")=True then%>
<div class="sMenu" style="background: #e11a19">
<a href="newsletter.asp">
<div>Newsletter</div>
<img src="./menu/newsletter.png">
</a>
</div>
<%end if%>

<div class="sMenu" style="background: #01b32b">
<a href="/download/progettiamo_guida_admin_ERS.pdf" target="_blank">
<div>Guida</div>
<img src="./menu/guida.png">
</a>
</div>


<div class="sMenu" style="background:#6b6b6b">
<a href="password.asp">
<div>Password</div>
<img src="./menu/password.png">
</a>
</div>

<div class="sMenu" style="background: #04aeda">
<a href="./set_preview.asp" target="_blank">
<div>Site View</div>
<img src="./menu/preview.png">
</a>
</div>

<%if Session("adm_config")=True then%>
<div class="sMenu" style="background: #6b6b6b">
<a href="edit.asp?tabella=_config_main&amp;pagina=1" target="editing_page" onclick="setEditing();"  >
<div><script type="text/javascript">document.write(menu1);</script></div>
<img src="./menu/configura.png">
</a>
</div>
<%end if%>

<%if len(Session("licensekey"))>0 then%>
<div class="sMenu" style="background: #6b6b6b">
<a href="edit.asp?tabella=_config_admin&pagina=1"  target="editing_page" onclick="setEditing();" >
<div><b>Adv.Config</b></div>
<img src="./menu/configura.png"></a>
</div>
<%End if%>

<!--VB:Aggiunta del tasto per Video Home (sempre visibile)-->
<div class="sMenu" style="background: #7e4430">
<a href="videohome.asp">
<div><b>Video Home</b></div>
    <img alt="" src="./menu/videohomeicon.png"/></a>
</div>

<div class="sMenu" style="background: #0081b5">
<a href="logout.asp">
<div>Log Out</div>
<img src="./menu/logout.png">
</a>
</div>

<div class="sMenu closeMenu" style="background: #000 ; border:0px;">
<a href="javascript: closeMainMenu()">
<div>Chiudi Menù</div>
<img src="./menu/close.png">
</a>
</div>

</div></div>
<iframe id="editing_page" name="editing_page" width="750" height="660" scrolling="no" frameborder="0" src="blank.asp"></iframe>