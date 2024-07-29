/*
    This file is part of login controller

 */

/**
 * submitForm is called by login form buttons
 * @param action - login or register
 */
function submitForm(action) {
    if(action == "login") {
        $.ajax("/web_semestral/public/login_controller/verify", {
            type: "POST",
            data: $("#login_form").serialize()
        }).done(function (re) {
            // console.log(re);
            switch (re) {
                case '1': login_error("Uživatel neexistuje!"); return;
                case '3': login_error("Špatné heslo!"); return;
            }

            let cur_url = window.location.href;
            window.location.replace("/web_semestral/public/login_controller/log_in_user");
            window.location.replace(cur_url);
        });

    } else if (action == "register") {
        window.location.replace("/web_semestral/public/registration/index");
    }
}

/**
 * This function simply changes the text of login form error element
 * @param msg - error message to be displayed
 */
function login_error(msg) {
    $('#log_error').text(msg);
}

/**
 * Action of a button to cancel registration
 */
$(document).on('click', '#reg_cancel', function () {
    window.history.back();
    // console.log(window .history.toString());
    // window.history.back();
    // window.history.back(-1);
});

/**
 * Function is to help smoothly log out user
 */
function logOut() {
    let cur_url = window.location.href;

    // using ajax, because otherwise the cur_url is back before the
    // php function is finished
    $.ajax({
        url: "/web_semestral/public/login_controller/log_out_user"
    }).done(function () {
        window.location.replace(cur_url);
    });
}

/**
 * logout button action - calls above function logOut()
 */
$(document).on('click', '#logout', logOut);