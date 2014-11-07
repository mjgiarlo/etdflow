class AuthorController < ApplicationController
  before_filter :find_or_initialize_author

  protected

  def find_or_initialize_author
    if current_author.nil?
#      self.login
      login
      return
    end
    @author = Author.find_or_initialize_by(access_id: current_author.access_id)
    @author
  end
end
