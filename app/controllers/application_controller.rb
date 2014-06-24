class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller 
  include Blacklight::Controller
  include Worthwhile::ApplicationControllerBehavior
  # Please be sure to implement current_user and user_session. Blacklight depends on
  # these methods in order to perform user specific actions. 

  layout 'author'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Blanket, site-wide password protection to keep development secret
  http_basic_authenticate_with name: "etdflow", password: "fold wet"

end
