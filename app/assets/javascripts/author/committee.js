/* Use role value in classes to identify which committee member boxes to fill after search */
$(document).on("click", ".modal-link", function () {

    var thisrole=$(this).data('role');
    var thisid=$(this).attr("id");

    $(".modal-header .this-role").text(thisrole );
    $('#ldap_lookup_uid').val('');
 /*   $('#ldap_lookup_role').text(thisid);  */
    $('div.search_results').val('');


});


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

});

$(document).on("click", ".choose_committee", function () {
    alert ('here');


});


