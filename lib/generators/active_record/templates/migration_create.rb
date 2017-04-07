class <%= migration_class_name %> < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def change
    create_table :<%= table_name %><%= primary_key_type %> do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.timestamps
      t.index [:email], name: :index_users_on_email, unique: true
    end
  end
end
