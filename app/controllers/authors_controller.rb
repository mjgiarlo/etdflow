class AuthorsController < ApplicationController

  def index
    @authors = Author.all
    respond_to do |format|
      format.html
      format.json {
        @authors_map = @authors.map do |a|
          [
              "<a href=#{edit_author_path(a)}>#{a.access_id}</a>",
              a.last_name,
              a.first_name,
              a.alternate_email_address,
              a.psu_email_address
          ]
        end
        @authors_json = { data: @authors_map }
        render json: @authors_json
      }
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    @author.update_attributes!(author_params)
    redirect_to authors_path
    flash[:notice] = 'Author successfully updated'
  rescue ActiveRecord::RecordInvalid
    redirect_to edit_author_path(@author)
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
