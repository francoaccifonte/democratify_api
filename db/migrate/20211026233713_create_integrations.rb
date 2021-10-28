class CreateIntegrations < ActiveRecord::Migration[6.1]
  def change
    create_table :integrations do |t|
      t.string :provider, null: false
      t.string :token
      t.string :uuid, null: false
      t.string :email
      t.string :name
      t.jsonb :metadata, default: {}

      t.timestamps
    end

    add_reference :integrations, :account, foreign_key: true
    add_reference :integrations, :user, foreign_key: true
    add_index :integrations, %i[provider token uuid]
  end
end
