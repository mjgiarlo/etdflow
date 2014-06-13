class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :access_id
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :alternate_email_address
      t.string :psu_email_address
      t.string :phone_number
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :is_alternate_email_public
    end
  end
end
