class CreatePropertyValues < ActiveRecord::Migration[7.1]
  def change
    create_table :property_values do |t|
      t.references :announcement, null: false, foreign_key: true
      t.references :property_field, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
