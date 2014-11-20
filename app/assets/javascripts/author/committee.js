/* Use role value in classes to identify which committee member boxes to fill after search */
$(document).on("click", ".modal-link", function () {

    var thisrole=$(this).data('role');
    var thisid=$(this).attr("id");

    $(".modal-header .this-role").text(thisrole );
    $('#ldap_lookup_uid').val('');
 /*   $('#ldap_lookup_role').text(thisid);  */
    $('div.search_results').val('');


});
/*

$(document).on("click", ".committee_search_submit", function () {

    var role=$('span.this-role').text();
    $('#ldap_lookup_role').val(role);
     $.ajax({
        url: "/lookup_committee",
        data: { role: $(role) }
    });
    /*   this is on the way back - use on submit from results section in committe_modal- to populate committee form*/
    /*    $('div.'+thisid+ ' input').val('hello');
     $('div.email-'+thisid+ ' input').val('helloemail');

    /*
    window.location.replace('/lookup_committee?uid='+$('#ldap_lookup_uid').val()); */
/*
});  */

$(document).on("click", ".add_selected_committee_member", function () {

    /*the radio list; person selected*/
    var list_order = $('input[name=search_for_committee_radio]:checked').val();
    var this_name = $('span.cte-name_'+list_order).text();
    var this_email = $('span.cte-email_'+list_order).text();

    /*the committee member role selected*/
    var this_role = $("#search_committee_role_list option:selected").val();
    $('div.'+this_role+' .committee_committee_members_name input').val(this_name);
    $('div.'+this_role+' .committee_committee_members_email input').val(this_email);

});


