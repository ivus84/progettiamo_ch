<%
'MAIL HEADER AND FOOTER
str_txt_notifica_body ="<html><head><meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" /></head><body style=""font-family:arial"">"
str_txt_notifica_body_end ="<p>Merci et &agrave; bient&ocirc;t<br /><br />Team Progettiamo.ch</p><p><img src="""&site_mainurl&"images/progettiamo_logo_mail.png""/></p></body></html>"

'DELETE ACCOUNT
str_notifica_delaccount="<p>Cher/&egrave;re utilisateur/trice de <b>progettiamo.ch</b>,</p><p>nous avons re&ccedil;u une demande de suppression associ&eacute;e &agrave; votre compte sur progettiamo.ch</p>"&_
"<p>Si vous ne voulez pas supprimer votre compte, vous pouvez ignorer ce message.</p><p>Si vous voulez confirmer la suppression du compte, veuillez <a href="""&site_mainurl&"deleteaccount/?#StrDigest#"">cliquer ici</a><br/><br/>ou copier le lien suivant et le coller dans votre navigateur<br/> "&site_mainurl&"deleteaccount/?#StrDigest#</p>"&_
"<p><br>"
str_subject_delaccount="Suppression d'un compte sur progettiamo.ch"



'EDIT EMAIL
str_notifica_modemail="<p>Cher/&egrave;re utilisateur/trice de <b>progettiamo.ch</b>,</p><p>nous avons re&ccedil;u une demande de modification de l'e-mail principal associ&eacute; &agrave; votre compte sur progettiamo.ch</p>"&_
"<p>Pour confirmer la modification de l'e-mail, veuillez <a href="""&site_mainurl&"confirmemail/?#StrDigest#""> cliquer ici</a><br/><br/>ou copier le lien suivant et le coller dans votre navigateur<br/> "&site_mainurl&"confirmemail/?#StrDigest#</p><p>Merci<br/>Progettiamo.ch</p><p>Si vous ne voulez pas effectuer la modification, vous pouvez ignorer ce message.</p>"&_
"<p><br>"
str_subject_modemail="Modifiez des données de connexion à progettiamo.ch"



'RETREIVE Password
str_notifica_retrpass="<p>Cher/&egrave;re utilisateur/trice de <b>progettiamo.ch</b>,</p><p>comme votre demande a &eacute;t&eacute; faite depuis la page d'acc&egrave;s de progettiamo.ch, nous vous envoyons un nouveau mot de passe pour acc&eacute;der aux fonctionnalit&eacute;s de la plateforme.<br/><br/>E-mail principal: #user_email#<br/><br/>Nouveau mot de passe: #user_password#</p>"&_
"<p><br>"
str_subject_retrpass="Récupérer le mot de passé sur progettiamo.ch"



'CREATE ACCOUNT
str_notifica_signup="<p>Bienvenue sur progettiamo.ch!</p><p>Nous avons re&ccedil;u une demande d'ouverture de compte associ&eacute;e &agrave; votre adresse e-mail sur la plateforme de financement participatif progettiamo.ch.</p>"&_
"<p>Pour confirmer le compte, veuillez <a href="""&site_mainurl&"confirm/?#StrDigest#"">cliquer ici</a><br/><br/>ou copier le lien suivant et le coller dans votre navigateur<br/> "&site_mainurl&"confirm/?#StrDigest#</p><p>Si vous ne souhaitez pas confirmer l'ouverture du compte, vous pouvez ignorer ce message.</p><p>Note: le compte de progettiamo.ch est totalement gratuit et la confidentialit&eacute; des coordonn&eacute;es de contact introduites est garantie.</p>"&_
"<p><br>"
str_subject_signup="Bienvenue sur progettiamo.ch"

'SEND PASSWORD FROM ADMIN
str_notifica_sendpass="<p>Cher/&egrave;re utilisateur/trice de <b>progettiamo.ch</b>,</p><p>par la pr&eacute;sente, nous vous envoyons le mot de passe pour acc&eacute;der aux fonctionnalit&eacute;s de la plateforme.<br/><br/>E-mail principal: #user_email#<br/><br/>Mot de passe: #user_password#</p>"&_
"<p><br>"
str_subject_sendpass="Votre mot de passe sur progettiamo.ch"

'SEND PROJECT FOR APPROVAL
str_notifica_sendproject="<p>Caro/a promotore/trice di progetto,</p><p>Abbiamo ricevuto la tua richiesta per la pubblicazione di un nuovo progetto sulla piattaforma di crowdfunding <b>progettiamo.ch</b></p>"&_
"#txt_project#<p>Il team di progettiamo.ch sta verificando il tuo progetto. Se le informazioni sono complete il tuo progetto sar&agrave; presto online.</p>"
str_subject_sendproject="Richiesta pubblicazione progetto su progettiamo.ch"

'PROJECT REJECTED
str_notifica_rejectproject="<p>Caro/a promotore/trice di progetto,</p><p>la richiesta di pubblicazione del tuo progetto sulla piattaforma di crowdfunding progettiamo.ch <b>non &egrave; al momento stata convalidata</b>.</p>#txt_project#<p><b>Motivazione</b>:<br/><i>#txt_reject#</i></p><p>Se desideri maggiori informazioni sul motivo del rifiuto, puoi metterti in contatto con noi all'indirizzo <a href=""mailto:#mail_area#"">#mail_area#</a></p>"
str_subject_rejectproject="Pubblicazione progetto non convalidata"

'PROJECT NEWS APPROVED
str_notifica_approve_news_project="<p>Caro/a promotore/trice di progetto,</p><p>Conferma pubblicazione <b>aggiornamento progetto</b> su <b>progettiamo.ch</b><br/><br/>&egrave; stata confermata la pubblicazione della tua news di progetto sulla piattaforma di crowdfunding <b>progettiamo.ch</b>.</p>"&_
"<p>Progetto:<br/><b>#project_name#</b></p><p>Link alla scheda progetto:<br/><a href=""#project_link#"">#project_link#</a></p>"
str_subject_approve_news_project="Pubblicazione aggiornamento su progettiamo.ch"

'PROJECT APPROVED
str_notifica_approve_project="<p>Caro/a promotore/trice di progetto,</p><p>siamo lieti di comunicarti che abbiamo pubblicato il tuo progetto sulla piattaforma di crowdfunding <b>progettiamo.ch</b>.</p>"&_
	"#txt_project#<p>Link alla scheda progetto:<br/><a href=""#project_link#"">#project_link#</a></p><p>Ed infine, ecco alcuni consigli per promuovere il tuo progetto:</p><p><ol><li><b>I promotori pi&ugrave; attivi sono vincenti</b>! I progetti pi&ugrave; visitati e con maggiore successo sono quelli con <b>promotori attivi</b>. Fai sapere ad amici e conoscenti che &egrave; in corso una raccolta fondi per il tuo progetto ed invitali a dare un contributo, per esempio attraverso:<ul><li>La pubblicazione del progetto sulla tua pagina Facebook o su altri social network<br/><br/></li><li>L'invio di una mail a tutti a tutti i tuoi contatti con il link al tuo progetto su progettiamo.ch </li><li>Ma soprattutto, attraverso il passaparola!</li></ul></li><li><b>Coinvolgi persone o enti vicini al progetto</b>! I primi finanziamenti dovrebbero venire dalla cerchia di amici e conoscenti del promotore (finanziamenti ""sulla fiducia""), dopodich&eacute; il cerchio si allarga man mano. Vale la regola che <b>chi riceve contributi ne attira sempre di pi&ugrave;</b>, mentre &egrave; da sfatare l'idea che i contributi vengono spalmati proporzionalmente su tutti i progetti o che la gente aiuta i progetti con meno finanziamenti!<br/><br/></li><li><b>Utilizza le news</b>! Gli esperti del crowdfunding dicono che &egrave; 10 volte pi&ugrave; facile ricevere i contributi che portano un progetto dal 50&#37; al 100&#37;, rispetto a ricevere i contributi che portano un progetto dallo 0&#37; al 50&#37;. Usa dunque la possibilit&agrave; di <b>inserire gli altri mezzi finanziari</b> che il tuo progetto ha gi&agrave; a disposizione, sia per una questione di trasparenza sia proprio perch&eacute; ci&ograve; avvantaggia i progetti. Le news sono infine un altro strumento da utilizzare per promuovere attivamente i progetti!</li></ul></p>"
str_subject_approve_project="Complimenti, il tuo progetto è su progettiamo.ch"

'DONATION MADE
str_notifica_senddonate="<p>Cher/&egrave;re utilisateur/trice de <b>progettiamo.ch</b>,</p>"&Chr(10)&"<p> les promoteurs du projet ""<b>#project_name#</b>"" et l'&eacute;quipe de progettiamo.ch vous remercient pour votre importante contribution!</p><p>Nous avons re&ccedil;u la promesse de financement suivante depuis votre compte: </p><p>Projet soutenu:<br/><b>#project_name#</b><br/>Montant promis:<br/><b>#donation_value# Fr.</b><br/><br/>"&Chr(10)&"</p>"&Chr(10)&"<p><i>Si vous souhaitez être tenu au courant des nouveaux projets introduits sur progettiamo.ch, nous vous invitons &agrave; vous <a href="""&site_mainurl&"newsletter/"">inscrire &agrave; notre</a>.</i></p>"&Chr(10)&"<p>Note : si vous n'avez pas envoy&eacute; la promesse vous-même ou vous pensez qu'elle contient des erreurs, nous vous demandons de nous contacter le plus vite possible &agrave; l'adresse: <a href=""mailto:#mail_area#"">#mail_area#</a></p>"&_
"<p><br>"
str_subject_senddonate="Merci pour votre promesse de financement sur progettiamo.ch"


'NOTIFICA COMMENTO
str_notifica_commento="<p>Cher/&egrave;re utilisateur/trice de <b>progettiamo.ch</b>,</p>"&Chr(10)&"<p>Un nouveau commentaire a &eacute;t&eacute; introduit au module de news #news_title# du projet #project_name#</p><p>Texte du commentaire:</p>"&Chr(10)&"<p><i>#txt_comment#</i></p>"&_
"<p><br>"
str_subject_commento="Notification d'un nouveau commentaire relatif au projet"

'NOTIFICA AGGIORNAMENTO
str_subject_news="Notification des news relatives au projet"
str_txtmail_news="Une news du projet <b>#project_name#</b> a &eacute;t&eacute; ajout&eacute;e<br/><br/>Titre de la news: <b>#news_title#</b><br/><br/>Texte de la news:<br/><i>#news_text#</i><br/><br/>Veuillez vous connecter &agrave; la zone d'administration pour faire approuver la publication de la mise &agrave; jour."&_
"<p><br>"
'NOTIFICA 1 settimana
str_subject_week="La prima settima su progettiamo.ch per il progetto #project_name#"
str_txtmail_week="Caro #promoter_name#<br/><b>#project_name#</b> &egrave; online su progettiamo.ch da 1 settimana! In questo breve tempo hai raccolto #tot_chf# e #tot_visits# visite al progetto! Ecco qualche consiglio utile per una raccolta fondi di successo:<br/><br/><ul><li>Spargi la voce: pi&ugrave; persone saranno a conoscenza del tuo progetto, maggiore &egrave; la possibilit&agrave; di ricevere donazioni. Inoltre ogni persona che conosce <b>#project_name#</b> potr&agrave; spargere la voce ad altri e fare conoscere la tua iniziativa!</li><li>Usa la comunicazione visiva: immagini e video sono il modo pi&ugrave; immediato per trasmettere in maniera chiara ed efficace il tuo messaggio e ti aiuteranno molto a trovare chi &egrave; interessato a sostenere la tua causa.</li></ul><br/>In bocca al lupo dal team di progettiamo.ch"

'NOTIFICA 1 mese
str_subject_month="Il primo mese su progettiamo.ch per il progetto #project_name#"
str_txtmail_month="Caro #promoter_name#<br/>Il tuo progetto <b>#project_name#</b> festeggia oggi il suo primo mese su progettiamo.ch. Finora hai raccolto #tot_chf# CHF e ti restano #daystogo# giorni per raggiungere la tua cifra obiettivo. Ecco alcuni consigli che ti aiuteranno a raccogliere il restante #percent_togo#%:<br/><ul>Sii attivo: il crowdfunding, in particolare all&#39;inizio di una campagna, ha bisogno di una costante attenzione e di un motore che lavora a pieno regime. Sfrutta tutti i canali di comunicazione a tua disposizione per parlare di  <b>#project_name#</b> e della raccolta fondi su progettiamo.ch.</li><li>Se non l&#39;hai ancora fatto crea una pagina facebook  <b>#project_name#</b> e assicurati che abbia pi&ugrave; ""mi piace"" e condivisioni possibili. Indica chiaramente nella pagina il link per donare fondi al tuo progetto su progettiamo.ch.</li><li>Tieni tutti aggiornati: pubblica regolarmente news nella sezione dedicata di progettiamo.ch, chi crede nel tuo progetto e i possibili finanziatori sono interessati a sapere come si sviluppa.</li></ul><br/>Buon lavoro dal team di progettiamo.ch"

'NOTIFICA manca 1 mese
str_subject_onemonth="Gli ultimi 30 giorni su progettiamo.ch per il progetto #project_name#"
str_txtmail_onemonth="Caro #promoter_name#<br/>Mancano 30 giorni alla chiusura di <b>#project_name#</b> e hai raccolto il #status_write#% della tua cifra obiettivo. Ecco un sommario della tua campagna:<br/>Visite al progetto: #tot_visits#<br/>Finanziatori: #tot_donators#<br/>Cifra raccolta: Chf #tot_chf#<br/>Cifra obiettivo: Chf #tot_target#<br/><br/>Ora &egrave; il momento dello sprint finale, cerca di essere il pi&ugrave; attivo possibile e dare il massimo per raggiungere la cifra obiettivo.<br/>Il team di progettiamo.ch fa il tifo per te!"


'NOTIFICHE STATUS
str_subject_notifica_default="Notification du statut du projet sur progettiamo.ch"
str_subject_notifica_pdeleted="Notification de la clôture du projet sur progettiamo.ch"
str_subject_notifica_pdone="Objectif atteint!"
str_subject_notifica_prealized="Le projet est devenu réalité!"

str_notifica_saluto="<p>Cher/&egrave;re utilisateur/trice de progettiamo.ch,</p>"

str_notifica_nota="<p>Note: vous recevez ce message conform&eacute;ment aux configurations de notification de votre compte sur progettiamo.ch.</p>"&_
"<p><br>"
str_notifica_status_target="Nous sommes heureux de vous informer que le projet <b>#project_name#</b> a atteint <b>#status_write#</b> &#37; du montant cible."&_
"<p><br>"
str_notifica_status_mancano="<br/><br/>Il nous manque encore: Fr. #donation_value#"

str_notifica_status_raggiunto="Notification du statut du projet <b>#project_name#</b><br/><br/>Le projet a atteint ou d&eacute;pass&eacute; 100&#37; du montant cible<br/>Acc&eacute;der &agrave; l'administration de projets pour v&eacute;rifier les promesses de financement."&_
"<p><br>"
str_notifica_status_done="Nous sommes tr&egrave;s heureux de vous informer que le projet <b>#project_name#</b> a atteint ou d&eacute;pass&eacute; 100&#37; de son montant cible.</p><p>La collecte de fonds a &eacute;t&eacute; un succ&egrave;s!<br/>Merci beaucoup d'avoir contribu&eacute; &agrave; ce r&eacute;sultat!</p><p>La collecte de fonds est maintenant termin&eacute;e et les promesses de financement r&eacute;colt&eacute;es seront envoy&eacute;es au promoteur du projet. Vous serez donc contact&eacute; par le promoteur du projet pour le paiement de la somme promise."&_
"<p><br>"

str_notifica_status_raggiunto_done="Notification du statut du projet <b>#project_name#</b><br/><br/>Le projet a atteint ou d&eacute;pass&eacute; 100&#37; du montant cible<br/><br/>La collecte de fonds est termin&eacute;e.</br/><br/>Acc&eacute;der &agrave; l'administration de projets pour v&eacute;rifier les promesses de financement."&_
"<p><br>"
str_notifica_status_scaduto="Notification du statut du projet <b>#project_name#</b><br/><br/>Le projet N'A PAS atteint 100&#37; (<b>#status_write#</b>&#37; atteint)<br/>La collecte de fonds est termin&eacute;e.<br/>Acc&eacute;der &agrave; l'administration de projets pour prolonger la dur&eacute;e du projet ou le fermer<br/>"&_
"<p><br>"
str_notifica_status_closed="Le projet <b>#project_name#</b> n'a pas malheureusement atteint son montant cible dans le d&eacute;lai pr&eacute;vu, il est donc ferm&eacute;.</p><p>Les promesses de financement r&eacute;colt&eacute;es sont annul&eacute;es.</p><p>Si vous voulez, vous pouvez effectuer le paiement de la somme promise en faveur  d'un autre projet"&_
"<p><br>"
str_notifica_status_realized="Nous sommes heureux de vous informer que le <b>#project_name#</b> a &eacute;t&eacute; r&eacute;alis&eacute;</b>.</p><p> Cela n'aurait pas &eacute;t&eacute; possible sans votre contribution: <b>merci!</b> "&_
"<p><br>"
str_notifica_status_news="D&eacute;couvrez les nouveaut&eacute;s du projet <b>#project_name#</b> en visitant la fiche du projet.</p><p>Merci pour votre int&eacute;rêt!"&_
"<p><br>"


str_notifica_status_link="<p><a href=""#project_link#"">Ouvrez la fiche du projet</a></p>"&_
"<p><br>"
%>