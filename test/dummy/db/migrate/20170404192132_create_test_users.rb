class CreateTestUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :test_users do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_digest

      t.timestamps

      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
