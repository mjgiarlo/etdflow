# Default strategy for signing in a user, based on his email and password in the database.
module Devise
  module Strategies
    class HttpHeaderAuthenticatable < ::Devise::Strategies::Base

      include Behaviors::HttpHeaderAuthenticatableBehavior

      # Called if the user doesn't already have a rails session cookie
       def valid?
        valid_author?(request.headers)
      end

      def authenticate!
        access_id  = remote_user(request.headers)
        if access_id.present?
          puts "AccessId: #{access_id}"
          u = Author.find_by access_id: access_id
          if u.nil?
            u = Author.create(access_id: access_id, psu_email_address: access_id+'@psu.edu')
#            u.populate_attributes
          end
          success!(u)
        else
          fail!
        end
      end

    end
  end
end

Warden::Strategies.add(:http_header_authenticatable, Devise::Strategies::HttpHeaderAuthenticatable)
