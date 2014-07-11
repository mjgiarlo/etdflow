class CreateCommitteeMembers < ActiveRecord::Migration
  def change
    create_table :committee_members do |t|
      t.integer :submission_id
      t.string :role
      t.string :name
      t.string :email
      t.boolean :is_advisor

      t.timestamps
    end
  end
end
