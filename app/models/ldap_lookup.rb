class LdapLookup
  USABBREVIATIONS =
      [
          'AL',
          'AK',
          'AZ',
          'AR',
          'CA',
          'CO',
          'CT',
          'DE',
          'DC',
          'FL',
          'GA',
          'HI',
          'ID',
          'IL',
          'IN',
          'IA',
          'KS',
          'KY',
          'LA',
          'ME',
          'MD',
          'MA',
          'MI',
          'MN',
          'MS',
          'MO',
          'MT',
          'NE',
          'NV',
          'NH',
          'NJ',
          'NM',
          'NY',
          'NC',
          'ND',
          'OH',
          'OK',
          'OR',
          'PA',
          'PR',
          'RI',
          'SC',
          'SD',
          'TN',
          'TX',
          'UT',
          'VT',
          'VA',
          'WA',
          'WV',
          'WI',
          'WY',
      ].freeze

  def self.map_author_attributes (access_id)

    #get the ldap directory entry for access_id
    ldap_entry = self.directory_entry(access_id)

    #no ldap entry found
    if ldap_entry.nil?
      Rails.logger.info "Access id #{access_id} does not exist in LDAP - #{Time.now}"
      return
    end

    #map LDAP directory entry to Author record
    @ldap_displayname = ldap_entry[:displayname].first
    @ldap_postaladdress = ldap_entry[:postaladdress].first

    #build attributes hash for author
    entry_attributes={}
    entry_attributes[:first_name] = LdapLookup.ldap_first_name
    entry_attributes[:middle_name] = LdapLookup.ldap_middle_name
    entry_attributes[:last_name] = LdapLookup.ldap_last_name
#    self.psu_email_address = LdapLookup.ldap_mail ldap_entry[:mail]
    entry_attributes[:address_1] = LdapLookup.ldap_address_1
    entry_attributes[:city] = LdapLookup.ldap_city
    entry_attributes[:state]  = LdapLookup.ldap_state
    entry_attributes[:zip] = LdapLookup.ldap_zip
    entry_attributes[:phone_number] = ldap_entry[:telephonenumber].first || ''
    entry_attributes
  end


  def groups! access_id
    return [] if access_id.blank?
    list = self.class.groups(access_id)

    if Hydra::LDAP.connection.get_operation_result.code == 0
      list.sort!
      #Rails.logger.debug "$#{access_id}$ groups = #{list} - Time.now"
      # TODO: Should we retry here if the code is 51-53???
    else
      Rails.logger.warn "Error getting groups for #{login} reason: #{Hydra::LDAP.connection.get_operation_result.message} - Time.now"
      return []
    end
    return list
  end

  def self.groups(access_id)
    2.times do
      begin
        groups=   Hydra::LDAP.groups_for_user(Net::LDAP::Filter.eq('uid', access_id)) do |result|
          result.first[:psmemberof].select{ |y| y.starts_with? 'cn=umg/' }.map{ |x| x.sub(/^cn=/, '').sub(/,dc=psu,dc=edu/, '') }
        end
      end rescue []
      return groups
    end
  end


  def directory_entry(attrs=[])
    self.class.directory_entry(access_id, attrs)
  end

  def self.directory_entry(access_id, attrs=[])

    exist = user_in_ldap? access_id
    return nil unless exist

    3.times do
      begin
        attrs=Hydra::LDAP.get_user(Net::LDAP::Filter.eq('uid', access_id), attrs)
        break unless attrs==[]
      end rescue[]
    end
    return attrs.first
  end

  private

  def self.user_in_ldap? access_id
    Hydra::LDAP.does_user_exist?(Net::LDAP::Filter.eq('uid', access_id))
  end

  def self.ldap_first_name
    name= @ldap_displayname.split(' ').first || ''
    name.titleize unless name.nil?
  end

  def self.ldap_middle_name
    middle=''
    name = @ldap_displayname.split(' ')
    if name.count > 2
      middle=name.second || ''
    end
    middle.titleize unless middle.nil?
  end

  def self.ldap_last_name
    name = @ldap_displayname.split(' ').last || ''
    name.titleize unless name.nil?
  end

  def self.ldap_address_1
    addr = @ldap_postaladdress.split('$').first || ''
  end

  def self.ldap_zip
    addr = @ldap_postaladdress.split(' ').last
    addr || ''
  end

  def self.ldap_state
    state = (@ldap_postaladdress.split('$').last).split(',').last
    state=state.split(' ').first
    i = USABBREVIATIONS.index state
    if i
      state = Author::USSTATES[i] || ''
    else
      state || ''
    end
    state
  end

  def self.ldap_city
    addr = (@ldap_postaladdress.split('$').last).split(',')
    addr[0] || ''
  end

end
