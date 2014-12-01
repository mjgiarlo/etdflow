#search results form - check if radio button & drop-down list selected
$(document).on "click", '.add-selected-committee-member', ->
  if $('#search_committee_role_list')[0].selectedIndex <= 0 || !$('input[name=search_for_committee_radio]:checked').val()
    $('div.modal-errors').html("<p class='alert alert-danger'>Please select a committee member and committee member role</p>")
  else
    #the radio list; person selected*/
    list_order = $('input[name=search_for_committee_radio]:checked').val()
    this_name = $('span.cte-name-'+list_order).text()
    this_email = $('span.cte-email-'+list_order).text()

    #the committee member role selected*/
    this_role = $("#search_committee_role_list option:selected").val()
    $('div.'+this_role+' .committee_committee_members_name input').val(this_name)
    $('div.'+this_role+' .committee_committee_members_email input').val(this_email)

    clear_modal()
    $('div.modal-errors').html("<p class='alert alert-success'>Committee Member was added.</p>")


$(document).on 'click', '.committee-modal-close', ->
  clear_modal()

#Remove data from search-results:  name list & role drop-down
clear_search_results = () ->
  $('fieldset.name-list').remove()
  $('#search_committee_role_list').attr('selectedIndex', '')
  display_off($('div.search-results'))

# remove data from search-box display
clear_search_box = () ->
  $('#ldap_lookup_info_uid').val('')
  display_on($('div.search-box'))

# switch element display on & set aria-hidden=false
window.display_on = (this_element) ->
  this_element.show()
  this_element.attr('aria-hidden', 'false')

# switch element display off & set aria-hidden=true
window.display_off = (this_element) ->
  this_element.hide()
  this_element.attr('aria-hidden', 'true')
  $('div.modal-errors .alert').hide()

#Remove all data from modal & set display to search form
clear_modal = () ->
  clear_search_results()
  clear_search_box()
  $('div.modal-errors .alert').hide()











