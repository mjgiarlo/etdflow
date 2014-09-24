class AddFedoraIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :fedora_id, :string
  end
end
