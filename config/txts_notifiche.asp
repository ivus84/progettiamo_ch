
<%
'MAIL HEADER AND FOOTER
str_txt_notifica_body ="<html><head><meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" /></head><body style=""font-family:arial"">"
str_txt_notifica_body_end ="<p>Grazie e a presto<br />Thank you and see you soon<br /><br />Team Progettiamo.ch</p><p><img src="""&site_mainurl&"images/progettiamo_logo_mail.png""/></p></body></html>"

'DELETE ACCOUNT
str_notifica_delaccount="<p>Caro/a utente di <b>progettiamo.ch</b>,</p><p>abbiamo ricevuto una richiesta di cancellazione per il tuo account - su progettiamo.ch</p>"&_
"<p>Se non desideri cancellare l'account puoi ignorare questo messaggio.</p><p>Se invece vuoi confermare la cancellazione dell'account fai <a href="""&site_mainurl&"deleteaccount/?#StrDigest#"">click qui</a><br/><br/>oppure copia e incolla nel tuo navigatore il seguente link<br/> "&site_mainurl&"deleteaccount/?#StrDigest#</p>"&_
"<p><br>"&_
"<p>Dear user of <b>progettiamo.ch</b>,</p><p>we have received a cancellation request associated with your account on progettiamo.ch .</p>"&_
"<p>If you do not want to cancel your account, you can ignore this message.</p><p>If you want to confirm the cancellation of your account <a href="""&site_mainurl&"deleteaccount/?#StrDigest#"">click here</a><br/><br/>or copy the following link and paste it into your browser<br/> "&site_mainurl&"deleteaccount/?#StrDigest#</p>"

str_subject_delaccount="Cancellazione account su progettiamo.ch/ Cancellation of an account on progettiamo.ch"



'EDIT EMAIL
str_notifica_modemail="<p>Caro/a utente di <b>progettiamo.ch</b>,</p><p>abbiamo ricevuto una richiesta di modifica dell'e-mail di accesso per il tuo account di progettiamo.ch</p>"&_
"<p>Per confermare la modifica dell'e-mail fai <a href="""&site_mainurl&"confirmemail/?#StrDigest#"">click qui</a><br/><br/>oppure copia e incolla nel tuo navigatore il seguente link<br/> "&site_mainurl&"confirmemail/?#StrDigest#</p><p>Grazie<br/>Progettiamo.ch</p><p>Se non desideri effettuare la modifica puoi ignorare questo messaggio.</p>"&_
"<p><br>"&_
"<p>Dear user of <b>progettiamo.ch</b>,</p><p>we have received a change request for the primary email associated with your account on progettiamo.ch</p>"&_
"<p>To confirm the change of your email, <a href="""&site_mainurl&"confirmemail/?#StrDigest#"">click here</a><br/><br/> or copy the following link and paste it into your browser <br/> "&site_mainurl&"confirmemail/?#StrDigest#</p><p>Thank you<br/>Progettiamo.ch</p><p>If you do not want to make the change, you can ignore this message.</p>"

str_subject_modemail="Modifica dati di accesso su progettiamo.ch/ Changing login data on progettiamo.ch"



'RETREIVE Password
str_notifica_retrpass="<p>Caro/a utente di <b>progettiamo.ch</b>,</p><p>su richiesta effettuata dalla pagina di accesso di progettiamo.ch, ti inviamo una nuova password per accedere alle funzionalit&agrave; della piattaforma.<br/><br/>Email di accesso: #user_email#<br/><br/>Nuova password: #user_password#</p>"&_
"<p><br>"&_
"<p>Dear user of <b>progettiamo.ch</b>,</p><p> as your request is sent from the login page of progettiamo.ch, we send you a new password to access functionalities of the platform.<br/><br/>Primary email: #user_email#<br/><br/>New password: #user_password#</p>"

str_subject_retrpass="Recupero password su progettiamo.ch/Retrieve password on progettiamo.ch"



'CREATE ACCOUNT
str_notifica_signup="<p>Benvenuto/a su progettiamo.ch!</p><p>Abbiamo ricevuto una richiesta di apertura account per il tuo indirizzo e-mail sulla piattaforma di crowdfunding progettiamo.ch.</p>"&_
"<p>Per confermare l'account fai <a href="""&site_mainurl&"confirm/?#StrDigest#"">click qui</a><br/><br/>oppure copia e incolla nel tuo navigatore il seguente link<br/> "&site_mainurl&"confirm/?#StrDigest#</p><p>Se non desideri confermare l'apertura dell'account puoi ignorare questo messaggio.</p><p>Nota: l'account di progettiamo.ch &egrave; totalmente gratuito e viene tutelata la privacy dei dati di contatto inseriti.</p>"&_
"<p><br>"&_
"<p>Welcome to progettiamo.ch!</p><p>We have received a request for account opening associated with your email address on the crowdfunding platform progettiamo.ch.</p>"&_
"<p>To confirm the account, <a href="""&site_mainurl&"confirm/?#StrDigest#"">click here</a><br/><br/>or copy the following link and paste it into your browser<br/> "&site_mainurl&"confirm/?#StrDigest#</p><p>If you do not want to confirm the opening of the account, you can ignore this message.</p><p>Note: the account of progettiamo.ch is completely free, and confidentiality of the included contact information is guaranteed.</p>"

str_subject_signup="Benvenuto/a su progettiamo.ch/ Welcome to progettiamo.ch"

'SEND PASSWORD FROM ADMIN
str_notifica_sendpass="<p>Caro/a utente di <b>progettiamo.ch</b>,</p><p>con la presente ti inviamo la password per accedere alle funzionalit&agrave; della piattaforma.<br/><br/>Email di accesso: #user_email#<br/><br/>Password: #user_password#</p>"&_
"<p><br>"&_
"<p>Dear user of <b>progettiamo.ch</b>,</p><p> we hereby send you the password to  access functionalities of the platform.<br/><br/>Primary emai: #user_email#<br/><br/>Password: #user_password#</p>"

str_subject_sendpass="La tua password su progettiamo.ch/ Your password on progettiamo.ch"

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
str_notifica_senddonate="<p>Caro/a utente di <b>progettiamo.ch</b>,</p>"&Chr(10)&"<p>I promotori del progetto ""<b>#project_name#</b>"" e il team di progettiamo.ch ti ringraziano per il tuo importante contributo!</p><p>Abbiamo ricevuto la seguente promessa di finanziamento dal tuo account:</p><p>Progetto sostenuto:<br/><b>#project_name#</b><br/>Cifra promessa:<br/><b>#donation_value# Fr.</b><br/><br/>"&Chr(10)&"</p>"&Chr(10)&"<p><i>Se desideri rimanere aggiornato sui nuovi progetti inseriti su progettiamo.ch, ti invitiamo a <a href="""&site_mainurl&"newsletter/"">iscriverti alla nostra newsletter</a>.</i></p>"&Chr(10)&"<p>Nota: se non hai inviato personalmente la promessa di contributo o se ritieni contenga degli errori, ti preghiamo di metterti al pi&ugrave; presto in contatto con noi all'indirizzo <a href=""mailto:#mail_area#"">#mail_area#</a></p>"&_
"<p><br>"&_
"<p>Dear user of <b>progettiamo.ch</b>,</p>"&Chr(10)&"<p>the promoters of the project ""<b>#project_name#</b>""  and the team of progettiamo.ch thank you for your important contribution!</p><p>We have received the following promise of funding from your account:</p><p>Project supported:<br/><b>#project_name#</b><br/>Amount promised:<br/><b>#donation_value# Fr.</b><br/><br/>"&Chr(10)&"</p>"&Chr(10)&"<p><i>If you want to stay updated on new projects added to progettiamo.ch, we invite you <a href="""&site_mainurl&"newsletter/"">to subscribe to our newsletter.</a>.</i></p>"&Chr(10)&"<p>Note : if you did not send the promise of funding personally or you think the promise contains errors, we ask you to contact us as quickly as possible at the address <a href=""mailto:#mail_area#"">#mail_area#</a></p>"

str_subject_senddonate="Grazie per la tua promessa di finanziamento su progettiamo.ch/ Thanks for your promise of funding on progettiamo.ch"


'NOTIFICA COMMENTO
str_notifica_commento="<p>Caro/a utente di <b>progettiamo.ch</b>,</p>"&Chr(10)&"<p>&Egrave; stato inserito un nuovo commento alla news #news_title# del progetto #project_name#</p><p>Testo del commento:</p>"&Chr(10)&"<p><i>#txt_comment#</i></p>"&_
"<p><br>"&_
"<p>Dear user of <b>progettiamo.ch</b>,</p>"&Chr(10)&"<p>A new comment has been added to the news #news_title# of the project #project_name#</p><p>Text of the comment:</p>"&Chr(10)&"<p><i>#txt_comment#</i></p>"

str_subject_commento="Notifica nuovo commento al progetto/ Notification of a new comment on the project  #project_name#"

'NOTIFICA AGGIORNAMENTO
str_subject_news="Notifica news di progetto/ Notification of the news of the project #project_name#"
str_txtmail_news="&Egrave; stato inserita una nuova news per il progetto <b>#project_name#</b><br/><br/>Titolo news: <b>#news_title#</b><br/><br/>Testo news:<br/><i>#news_text#</i><br/><br/>Collegarsi all'area amministrazione per approvare la pubblicazione dell'aggiornamento."&_
"<p><br>"&_
"A recent news of the project  <b>#project_name#</b> has been added<br/><br/>News title: <b>#news_title#</b><br/><br/>News text:<br/><i>#news_text#</i><br/><br/>Please connect to the admin area to get the publication of the update approved."

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
str_subject_notifica_default="Notifica status progetto #project_name# su progettiamo.ch/ Status notification of the project #project_name# on progettiamo.ch"
str_subject_notifica_pdeleted="Notifica chiusura progetto #project_name# su progettiamo.ch/ Closure notification of the project #project_name# su/on progettiamo.ch"
str_subject_notifica_pdone="Obiettivo raggiunto!/ Target is achieved!"
str_subject_notifica_prealized="Il progetto è diventato realtà !/ The project has become reality!"

str_notifica_saluto="<p>Caro/a utente di progettiamo.ch,</p>"&_
"<p>Dear user of progettiamo.ch,</p>"

str_notifica_nota="<p>Nota: ricevi questa email in base alle impostazioni di notifica del tuo account su progettiamo.ch.</p>"&_
"<p><br>"&_
"<p>Note: you receive this email in accordance with notification settings of your account on progettiamo.ch.</p>"

str_notifica_status_target="siamo lieti di informarti che il progetto <b>#project_name#</b> ha raggiunto il <b>#status_write#</b> &#37; della cifra obiettivo."&_
"<p><br>"&_
"We are happy to inform you that the project <b>#project_name#</b> has achieved the <b>#status_write#</b> &#37; target amount."

str_notifica_status_mancano="<br/><br/>Mancano ancora: Fr. #donation_value#"&_
"<br/><br/>We still have to collect: Fr. #donation_value#"

str_notifica_status_raggiunto="Notifica status progetto <b>#project_name#</b><br/><br/>Il progetto ha raggiunto o superato il 100&#37; della cifra obiettivo<br/>Accedere all'amministrazione progetti per verificare le promesse di finanziamento."&_
"<p><br>"&_
"Notification status of the project <b>#project_name#</b><br/><br/>The project has achieved or exceeded 100&#37; of the target amount<br/>Access the project administration to check the promises of funding."

str_notifica_status_done="siamo molto lieti di informarti che il progetto <b>#project_name#</b> ha raggiunto o superato il 100&#37; della sua cifra obiettivo.</p><p>La raccolta fondi ha avuto successo!<br/>Grazie di cuore per aver contribuito a questo risultato!</p><p>Il crowdfunding &egrave; ora concluso e le promesse di contributo raccolte verranno consegnate al promotore del progetto. Sarai dunque contattato dal promotore di progetto per il versamento della tua promessa."&_
"<p><br>"&_
"We are very happy to inform you that the project <b>#project_name#</b> has achieved or exceeded 100&#37; of its target amount.</p><p>The crowdfunding has been successful!<br/>Thank you very much for your contribution to this result!</p><p>The crowdfunding is now finished and the collected promises of funding will be sent to the project promoter. Therefore, you will be contacted by the promoter for the payment of your promise."&_
"<p><br>"

str_notifica_status_raggiunto_done="Notifica status progetto <b>#project_name#</b><br/><br/>Il progetto ha raggiunto o superato il 100&#37; della cifra obiettivo<br/><br/>La data di termine della raccolta fondi &egrave; terminata.</br/><br/>Accedere all'amministrazione progetti per verificare le promesse di finanziamento."&_
"<p><br>"&_
"Status notification of the project <b>#project_name#</b><br/><br/>The project has achieved or exceeded 100&#37; of the target amount<br/><br/>The fundraising is finished.</br/><br/>Access the project administration to check the promises of funding."

str_notifica_status_scaduto="Notifica status progetto <b>#project_name#</b><br/><br/>Il progetto NON ha raggiunto il 100&#37; (<b>#status_write#</b>&#37; raggiunto)<br/>La data di termine della raccolta fondi &egrave; terminata.<br/>Accedere all'amministrazione progetti per prorogare o chiudere il progetto<br/>"&_
"<p><br>"&_
"Notification status of the project <b>#project_name#</b><br/><br/>The project has NOT achieved 100&#37; (<b>#status_write#</b>&#37; achieved)<br/>The fundraising is finished. <br/>Access the project administration to extend the duration of or close the project<br/>"

str_notifica_status_closed="il progetto <b>#project_name#</b> non ha purtroppo raggiunto la propria cifra obiettivo entro la scadenza prevista ed &egrave; quindi stato chiuso.</p><p>Le promesse di finanziamento raccolte vengono annullate.</p><p>A tua discrezione, se ti fa piacere puoi versare l'importo promesso su un altro progetto"&_
"<p><br>"&_
"Unfortunately, the project <b>#project_name#</b> has not achieved its target amount by the established deadline and is therefore closed.</p><p>The collected promises of funding are cancelled.</p><p>At your discretion, if you like, you can pay the promised amount in favour of another project"

str_notifica_status_realized="siamo felici di informarti che il progetto <b>#project_name#</b> &egrave; stato <b>realizzato</b>.</p><p>Non sarebbe stato possibile senza il tuo contributo: <b>grazie!</b> "&_
"<p><br>"&_
"we are happy to inform you that the project <b>#project_name#</b> has been completed</b>.</p><p>It would not have been possible without your contribution: <b>thank you!</b> "

str_notifica_status_news="scopri le novit&agrave; del progetto <b>#project_name#</b> visitando la scheda del progetto.</p><p>Grazie per il tuo interesse!"&_
"<p><br>"&_
"Discover the news of the project <b>#project_name#</b> by seeing the project tab.</p><p>Thank you for your interest!"


str_notifica_status_link="<p><a href=""#project_link#"">Apri la scheda del progetto</a></p>"&_
"<p><br>"&_
"<p><a href=""#project_link#"">Open the project tab</a></p>"
%>