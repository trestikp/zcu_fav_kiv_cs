/*
    This file is part of registration controller
 */

/**
 * Handles event of button to register user. Checkes for empty fields and '@' in email and sets
 * corresponding errors. If everything is filled sends retrieved data to server.
 */
$(document).on('click', '#register', function () {
    let interrupt = false;
    // reg_uname, reg_email, reg_passwd, reg_passwd_check
    if (document.getElementById('reg_uname').value == "") {
        document.getElementById('reg_uname').style.borderColor = "red";
        $('#reg_uname_error').text("Toto pole musí být vyplněné!");
        document.getElementById('reg_uname_error').style.color = 'red';
        interrupt = true;
    }

    if (document.getElementById('reg_email').value == "") {
        document.getElementById('reg_email').style.borderColor = "red";
        $('#reg_email_error').text("Toto pole musí být vyplněné!");
        document.getElementById('reg_email_error').style.color = 'red';
        interrupt = true;
    }

    if (!document.getElementById('reg_email').value.includes('@')) {
        document.getElementById('reg_email').style.borderColor = "red";
        $('#reg_email_error').text("Email musí obsahovat @");
        document.getElementById('reg_email_error').style.color = 'red';
        interrupt = true;
    }

    if (document.getElementById('reg_passwd').value == "") {
        document.getElementById('reg_passwd').style.borderColor = "red";
        $('#reg_passwd_error').text("Toto pole musí být vyplněné!");
        document.getElementById('reg_passwd_error').style.color = 'red';
        interrupt = true;
    }

    if (document.getElementById('reg_passwd_check').value == "") {
        document.getElementById('reg_passwd_check').style.borderColor = "red";
        $('#reg_passwd_check_error').text("Toto pole musí být vyplněné!");
        document.getElementById('reg_passwd_check_error').style.color = 'red';
        interrupt = true;
    }

    if (document.getElementById('reg_passwd').value != document.getElementById('reg_passwd_check').value) {
        document.getElementById('reg_passwd_check').style.borderColor = "red";
        document.getElementById('reg_passwd').style.borderColor = "red";
        $('#reg_passwd_check_error').text("Hesla se musí shodovat!");
        document.getElementById('reg_passwd_check_error').style.color = 'red';
        interrupt = true;
    }

    if (interrupt) {
        return false;
    }

    $.ajax('/web_semestral/public/registration/process', {
        type: 'POST',
        data: $('#reg_form').serialize()
    }).done(function (re) {
        if (re.charAt(re.length - 1) == '1') {
            $('#reg_error').text("Uživatelské jméno již existuje. Prosím zvolte si jiné.");
            $('#reg_error').css('color', 'red');
            return;
        }

        window.location.replace("/web_semestral/public/registration/complete");
    });
});

/**
 * Removes username error
 */
function uname_err_remove() {
    $('#reg_uname_error').text('');
    $('#reg_uname').css("border", "");
}

/**
 * Removes email error
 */
function uname_email_remove() {
    $('#reg_email_error').text('');
    $('#reg_email').css("border", "");
}

/**
 * Removes password error
 */
function uname_passwd_remove() {
    $('#reg_passwd_error').text('');
    $('#reg_passwd').css("border", "");
}

/**
 * Removes password check error
 */
function uname_passwd_check_remove() {
    $('#reg_passwd_check_error').text('');
    $('#reg_passwd_check').css("border", "");
}

/**
 * Handles button after registration is send to take user back to main page
 */
$(document).on('click', '#reg_finish', function () {
    window.location.replace("/web_semestral/public/home/index");
});
