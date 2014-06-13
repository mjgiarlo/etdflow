class ChangeDescriptionToNameInPrograms < ActiveRecord::Migration
  def change
    rename_column :programs, :description, :name
  end
end
