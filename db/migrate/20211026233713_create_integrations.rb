class CreateIntegrations < ActiveRecord::Migration[6.1]
  def change
    create_table :integrations do |t|
      t.string :provider, null: false
      t.string :token
      t.string :uuid
      t.string :email
      t.string :name
      t.string :type_in_chain
      t.timestamp :expires_at
      t.jsonb :metadata, default: {}

      t.timestamps
    end

    add_reference :integrations, :account, foreign_key: true
    add_reference :integrations, :user, foreign_key: true
    add_reference :integrations, :front_end_token, foreign_key: { to_table: :integrations }
    add_reference :integrations, :active_token, foreign_key: { to_table: :integrations }
    add_reference :integrations, :refresh_token, foreign_key: { to_table: :integrations }
    add_index :integrations, %i[provider token uuid]
  end
end
