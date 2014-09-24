class UninstallWorthwhileGenerator < ActiveRecord::Migration
  def change
    drop_table :bookmarks
    drop_table :searches
    drop_table :users

  end
end
