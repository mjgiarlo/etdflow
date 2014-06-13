class CreateDegrees < ActiveRecord::Migration
  def change
    create_table :degrees do |t|
      t.string :name
      t.string :description
      t.string :degree_type
      t.boolean :is_active
    end
  end
end
