class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :author_id
      t.integer :program_id
      t.integer :degree_id
      t.string :semester
      t.integer :year
    end
  end
end
