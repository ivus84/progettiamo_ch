<!--#INCLUDE VIRTUAL="./admin/load_connection.asp"-->

<%
titletop_en="User Guide"
titletop_de="User guide"
titletop_it="Guida utente"
titletop=Eval("titletop_"&langedit)

%>
<!--#INCLUDE VIRTUAL="./ADMIN/load_body.asp"-->
<!--#INCLUDE VIRTUAL="./ADMIN/main_menu.asp"-->
<%connection.close%>
<div id="content_page">

<p class="titolo"><%=titletop%></p>

<p>
<ol class="testoadm" style="padding:0px 16px;">
<li><a href="javascript:set_manual('it_p1.pdf');">Accesso e prerequisiti</a><br/><br/></li>
<li><a href="javascript:set_manual('it_p2.pdf');">Men&ugrave; principale</a><br/><br/></li>
<li><a href="javascript:set_manual('it_p3.pdf');">Gestione contenuti</a><br/><br/></li>
<li><a href="javascript:set_manual('it_p4.pdf');">Creazione di pagine e ordinamento</a><br/><br/></li>
<li><a href="javascript:set_manual('it_p5-6.pdf');">Editing di una pagina</a><br/><br/></li>
<li><a href="javascript:set_manual('it_p7-8.pdf');">Editing del testo</a><br/><br/></li>
<li><a href="javascript:set_manual('it_p9-11.pdf');">Inserimento link e immagini nel testo</a><br/><br/></li>
<li><a href="javascript:set_manual('it_p12.pdf');">Cestino</a><br/><br/></li>
<li><a href="javascript:set_manual('it_p13.pdf');">Gestione documenti</a><br/><br/></li>
<li><a href="javascript:set_manual('it_p15.pdf');">Gestione immagini</a><br/><br/></li>
<li><a href="javascript:set_manual('it_p14.pdf');">Lingue aggiuntive</a><br/><br/></li>
</ol>

</p>
</div>
<iframe id="setManual_site" width="810" height="660" style="position:relative; float:left; z-index:201;height:560px; margin-top:-300px; margin-left:190px;border:solid 1px #999999; overflow:auto; display:none" frameborder="no" src="blank.asp" ></iframe>
<div id="closeManual" style="position:relative; float:left;clear:both; z-index:101;margin-left:960px; margin-top:15px;display:none"><a href="javascript: close_manual()">CHIUDI</a></div>

<script type="text/javascript">
var obj=$("#setManual_site");
var obj1=$("#closeManual");

function set_manual(dest) {
obj.attr("src","./manual/"+dest);
obj.fadeIn()
obj1.fadeIn()
}

function close_manual() {
obj.attr("src","blank.asp");
obj.fadeOut()
obj1.fadeOut()
}

</script>

</body>
</html>

