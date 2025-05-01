class CreateCategoryApps < ActiveRecord::Migration[7.1]
  def change
    create_table :category_apps do |t|
      t.string :name

      t.timestamps
    end
  end
end
