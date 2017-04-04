class CreateTestUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :test_users do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.boolean :activated
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps

      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
