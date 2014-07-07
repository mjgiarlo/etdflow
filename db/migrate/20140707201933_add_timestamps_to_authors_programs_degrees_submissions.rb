class AddTimestampsToAuthorsProgramsDegreesSubmissions < ActiveRecord::Migration
  def change
    change_table(:authors) { |t| t.timestamps }
    change_table(:programs) { |t| t.timestamps }
    change_table(:degrees) { |t| t.timestamps }
    change_table(:submissions) { |t| t.timestamps }
  end
end
