/*
    This file is a part of reviewer assignment to posts controller
 */

/**
 * Actions of buttons with class .r_adding, which find closest select and extract necessary data
 * to assign a reviewer to a post
 */
$(document).on('click', '.r_adding', function () {
    let id = get_r_id(this.id);
    let selected = get_selected(this.id);

    $.ajax("/web_semestral/public/r_assignment/add_review_queue", {
        data: {p_id: id, r_id: selected},
        type: "POST"
    }).done(function (re) {
        switch (re.charAt(re.length - 1)) {
            case '0': window.location.reload(false); break;
            case '1': unknow_values(); break
            default: unknown_error(); break;
        }
    });
});

/**
 * Changes assignment error element to unknown error
 */
function unknown_error() {
    $('#r_assignment_err').text('Neznámá chyba. Prosím kontaktujte vývojáře.');
}

/**
 * Changes assignment error element to value retrieving error
 */
function unknow_values() {
    $('#r_assignment_err').text('Nepodařilo se získat potřebné údaje. Přidání selhalo.');
    // $('#r_assignment_err').html('Nepodařilo se získat potřebné údaje. Přidání selhalo.');
}

/**
 * Supporting method get button index (between 0 and 2)
 * @param id of the clicked button
 * @returns {string} returns index
 */
function get_index(id) {
    return id.charAt(id.length - 1);
}

/**
 * Gets id of the reviewer from the button id
 * @param id button id
 * @returns {string} reviewer id
 */
function get_r_id(id) {
    let res = '';
    let ptr = 2;

    while(id.charAt(ptr) != '_') {
        res += id.charAt(ptr);
        ptr++;
    }

    return res;
}

/**
 * Gets a selected value from select. Gets it by constructing select id from button id.
 * @param id button id
 * @returns {string | number | string[] | jQuery} selected option value
 */
function get_selected(id) {
    let index = get_index(id);
    id = get_r_id(id);
    let selector = "r_" + id + "_select" + index;

    return $('#' + selector).val();
}