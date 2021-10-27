class CreateIntegrations < ActiveRecord::Migration[6.1]
  def change
    create_table :integrations do |t|
      t.string :integration_type, null: false
      t.string :token
      t.string :email
      t.string :name
      t.jsonb :metadata, default: {}

      t.timestamps
    end

    add_reference :integrations, :user, foreign_key: true
    add_index :integrations, %i[integration_type user_id], unique: true
  end
end
