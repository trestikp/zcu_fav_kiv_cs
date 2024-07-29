/*
    This file is supposed to be controller switching active nav link
    (currently not really working)
 */
$(document).on('click', '.navigation-link', function () {
    $('ul li a.active').removeClass('active');
    $(this).addClass('active');

    // $.ajax('/web_semestral/public/controller/active_nav_link', {
    //     data: {active_l: $(this).text()},
    //     type: "POST"
    // });
    // $(this).load('controller/active_nav_link/active_l?' + $(this).text());
});