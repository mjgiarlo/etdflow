/**
 * Created by jxb13 on 11/11/14.
 */

$(document).on("click", 'button.committee_search', function (e) {

    var $submittedValue = $('#ldap_loookup_uid').val();

    $.ajax({
        url: "/lookup_committee/?uid="+$('#ldap_lookup_uid').val(),
        data: $('#ldap_lookup_uid').val(),    #problem is here....
        dataType: "JSON"
    }).success(function(json){
        $('div.search_results').html('THISISIT');
    });
    $('div.search_results').html('ERROR');
    return false;
});