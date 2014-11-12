class LdapLookupController < ApplicationController

  def new
    LdapLookup.new
  end

  def ldap_lookups
    Rails.logger.info "HEREIAM"
    Rails.logger.info params.inspect
    Rails.logger.info "HEREIAMAGAIN"
    @ldap_lookup_info = LdapLookup.new(uid: 'meb113')
    @ldap_lookup_info.ldap_record = 'record information'
    puts @ldap_lookup_info.inspect

#    @ldap_lookup.get_ldap_entry
#    return unless !@ldap_lookup.ldap_record.nil?
#    puts @ldap_lookup.inspect
#    @ldap_lookup.map_committee_attributes

     respond_to do |format|
       format.html
       format.json { render :json => @ldap_lookup_info }
     end


  end
end