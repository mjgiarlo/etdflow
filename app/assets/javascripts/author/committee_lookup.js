/**
 * Created by jxb13 on 11/11/14.
 */
$(document).on("click", 'button.committee_search', function (e) {

    var $submittedValue = $('#ldap_loookup_uid').val();

    $.ajax({
        url: "/lookup_committee",
        data: { uid: $('#ldap_lookup_uid').val(), name: $('#ldap_lookup_name').val(), record_info: 'X'},
        dataType: "json"
    }).success(function(data){
        alert(data.record_info)
        $('div.search_results').html(data.record_info);
    });
    $('div.search_results').html('ERROR');
    return false;
});
