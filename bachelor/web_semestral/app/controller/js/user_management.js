/*
    This file is part of user managment controller
 */

/**
 * Handles action of a button with class .role-changes. Finds closest table row from which extracts selected option in
 * a user select and sends it to the server
 */
$(document).on('click', '.role-changer', function () {
    let select = $(this).closest('tr').find('.role-select').val();
    let username = $(this).closest('tr').find('.role-user').text();

    if (select == null) return;

    $.ajax("/web_semestral/public/user_mngmnt/change_role", {
        data: {username: username, role: select},
        type: "POST"
    }).done(function () {
        window.location.reload(false);
    });
    // console.log(username + " to be " + select);
});