
<%
'MAIL HEADER AND FOOTER
str_txt_notifica_body ="<html><head><meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" /></head><body style=""font-family:arial"">"
str_txt_notifica_body_end ="<p>Vielen Dank und bis bald<br />Team Progettiamo.ch</p><p><img src="""&site_mainurl&"images/progettiamo_logo_mail.png""/></p></body></html>"

'DELETE ACCOUNT
str_notifica_delaccount="<p>Liebe/r Benutzer/in von <b>progettiamo.ch</b>,</p><p>wir haben einen L&ouml;schungsantrag f&uuml;r dein Konto auf progettiamo.ch erhalten</p>"&_
"<p>Falls du dein Konto nicht l&ouml;schen m&ouml;chtest, ignoriere diese Nachricht.</p><p>Falls du die Kontol&ouml;schung best&auml;tigen m&ouml;chtest, <a href="""&site_mainurl&"deleteaccount/?#StrDigest#""> klicke hier</a><br/><br/>oder kopiere folgenden Link und f&uuml;ge ihn in deinen Webbrowser ein<br/> "&site_mainurl&"deleteaccount/?#StrDigest#</p>"&_
"<p><br>"
str_subject_delaccount="Löschung des Kontos auf progettiamo.ch"



'EDIT EMAIL
str_notifica_modemail="<p>Liebe/r Benutzer/in von <b>progettiamo.ch</b>,</p><p> wir haben einen Antrag zur &Auml;nderung deiner E-Mail-Adresse f&uuml;r die Anmeldung zu deinem progettiamo.ch-Konto erhalten</p>"&_
"<p>Um die &Auml;nderung deiner E-Mail-Adresse zu best&auml;tigen, <a href="""&site_mainurl&"confirmemail/?#StrDigest#"">klicke hier</a><br/><br/>oder kopiere folgenden Link und f&uuml;ge ihn in deinen Webbrowser ein<br/> "&site_mainurl&"confirmemail/?#StrDigest#</p><p>Danke<br/>Progettiamo.ch</p><p>Falls du keine &Auml;nderung vornehmen m&ouml;chtest, ignoriere diese Nachricht.</p>"&_
"<p><br>"
str_subject_modemail="Zugangsdaten zu progettiamo.ch ändern"



'RETREIVE Password
str_notifica_retrpass="<p>Liebe/r Benutzer/in von <b>progettiamo.ch</b>,</p><p>aufgrund der Anfrage, die auf der Anmeldeseite get&auml;tigt wurde, senden wir dir ein neues Passwort f&uuml;r den Zugriff auf die Plattformfunktionen.<br/><br/>E-Mail-Adresse f&uuml;r die Anmeldung: #user_email#<br/><br/>Neues Passwort: #user_password#</p>"&_
"<p><br>"
str_subject_retrpass="Passwort auf progettiamo.ch wiederherstellen"



'CREATE ACCOUNT
str_notifica_signup="<p>Willkommen auf progettiamo.ch!</p><p>Wir haben von deiner E-Mail-Adresse eine Anfrage zur Kontoer&ouml;ffnung auf der Crowdfunding-Plattform progettiamo.ch erhalten.</p>"&_
"<p>Zur Kontobest&auml;tigung <a href="""&site_mainurl&"confirm/?#StrDigest#"">klicke hier</a><br/><br/>oder kopiere folgenden Link und f&uuml;ge ihn in deinen Webbrowser ein<br/> "&site_mainurl&"confirm/?#StrDigest#</p><p>Falls du die Kontoer&ouml;ffnung nicht best&auml;tigen willst, ignoriere diese Nachricht.</p><p>Bemerkung: Das Konto auf progettiamo.ch ist vollkommen kostenlos, der Schutz der Kontaktdaten wird gew&auml;hrt.</p>"&_
"<p><br>"
str_subject_signup="Willkommen auf progettiamo.ch!"

'SEND PASSWORD FROM ADMIN
str_notifica_sendpass="<p>Liebe/r Benutzer/in von <b>progettiamo.ch</b>,</p><p>hiermit senden wir dir das Passwort f&uuml;r den Zugang zu allen Plattformfunktionen.<br/><br/>E-Mail-Adresse f&uuml;r die Anmeldung: #user_email#<br/><br/>Passwort: #user_password#</p>"&_
"<p><br>"
str_subject_sendpass="Dein Passwort auf progettiamo.ch"

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
str_notifica_senddonate="<p>Liebe/r Benutzer/in von <b>progettiamo.ch</b>,</p>"&Chr(10)&"<p>die Tr&auml;ger des Projekts ""<b>#project_name#</b>""  und das Team von progettiamo.ch bedanken sich f&uuml;r deinen wichtigen Beitrag!</p><p>Wir haben folgende Finanzierungszusage von deinem Konto erhalten:</p><p>Unterst&uuml;tztes Projekt:<br/><b>#project_name#</b><br/>Zugesagte Summe:<br/><b>#donation_value# Fr.</b><br/><br/>"&Chr(10)&"</p>"&Chr(10)&"<p><i>Falls du weiterhin Updates &uuml;ber neue Projekte auf progettiamo.ch erhalten m&ouml;chtest, kannst du <a href="""&site_mainurl&"newsletter/"">unseren Newsletter abonnieren.</a>.</i></p>"&Chr(10)&"<p>Bemerkung: Hast nicht du pers&ouml;nlich die Beitragszusage get&auml;tigt? Oder sind in deiner Beitragszusage Fehler enthalten? Dann kontaktiere uns bitte unter folgender Adresse <a href=""mailto:#mail_area#"">#mail_area#</a></p>"&_
"<p><br>"
str_subject_senddonate="Herzlichen Dank für deine Finanzierungszusage auf progettiamo.ch"


'NOTIFICA COMMENTO
str_notifica_commento="<p>Liebe/r Benutzer/in von <b>progettiamo.ch</b>,</p>"&Chr(10)&"<p>Bei der News #news_title# zum Projekt #project_name# wurde ein neuer Kommentar eingef&uuml;gt</p><p>Kommentartext:</p>"&Chr(10)&"<p><i>#txt_comment#</i></p>"&_
"<p><br>"
str_subject_commento="Benachrichtigung über neue Kommentare zum Projekt"

'NOTIFICA AGGIORNAMENTO
str_subject_news="Benachrichtigung über News zum Projekt"
str_txtmail_news="Newstitel: <b>#news_title#</b><br/><br/>Newstext:<br/><i>#news_text#</i><br/><br/>Verbinde dich mit dem Verwaltungscenter, um die Ver&ouml;ffentlichung des Updates zu genehmigen."&_
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
str_subject_notifica_default="Benachrichtigung über den Stand des Projekts"
str_subject_notifica_pdeleted="Benachrichtigung über den Abschluss des Projekts"
str_subject_notifica_pdone="Ziel erreicht!"
str_subject_notifica_prealized="Das Projekt wurde verwirklicht!"

str_notifica_saluto="<p>Liebe/r Benutzer/in von progettiamo.ch,</p>"

str_notifica_nota="<p>Bemerkung: Du erh&auml;ltst diese E-Mail aufgrund der Benachrichtigungseinstellungen deines Kontos auf progettiamo.ch.</p>"&_
"<p><br>"
str_notifica_status_target="Wir freuen uns dich zu informieren, dass das Projekt <b>#project_name#</b> <b>#status_write#</b> &#37; die Zielsumme erreicht hat."&_
"<p><br>"
str_notifica_status_mancano="<br/><br/>Es fehlen noch: Fr. #donation_value#"

str_notifica_status_raggiunto="Benachrichtigung &uuml;ber den Stand des Projekts<b>#project_name#</b><br/><br/>Das Projekt hat die Zielsumme zu 100&#37; erreicht oder &uuml;berschritten<br/>Auf die Projektverwaltung zugreifen, um die Finanzierungszusagen zu &uuml;berpr&uuml;fen."&_
"<p><br>"
str_notifica_status_done="Wir freuen uns dich zu informieren, dass das Projekt <b>#project_name#</b> die Zielsumme zu 100&#37; erreicht oder &uuml;berschritten hat.</p><p>Die Spendensammlung war erfolgreich!<br/>Herzlichen Dank f&uuml;r deinen Beitrag!</p><p>Das Crowdfunding ist nun beendet und die gesammelten Beitragszusagen werden dem Projekttr&auml;ger &uuml;bergeben. Der Projekttr&auml;ger wird dich f&uuml;r die &uuml;berweisung des zugesagten Betrags kontaktieren."&_
"<p><br>"

str_notifica_status_raggiunto_done="Benachrichtigung &uuml;ber den Stand des Projekts <b>#project_name#</b><br/><br/>Das Projekt hat die Zielsumme zu 100&#37; erreicht oder &uuml;berschritten<br/><br/>Die Zeit ist abgelaufen, die Spendensammlung ist beendet.</br/><br/>Auf die Projektverwaltung zugreifen, um die Finanzierungszusagen zu &uuml;berpr&uuml;fen."&_
"<p><br>"
str_notifica_status_scaduto="Benachrichtigung &uuml;ber den Stand des Projekts <b>#project_name#</b><br/><br/>Das Projekt hat die 100&#37; -Marke NICHT erreicht (<b>#status_write#</b>&#37; erreicht)<br/>Die Zeit ist abgelaufen, die Spendensammlung ist beendet.<br/>Auf die Projektverwaltung zugreifen, um die Finanzierungszusagen zu &uuml;berpr&uuml;fen<br/>"&_
"<p><br>"
str_notifica_status_closed="Das Projekt <b>#project_name#</b> hat die Zielsumme in der vorgegebenen Zeit leider nicht erreicht und wurde somit beendet.</p><p>Die gesammelten Finanzierungszusagen werden annulliert.</p><p> Falls du m&ouml;chtest, kannst du den zugesagten Betrag gerne einem anderen Projekt zukommen lassen"&_
"<p><br>"
str_notifica_status_realized="Wir freuen uns dich zu informieren, dass das Projekt <b>#project_name#</b> realisiert wurde </b>.</p><p>Das w&auml;re ohne deinen Beitrag nicht m&ouml;glich gewesen: <b>Vielen Dank!</b> "&_
"<p><br>"
str_notifica_status_news="Gehe auf die Projekt&uuml;bersicht und entdecke die News zum Projek <b>#project_name#</b>.</p><p>Vielen Dank f&uuml;r dein Interesse!"&_
"<p><br>"

str_notifica_status_link="<p><a href=""#project_link#"">Projekt&uuml;bersicht &ouml;ffnen</a></p>"
%>