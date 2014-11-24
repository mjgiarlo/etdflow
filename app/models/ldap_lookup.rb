class LdapLookup

  include ActiveModel::AttributeMethods
  include ActiveModel::Model
  include ActiveModel::Validations

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

  attr_accessor :uid
  attr_accessor :roles_list
  attr_accessor :ldap_record
  attr_accessor :mapped_attributes

  validates :uid, presence: true, :format => {:with => /\A[a-zA-Z][a-zA-Z]+[0-9]*\z/i }


  def self.committee_roles_list

    rlist = [[Etdflow::Application.config.committee_advisor_role, Etdflow::Application.config.committee_advisor_role.parameterize]]
    Etdflow::Application.config.committee_other_required_roles.each do |r|
      rlist << [r, r.parameterize]
    end
    rlist
  end

  def committee_roles_list
    self.roles_list ||= self.class.committee_roles_list
  end

  def self.directory_entry(lookup_type, searchterm, attrs=[])

    # exist = user_in_ldap? access_id
    # return nil unless exist

    3.times do
      begin
        attrs=Hydra::LDAP.get_user(Net::LDAP::Filter.eq(lookup_type, searchterm), attrs)
        break unless attrs==[]
      end rescue[]
    end
    return attrs
  end


  def directory_entry(attrs=[])

    self.class.directory_entry(searchterm, attrs)
  end

#Queries LDAP with access id and returns one entry
  def get_ldap_entry
    ldap_entry = nil
    exist = LdapLookup.user_in_ldap? self.uid
    return nil unless exist

    #get the ldap directory entry for access_id
    ldap_entry = LdapLookup.directory_entry('uid', self.uid)
    self.ldap_record = ldap_entry.first
    #no ldap entry found
    if self.ldap_record.nil?
      Rails.logger.info "Access id #{self.uid} does not exist in LDAP - #{Time.now}"
    end
  end

#Queries LDAP with last name or uid; returns list
  def get_ldap_list
    ldap_entry = []
    if self.uid.count("0-9") > 0
      search_type = 'uid'
      search_desc = 'Access Id'
    else
      search_type = 'sn'
      search_desc = 'Last Name'
    end
    ldap_entry = LdapLookup.directory_entry(search_type, self.uid)
#    self.ldap_record = ldap_entry
#    if self.ldap_record.nil?
    if ldap_entry.nil?
      Rails.logger.info "#{search_desc}- #{self.uid} - does not exist in LDAP - #{Time.now}"
      self.errors.add(:uid, "was not found in the directory.")
    end
    ldap_entry
  end

  def map_author_attributes
    self.roles_list
    #map LDAP directory entry to Author record
    @ldap_displayname = self.ldap_record[:displayname].first
    @ldap_postaladdress = self.ldap_record[:postaladdress].first
    @ldap_phone = self.ldap_record[:telephonenumber].first

    #build attributes hash for author
    self.mapped_attributes={}
    self.mapped_attributes[:first_name] = ldap_first_name
    self.mapped_attributes[:middle_name] = ldap_middle_name
    self.mapped_attributes[:last_name] = ldap_last_name
#    self.psu_email_address = ldap_mail ldap_entry[:mail]
    self.mapped_attributes[:address_1] = ldap_address_1
    self.mapped_attributes[:city] = ldap_city
    self.mapped_attributes[:state]  = ldap_state
    self.mapped_attributes[:zip] = ldap_zip
    self.mapped_attributes[:phone_number] = ldap_telephone || ''
  end



  def close_connection
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

  def lookup

    ###These lines are commented to avoid hitting ldap while getting this working
    self.ldap_record = get_ldap_list
    if self.ldap_record.nil?
      self.errors.add(:base, I18n.t('ldap_lookup.search_failed', uid: self.uid))
      return nil
    end

    self.mapped_attributes = map_committee_attributes
    if self.mapped_attributes.nil?
     self.errors.add(:base, I18n.t('ldap_lookup.search_failed', uid: self.uid))
     return nil
    end

  end

  private

  def self.user_in_ldap? access_id
    Hydra::LDAP.does_user_exist?(Net::LDAP::Filter.eq('uid', access_id))
  end

  def ldap_first_name
    name= @ldap_displayname.split(' ').first || ''
    name.titleize unless name.nil?
  end

  def ldap_middle_name
    middle=''
    name = @ldap_displayname.split(' ')
    if name.count > 2
      middle=name.second || ''
    end
    middle.titleize unless middle.nil?
  end

  def ldap_last_name
    name = @ldap_displayname.split(' ').last || ''
    name.titleize unless name.nil?
  end

  def ldap_address_1
    addr = @ldap_postaladdress.titleize.split('$').first || ''
  end

  def ldap_address_2

  end

  def ldap_zip
    addr = @ldap_postaladdress.split(' ').last
    addr || ''
  end

  def ldap_state
    state = (@ldap_postaladdress.split('$').last).split(',').last
    state=state.split(' ').first
    i = USABBREVIATIONS.index state.upcase
    if i
      state = Author::USSTATES[i] || ''
    else
      state || ''
    end
    state
  end

  def ldap_city
    addr = (@ldap_postaladdress.titleize.split('$').last).split(',')
    addr[0] || ''
  end

  def ldap_telephone
    phone = @ldap_phone
    return phone unless !phone.nil?
    #remove prefix and replace blanks with dashes
    phone = phone.remove('+1 ').gsub(' ', '-')
    phone
  end

  def map_committee_attributes

    return nil unless !self.ldap_record.nil?
#    self.mapped_attributes = []
    mapped_attributes = []
    tmp = {}
    self.ldap_record.each_with_index do |rec|
      uid = rec[:uid].first || ''
      name = (rec[:displayname].first).titleize || ' '
      email = rec[:mail].first || ' '
#      dept = tmp[:dept] = rec[:psdepartment].first.titleize || ' '

      mapped_attributes << {:uid => uid, :name => name, :email => email}
      tmp={}
    end
    mapped_attributes
  end

end

