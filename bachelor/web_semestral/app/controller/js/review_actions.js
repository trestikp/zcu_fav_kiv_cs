/*
    This file is part of review submitting controller
 */

/**
 * Handles action of a button to send review. Checks if all review criteriums are selected and on no error
 * sends data to server
 */
$(document).on('click', '#send_review', function () {
    let error = false;
    let c1 = $('#criterium_1 option:selected').val();
    let c2 = $('#criterium_2 option:selected').val();
    let c3 = $('#criterium_3 option:selected').val();
    let overall = $('#overall option:selected').val();

    if (c1 == '' || c2 == '' || c3 == '' || overall == '') {
        error = true;
        $('#review_error').text("Všechna ohodnocení musí být vybrána!")
    }

    if (error) {
        return;
    }

    $.ajax("/web_semestral/public/review/submit_review", {
        data: $('#review_form').serialize(),
        type: "POST"
    }).done(function (re) {
        // console.log(re);
        window.location.replace("/web_semestral/public/review/success");
    });
});

/**
 * Handles after send button action to go back to reviews
 */
$(document).on('click', '#goto_reviews', function () {
    window.location.replace("/web_semestral/public/review/index");
});