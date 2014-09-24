class ApplicationController < ActionController::Base
  layout 'author'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Blanket, site-wide password protection to keep development secret
  http_basic_authenticate_with name: "etdflow", password: "fold wet"

  protected

  #  the http_authenticated user
  def remote_user
    access_id, pass = ActionController::HttpAuthentication::Basic::user_name_and_password(request)
    access_id
  end

end
