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
    #   @ldap_lookup_info.get_ldap_list
    #   return unless !@ldap_lookup_info.ldap_record.nil?
    ########

      @ldap_lookup_info.ldap_record = @ldap_lookup_info.ldap_record = [ @myhash={:dn=>["uid=jxb13,dc=psu,dc=edu"], :objectclass=>["top", "PSUperson", "eduPerson", "inetOrgPerson", "organizationalPerson", "person", "posixAccount"], :mail=>["jxb13@psu.edu"], :uid=>["jxb13"], :edupersonprincipalname=>["jxb13@psu.edu"], :fax=>["1 814 863-3560"], :labeleduri=>["http://www.personal.psu.edu/jxb13/"], :title=>["SR RES PRGMR"], :givenname=>["JONI LEE"], :sn=>["BARNOFF"], :psmaclabgid=>["5000"], :psmaclabhomedir=>["/Users/guest"], :psdiridn=>["370080"], :psuidnumber=>["406631"], :edupersonprimaryaffiliation=>["STAFF"], :gidnumber=>["1000"], :uidnumber=>["406631"], :cn=>["JONI LEE BARNOFF"], :displayname=>["JONI LEE BARNOFF"], :loginshell=>["/bin/bash"], :psmailid=>["jxb13@psu.edu"], :telephonenumber=>["+1 814 865 4845"], :psadminarea=>["INFORMATION TECH SERVICES"], :psmemberof=>["cn=staff.up.cis,dc=psu,dc=edu", "cn=psu.facstaff,dc=psu,dc=edu", "cn=umg/up.its.its-itana.collab,dc=psu,dc=edu", "cn=umg/up.dlt.staff,dc=psu,dc=edu", "cn=psu.up.staff,dc=psu,dc=edu", "cn=umg/up.ais.osd_sandbox.developer,dc=psu,dc=edu", "cn=umg/up.its.voipusers,dc=psu,dc=edu", "cn=umg/up.dlt.applicationsteam,dc=psu,dc=edu", "cn=umg/up.dlt.drupal7prod,dc=psu,dc=edu", "cn=umg/up.dlt.drupal7dev,dc=psu,dc=edu", "cn=umg/up.its.mac-web,dc=psu,dc=edu", "cn=umg/up.its.mac-web.admin,dc=psu,dc=edu", "cn=umg/up.library.purlz_admin,dc=psu,dc=edu", "cn=umg/up.library.purlz_admin.admin,dc=psu,dc=edu", "cn=umg/up.library.purlz_admin.owner,dc=psu,dc=edu", "cn=umg/up.dlt.resource_list_for_techs,dc=psu,dc=edu", "cn=umg/up.lib.ezproxy.administrator,dc=psu,dc=edu", "cn=umg/up.lib.ezproxy.administrator.admin,dc=psu,dc=edu", "cn=umg/personal.cdm5214.firewallgroup,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin.admin,dc=psu,dc=edu", "cn=umg/up.dlt.dlt-web-prod,dc=psu,dc=edu", "cn=umg/up.dlt.dlt-web-prod.admin,dc=psu,dc=edu", "cn=umg/up.dlt.dlt-web-prod.owner,dc=psu,dc=edu", "cn=umg/up.its.mac-web-prod,dc=psu,dc=edu", "cn=umg/up.its.mac-web-prod.admin,dc=psu,dc=edu", "cn=umg/up.its.mac-web-prod.owner,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin-viewers,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin-viewers.admin,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin-viewers.owner,dc=psu,dc=edu", "cn=psu.itstaff,dc=psu,dc=edu", "cn=umg/up.dlt.archivesphere-admin-viewers,dc=psu,dc=edu", "cn=umg/up.dlt.archivesphere-admin.admin,dc=psu,dc=edu", "cn=umg/up.its.sas,dc=psu,dc=edu"], :homedirectory=>["/pass/users/j/x/jxb13"], :edupersonaffiliation=>["member", "staff"], :postaladdress=>["003E PATERNO LIBRARY$UNIVERSITY PARK$UNIVERSITY PARK, PA 16802"], :pscampus=>["UNIVERSITY PARK"], :psofficeaddress=>["E-4 Paterno Library"], :psdepartment=>["ITS SERVICES & SOLUTIONS"], :psmailbox=>["jxb13@ucs.psu.edu"], :psmailhost=>["ucs.psu.edu"]},  @myhash={:dn=>["uid=meb113,dc=psu,dc=edu"], :objectclass=>["top", "PSUperson", "eduPerson", "inetOrgPerson", "organizationalPerson", "person", "posixAccount"], :mail=>["meb113@psu.edu"], :uid=>["meb113"], :psmailbox=>["meb113@email.psu.edu"], :edupersonprincipalname=>["meb113@psu.edu"], :givenname=>["MARK E"], :displayname=>["MARK E BARNOFF"], :sn=>["BARNOFF"], :cn=>["MARK E BARNOFF"], :psmaclabgid=>["5000"], :psmaclabhomedir=>["/Users/guest"], :telephonenumber=>["+1 814 865 2865"], :psdiridn=>["372781"], :psuidnumber=>["87571"], :edupersonprimaryaffiliation=>["STAFF"], :psdepartment=>["APPLIED RESEARCH LAB"], :gidnumber=>["1000"], :uidnumber=>["87571"], :loginshell=>["/bin/bash"], :psmailhost=>["email.psu.edu"], :psmemberof=>["cn=umg/up.ecs,dc=psu,dc=edu", "cn=psu.facstaff,dc=psu,dc=edu", "cn=psu.up.staff,dc=psu,dc=edu", "cn=umg/up.its.voipusers,dc=psu,dc=edu"], :homedirectory=>["/pass/users/m/e/meb113"], :psmailid=>["mbarnoff@psu.edu", "meb113@psu.edu"], :title=>["RES & DEV ENGR"], :edupersonaffiliation=>["staff", "member"], :postaladdress=>["2210G ARL WEST III (ATOTECH)$UNIVERSITY PARK$STATE COLLEGE, PA 16801"], :pscampus=>["UNIVERSITY PARK"], :psadminarea=>["RESEARCH- DEFENSE REL"]}, @myhash={:dn=>["uid=rmb1,dc=psu,dc=edu"], :objectclass=>["top", "PSUperson", "eduPerson", "inetOrgPerson", "organizationalPerson", "person", "posixAccount"], :psofficephone=>["1-814-237-5123"], :mail=>["rmb1@psu.edu"], :uid=>["rmb1"], :edupersonprincipalname=>["rmb1@psu.edu"], :fax=>["1-814-237-5185"], :postaladdress=>["606 NIMITZ AVE$STATE COLLEGE, PA 16801"], :title=>["PROF EMER CIVL ENG"], :givenname=>["ROBERT M"], :displayname=>["ROBERT M BARNOFF"], :sn=>["BARNOFF"], :cn=>["ROBERT M BARNOFF"], :psmaclabgid=>["5000"], :psmaclabhomedir=>["/Users/guest"], :telephonenumber=>["+1 814 238 4297"], :psdiridn=>["380062"], :psuidnumber=>["339875"], :edupersonprimaryaffiliation=>["EMERITUS"], :gidnumber=>["1000"], :uidnumber=>["339875"], :loginshell=>["/bin/bash"], :psmailbox=>["rmb1@email.psu.edu"], :psmailhost=>["email.psu.edu"], :psmailid=>["rmb1@psu.edu"], :psmemberof=>["cn=psu.adj_facstaff,dc=psu,dc=edu"], :homedirectory=>["/pass/users/r/m/rmb1"], :edupersonaffiliation=>["emeritus", "member"]}]

       @ldap_lookup_info.map_committee_attributes
    end
  end

  def committee_member_select
    puts "SELECTHINGTHECOMMITTEE"
  end
end