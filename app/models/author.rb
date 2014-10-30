class Author <  ActiveRecord::Base

  self.include_root_in_json = false


  Devise.add_module(:http_header_authenticatable,
                    strategy: true,
                    controller: :sessions,
                    model: 'devise/models/http_header_authenticatable')

  devise :http_header_authenticatable, :rememberable

  has_many :submissions

  validates_presence_of :access_id,
                        :first_name,
                        :last_name,
                        :alternate_email_address,
                        :psu_email_address,
                        :phone_number,
                        :address_1,
                        :city,
                        :state,
                        :zip

  validates_format_of :alternate_email_address,
                      :psu_email_address,
                      with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i

  validates_format_of :phone_number,
                      with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/,
                      message: 'should be in the form 1234567890 or 123-456-7890'

  validates_format_of :zip,
                      with: /\A\d{5}(-\d{4})?\z/,
                      message: 'should be in the form 12345 or 12345-1234'

  USSTATES = [
         'Alabama',
         'Alaska',
         'Arizona',
         'Arkansas',
         'California',
         'Colorado',
         'Connecticut',
         'Delaware',
         'District of Columbia',
         'Florida',
         'Georgia',
         'Hawaii',
         'Idaho',
         'Illinois',
         'Indiana',
         'Iowa',
         'Kansas',
         'Kentucky',
         'Louisiana',
         'Maine',
         'Maryland',
         'Massachusetts',
         'Michigan',
         'Minnesota',
         'Mississippi',
         'Missouri',
         'Montana',
         'Nebraska',
         'Nevada',
         'New Hampshire',
         'New Jersey',
         'New Mexico',
         'New York',
         'North Carolina',
         'North Dakota',
         'Ohio',
         'Oklahoma',
         'Oregon',
         'Pennsylvania',
         'Puerto Rico',
         'Rhode Island',
         'South Carolina',
         'South Dakota',
         'Tennessee',
         'Texas',
         'Utah',
         'Vermont',
         'Virginia',
         'Washington',
         'West Virginia',
         'Wisconsin',
         'Wyoming'
    ].freeze

  validates_inclusion_of :state,  in: USSTATES

  def full_name
    first_name + ' ' + middle_name + ' ' + last_name
  end

  def self.ask_to_display_email?
    Etdflow::Application.config.display_is_alternate_email_public_question
  end

end
