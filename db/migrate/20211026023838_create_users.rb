class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :hashed_password, null: false
      t.string :session_token, null: false
      t.string :email, null: false
      t.boolean :admin, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
