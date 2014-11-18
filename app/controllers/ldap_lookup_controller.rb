class LdapLookupController < ApplicationController

  def new

    LdapLookup.new
  end

  def ldap_lookups
    puts params

    @ldap_lookup_info = LdapLookup.new(uid: params[:ldap_lookup][:uid], role: params[:ldap_lookup][:role].parameterize)
    puts @ldap_lookup_info.inspect

    @ldap_lookup_info.valid?
    if @ldap_lookup_info.errors.any?
       puts @ldap_lookup_info.errors.full_messages.inspect
    else
    ###These lines are commented to avoid hitting ldap while getting this working
       @ldap_lookup_info.get_ldap_list
       return unless !@ldap_lookup_info.ldap_record.nil?
    ########
       @ldap_lookup_info.map_committee_attributes
    end
  end
end