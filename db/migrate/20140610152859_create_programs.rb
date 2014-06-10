class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :description
      t.boolean :is_active
    end
  end
end
