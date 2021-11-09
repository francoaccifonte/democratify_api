class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email, null: false
      t.string :token, null: false

      t.timestamps
    end

    add_index :accounts, :email, unique: true
    add_index :accounts, :name, unique: true
  end
end
