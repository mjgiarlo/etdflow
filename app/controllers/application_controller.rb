class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Behaviors::HttpHeaderAuthenticatableBehavior

  before_filter :clear_session_author
  before_filter :set_current_author

  unless Rails.env.development? || Rails.env.test?
    rescue_from RuntimeError, with: :render_500
    rescue_from ActionView::Template::Error, with: :render_500
    rescue_from ActiveRecord::StatementInvalid, with: :render_500
    rescue_from Mysql2::Error, with: :render_500
    rescue_from Net::LDAP::LdapError, with: :render_500
    rescue_from RSolr::Error::Http, with: :render_500
    rescue_from Blacklight::Exceptions::ECONNREFUSED, with: :render_500
    rescue_from Errno::ECONNREFUSED, with: :render_500
    rescue_from Rubydora::FedoraInvalidRequest, with: :render_500
    rescue_from ActionDispatch::Cookies::CookieOverflow, with: :render_500
  end


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

  def set_current_author
    Author.current = current_author
  end

  def logout
  #   # make any local additions here (e.g. expiring local sessions, etc.)
  #   # adapted from here: http://cosign.git.sourceforge.net/git/gitweb.cgi?p=cosign/cosign;a=blob;f=scripts/logout/logout.php;h=3779248c754001bfa4ea8e1224028be2b978f3ec;hb=HEAD
     cookies.delete(request.env['COSIGN_SERVICE']) if request.env['COSIGN_SERVICE']
     redirect_to Webaccess.logout_url
  end

  def login
    redirect_to Webaccess.login_url
  end


  protected



  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in).permit(:access_id)
  end

  def author_logged_in?
    author_signed_in? and ( valid_author?(request.headers) || Rails.env.test?)
  end

  def render_500(exception)   #####this needs to go to a generic error page######
    Rails.logger.error("Rendering 500 page due to exception: #{exception.inspect} - #{exception.backtrace if exception.respond_to? :backtrace}")
    render template: '/static/error', layout: 'error_html'
  end


end
