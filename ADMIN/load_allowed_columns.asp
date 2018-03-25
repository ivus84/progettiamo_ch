<%
underdevelopment=", LO_allow_comments , CO_metodi_ecommerce , TA_dati_conto_corrente , TX_codizioni_vendita , TA_var1 , TA_var2 , TA_var3 , TA_var4 , TA_var5 , TA_var6 , LO_vis_var1 , LO_vis_var2 , LO_vis_var3 , LO_vis_var4 , LO_vis_var5 , LO_vis_var6 , LO_vis_price_CHF , LO_vis_price_EUR , LO_vis_price_USD , IN_var_iva , "

allowed_columns=" , IN_peso , AT_image , TA_taglie , TA_nazione , TA_regione , TA_provincia , TA_telefono1 , TA_cellulare , TA_cellulare1 , TA_fax , TA_qualifica , TA_tel , TA_via , TA_url , LO_available , IN_prezzo_CHF , LO_ecommerce , TA_mail_subject , TX_text_oblig , TX_datadef , TX_message , TX_message_after_send , CO_networking_grouptype , TA_nomev , TA_titolo , TA_grandezza , LO_allow_attachments , LO_close_posts , CO_networking_groups , CO_networking_themes , AT_file , LO_closed , CO_registeredusers ,  LO_auto_redirect ,  AT_foto1 , AT_foto2 , AT_foto3 , AT_foto4 , AT_foto5 , AT_foto6 , AT_foto7 , AT_foto8 , LO_published , TA_nome , TA_nome_1 , TX_testo , CO_tipi_transazione , TA_comune , TA_provincia_cantone , IN_prezzo , IN_deposito_garanzia , LO_fixed_gallery , IN_thumbnail_num , TX_text_css , TX_testonewsletter , IN_left_2 , IN_top_2 , IN_layer_height2 , IN_layer_width2 , LO_change_in_sections , LO_allow_mailing , TX_text , TX_CSS_layer , AT_favicon , TX_CSS_link , LO_just_home , TA_overflow , AT_image , IN_contatore , LO_visible , LO_vertical, TX_CSS_over , TX_CSS , TX_CSS_active , IN_left , IN_top , IN_width , IN_height , IN_levels , IN_layer_width , IN_layer_height , TX_CSS_level1 , TX_CSS_level1over , TX_CSS_level2 , TX_CSS_level2over , TX_CSS_level3 , TX_CSS_level3over , TX_CSS_level4 , TX_CSS_level4over , TX_CSS_level5 , TX_CSS_level5over , TA_basedir , TA_basedir1 , LO_allow_languages , LO_allow_galleries , LO_allow_subscribers ,  TX_descrizione , LO_pubblica , TA_password , DT_data , TA_luogo , LO_enabled , TA_cognome , TA_societa , TA_indirizzo , TA_citta , TA_cap , TA_telefono , TA_email , AT_general_background , TA_textalignment , TA_password_protect , LO_password_protected , TX_website_description , TX_website_abstract ,  TX_website_keywords , TA_fontfamily , IN_fontsize , TA_fontweight , TA_fontstyle , CL_colori , TA_textdecoration , IN_lineheight , AT_backgroundImage , TA_bgrepeat , CL_coloribg , AT_immagine , , TA_nomeprogetto , AT_logo , CO_sezioni , CO_sezioni , CO_macrosezioni , LO_pubblica"&Session("reflang")&" , LO_homepage , LO_tipo , LO_news , IN_ordine , TA_nome"&Session("reflang")&" , TX_testo"&Session("reflang")&" , CO_tematica , TA_anno , TA_info , AT_immagine_menu , TX_codice_embed , TX_embed , CR_oggetti , TA_maildefault , AT_mappa , TA_video_title , TX_video_subtitle , LO_video_position , AT_snapshot , TX_video_embed , LO_disabilitato , "

if Session("allow_mailing" & numproject)=True then allowed_columns=allowed_columns&" LO_newsletter , "

if LCase(tabella)="newsletter" Then  allowed_columns=allowed_columns & " , TE_testo , IN_newsletter_numero ,"
if LCase(tabella)="newsletter_elements" Then  
    allowed_columns=allowed_columns&" , TE_testo , LO_footer , CO_oggetti ,"
    allowed_columns=Replace(allowed_columns,", IN_ordine ,",",")
End If

if LCase(tabella)="newsletter_address" Then  allowed_columns=allowed_columns&" , TA_ip ,"
if LCase(tabella)="testimonianze" Then  allowed_columns=allowed_columns&" , TE_testo ,"

if LCase(tabella)="p_projects" Then  
    allowed_columns=allowed_columns&" , CO_p_category , IN_cifra , AT_banner , AT_main_img , LO_realizzato , CO_p_area , IN_mezzi_propri , IN_cifra_minima , DT_apertura , TX_video_embed , LO_video_embed , CR_p_projects , LO_deducibile , TX_widget , LO_bonus , TX_testo_bonus , AT_sponsor , "
    allowed_columns=Replace(allowed_columns,", CO_registeredusers ,",",")
    allowed_columns=Replace(allowed_columns,", TA_nome ,",",")
    allowed_columns=Replace(allowed_columns,", TA_nome_1 ,",",")
    allowed_columns=Replace(allowed_columns,", TA_luogo ,",",")
    allowed_columns=Replace(allowed_columns,", TA_nazione ,",",")

End if

if LCase(tabella)="p_subcategory" Then  
    allowed_columns=Replace(allowed_columns,", IN_ordine ,",",")
End If

if LCase(tabella)="p_comments" Then  
    allowed_columns=Replace(allowed_columns,", CO_registeredusers ,",",")
    allowed_columns=Replace(allowed_columns,", TA_nome ,",",")
End if


if LCase(tabella)="p_description" Then  
    'allowed_columns=Replace(allowed_columns,", TX_embed ,",",")
    allowed_columns=Replace(allowed_columns,", IN_ordine ,",",")
    allowed_columns=allowed_columns&" , LO_confirmed ,"
End if

if LCase(tabella)="formulari" Then  allowed_columns=allowed_columns&" , DT_data_chiusura ,"

if LCase(tabella)="sponsors" Then  
    allowed_columns=Replace(allowed_columns,", CR_oggetti ,",",")
    allowed_columns=Replace(allowed_columns,", TA_titolo ,",",")
    allowed_columns=allowed_columns&" , TA_link , LO_partner , TA_sotto_titolo , LO_homepage ,"
end if

if LCase(tabella)="oggetti" then 
    allowed_columns=" , TA_nome"&Session("reflang")&" , DT_data , TX_testo"&Session("reflang")&" ,"
End if

if LCase(tabella)="_config_main" then 
    'allowed_columns=Replace(allowed_columns,", AT_logo ,",",")
    allowed_columns=Replace(allowed_columns,", AT_mappa ,",",")
    allowed_columns=Replace(allowed_columns,", TA_maildefault ,",",")
    allowed_columns=allowed_columns&" , CO_oggetti ,"
end if



if LCase(tabella)="registeredusers" then
    allowed_columns=Replace(allowed_columns,"AT_immagine ,","")
    allowed_columns=Replace(allowed_columns,"LO_ecommerce ,","")
    allowed_columns=Replace(allowed_columns,"TA_fax ,","")
    allowed_columns=Replace(allowed_columns,"TA_societa ,","")
    allowed_columns=allowed_columns&" , DT_last_login , TA_password_iniziale , TA_ente , TA_natel , TA_societa , TA_facebook , TA_twitter , TA_linkedin , CO_nazioni , DT_data_nascita ," 
    If Session("adm_area")=0 Or isnull(Session("adm_area")) Then allowed_columns=allowed_columns&" CO_p_area ,"
End If

if LCase(tabella)="boxes" Then 
    allowed_columns=allowed_columns&" , TA_nome_1 , TA_nome_2 , TA_nome_3 , TA_nome_4 ,"
End if


if LCase(Session("tab"))="associa_galleries_immagini" then 
    allowed_columns=allowed_columns&" ,   TX_desc , "
    allowed_columns=Replace(allowed_columns,", IN_ordine ,",",")
End If


if LCase(tabella)="homepage" then 
    allowed_columns=allowed_columns&" CO_oggetti , CO_lingue , IN_blocco , TA_feed ,"
End If

%>