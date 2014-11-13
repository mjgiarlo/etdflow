class LdapLookupController < ApplicationController

  def new
    LdapLookup.new
  end

  def ldap_lookups
    Rails.logger.info "HEREIAM"
    Rails.logger.info params.inspect
    Rails.logger.info params[:uid]
    Rails.logger.info params[:name]
    Rails.logger.info "HEREIAMAGAIN"
    @ldap_lookup_info = LdapLookup.new(uid: 'meb113')
#    @ldap_lookup_info.ldap_record = 'record information data.....'

#   puts @ldap_lookup_info.inspect

    @ldap_lookup_info.get_ldap_entry
    return unless !@ldap_lookup_info.ldap_record.nil?
    puts @ldap_lookup_info.inspect
    @ldap_lookup_info.map_committee_attributes

    respond_to do |format|
      format.html
      format.json  { render :json => {uid: @ldap_lookup_info.uid, name: @ldap_lookup_info.name, record_info: @ldap_lookup_info.mapped_attributes.to_s}}
    end


  end
end