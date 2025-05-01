class CreateAnnouncements < ActiveRecord::Migration[7.1]
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.date :pub_date
      t.string :status
      t.references :user_app, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.references :category_app, null: false, foreign_key: true

      t.timestamps
    end
  end
end
