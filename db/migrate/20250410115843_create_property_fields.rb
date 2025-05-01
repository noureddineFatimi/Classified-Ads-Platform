class CreatePropertyFields < ActiveRecord::Migration[7.1]
  def change
    create_table :property_fields do |t|
      t.references :category_app, null: false, foreign_key: true
      t.string :name
      t.string :field_type
      t.boolean :required

      t.timestamps
    end
  end
end
