class LdapLookupController < ApplicationController

  def new

    LdapLookup.new
  end

  def ldap_lookups

    @ldap_lookup_info = LdapLookup.new(uid: params[:ldap_lookup][:uid])

    @ldap_lookup_info.valid?
    if @ldap_lookup_info.errors.any?
       puts @ldap_lookup_info.errors.full_messages.inspect
####       render error messages
    else
    ###These lines are commented to avoid hitting ldap while getting this working
    #   @ldap_lookup_info.get_ldap_list
    #   return unless !@ldap_lookup_info.ldap_record.nil?
    ########

       @ldap_lookup_info.ldap_record = ['for testing need lda record']

       @ldap_lookup_info.map_committee_attributes
       if @ldap_lookup_info.mapped_attributes.nil?
          render text: 'Not Found'
       else
          render 'ldap_lookup/selection_form.js.erb'
       end
     end
  end


  def committee_member_select

    if params['search_committee_role_list'].nil? || params['search_for_committee_radio'].nil?
        puts 'SELECTIOnERROR'
     else
      render partial: 'search_form'
    end
  end
end
