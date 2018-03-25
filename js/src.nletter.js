
refreshC = function () {
    $('.cptch').attr('src', '/images/vuoto.gif')
    setTimeout(function () { $('.cptch').attr('src', '/img_captcha.asp?ssid=' + Math.floor((Math.random() * 99999) + 1)) }, 200)
}

makeFBSignup = function () {
    $('input').not('.sb').not('.pw').focus(function () {
        if ($(this).attr('alt'))
            if ($(this).val() != null && $(this).val().toLowerCase() == ($(this).attr('alt').toLowerCase())) $(this).val('')
        if ($(this).attr('name') == "TA_telefono") checkPrefix($(this), $('input[name=CO_nazioni]').val())

        if ($(this).attr('name') == "DT_data_nascita" && ($(this).val().length > 10 || $(this).val() == str_date_fromat)) $(this).val(str_date_fromat)

        if ($(this).attr('name') == "TA_telefono" && $(this).val().indexOf(' ' + str_f_telefono) != -1) $(this).val($(this).val().replace(' ' + str_f_telefono, ' '))
        $(this).removeClass('err')
    })

    $('input').not('.sb').not('.cp').not('.pw').blur(function () {
        if ($(this).val().length == 0) $(this).val($(this).attr('alt'))
    })


    $('#formFBSignup').submit(function (e) {
        e.preventDefault();
        complete = 1;
        gtMail = $('input[name=TA_email]').val();
        gtDate = $('input[name=DT_data_nascita]').val();
        gtTel = $('input[name=TA_telefono]').val();

        $('.errMsg').fadeOut();
        $('.errMsg').html("");

        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        var date_regexDt = /^(0[1-9]|1\d|2\d|3[01]).(0[1-9]|1[0-2]).(19|20)\d{2}$/;

        if (!regex.test(gtMail)) { $('input[name=TA_email]').addClass('err'); complete = 0; }
        if (!date_regexDt.test(gtDate)) { $('input[name=DT_data_nascita]').addClass('err'); complete = 0; } else {
            var t = gtDate.split('.');
            var m = parseInt(t[1], 10);
            var d = parseInt(t[0], 10);
            var y = parseInt(t[2], 10);
            var date = new Date(t[2], t[1] - 1, t[0]);
            checkD = (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d);
            if (!checkD) {
                $('input[name=DT_data_nascita]').addClass('err'); complete = 0;
            } else {
                getAge = _calculateAge(date);
                if (getAge < 18) {
                    var r = confirm(str_age_min);
                    if (r == true) $('input[name=DT_data_nascita]').focus()
                    $('input[name=DT_data_nascita]').addClass('err'); complete = 0;
                }
            }
        }

        var regexTel = /^((\+\d{1,3}(-| )?\(?\d\)?(-| )?\d{1,5})|(\(?\d{2,6}\)?))(-| )?(\d{2,4})(-| )?(\d{2,4})(( x| ext)\d{1,5}){0,1}$/;
        //if (!regexTel.test(gtTel)) { $('input[name=TA_telefono]').addClass('err'); complete=0; }

        // check phone format
        var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();
        var phoneNumber = gtTel;
        var number;
        //VB:Bro immagino che questo sia il controllo implementato da te; occorre modificarlo con la classe err al posto dell'alert
        try {
            number = phoneUtil.parseAndKeepRawInput(phoneNumber, "");
            $('input[name=TA_telefono]').attr('error', 'false');
            if (!phoneUtil.isValidNumber(number)) {
                try {
                    var regionCode = phoneUtil.getRegionCodeForNumber(number);
                    if (!regionCode)
                        $('input[name=TA_telefono]').attr('error', 'true');
                    else
                        $('input[name=TA_telefono]').attr('error', 'true');
                    //alert(str_phone_not_valid_wexample.replace("&&", phoneUtil.getExampleNumber(regionCode)));
                } catch (e) {
                    //alert(str_phone_not_valid);
                    $('input[name=TA_telefono]').attr('error', 'true');
                }
                //              $('input[name=TA_telefono]').focus();
                $('input[name=TA_telefono]').attr('error', 'true');
                complete = 0;
                console.log('number not valid'); //alert('number not valid'); 
            }
        } catch (e) {
            //alert(str_phone_not_valid);
            $('input[name=TA_telefono]').attr('error', 'true');
            complete = 0;
            //console.log(str_phone_not_valid); //alert('number not valid'); 
        }

        //VB: In questo selector aggiunge a tutti gli elementi con la classe str la classe err, quindi è inutile aggiungerla prima....
        $('.str').not('.cp').not('.pw').each(function () {
            $(this).css('border', 'solid 0px')
            //VB: Gestione per il numero di telefono errato con l'aggiunta dell'attribute 'error')
            gtVal = $(this).val();
            gtVal1 = $(this).attr('name').replace("TA_", "");

            if (gtVal.length < 1 || gtVal == gtVal1 || $(this).attr('error') == 'true') {

                $(this).addClass('err')
                complete = 0;

            }
        })



        if (complete == 0) {
            $('html, body').animate({ scrollTop: 0 }, 300)
            $('.errMsg').html(str_obl_filed);
            $('.errMsg').fadeIn();
            return;
        }


        $.ajax({
            type: "POST",
            url: "/actions/fb_signup.asp",
            dataType: 'html',
            data: $("#formFBSignup").serialize(),
            timeout: 6000,
            success: function (msg) {
                /*if (msg == "OK") {
                    $('p.title').html('Grazie!');
                    $('#formFBSignup').html('<p style="padding:11px; width:300px">' + str_account_created + '</p>');
                    return;
                }*/
                if (msg == "Exist") {
                    $('html, body').animate({ scrollTop: 0 }, 300)
                    $('.errMsg').html(str_email_exist);
                    $('.errMsg').fadeIn();
                    $('input[name=TA_email]').addClass('err');
                    return;
                } else {
                    document.location = msg;
                }
            },
            error: function (msg) {
                $('.errMsg').html(str_generic_error);
                $('html, body').animate({ scrollTop: 0 }, 300)
                $('.errMsg').fadeIn();

            }
        })


        return false;
    });
    makeCapthca()

}
makeSignup = function () {
    $('input').not('.sb').not('.pw').focus(function () {
        if ($(this).attr('alt'))
            if ($(this).val() != null && $(this).val().toLowerCase() == ($(this).attr('alt').toLowerCase())) $(this).val('')
        if ($(this).attr('name') == "TA_telefono") checkPrefix($(this), $('input[name=CO_nazioni]').val())

        if ($(this).attr('name') == "DT_data_nascita" && ($(this).val().length > 10 || $(this).val() == str_date_fromat)) $(this).val(str_date_fromat)

        if ($(this).attr('name') == "TA_telefono" && $(this).val().indexOf(' ' + str_f_telefono) != -1) $(this).val($(this).val().replace(' ' + str_f_telefono, ' '))
        $(this).removeClass('err')
    })

    $('input').not('.sb').not('.cp').not('.pw').blur(function () {
        if ($(this).val().length == 0) $(this).val($(this).attr('alt'))
    })

    $('input.pw').focus(function () {
        $(this).val('')
        $(this).removeClass('err')

    })

    $('input.pw').blur(function () {
        if (!isValid($(this).val())) $(this).addClass('err')
        if ($('input.pw').eq(0).val() != $('input.pw').eq(1).val()) $('input.pw').eq(1).addClass('err')
    });


    $('#formSignup').submit(function (e) {
        e.preventDefault();
        complete = 1;
        gtMail = $('input[name=TA_email]').val();
        gtDate = $('input[name=DT_data_nascita]').val();
        gtPass = $('input[name=TA_password]').val();
        gtPass1 = $('input[name=TA_password_1]').val();
        gtTel = $('input[name=TA_telefono]').val();

        $('.errMsg').fadeOut();
        $('.errMsg').html("");
        $('.chch').removeClass('err')

        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        var date_regexDt = /^(0[1-9]|1\d|2\d|3[01]).(0[1-9]|1[0-2]).(19|20)\d{2}$/;

        if (!isValid(gtPass)) { $('input.pw').eq(0).addClass('err'); $('input.pwd1').addClass('err'); complete = 0; }
        if (!isValid(gtPass1)) { $('input.pw').eq(1).addClass('err'); $('input.pwd2').addClass('err'); complete = 0; }
        if ($('input.pw').eq(0).val() != $('input.pw').eq(1).val()) { $('input.pw').eq(1).addClass('err'); complete = 0; }
        if (!regex.test(gtMail)) { $('input[name=TA_email]').addClass('err'); complete = 0; }
        if (!date_regexDt.test(gtDate)) { $('input[name=DT_data_nascita]').addClass('err'); complete = 0; } else {
            var t = gtDate.split('.');
            var m = parseInt(t[1], 10);
            var d = parseInt(t[0], 10);
            var y = parseInt(t[2], 10);
            var date = new Date(t[2], t[1] - 1, t[0]);
            checkD = (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d);
            if (!checkD) {
                $('input[name=DT_data_nascita]').addClass('err'); complete = 0;
            } else {
                getAge = _calculateAge(date);
                if (getAge < 18) {
                    var r = confirm(str_age_min);
                    if (r == true) $('input[name=DT_data_nascita]').focus()
                    $('input[name=DT_data_nascita]').addClass('err'); complete = 0;
                }
            }
        }

        var regexTel = /^((\+\d{1,3}(-| )?\(?\d\)?(-| )?\d{1,5})|(\(?\d{2,6}\)?))(-| )?(\d{2,4})(-| )?(\d{2,4})(( x| ext)\d{1,5}){0,1}$/;
        //if (!regexTel.test(gtTel)) { $('input[name=TA_telefono]').addClass('err'); complete=0; }

        // check phone format
        var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();
        var phoneNumber = gtTel;
        var number;
        //VB:Bro immagino che questo sia il controllo implementato da te; occorre modificarlo con la classe err al posto dell'alert
        try {
            number = phoneUtil.parseAndKeepRawInput(phoneNumber, "");
            $('input[name=TA_telefono]').attr('error', 'false');
            if (!phoneUtil.isValidNumber(number)) {
                try {
                    var regionCode = phoneUtil.getRegionCodeForNumber(number);
                    if (!regionCode)
                        $('input[name=TA_telefono]').attr('error', 'true');
                    else
                        $('input[name=TA_telefono]').attr('error', 'true');
                    //alert(str_phone_not_valid_wexample.replace("&&", phoneUtil.getExampleNumber(regionCode)));
                } catch (e) {
                    //alert(str_phone_not_valid);
                    $('input[name=TA_telefono]').attr('error', 'true');
                }
                //              $('input[name=TA_telefono]').focus();
                $('input[name=TA_telefono]').attr('error', 'true');
                complete = 0;
                console.log('number not valid'); //alert('number not valid'); 
            }
        } catch (e) {
            //alert(str_phone_not_valid);
            $('input[name=TA_telefono]').attr('error', 'true');
            complete = 0;
            //console.log(str_phone_not_valid); //alert('number not valid'); 
        }

        //VB: In questo selector aggiunge a tutti gli elementi con la classe str la classe err, quindi è inutile aggiungerla prima....
        $('.str').not('.cp').not('.pw').each(function () {
            $(this).css('border', 'solid 0px')
            //VB: Gestione per il numero di telefono errato con l'aggiunta dell'attribute 'error')
            gtVal = $(this).val();
            gtVal1 = $(this).attr('name').replace("TA_", "");

            if (gtVal.length < 1 || gtVal == gtVal1 || $(this).attr('error') == 'true') {

                $(this).addClass('err')
                complete = 0;

            }
        })

        if (!$('.chch').hasClass("ok")) {
            complete = 0;
            $('input[name="cptch"]').addClass('err')
        }


        if (complete == 0) {
            $('html, body').animate({ scrollTop: 0 }, 300)
            $('.errMsg').html(str_obl_filed);
            $('.errMsg').fadeIn();
            return;
        }


        $.ajax({
            type: "POST",
            url: "/actions/signup.asp",
            dataType: 'html',
            data: $("#formSignup").serialize(),
            timeout: 6000,
            success: function (msg) {
                if (msg == "OK") {
                    $('p.title').html('Grazie!');
                    $('#formSignup').html('<p style="padding:11px; width:300px">' + str_account_created + '</p>');
                    return;
                }
                if (msg == "Exist") {
                    $('html, body').animate({ scrollTop: 0 }, 300)
                    $('.errMsg').html(str_email_exist);
                    $('.errMsg').fadeIn();
                    $('input[name=TA_email]').addClass('err');
                    return;
                }
            },
            error: function (msg) {
                $('.errMsg').html(str_generic_error);
                $('html, body').animate({ scrollTop: 0 }, 300)
                $('.errMsg').fadeIn();

            }
        })


        return false;
    });
    makeCapthca()

}


makeForget = function () {
    $('input[name=password]').remove()
    $('label.pwd').remove()
    $('input.pwd1').remove()
    $('p.fbl').remove()
    $('p.crt').remove()
    $('p.bck').remove()
    $('p.or').remove()
    $('div.reg').remove()
    $('div.column').css('width', "330px");
    $('div.column').css('float', "none");
    $('div.column').css('margin', "0 auto");
    $('div.column div:first-child').css('padding-right', "0px");
    $('p.fc').css('width','100%')
    $('input.sb').eq(0).val(str_reset_pass)
    $('p.title').html($('div.recover').html())
    //$('#formLogin').html($('div.recover').html());
    $('p.fc').css('display', 'inline-block')
    makeCapthca()
    $('#formLogin').unbind('submit')
    $('#formLogin').submit(function (e) {
        complete = 1;

        e.preventDefault();
        $('input[name=email]').removeClass('err')
        gtMail = $('input[name=email]').val();

        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;

        if (!regex.test(gtMail)) {
            $('input[name=email]').addClass('err')
            complete = 0;
        }

        if (!$('.chch').hasClass("ok")) {
            complete = 0;
            $('input[name="cptch"]').addClass('err')
        }

        if (complete == 0) {
            return;
        }

        var data1 = {
            email: gtMail
        };

        $.ajax({
            type: "POST",
            url: "/actions/passwordForget.asp",
            data: data1,
            timeout: 6000,
            success: function (msg) {

                if (msg == "OK") {
                    $('#formLogin').html('<p style="padding:11px; width:300px">' + str_new_pass_sent + '</p>');
                }

                if (msg == "EMAIL") {
                    $('input[name=email]').addClass('err')
                }
            },
            error: function () {
                $('.errMsg').html(str_generic_error);
                $('.errMsg').fadeIn();
            }

        });

    })
}

makeLogin = function () {
    $('input').not('.sb').focus(function () {
        if ($(this).val() != null && $(this).val().toLowerCase() == $(this).attr('name')) $(this).val('')
        if ($(this).hasClass('err')) $(this).val('')
        $(this).removeClass('err')
    })


    $('#formLogin').submit(function (e) {
        e.preventDefault();

        complete = 1;
        gtMail = $('input[name=email]').val();
        gtPass = $('input[name=password]').val();

        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;

        if (!regex.test(gtMail)) {
            $('input[name=email]').addClass('err')
            complete = 0;
        }

        if (gtPass.length < 4 || gtPass == 'password') {
            $('.pwd').addClass('err')
            complete = 0;
        }

        if (complete == 0) {
            return;
        }

        var data1 = {
            password: gtPass,
            email: gtMail
        };


        $.ajax({
            type: "POST",
            url: "/actions/login.asp",
            data: data1,
            timeout: 6000,
            success: function (msg) {

                if (msg == "PASSWORD") {
                    $('input[name=password]').addClass('err')
                    return;
                }

                if (msg == "EMAIL") {
                    $('input[name=email]').addClass('err')
                    return;
                }

                $('#formLogin').unbind('submit');
                $('#formLogin').submit(function () {
                    return true;
                })
                gotoLoc = $('a.refer').attr('href');
                $('input[name=goto]').val(gotoLoc)

                $('#formLogin').attr('action', '/actions/login_do.asp');
                $('#formLogin').submit();
                return;

            },
            error: function () {
                $('.errMsg').html(str_generic_error);
                $('.errMsg').fadeIn();
            }

        });


    });
}

makeContact = function () {
    $('input').not('.sb').focus(function () {
        if ($(this).val() != null && $(this).val().toLowerCase() == $(this).attr('name')) $(this).val('')
        $(this).removeClass('err')

    })

    $('input').not('.sb').not('.cp').blur(function () {
        if ($(this).val().length == 0) $(this).val($(this).attr('name'))
    })

    $('#formContact').submit(function (e) {
        e.preventDefault();
        complete = 1;

        $('input').removeClass('err')
        $('.errMsg').css('display', 'none');

        gtMail = $('input[name=email]').val();

        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (!regex.test(gtMail)) {
            $('input[name=email]').addClass('err')
            complete = 0;
        }

        $('.str').not('.cp').each(function () {
            gtVal = $(this).val();
            gtVal1 = $(this).attr('name');
            if (gtVal.length < 2 || gtVal == gtVal1) {
                $(this).addClass('err')
                complete = 0;
            }
        })


        if (complete == 0) {
            $('.errMsg').html(str_obl_filed);
            $('.errMsg').fadeIn();
            return;
        }

        var data1 = {
            nome: $('input[name=nome]').val(),
            cognome: $('input[name=cognome]').val(),
            email: gtMail,
            cptch: $('input[name=cptch]').val()
        };


        $.ajax({
            type: "POST",
            url: "/newsletter_add.asp",
            data: data1,
            timeout: 6000,
            success: function (msg) {

                if (msg == "OK") {
                    $('input.sb').val(str_subscription_done)
                    $('input.sb').removeAttr('onclick')
                    $('.fc').remove()
                    $('input.sb').addClass('sbs')
                }

                if (msg == "EXIST") {
                    $('.errMsg').html(str_email_registered);
                    $('.errMsg').fadeIn();

                }

                if (msg == "CODE") {
                    $('.errMsg').html(str_verify_code);
                    $('.errMsg').fadeIn();
                    $('input[name=cptch]').addClass('err')
                }
            },
            error: function () {
                $('.errMsg').html(str_generic_error);
                $('.errMsg').fadeIn();
            }

        });
        return false;
    });

    makeCapthca()
}

makeCapthca = function () {
    $('input[name="cptch"]').keyup(function () {
        gtval1 = $(this).val()
        $(this).removeClass('err')

        $.ajax({
            url: "/incs/capthca_check.asp?val=" + gtval1 + "&ssid=" + Math.floor(Math.random() * 99999),
            success: function (msg) {
                if (msg == "OK") {
                    $('.chch').attr('src', '/images/check_ove.png')
                    $('.chch').addClass("ok")
                } else {
                    $('.chch').attr('src', '/images/check.png')
                    $('.chch').removeClass("ok")
                }
            }
        })
    })
}
var access_token;
function fb_signup(return_url) {
    if (!return_url) { return_url = '/';}
    document.location = '/signin/fb_signup.asp?return_url='+return_url;
}
function fb_login() {
    FB.login(function (response) {

        if (response.authResponse) {

            access_token = response.authResponse.accessToken;
            user_id = response.authResponse.userID;

            getFB_account(response);

        } else {

            $('p.fbl').html($('p.fbl').html() + '<br/><br/>' + str_logfb_not);

        }
    }, {
        scope: 'email,user_location,public_profile,user_birthday'
    });
}

getFB_account = function (response) {
    if (response.status !== 'connected') {
        console.log("not connected");
    } else {
        getFbLogin()
    }
}

checkFBLogin = function () {

    $.ajax({
        type: "POST",
        url: "/actions/fb_login.asp",
        data: data1,
        timeout: 6000,
        success: function (msg) {

            if (msg == "OK") {
                document.location = "" + $('a.refer').attr('href')
            }

            if (msg == 'RECHECK') {
                getFbLogin();
            }

            if (msg == 'EMAIL') {
                $('p.fbl').html($('p.fbl').html() + '<br/><br/>' + str_logfb_noexist);
                $('<form id="fbl" action="/signin/" method="post"><input type="hidden" name="setmail" value="' + setMail + '"/><input type="hidden" name="setcity" value="' + setLocation + '"/><input type="hidden" name="setname" value="' + last_name + '"/><input type="hidden" name="setfirstname" value="' + first_name + '"/></form>').appendTo($('body'))
                setTimeout(function () { $('#fbl').submit() }, 5000)
            }
        }
    });
}

getFbLogin = function () {
    FB.api('/me?fields=id,email,name,birthday', function (response) {
        //getVerified = response.verified;
        //if (getVerified!=true)
        //{
        //    console.log("verified false")
        //return;
        //}
        setLocation = ""
        var setId = response.id
        var sLoc = ""
        try {
            sLoc = response.location.name;
        } catch (err) {
            console.log("err" + err);
            sLoc = ""
        }
        if (sLoc.length > 0) {
            sLoca = sLoc.split(',')
            setLocation = sLoca[0]
        }
        setMail = response.email
        last_name = response.last_name
        first_name = response.first_name
        console.log("setMail: " + setMail);
        console.log("setId: " + setId);
        console.log(response);
        return;
        data1 = {
            setmail: setMail,
            setId: setId
        };

        checkFBLogin()
    })
}

makeUnsub = function () {
    $('input').not('.sb').focus(function () {
        if ($(this).val() != null && $(this).val().toLowerCase() == $(this).attr('name')) $(this).val('')
        $(this).removeClass('err')

    })

    $('input').not('.sb').not('.cp').blur(function () {
        if ($(this).val().length == 0) $(this).val($(this).attr('name'))
    })

    $('#formContact').submit(function (e) {
        e.preventDefault();
        complete = 1;

        $('input').removeClass('err')
        $('.errMsg').css('display', 'none');

        gtMail = $('input[name=email]').val();

        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (!regex.test(gtMail)) {
            $('input[name=email]').addClass('err')
            complete = 0;
        }

        if (complete == 0) {
            $('.errMsg').html(str_obl_filed);
            $('.errMsg').fadeIn();
            return;
        }

        var data1 = {
            email: gtMail,
            cptch: $('input[name=cptch]').val()
        };


        $.ajax({
            type: "POST",
            url: "/newsletter_del.asp",
            data: data1,
            timeout: 6000,
            success: function (msg) {

                if (msg == "OK") {
                    $('input.sb').val(str_unsubscription_done)
                    $('input.sb').css('background', 'transparent')
                    $('input.sb').removeAttr('onclick')
                    $('.fc').remove()
                    $('input.sb').addClass('sbs')
                }

                if (msg == "NOEXIST") {
                    $('.errMsg').html(str_email_noexist);
                    $('.errMsg').fadeIn();

                }

                if (msg == "CODE") {
                    $('.errMsg').html(str_verify_code);
                    $('.errMsg').fadeIn();
                    $('input[name=cptch]').addClass('err')
                }
            },
            error: function () {
                $('.errMsg').html(str_generic_error);
                $('.errMsg').fadeIn();
            }

        });
        return false;
    });

    $('input[name="cptch"]').keyup(function () {
        gtval1 = $(this).val()
        $.ajax({
            url: "/incs/capthca_check.asp?val=" + gtval1 + "&ssid=" + Math.floor(Math.random() * 99999),
            success: function (msg) {
                if (msg == "OK") {
                    $('.chch').attr('src', '/images/check_ove.png')
                } else {
                    $('.chch').attr('src', '/images/check.png')
                }
            }
        })
    })

}