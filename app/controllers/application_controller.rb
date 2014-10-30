class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Behaviors::HttpHeaderAuthenticatableBehavior

  before_filter :clear_session_author

  layout 'author'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Blanket, site-wide password protection to keep development secret
#  http_basic_authenticate_with name: "etdflow", password: "fold wet"

  def clear_session_author
    if request.nil?
      logger.warn "Request is Nil, how weird!!!"
      return
    end

    # only logout if the REMOTE_USER is not set in the HTTP headers and a user is set within warden
    # logout clears the entire session including flash messages
    search = session[:search].dup if session[:search]
    request.env['warden'].logout unless author_logged_in?
    session[:search] = search
  end



  protected


  def current_remote_user
#    access_id, pass = ActionController::HttpAuthentication::Basic::user_name_and_password(request)
    if current_author.nil?
      redirect_to Webaccess.login_url
    end
    current_author
  end

  def configure_permitted_parameters
#    devise_parameter_sanitizer.for(:sign_in) << :access_id
    devise_parameter_sanitizer.for(:sign_in).permit(:access_id)
  end

  def author_logged_in?
    author_signed_in? and ( valid_author?(request.headers) || Rails.env.test?)
  end

end
