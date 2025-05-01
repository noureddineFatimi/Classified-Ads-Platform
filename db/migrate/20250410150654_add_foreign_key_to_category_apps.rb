class AddForeignKeyToCategoryApps < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :category_apps, :category_apps, column: :parent_id
  end
end
