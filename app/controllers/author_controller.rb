class AuthorController < ApplicationController
  before_filter :find_or_initialize_author

  def logout
    # make any local additions here (e.g. expiring local sessions, etc.)
    # adapted from here: http://cosign.git.sourceforge.net/git/gitweb.cgi?p=cosign/cosign;a=blob;f=scripts/logout/logout.php;h=3779248c754001bfa4ea8e1224028be2b978f3ec;hb=HEAD
    cookies.delete(request.env['COSIGN_SERVICE']) if request.env['COSIGN_SERVICE']
    redirect_to Webaccess.logout_url
  end

  def login
    redirect_to Webaccess.login_url
  end

  protected

  def find_or_initialize_author
    @author = Author.find_or_initialize_by(access_id: current_remote_user)
  end
end
