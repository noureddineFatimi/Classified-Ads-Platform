class CreateUserApps < ActiveRecord::Migration[7.1]
  def change
    create_table :user_apps do |t|
      t.string :unername
      t.string :email
      t.string :password_digest
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
