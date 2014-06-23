class Admin::AuthorsController < ApplicationController

  def index
    @authors = Author.all
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    @author.update_attributes!(author_params)
    redirect_to admin_authors_path
    flash[:notice] = 'Author successfully updated'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_admin_author_path(@author)
    flash[:notice] = e.message
  end

  private

  def author_params
    params.require(:author).permit(:access_id,
                                   :first_name,
                                   :middle_name,
                                   :last_name,
                                   :alternate_email_address,
                                   :psu_email_address,
                                   :phone_number,
                                   :is_alternate_email_public,
                                   :address_1,
                                   :address_2,
                                   :city,
                                   :state,
                                   :zip)
  end

end