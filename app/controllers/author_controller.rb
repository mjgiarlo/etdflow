class AuthorController < ApplicationController
  before_filter :find_or_initialize_author

  protected

  def find_or_initialize_author
    @author = Author.find_or_initialize_by(access_id: remote_user)
  end
end
