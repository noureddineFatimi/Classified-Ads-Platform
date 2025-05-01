class AddPremiumToUserApps < ActiveRecord::Migration[7.1]
  def change
    add_column :user_apps, :premium, :boolean
  end
end
