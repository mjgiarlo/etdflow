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

end
