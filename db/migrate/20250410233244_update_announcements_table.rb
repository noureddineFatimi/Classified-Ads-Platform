class UpdateAnnouncementsTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :announcements, :premium, :boolean
    add_column :announcements, :phone_number, :string
  end
end
