class RenameInUserApp < ActiveRecord::Migration[7.1]
  def change
    rename_column :user_apps, :unername, :username
  end
end
