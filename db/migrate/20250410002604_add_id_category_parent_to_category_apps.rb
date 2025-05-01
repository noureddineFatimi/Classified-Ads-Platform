class AddIdCategoryParentToCategoryApps < ActiveRecord::Migration[7.1]
  def change
    add_column :category_apps, :id_category_parent, :integer
  end
end
