/*search results form - check if radio button & drop-down list selected */
$(document).on("click", ".add-selected-committee-member", function () {
    if ($("#search_committee_role_list")[0].selectedIndex <= 0 ||
        !$("input[name=search_for_committee_radio]:checked").val())
    {
        $('div.modal-errors').html("<p class='alert alert-danger'>Please select a committee member and committee member role</p>");
        return false;
    }

    /*the radio list; person selected*/
    var list_order = $('input[name=search_for_committee_radio]:checked').val();
    var this_name = $('span.cte-name-'+list_order).text();
    var this_email = $('span.cte-email-'+list_order).text();

    /*the committee member role selected*/
    var this_role = $("#search_committee_role_list option:selected").val();
    $('div.'+this_role+' .committee_committee_members_name input').val(this_name);
    $('div.'+this_role+' .committee_committee_members_email input').val(this_email);

    clear_modal();
    $('div.modal-errors').html("<p class='alert alert-success'>Committee Member was added.</p>");

});

/*clear data from modal; hide search-results and display search-box*/
$(document).on('click', '.committee-modal-close', function() {
    clear_modal();
});

/*Remove all data from modal & set display to search form*/
function clear_modal() {
    clear_search_results();
    clear_search_box();
    $('div.modal-errors .alert').hide();
}

/*Remove data from search-results:  name list & role drop-down*/
function clear_search_results() {
    $('fieldset.name-list').remove();
    $('#search_committee_role_list').attr('selectedIndex', '');
    display_off($('div.search-results'));
}

/* remove data from search-box display */
function clear_search_box() {
    $('#ldap_lookup_info_uid').val('');
    display_on($('div.search-box'));
}

/* switch element display on & set aria-hidden=false*/
function display_on(this_element) {
        this_element.show();
        this_element.attr('aria-hidden', 'false');
}

/*switch element display off & set aria-hidden=true*/
function display_off(this_element) {
        this_element.hide();
        this_element.attr('aria-hidden', 'true');
        $('div.modal-errors .alert').hide();
}


