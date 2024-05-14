class <%= migration_class_name %> < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def self.up
    change_table :<%= table_name %> do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.index [:email], name: :index_users_on_email, unique: true
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
    ## Uncomment and edit below to remove any fields that were in your original model and you want to keep
    # remove_column :<%= table_name %>, :email, :string
    # remove_column :<%= table_name %>, :password_digest, :string
    # remove_column :<%= table_name %>, :remember_digest, :string
    # remove_column :<%= table_name %>, :reset_digest, :string
    # remove_column :<%= table_name %>, :reset_sent_at, :datetime
    # remove_index :<%= table_name %>, name: :index_users_on_email
  end
end
