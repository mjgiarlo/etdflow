class Author <  ActiveRecord::Base

  validates_presence_of :access_id,
                        :first_name,
                        :last_name,
                        :middle_name,
                        :alternate_email_address,
                        :psu_email_address,
                        :phone_number,
                        :address_1,
                        :city,
                        :state,
                        :zip

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

end
