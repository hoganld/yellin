class <%= migration_class_name %> < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def change
    create_table :<%= table_name %><%= primary_key_type %> do |t|
      t.references :user, null: false, foreign_key: true
      t.string :user_agent
      t.string :ip_address

      t.timestamps
    end
  end
end
