class LdapLookupController < ApplicationController

  def ldap_lookups

    @ldap_lookup_info = LdapLookup.new(uid: params[:ldap_lookup_info][:uid])
    @ldap_lookup_info.valid?
    if @ldap_lookup_info.errors.any?
       render partial: 'ldap_lookup/committee_modal_errors', locals: {ldap_lookup_info: @ldap_lookup_info}
    else
      @ldap_lookup_info.lookup
      if @ldap_lookup_info.errors.any?
          render partial: 'ldap_lookup/committee_modal_errors', locals: {ldap_lookup_info: @ldap_lookup_info}
      else
          render 'ldap_lookup/selection_form', locals: {ldap_lookup_info: @ldap_lookup_info}
      end
    end
  end


  def committee_select
    render partial: 'ldap_lookup/search_form', locals: {ldap_lookup_info: @ldap_lookup_info}
   end
end
