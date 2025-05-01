class CreatePropertyFieldOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :property_field_options do |t|
      t.references :property_field, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
