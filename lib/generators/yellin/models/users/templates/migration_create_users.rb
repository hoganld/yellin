class <%= migration_class_name %> < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def change
    create_table :<%= table_name %> do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.timestamps
      t.index [:email], name: :index_users_on_email, unique: true
    end
  end
end