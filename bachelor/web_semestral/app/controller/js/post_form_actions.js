/*
    This file is a part of post posting controller
 */

/**
 * Action of 'post_action' button. Gets data from the post form and gets a file if one is attached
 * and sends it to server via ajax. Also handles error codes from the server.
 */
$(document).on('click', '#post_action', function() {
    // $.ajax("/web_semestral/public/post/submit_post", {
    //     type: "POST",
    //     data: $('#post_form').serialize(),
    // }).done(function (re) {
    //     console.log(re);
    //     window.location.replace("/web_semestral/public/post/submit_success");
    //     // console.log($('#post_form').serialize());
    // });


    let file_data = $('#pdf_input').prop('files')[0];
    let form_data = new FormData($('#post_form')[0]);
    form_data.append('pdf_input', file_data);

    $.ajax("/web_semestral/public/post/submit_post", {
        dataType: 'text',
        cache: false,
        contentType: false,
        processData: false,
        data: form_data,
        type: "POST"
    }).done(function (re) {
        try {
            let arr = JSON.parse(re);

            switch (arr['code']) {
                case 0: window.location.replace("/web_semestral/public/post/submit_success"); break;
                case 1: empty_title(); break;
                case 2: empty_description(); break;
                case 3: wrong_extension(); break;
                case 4: oversize(); break;
                case 5: upload_error(); break;
            }
        } catch (e) {
            // do nothing
        }
    });
});

/**
 * Action of a button to redirect to "Mé příspěvky" after submitting a post
 */
$(document).on('click', '#my_posts_red', function() {
    window.location.replace("/web_semestral/public/my_posts/index");
});

/**
 * Action of a button to redirect to add a new post
 */
$(document).on('click', '#new_post_red', function() {
    window.location.replace("/web_semestral/public/post/index");
});

/**
 * Changes post error element to an error occurring by empty title
 */
function empty_title() {
    $('#post_error').text("Musíte zadat titul!");
}

/**
 * Changes post error element to an error occurring by empty description
 */
function empty_description() {
    $('#post_error').text("Musíte zadat popisek!");
}

/**
 * Changes post error element to an error occurring by incorrect file type
 */
function wrong_extension() {
    $('#post_error').text("Vybraný soubor není pdf!");
}

/**
 * Changes post error element to an error occurring by too large file
 */
function oversize() {
    $('#post_error').text("Soubor je příliš velký!");
}

/**
 * Changes post error element to an error occurring by the server error
 */
function upload_error() {
    $('#post_error').text("Upload se nezdařil (chyba serveru).");
}