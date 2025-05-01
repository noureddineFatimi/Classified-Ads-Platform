class REnameIdCategoryParentToParentIdInCategoryApps < ActiveRecord::Migration[7.1]
  def change
    rename_column :category_apps, :id_category_parent, :parent_id
  end
end
