class LdapLookupController < ApplicationController

  def new

    LdapLookup.new
  end


  def ldap_lookups


    @ldap_lookup_info = LdapLookup.new(uid: params[:ldap_lookup_info][:uid])

    @ldap_lookup_info.valid?
    if @ldap_lookup_info.errors.any?
       puts @ldap_lookup_info.errors.full_messages.inspect
       render partial: 'ldap_lookup/modal_errors', locals: {ldap_lookup_info: @ldap_lookup_info}
    else
    ###These lines are commented to avoid hitting ldap while getting this working
    #   @ldap_lookup_info.get_ldap_list
    #   return unless !@ldap_lookup_info.ldap_record.nil?
    ########
      @ldap_lookup_info.ldap_record = [{:dn=>["uid=jxb13,dc=psu,dc=edu"], :objectclass=>["top", "PSUperson", "eduPerson", "inetOrgPerson", "organizationalPerson", "person", "posixAccount"], :mail=>["jxb13@psu.edu"], :uid=>["jxb13"], :edupersonprincipalname=>["jxb13@psu.edu"], :fax=>["1 814 863-3560"], :labeleduri=>["http://www.personal.psu.edu/jxb13/"], :title=>["SR RES PRGMR"], :givenname=>["JONI LEE"], :sn=>["BARNOFF"], :psmaclabgid=>["5000"], :psmaclabhomedir=>["/Users/guest"], :psdiridn=>["370080"], :psuidnumber=>["33333"], :edupersonprimaryaffiliation=>["STAFF"], :gidnumber=>["1000"], :uidnumber=>["333333"], :cn=>["JONI LEE BARNOFF"], :displayname=>["JONI LEE BARNOFF"], :loginshell=>["/bin/bash"], :psmailid=>["jxb13@psu.edu"], :telephonenumber=>["+1 814 865 4845"], :psadminarea=>["INFORMATION TECH SERVICES"], :psmemberof=>["cn=staff.up.cis,dc=psu,dc=edu", "cn=psu.facstaff,dc=psu,dc=edu", "cn=umg/up.its.its-itana.collab,dc=psu,dc=edu", "cn=umg/up.dlt.staff,dc=psu,dc=edu", "cn=psu.up.staff,dc=psu,dc=edu", "cn=umg/up.ais.osd_sandbox.developer,dc=psu,dc=edu", "cn=umg/up.its.voipusers,dc=psu,dc=edu", "cn=umg/up.dlt.applicationsteam,dc=psu,dc=edu", "cn=umg/up.dlt.drupal7prod,dc=psu,dc=edu", "cn=umg/up.dlt.drupal7dev,dc=psu,dc=edu", "cn=umg/up.its.mac-web,dc=psu,dc=edu", "cn=umg/up.its.mac-web.admin,dc=psu,dc=edu", "cn=umg/up.library.purlz_admin,dc=psu,dc=edu", "cn=umg/up.library.purlz_admin.admin,dc=psu,dc=edu", "cn=umg/up.library.purlz_admin.owner,dc=psu,dc=edu", "cn=umg/up.dlt.resource_list_for_techs,dc=psu,dc=edu", "cn=umg/up.lib.ezproxy.administrator,dc=psu,dc=edu", "cn=umg/up.lib.ezproxy.administrator.admin,dc=psu,dc=edu", "cn=umg/personal.cdm5214.firewallgroup,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin.admin,dc=psu,dc=edu", "cn=umg/up.dlt.dlt-web-prod,dc=psu,dc=edu", "cn=umg/up.dlt.dlt-web-prod.admin,dc=psu,dc=edu", "cn=umg/up.dlt.dlt-web-prod.owner,dc=psu,dc=edu", "cn=umg/up.its.mac-web-prod,dc=psu,dc=edu", "cn=umg/up.its.mac-web-prod.admin,dc=psu,dc=edu", "cn=umg/up.its.mac-web-prod.owner,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin-viewers,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin-viewers.admin,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin-viewers.owner,dc=psu,dc=edu", "cn=psu.itstaff,dc=psu,dc=edu", "cn=umg/up.dlt.archivesphere-admin-viewers,dc=psu,dc=edu", "cn=umg/up.dlt.archivesphere-admin.admin,dc=psu,dc=edu", "cn=umg/up.its.sas,dc=psu,dc=edu"], :homedirectory=>["/pass/users/j/x/jxb13"], :edupersonaffiliation=>["member", "staff"], :postaladdress=>["003E PATERNO LIBRARY$UNIVERSITY PARK$UNIVERSITY PARK, PA 16802"], :pscampus=>["UNIVERSITY PARK"], :psofficeaddress=>["E-4 Paterno Library"], :psdepartment=>["ITS SERVICES & SOLUTIONS"], :psmailbox=>["jxb13@ucs.psu.edu"], :psmailhost=>["ucs.psu.edu"]}]

       @ldap_lookup_info.map_committee_attributes
       if @ldap_lookup_info.mapped_attributes.nil?
          render text: 'Not Found'
       else
          render 'ldap_lookup/selection_form.js.erb', locals: {ldap_lookup_info: @ldap_lookup_info}
       end
    end

  end


  def committee_member_select

    if params['search_committee_role_list'].nil? || params['search_for_committee_radio'].nil?
        puts render partial: 'ldap_lookup/modal_errors', locals: {ldap_lookup_info: @ldap_lookup_info}
    else
      @ldap_lookup_info = LdapLookup.new
      render partial: 'ldap_lookup/search_form', locals: {ldap_lookup_info: @ldap_lookup_info}
    end
  end
end
