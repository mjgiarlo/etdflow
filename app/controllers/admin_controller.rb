class AdminController < ApplicationController

   before_filter :find_or_initialize_administrator

  layout 'admin'

  protected

  def find_or_initialize_administrator
    if current_author.nil?
#      self.login
      login
      return
    end
    @author = Author.find_or_initialize_by(access_id: current_author.access_id)
    ### if in UMG administrator group ????
    @author
  end

end