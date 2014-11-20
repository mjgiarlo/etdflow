class LdapLookupController < ApplicationController

  def new

    LdapLookup.new
  end

  def ldap_lookups

    @ldap_lookup_info = LdapLookup.new(uid: params[:ldap_lookup][:uid])

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

  def committee_member_select
    puts "SELECTHINGTHECOMMITTEE"
  end
end
