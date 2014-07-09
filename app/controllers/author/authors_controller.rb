class Author::AuthorsController < AuthorController

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    @author.save!
    redirect_to author_root_path
    flash[:notice] = 'Contact information confirmed successfully'
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def edit
  end

  def update
    @author.update_attributes!(author_params)
    redirect_to author_root_path
    flash[:notice] = 'Contact information updated successfully'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_author_author_path(@author)
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
