require 'spec_helper'
require 'support/rails'
require 'support/database_cleaner'
require 'support/factories'
require 'support/committee_factory'
require 'support/fixture'
require 'support/ldap_lookup'

  def get_vhost_values
    hostname = Socket.gethostname
    vhost=Etdflow::Application.config.hosts_vhosts_map[hostname] || "https://#{hostname}/"
    uri=URI.parse(vhost)
    service=uri.host
    port = uri.port
    service << "-#{port}" unless port == 443
    [service, vhost]
  end


  def create_author_from_ldap
   @ldap_info = LdapLookup.new(uid: 'jxb13', ldap_record: mock_ldap_entry.first)
    @ldap_info.map_author_attributes
    author = Author.create(@ldap_info.mapped_attributes)
    author

  end

  def create_committee_lookup_list
    @ldap_info = LdapLookup.new(uid: 'barnoff', ldap_record: mock_ldap_list)
    @ldap_info.mapped_attributes = @ldap_info.map_committee_attributes
    ldap_info = @ldap_info
    ldap_info
  end



