class <%= migration_class_name %> < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def self.up
    change_table :<%= table_name %> do |t|
      t.references :user, null: false, foreign_key: true
      t.string :user_agent
      t.string :ip_address
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
    ## Uncomment and edit below to remove any fields that were in your original model and you want to keep
    # remove_reference :<%= table_name %>, :user, foreign_key: true
    # remove_column :<%= table_name %>, :user_agent, :string
    # remove_column :<%= table_name %>, :ip_address, :string
  end
end
