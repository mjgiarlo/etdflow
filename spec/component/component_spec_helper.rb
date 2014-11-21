require 'spec_helper'
require 'support/rails'
require 'support/database_cleaner'
require 'support/factories'
require 'support/committee_factory'
require 'support/fixture'

  def get_vhost_values
    hostname = Socket.gethostname
    vhost=Etdflow::Application.config.hosts_vhosts_map[hostname] || "https://#{hostname}/"
    uri=URI.parse(vhost)
    service=uri.host
    port = uri.port
    service << "-#{port}" unless port == 443
    [service, vhost]
  end

  def ldap_entry
    ldap_entry = [{:dn=>["uid=jxb13,dc=psu,dc=edu"], :objectclass=>["top", "PSUperson", "eduPerson", "inetOrgPerson", "organizationalPerson", "person", "posixAccount"], :mail=>["jxb13@psu.edu"], :uid=>["jxb13"], :edupersonprincipalname=>["jxb13@psu.edu"], :fax=>["1 814 863-3560"], :labeleduri=>["http://www.personal.psu.edu/jxb13/"], :title=>["SR RES PRGMR"], :givenname=>["JONI LEE"], :sn=>["BARNOFF"], :psmaclabgid=>["5000"], :psmaclabhomedir=>["/Users/guest"], :psdiridn=>["370080"], :psuidnumber=>["33333"], :edupersonprimaryaffiliation=>["STAFF"], :gidnumber=>["1000"], :uidnumber=>["333333"], :cn=>["JONI LEE BARNOFF"], :displayname=>["JONI LEE BARNOFF"], :loginshell=>["/bin/bash"], :psmailid=>["jxb13@psu.edu"], :telephonenumber=>["+1 814 865 4845"], :psadminarea=>["INFORMATION TECH SERVICES"], :psmemberof=>["cn=staff.up.cis,dc=psu,dc=edu", "cn=psu.facstaff,dc=psu,dc=edu", "cn=umg/up.its.its-itana.collab,dc=psu,dc=edu", "cn=umg/up.dlt.staff,dc=psu,dc=edu", "cn=psu.up.staff,dc=psu,dc=edu", "cn=umg/up.ais.osd_sandbox.developer,dc=psu,dc=edu", "cn=umg/up.its.voipusers,dc=psu,dc=edu", "cn=umg/up.dlt.applicationsteam,dc=psu,dc=edu", "cn=umg/up.dlt.drupal7prod,dc=psu,dc=edu", "cn=umg/up.dlt.drupal7dev,dc=psu,dc=edu", "cn=umg/up.its.mac-web,dc=psu,dc=edu", "cn=umg/up.its.mac-web.admin,dc=psu,dc=edu", "cn=umg/up.library.purlz_admin,dc=psu,dc=edu", "cn=umg/up.library.purlz_admin.admin,dc=psu,dc=edu", "cn=umg/up.library.purlz_admin.owner,dc=psu,dc=edu", "cn=umg/up.dlt.resource_list_for_techs,dc=psu,dc=edu", "cn=umg/up.lib.ezproxy.administrator,dc=psu,dc=edu", "cn=umg/up.lib.ezproxy.administrator.admin,dc=psu,dc=edu", "cn=umg/personal.cdm5214.firewallgroup,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin.admin,dc=psu,dc=edu", "cn=umg/up.dlt.dlt-web-prod,dc=psu,dc=edu", "cn=umg/up.dlt.dlt-web-prod.admin,dc=psu,dc=edu", "cn=umg/up.dlt.dlt-web-prod.owner,dc=psu,dc=edu", "cn=umg/up.its.mac-web-prod,dc=psu,dc=edu", "cn=umg/up.its.mac-web-prod.admin,dc=psu,dc=edu", "cn=umg/up.its.mac-web-prod.owner,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin-viewers,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin-viewers.admin,dc=psu,dc=edu", "cn=umg/up.dlt.scholarsphere-admin-viewers.owner,dc=psu,dc=edu", "cn=psu.itstaff,dc=psu,dc=edu", "cn=umg/up.dlt.archivesphere-admin-viewers,dc=psu,dc=edu", "cn=umg/up.dlt.archivesphere-admin.admin,dc=psu,dc=edu", "cn=umg/up.its.sas,dc=psu,dc=edu"], :homedirectory=>["/pass/users/j/x/jxb13"], :edupersonaffiliation=>["member", "staff"], :postaladdress=>["003E PATERNO LIBRARY$UNIVERSITY PARK$UNIVERSITY PARK, PA 16802"], :pscampus=>["UNIVERSITY PARK"], :psofficeaddress=>["E-4 Paterno Library"], :psdepartment=>["ITS SERVICES & SOLUTIONS"], :psmailbox=>["jxb13@ucs.psu.edu"], :psmailhost=>["ucs.psu.edu"]}]
    ldap_entry
  end

  def create_author_from_ldap

   @ldap_info = LdapLookup.new(uid: 'jxb13', ldap_record: ldap_entry.first)
    @ldap_info.map_author_attributes
    author = Author.create(@ldap_info.mapped_attributes)
    author

  end



